/*
 * usb_api.h
 *
 *  Created on: 01.07.2015
 *      Author: Andreas
 */

#ifndef API_USB_API_H_
#define API_USB_API_H_

#include "chip.h"
#include "Descriptors.h"

typedef struct USB_API_T* USB_API_PTR;
struct USB_API_T{
	/**
	 * @brief	Check if device is connected USB host application.
	 * @return	Returns non-zero value if connected.
	 */
	bool 		(*isConnected)	(void);
	/**
	 * @brief	Queue the read buffer to USB DMA
	 * @param	pBuf	: Pointer to buffer where read data should be copied
	 * @param	buf_len	: Length of the buffer passed
	 * @return	Returns LPC_OK on success.
	 */
	ErrorCode_t (*QueueReadReq)	(uint8_t *pBuf, uint32_t buf_len);
	/**
	 * @brief	Check if queued read buffer got any data
	 * @return	Returns length of data received. Returns -1 if read is still pending.
	 * @note	Since on USB, zero length packets are transferred -1 is used for
	 *			Rx pending indication.
	 */
	int32_t 	(*QueueReadDone)(void);
	/**
	 * @brief	A blocking read call
	 * @param	pBuf	: Pointer to buffer where read data should be copied
	 * @param	buf_len	: Length of the buffer passed
	 * @return	Return number of bytes read. Returns -1 if previous read is pending.
	 */
	int32_t 	(*Read)			(uint8_t *pBuf, uint32_t buf_len);
	/**
	 * @brief	Queue the given buffer for transmission to USB host application.
	 * @param	pBuf	: Pointer to buffer to be written
	 * @param	buf_len	: Length of the buffer passed
	 * @return	Returns LPC_OK on success.
	 */
	ErrorCode_t (*QueueSendReq)	(uint8_t *pBuf, uint32_t buf_len);
	/**
	 * @brief	Check if queued send is done.
	 * @return	Returns length of remaining data to be sent.
	 *			0 indicates transfer done.
	 */
	int32_t 	(*QueueSendDone)(void);
};

/**
 * @brief	Initialize USB interface.
 * @param	mem_base	: Pointer to memory address which can be used by libusbdev driver
 * @param	mem_size	: Size of the memory passed
 * @return	If found returns the address of requested interface else returns NULL.
 */
USB_API_PTR USB_API_CREATE();

void USB_API_DESTROY(USB_API_PTR instance);

extern void PerformUSB_Vendor(int8_t cmd, uint16_t Value);

#endif /* API_USB_API_H_ */
