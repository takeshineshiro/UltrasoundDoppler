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
    INITVAL_BURST       = 128,  // 10/4 *64
    INITVAL_SAMPLE      = 256,  // 14/4 *64
    INITVAL_DEPHT       = 768,  //
	INITVAL_GATELENGTH	= 4,
	INITVAL_SVLENGTH	= 16
};

SPI_API_PTR spiHandle;
uint16_t rx[10] = {0};
uint16_t t = 0;

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
static void HAL_READCONFIG(uint16_t* data);

static void USD_HW_API_Implementation(USD_HW_API_PTR instance){
	instance->Config.prf = INITVAL_PRF;
	instance->Config.burst = INITVAL_BURST;
	instance->Config.sample = INITVAL_SAMPLE;
	instance->Config.depht = INITVAL_DEPHT;
	instance->Config.settings.ENABLE = 0;
	instance->Config.settings.FREQUENCY = Freq8MHz;
	instance->Config.settings.GATE_LENGTH = 3;
	instance->Config.settings.RX_ON = 0;
	instance->Config.settings.TX_ON = 0;
	instance->ResetUSD = HAL_RESET;
	instance->WriteConfig = HAL_WRITECONFIG;
	instance->ReadConfig = HAL_READCONFIG;
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
	Chip_GPIO_SetPinState(LPC_GPIO_PORT, USD_ENABLE_PORT, USD_ENABLE_PIN, false);
	Chip_GPIO_SetPinState(LPC_GPIO_PORT, USD_ENABLE_PORT, USD_ENABLE_PIN, true);
}

static void HAL_WRITECONFIG(void){
	HAL_RESET();
	/*uint16_t cmd1[] = {
				0x02, 4,
				 (usdhandle->Config.settings.TX_ON << 0) |
				 (usdhandle->Config.settings.RX_ON << 1) |
				(0 << 2) |
		   (usdhandle->Config.settings.GATE_LENGTH << 6) |
			 (usdhandle->Config.settings.FREQUENCY << 14)
		};*/
	uint16_t cmd[] = {
			0x02, 0,
			usdhandle->Config.burst,
			usdhandle->Config.sample,
			usdhandle->Config.depht,
			usdhandle->Config.prf,
			 (usdhandle->Config.settings.TX_ON << 0) |
			 (usdhandle->Config.settings.RX_ON << 1) |
			(usdhandle->Config.settings.ENABLE << 2) |
	   (usdhandle->Config.settings.GATE_LENGTH << 6) |
		 (usdhandle->Config.settings.FREQUENCY << 14)
	};
	//spiHandle->write16bit(cmd1, sizeof(cmd1) / sizeof(cmd1[0])*2);
	spiHandle->write16bit(cmd, sizeof(cmd) / sizeof(cmd[0])*2);
	//HAL_READCONFIG(rx);
	//HAL_READCONFIG(rx);
}

static void HAL_RUN(void){
	uint16_t tx[1] = {0x06};
	spiHandle->write16bit(tx, 2);
}

static void HAL_STOP(void){
	uint16_t tx[1] = {0x04};
	spiHandle->write16bit(tx, 2);
}

void HAL_READCONFIG(uint16_t* data){
	uint16_t tx[10] = {0};
	tx[0] = 0x08;
	t = spiHandle->transfer16bit(tx, data, sizeof(tx) / sizeof(tx[0])*2);
}
