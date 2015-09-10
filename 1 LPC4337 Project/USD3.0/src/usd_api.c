/*
 * usd_api.c
 *
 *  Created on: 25.06.2015
 *      Author: Andreas
 */

#include "usd_api.h"
#include "spi_api.h"
#include "chip.h"
#include <stdlib.h>

enum SCANNERINITVALUES{
    INITVAL_FREQ_MHZ    = Freq8MHz,
    INITVAL_PRF         = 64000000/10000-1, // 10kHz
    INITVAL_BURST       = 100,  // 10/4 *64
    INITVAL_SAMPLE      = 120,  // 14/4 *64
    INITVAL_DEPHT       = 140,  //
	INITVAL_GATELENGTH	= 4,
	INITVAL_SVLENGTH	= 16
};

SPI_API_PTR spiHandle;

void SetupHardware(void){
	/* --- SPI --- */
	spiHandle = SPI_API_CREATE();
	/* --- ENABLE --- */
	Chip_GPIO_SetPinDIROutput(LPC_GPIO_PORT, USD_ENABLE_PORT, USD_ENABLE_PIN);
	Chip_GPIO_SetPinState(LPC_GPIO_PORT, USD_ENABLE_PORT, USD_ENABLE_PIN, true);
	Chip_GPIO_SetPinState(LPC_GPIO_PORT, USD_ENABLE_PORT, USD_ENABLE_PIN, false);
	Chip_GPIO_SetPinState(LPC_GPIO_PORT, USD_ENABLE_PORT, USD_ENABLE_PIN, true);
}

static void HAL_RESET(void);
static void HAL_WRITECONFIG(void);
static void HAL_RUN(void);
static void HAL_STOP(void);

static void USD_HW_API_Implementation(USD_HW_API_PTR instance){
	instance->Config.prf = INITVAL_PRF;
	instance->Config.burst = INITVAL_BURST;
	instance->Config.sample = INITVAL_SAMPLE;
	instance->Config.depht = INITVAL_DEPHT;
	instance->Config.settings.bits.ENABLE = 0;
	instance->Config.settings.bits.FREQUENCY = Freq8MHz;
	instance->Config.settings.bits.GATE_LENGTH = 3;
	instance->Config.settings.bits.RX_ON = 0;
	instance->Config.settings.bits.TX_ON = 0;
	instance->ResetUSD = HAL_RESET;
	instance->WriteConfig = HAL_WRITECONFIG;
	instance->Start = HAL_RUN;
	instance->Stop = HAL_STOP;
}

USD_HW_API_PTR USD_HW_API_CREATE(void){
	USD_HW_API_PTR instance = (USD_HW_API_PTR)malloc(sizeof(struct USD_HW_API));
	SetupHardware();
	USD_HW_API_Implementation(instance);
	return instance;
}

void USD_HW_API_DESTROY(USD_HW_API_PTR instance){
	free(instance);
}


static inline void HAL_RESET(void){
	Chip_GPIO_SetPinState(LPC_GPIO_PORT, USD_ENABLE_PORT, USD_ENABLE_PIN, true);
	Chip_GPIO_SetPinState(LPC_GPIO_PORT, USD_ENABLE_PORT, USD_ENABLE_PIN, false);
	Chip_GPIO_SetPinState(LPC_GPIO_PORT, USD_ENABLE_PORT, USD_ENABLE_PIN, true);
}

static void HAL_WRITECONFIG(void){
	HAL_RESET();
	uint16_t cmd[] = {
			SETSettings, (uint16_t)usdhandle->Config.settings.Value,
			SETDELAY1, usdhandle->Config.burst,
			SETDEMOD, usdhandle->Config.sample,
			SETDELAY2, usdhandle->Config.depht,
			SETRETRANSMIT, usdhandle->Config.prf,
	};
	//spiHandle->write16bit(cmd, sizeof(cmd) / sizeof(cmd[0]));
}

static void HAL_RUN(void){
	uint16_t tx[1] = {0x06};
	usdhandle->Config.settings.bits.ENABLE = 1;
	spiHandle->write16bit(tx, 2);
}

static void HAL_STOP(void){
	uint16_t tx[1] = {0x04};
		usdhandle->Config.settings.bits.ENABLE = 0;
		spiHandle->write16bit(tx, 2);
}
