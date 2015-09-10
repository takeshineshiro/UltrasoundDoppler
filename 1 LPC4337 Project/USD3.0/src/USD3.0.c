/*
===============================================================================
 Name        : USD3.0.c
 Author      : $(author)
 Version     :
 Copyright   : $(copyright)
 Description : main definition
===============================================================================
*/

#if defined (__USE_LPCOPEN)
#if defined(NO_BOARD_LIB)
#include "chip.h"
#else
#include "boardSetup.h"
#include "board.h"
#endif
#endif

// TODO: insert other include files here
#include "usb_api.h"
#include "spi_api.h"
#include "usd_api.h"
#include "SCT.h"

// TODO: insert other definitions and declarations here
USB_API_PTR usb;
USD_HW_API_PTR usdhandle;

uint16_t tx[8] = {0};
uint16_t rx[8] = {0};

volatile uint16_t buffer[5*SAMPLES] = {0};
uint32_t counter = 0;

void ROI_dataReceived(TransferType dataType){
	//usb->QueueSendReq(&buffer[0], SAMPLES*4);
	if(usdhandle->Mode == 1) usdhandle->Start();
}

void PerformUSB_Vendor(int8_t cmd, uint16_t value){
	switch(cmd){
		case FREQUENCY:
			usdhandle->Config.settings.bits.FREQUENCY = value;
			usdhandle->WriteConfig();
			Board_LED_Toggle(0);
			break;
		case PRF:
			usdhandle->Config.prf = value;
			usdhandle->WriteConfig();
			Board_LED_Toggle(0);
			break;
		case BURST:
			usdhandle->Config.burst = value;
			usdhandle->WriteConfig();
			Board_LED_Toggle(0);
			break;
		case SAMPLE:
			usdhandle->Config.sample = value;
			usdhandle->WriteConfig();
			Board_LED_Toggle(0);
			break;
		case DEPTH:
			usdhandle->Config.depht = value+2;
			usdhandle->WriteConfig();
			Board_LED_Toggle(0);
			break;
		case GATE:
			usdhandle->Config.settings.bits.GATE_LENGTH = value;
			usdhandle->WriteConfig();
			Board_LED_Toggle(0);
			break;
		case TX_ON:
			usdhandle->Config.settings.bits.TX_ON = value;
			usdhandle->WriteConfig();
			Board_LED_Toggle(0);
			break;
		case RX_ON:
			usdhandle->Config.settings.bits.RX_ON = value;
			usdhandle->WriteConfig();
			break;
		case MODE:
			if(value == 1) usdhandle->Start();
			/*
			if(value == 1){
				usdhandle->Mode = 1;
				usdhandle->Start();
			}
			else{
				usdhandle->Mode = 0;
				usdhandle->Stop();
			}*/
			break;
		default:
			break;
	} //end switch
}

int main(void) {
	USD_SystemInit();
	//Board_SystemInit();
	//SystemCoreClockUpdate();
	//Board_Init();

    //spi = SPI_API_CREATE();
    usdhandle = USD_HW_API_CREATE();

    USD_HW_DATAPORT_CREATE(ROI_dataReceived);
    USD_HW_DATAPORT_START();

    usb = USB_API_CREATE();



    //tx[0] = 0x04;	//Shutdown System
    //t = spi->write16bit(tx, 2);

    // Enter an infinite loop, just incrementing a counter
    while(1){
    	/*t = spi->transfer16bit(tx, rx, sizeof(tx) / sizeof(tx[0])*2);
    	for(int i = 0; i < 8; i++){
			rx[i] = 0;
		}*/
    }
}
