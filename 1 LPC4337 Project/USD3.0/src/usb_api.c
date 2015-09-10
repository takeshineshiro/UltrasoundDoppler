/*
 * usb_api.c
 *
 *  Created on: 01.07.2015
 *      Author: Andreas
 */

#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include "app_usbd_cfg.h"
#include "usb_api.h"
#include "SCT.h"

/*****************************************************************************
 * Public types/enumerations/variables
 ****************************************************************************/
const USBD_API_T *g_pUsbApi;

#define EP1_OUT_INDEX           2
#define EP1_OUT_BIT             _BIT(1)
#define EP1_IN_INDEX            3
#define EP1_IN_BIT              _BIT(1 + 16)
#define EP2_OUT_INDEX           4
#define EP2_OUT_BIT             _BIT(2)
#define EP2_IN_INDEX            5
#define EP2_IN_BIT              _BIT(2 + 16)

typedef struct _LUSB_CTRL_ {
	USBD_HANDLE_T hUsb;
	uint8_t *pRxBuf;
	uint32_t rxBuffLen;
	uint8_t *pTxBuf;//[1024];
	uint32_t txBuffStart;
	uint32_t txBuffLen;
	uint32_t newStatus;
	uint32_t curStatus;
	volatile uint8_t connected;
	volatile uint16_t tx_flags;
} LUSB_CTRL_T;

static LUSB_CTRL_T g_lusb;
/* Endpoint 0 patch that prevents nested NAK event processing */
static uint32_t g_ep0RxBusy = 0;/* flag indicating whether EP0 OUT/RX buffer is busy. */
static USB_EP_HANDLER_T g_Ep0BaseHdlr;	/* variable to store the pointer to base EP0 handler */

/* --- private functions --- */
static uint32_t HAL_USB_Init(uint32_t memBase, uint32_t memSize);
static bool HAL_USB_isConnected(void);
static ErrorCode_t HAL_USB_SendRequest(uint8_t *pBuf, uint32_t buf_len);
static int32_t HAL_USB_SendDone(void);
static int32_t HAL_USB_Read(uint8_t *pBuf, uint32_t buf_len);
static ErrorCode_t HAL_USB_ReadRequest(uint8_t *pBuf, uint32_t buf_len);
static int32_t HAL_USB_ReadDone(void);

__attribute__ ((aligned (4))) const uint8_t MANUFACTOR[] = {
		'H', 0,'S', 0,'-', 0,'U', 0,'l', 0,'m', 0
};
__attribute__ ((aligned (4))) const uint8_t VERSION[] = {
		'0', 0,'.', 0,'1', 0,'.', 0,'2', 0,'a', 0,'l', 0,'p', 0,'h', 0,'a', 0
};

/* Handler for WCID USB device requests. */
ErrorCode_t WCID_hdlr(USBD_HANDLE_T hUsb, void *data, uint32_t event){
	USB_CORE_CTRL_T *pCtrl = (USB_CORE_CTRL_T *) hUsb;
	ErrorCode_t ret = ERR_USBD_UNHANDLED;

	if (event == USB_EVT_SETUP) {
		switch (pCtrl->SetupPacket.bmRequestType.BM.Type) {
			case REQUEST_STANDARD:
				if ((pCtrl->SetupPacket.bmRequestType.BM.Recipient == REQUEST_TO_DEVICE) &&
					(pCtrl->SetupPacket.bRequest == USB_REQUEST_GET_DESCRIPTOR) &&
					(pCtrl->SetupPacket.wValue.WB.H == USB_STRING_DESCRIPTOR_TYPE) &&
					(pCtrl->SetupPacket.wValue.WB.L == 0x00EE)) {
					pCtrl->EP0Data.pData = (uint8_t *) &WCID_String_Descriptor;
					pCtrl->EP0Data.Count = pCtrl->SetupPacket.wLength;
					USBD_API->core->DataInStage(pCtrl);
					ret = LPC_OK;
				}
				break;
		case REQUEST_VENDOR:
			switch (pCtrl->SetupPacket.bRequest) {
				case WCID_VENDOR_CODE:
					if (pCtrl->SetupPacket.wIndex.W == 0x04) {
						pCtrl->EP0Data.pData = (uint8_t *) &WCID_CompatID_Descriptor;
						pCtrl->EP0Data.Count = pCtrl->SetupPacket.wLength;
						USBD_API->core->DataInStage(pCtrl);
						ret = LPC_OK;
					}
					if(pCtrl->SetupPacket.wIndex.W == 0x05){
						pCtrl->EP0Data.pData = (uint8_t *) &WCID_ExtProp_Descriptor;
						pCtrl->EP0Data.Count = pCtrl->SetupPacket.wLength;
						USBD_API->core->DataInStage(pCtrl);
						ret = LPC_OK;
					}
					break;
				case 0x0000: //ping
					pCtrl->EP0Data.pData = NULL;
					pCtrl->EP0Data.Count = pCtrl->SetupPacket.wLength;
					USBD_API->core->DataInStage(pCtrl);
					ret = LPC_OK;
					break;
				case 0x0001: //CoreClock
					pCtrl->EP0Data.pData = (uint8_t *) &SystemCoreClock;
					pCtrl->EP0Data.Count = pCtrl->SetupPacket.wLength;
					USBD_API->core->DataInStage(pCtrl);
					ret = LPC_OK;
					break;
				case 0x0002: //Manufacture
					pCtrl->EP0Data.pData = (uint8_t *) &MANUFACTOR;
					pCtrl->EP0Data.Count = pCtrl->SetupPacket.wLength;
					USBD_API->core->DataInStage(pCtrl);
					ret = LPC_OK;
					break;
				case 0x0003: //version
					pCtrl->EP0Data.pData = (uint8_t *) &VERSION;
					pCtrl->EP0Data.Count = pCtrl->SetupPacket.wLength;
					USBD_API->core->DataInStage(pCtrl);
					ret = LPC_OK;
					break;
				default:
					USBD_API->core->DataInStage(pCtrl);
					PerformUSB_Vendor(pCtrl->SetupPacket.bRequest, pCtrl->SetupPacket.wValue.W);
					ret = LPC_OK;
					break;
				}
		}
	}
	else if ((event == USB_EVT_OUT) && (pCtrl->SetupPacket.bmRequestType.BM.Type == REQUEST_VENDOR)) {
		if (pCtrl->SetupPacket.bRequest == 0x10) {
			USBD_API->core->StatusInStage(pCtrl);
			ret = LPC_OK;
		}
	}
	/* For bus powered devices set the device_status to 0. The default handler
	   assumes SELF_POWERED. This step is needed for usb.org Ch9 certification
	   test to pass. */
	if (event == USB_EVT_RESET) {
		pCtrl->device_status = 0;
	}

	return ret;
}

/* USB bulk EP_IN endpoint handler */
static ErrorCode_t BulkIN_Hdlr(USBD_HANDLE_T hUsb, void *data, uint32_t event){
	LUSB_CTRL_T *pUSB = (LUSB_CTRL_T *) data;
	// Exit if not an IN event or Exit if buffer empty
	if ((event != USB_EVT_IN) || (pUSB->txBuffLen == pUSB->txBuffStart)) return ERR_USBD_UNHANDLED;
	// Send buffer
	pUSB->txBuffStart += USBD_API->hw->WriteEP(hUsb, USB_ENDPOINT_IN(1), (uint8_t*)(&pUSB->pTxBuf[pUSB->txBuffStart]), 512);
	return LPC_OK;
}



/* USB bulk EP_OUT endpoint handler */
/*
static ErrorCode_t BulkOUT_Hdlr(USBD_HANDLE_T hUsb, void *data, uint32_t event){
	LUSB_CTRL_T *pUSB = (LUSB_CTRL_T *) data;

	// We received a transfer from the USB host.
	if (event == USB_EVT_OUT) {
		pUSB->rxBuffLen = USBD_API->hw->ReadEP(hUsb, USB_ENDPOINT_OUT(1), pUSB->pRxBuf);
		pUSB->pRxBuf = 0;
	}
	return LPC_OK;
}
*/

/* dTD field and bit defines */
#define TD_NEXT_TERMINATE       _BIT(0)
#define TD_IOC                  _BIT(15)
#define USB_DEST_ADDR           buffer// 0x20004000//&[0]// //

/* dTD Transfer Description */
typedef volatile struct {
	volatile uint32_t next_dTD;
	volatile uint32_t total_bytes;
	volatile uint32_t buffer0;
	volatile uint32_t buffer1;
	volatile uint32_t buffer2;
	volatile uint32_t buffer3;
	volatile uint32_t buffer4;
	volatile uint32_t reserved;
}  DTD_T;

/* dQH  Queue Head */
typedef volatile struct {
	volatile uint32_t cap;
	volatile uint32_t curr_dTD;
	volatile uint32_t next_dTD;
	volatile uint32_t total_bytes;
	volatile uint32_t buffer0;
	volatile uint32_t buffer1;
	volatile uint32_t buffer2;
	volatile uint32_t buffer3;
	volatile uint32_t buffer4;
	volatile uint32_t reserved;
	volatile uint32_t setup[2];
	volatile uint32_t gap[4];
}  DQH_T;

DTD_T *g_dtdPool[4];
int ep_count[4];

/* Handle USB RESET event */
static ErrorCode_t HAL_USB_ResetEvent(USBD_HANDLE_T hUsb){
	/* reset the control structure */
	memset(&g_lusb, 0, sizeof(LUSB_CTRL_T));
	g_lusb.hUsb = hUsb;
	return LPC_OK;
}

/* EP0_patch part of WORKAROUND for artf45032. */
static ErrorCode_t EP0_patch(USBD_HANDLE_T hUsb, void *data, uint32_t event)
{
	switch (event) {
	case USB_EVT_OUT_NAK:
		if (g_ep0RxBusy) {
			/* we already queued the buffer so ignore this NAK event. */
			return LPC_OK;
		}
		else {
			/* Mark EP0_RX buffer as busy and allow base handler to queue the buffer. */
			g_ep0RxBusy = 1;
		}
		break;

	case USB_EVT_SETUP:	/* reset the flag when new setup sequence starts */
	case USB_EVT_OUT:
		/* we received the packet so clear the flag. */
		g_ep0RxBusy = 0;
		break;
	}
	return g_Ep0BaseHdlr(hUsb, data, event);
}

/* Program transfer descriptors for given endpoint. */
static void Prog_DTD(uint32_t epIndex, uint32_t epBit)
{
	int i;
	DQH_T *ep_QH = (DQH_T *) LPC_USB->ENDPOINTLISTADDR;
	/* Get physical address for TD */
	uint32_t dtd_phys = (uint32_t) &g_dtdPool[epIndex - 2][0];
	/* get DTDs for the given endpoint */
	DTD_T *ep_TD = &g_dtdPool[epIndex - 2][0];

	/* Zero out the device transfer descriptors */
	memset((void *) dtd_phys, 0, 8 * sizeof(DTD_T));

	/* set each TD to transfer 20KB */
	for (i = 0; i < 8; i++) {
		ep_TD[i].next_dTD = (uint32_t) (dtd_phys + ((1 + i) * sizeof(DTD_T)));
		ep_TD[i].total_bytes = (0x4000 << 16) | TD_IOC | 0x80;
		/* we will use same memory area for Rx and Tx for EP1 & EP2. Since we are
		   just interested in throughput instead of data in this test */
		ep_TD[i].buffer0 = (uint32_t)USB_DEST_ADDR;
		ep_TD[i].buffer1 = ((uint32_t)USB_DEST_ADDR + 0x1000);
		ep_TD[i].buffer2 = ((uint32_t)USB_DEST_ADDR + 0x2000);
		ep_TD[i].buffer3 = ((uint32_t)USB_DEST_ADDR + 0x3000);
		ep_TD[i].buffer4 = ((uint32_t)USB_DEST_ADDR + 0x4000);
		ep_TD[i].reserved = 0;
	}

	ep_TD[7].next_dTD = 0x01;	/* The next DTD pointer is INVALID */

	/* update the hardware endpoint queue */
	ep_QH[epIndex].next_dTD = dtd_phys;
	ep_QH[epIndex].total_bytes &= (~0xC0);

	/* prime the endpoint for transfer to start */
	LPC_USB->ENDPTPRIME |= epBit;
}

/* USB Configure Event Callback. Called automatically after active
 * configuration is selected.
 */
static ErrorCode_t ConfigureEvent(USBD_HANDLE_T hUsb)
{
	/* setup the transfer descriptors for all bandwidth test endpoints */
	Prog_DTD(EP1_OUT_INDEX, EP1_OUT_BIT);	/* EP1_OUT */
	Prog_DTD(EP2_OUT_INDEX, EP2_OUT_BIT);	/* EP2_OUT */
	Prog_DTD(EP1_IN_INDEX, EP1_IN_BIT);		/* EP1_IN */
	Prog_DTD(EP2_IN_INDEX, EP2_IN_BIT);		/* EP2_IN */
	return LPC_OK;
}


/* Handle endpoint events.
 * OUT endpoints will get USB_EVT_OUT & USB_EVT_OUT_NAK events.
 * IN endpoints will get USB_EVT_IN & USB_EVT_IN_NAK events.
 */
static ErrorCode_t EpHandler(uint32_t event, uint32_t epIndex, uint32_t epBit)
{
	switch (event) {

	case USB_EVT_OUT:
	case USB_EVT_IN:
		/* enqueue next TD to transfer to external SRAM */
		ep_count[epIndex - 2]++;
		if (ep_count[epIndex - 2] == 8)
		{
			ep_count[epIndex - 2] = 0;
			Prog_DTD(epIndex, epBit);
		}
		break;

	case USB_EVT_IN_NAK:
		/* should be here for the first time only. */
		break;

	case USB_EVT_OUT_NAK:
		/* should be here for the first time only. */
		break;
	}
	return LPC_OK;
}

/* Bulk IN Endpoint 1 Event Callback.*/
static ErrorCode_t Ep1InHandler(USBD_HANDLE_T hUsb, void *data, uint32_t event)
{
	return EpHandler(event, EP1_IN_INDEX, EP1_IN_BIT);
}

/* Bulk IN Endpoint 1 Event Callback.*/
static ErrorCode_t Ep2InHandler(USBD_HANDLE_T hUsb, void *data, uint32_t event)
{
	return EpHandler(event, EP2_IN_INDEX, EP2_IN_BIT);
}



/* --- public functions --- */
USB_API_PTR  USB_API_CREATE() {
	USB_API_PTR instance = (USB_API_PTR) malloc(sizeof(struct USB_API_T));
	instance->isConnected	= HAL_USB_isConnected;
	instance->QueueSendReq	= HAL_USB_SendRequest;
	instance->QueueSendDone = HAL_USB_SendDone;
	instance->Read			= HAL_USB_Read;
	instance->QueueReadReq 	= HAL_USB_ReadRequest;
	instance->QueueReadDone = HAL_USB_ReadDone;
	HAL_USB_Init(USB_STACK_MEM_BASE, USB_STACK_MEM_SIZE);
	return instance;
}

void USB_API_DESTROY(USB_API_PTR instance) {
	free(instance);
}


void USB_IRQHandler(void)
{
	USBD_API->hw->ISR(g_lusb.hUsb);
}

static uint32_t HAL_USB_Init(uint32_t memBase, uint32_t memSize){
	USBD_API_INIT_PARAM_T usb_param;
	USB_CORE_DESCS_T desc;
	ErrorCode_t ret = LPC_OK;
	USB_CORE_CTRL_T *pCtrl;

	USB_init_pin_clk();

	/* Init USB API structure */
	g_pUsbApi = (const USBD_API_T *) LPC_ROM_API->usbdApiBase;

	/* initialize call back structures */
	memset((void *) &usb_param, 0, sizeof(USBD_API_INIT_PARAM_T));
	usb_param.usb_reg_base = LPC_USB_BASE;
	usb_param.max_num_ep = USB_MAX_EP_NUM;
	usb_param.mem_base = USB_STACK_MEM_BASE;
	usb_param.mem_size = USB_STACK_MEM_SIZE;
	usb_param.USB_Reset_Event = HAL_USB_ResetEvent;
	usb_param.USB_Configure_Event = ConfigureEvent;

	/* Set the USB descriptors */
	desc.device_desc = (uint8_t *) &USB_DeviceDescriptor;
	desc.string_desc = (uint8_t *) USB_StringDescriptor;
#ifdef USE_USB0
	desc.high_speed_desc = (uint8_t *) &USB_HsConfigDescriptor;
	desc.full_speed_desc = (uint8_t *) &USB_FsConfigDescriptor;
	desc.device_qualifier = (uint8_t *) &USB_DeviceQualifier;
#else
	/* Note, to pass USBCV test full-speed only devices should have both
	 * descriptor arrays point to same location and device_qualifier set
	 * to 0.
	 */
	desc.high_speed_desc = (uint8_t *) USB_FsConfigDescriptor;
	desc.full_speed_desc = (uint8_t *) USB_FsConfigDescriptor;
	desc.device_qualifier = 0;
#endif

	/* USB Initialization */
	ret = USBD_API->hw->Init(&g_lusb.hUsb, &desc, &usb_param);
	if (ret == LPC_OK) {
		pCtrl = (USB_CORE_CTRL_T *) &g_lusb.hUsb;	/* convert the handle to control structure */
		g_Ep0BaseHdlr = pCtrl->ep_event_hdlr[0];/* retrieve the default EP0_OUT handler */
		pCtrl->ep_event_hdlr[0] = EP0_patch;/* set our patch routine as EP0_OUT handler */

		/* allocate TDs for bandwidth test in USB accessable memory*/
		while (usb_param.mem_base & 0x1F) {
			usb_param.mem_base++; usb_param.mem_size--;
		}
		/* allocate DTDs for EP1_OUT */
		g_dtdPool[0] = (DTD_T *) usb_param.mem_base;
		usb_param.mem_base += (8 * sizeof(DTD_T));
		/* allocate DTDs for EP1_IN */
		g_dtdPool[1] = (DTD_T *) usb_param.mem_base;
		usb_param.mem_base += (8 * sizeof(DTD_T));
		/* allocate DTDs for EP2_OUT */
		g_dtdPool[2] = (DTD_T *) usb_param.mem_base;
		usb_param.mem_base += (8 * sizeof(DTD_T));
		/* allocate DTDs for EP2_IN */
		g_dtdPool[3] = (DTD_T *) usb_param.mem_base;
		usb_param.mem_base += (8 * sizeof(DTD_T));

		/* update size for all four EPs */
		usb_param.mem_size -= (4 * 8 * sizeof(DTD_T));


		/* register WCID handler */
		ret = USBD_API->core->RegisterEpHandler(g_lusb.hUsb, EP1_IN_INDEX, Ep1InHandler, &g_lusb);
		if (ret == LPC_OK) {
			ret = USBD_API->core->RegisterEpHandler(g_lusb.hUsb, EP2_IN_INDEX, Ep2InHandler, &g_lusb);
			if (ret == LPC_OK) {
				ret = USBD_API->core->RegisterClassHandler(g_lusb.hUsb, WCID_hdlr, &g_lusb);
				if (ret == LPC_OK) {
					NVIC_EnableIRQ(USB0_IRQn);/*  enable USB interrrupts */
					/* now connect */
					USBD_API->hw->Connect(g_lusb.hUsb, 1);
				}
			}
		}
	}
	return ret;
}

static bool HAL_USB_isConnected(void){
	return USB_IsConfigured(g_lusb.hUsb);
}

static ErrorCode_t HAL_USB_SendRequest(uint8_t *pBuf, uint32_t buf_len){
	LUSB_CTRL_T *pUSB = (LUSB_CTRL_T *) &g_lusb;

	pUSB->pTxBuf = pBuf;
	pUSB->txBuffLen = buf_len;
	pUSB->txBuffStart = 0;
	return BulkIN_Hdlr(pUSB->hUsb, pUSB, USB_EVT_IN);
}

/* Check if queued send is done. */
static int32_t HAL_USB_SendDone(void){
	LUSB_CTRL_T *pUSB = (LUSB_CTRL_T *) &g_lusb;
	/* return remaining length */
	return pUSB->txBuffLen - pUSB->txBuffStart;
}

static int32_t HAL_USB_Read(uint8_t *pBuf, uint32_t buf_len){
	//TODO::
	return -1;
}

static ErrorCode_t HAL_USB_ReadRequest(uint8_t *pBuf, uint32_t buf_len){
	LUSB_CTRL_T *pUSB = (LUSB_CTRL_T *) &g_lusb;
	ErrorCode_t ret = ERR_FAILED;

	/* Check if a read request is pending */
	if (pUSB->pRxBuf == 0) {
		/* Queue the read request */
		pUSB->pRxBuf = pBuf;
		pUSB->rxBuffLen = buf_len;
		USBD_API->hw->ReadReqEP(pUSB->hUsb, USB_ENDPOINT_OUT(1), pBuf, buf_len);
		ret = LPC_OK;
	}
	return ret;
}

/* Check if queued read buffer got any data */
static int32_t HAL_USB_ReadDone(void){
	LUSB_CTRL_T *pUSB = (LUSB_CTRL_T *) &g_lusb;

	/* A read request is pending */
	if (pUSB->pRxBuf) {
		return -1;
	}
	/* if data received return the length */
	return pUSB->rxBuffLen;
}
