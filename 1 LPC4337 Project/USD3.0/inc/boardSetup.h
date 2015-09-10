/*
 * BoardSetup.h
 *
 *  Created on: 27.05.2015
 *      Author: Andreas
 */

#ifndef INC_BOARDSETUP_H_
#define INC_BOARDSETUP_H_

#include "chip.h"

#ifdef __cplusplus
extern "C" {
#endif

void USD_SystemInit(void);

typedef struct {
	uint8_t port;
	uint8_t pin;
	uint16_t modefunc;
} io_port_t;

/* SPI Config */

typedef struct {
	io_port_t SSEL;
	io_port_t SCK;
	io_port_t MOSI;
	io_port_t MISO;
	SSP_ConfigFormat ssp_format;
} SSP_t;


static const SSP_t SSP1 = {
	.SSEL 	= {0x1, 5, (SCU_PINIO_FAST | SCU_MODE_FUNC5)},
	.SCK 	= {0xF, 4, (SCU_PINIO_FAST | SCU_MODE_FUNC0)},
	.MISO	= {0x1, 3, (SCU_MODE_INACT | SCU_MODE_INBUFF_EN | SCU_MODE_ZIF_DIS | SCU_MODE_FUNC5)},
	.MOSI	= {0x1, 4, (SCU_MODE_INACT | SCU_MODE_INBUFF_EN | SCU_MODE_ZIF_DIS | SCU_MODE_FUNC5)},
	.ssp_format = {
			.frameFormat = SSP_FRAMEFORMAT_SPI,
			.bits = SSP_BITS_16,
			.clockMode = SSP_CLOCK_MODE3
	},
};
#define SSP1_USE_CS (1)
#define LPC_SSP           LPC_SSP1
#define SSP_IRQ           SSP1_IRQn
#define SSPIRQHANDLER SSP1_IRQHandler

#define USD_ENABLE_PORT 5
#define USD_ENABLE_PIN 	15


#ifdef __cplusplus
}
#endif

#endif /* INC_BOARDSETUP_H_ */
