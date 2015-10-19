/*
 * USD_DataInterface.c
 *
 *  Created on: 24.06.2015
 *      Author: Andreas Rehn
 */
#include <stdlib.h>
#include "spi_api.h"
#include "boardSetup.h"
#include "chip.h"
#include "ssp_18xx_43xx.h"

static Chip_SSP_DATA_SETUP_T xf_setup;

static inline void SSP_Mux(LPC_SSP_T *pSSP)
{
	if (pSSP == LPC_SSP1) {
		Chip_SCU_PinMuxSet(SSP1.SCK.port,  SSP1.SCK.pin,  SSP1.SCK.modefunc);  	/* PF.4 => SCK1 */
		Chip_SCU_PinMuxSet(SSP1.MOSI.port, SSP1.MOSI.pin, SSP1.MOSI.modefunc); 	/* P1.4 => MOSI1 */
		Chip_SCU_PinMuxSet(SSP1.MISO.port, SSP1.MISO.pin, SSP1.MISO.modefunc); 	/* P1.3 => MISO1 */
#if SSP1_USE_CS
		Chip_SCU_PinMuxSet(SSP1.SSEL.port, SSP1.SSEL.pin, SSP1.SSEL.modefunc);  /* P1.5 => SSEL1 */
		Chip_GPIO_SetPinDIROutput(LPC_GPIO_PORT, 1, 8);
		Chip_GPIO_SetPinState(LPC_GPIO_PORT, 1, 8, true);
#endif

	}
	else {
		return;
	}
}

static inline void SSP_Init(LPC_SSP_T *pSSP)
{
	if(pSSP == LPC_SSP1){
		Chip_Clock_Enable(CLK_MX_SSP1);
		Chip_Clock_Enable(CLK_APB2_SSP1);

		Chip_SSP_Set_Mode(pSSP, SSP_MODE_MASTER);
		Chip_SSP_SetFormat(pSSP, SSP1.ssp_format.bits, SSP1.ssp_format.frameFormat, SSP1.ssp_format.clockMode);
		Chip_SSP_SetBitRate(pSSP, 10000000);
		Chip_SSP_Enable(pSSP);
		NVIC_EnableIRQ(SSP_IRQ);
		Chip_SSP_Set_Mode(pSSP, SSP_MODE_MASTER);
	}
	else {
		return;
	}
}

/* private functions */
static uint32_t spi_write16(uint16_t *txbuff, uint32_t transferSize);
static uint32_t spi_transfer16(uint16_t *txbuff, uint16_t *rxbuff, uint32_t transferSize);
static uint32_t spi_fillTransfer(uint16_t *txbuff, uint32_t transferSize);

/* public functions */

SPI_API_PTR  SPI_API_CREATE(void) {
	SPI_API_PTR instance = (SPI_API_PTR) malloc(sizeof(struct SPI_API_T));
	SSP_Mux(LPC_SSP);
	SSP_Init(LPC_SSP);
	instance->write16bit = spi_write16;
	instance->transfer16bit = spi_transfer16;
	return instance;
}

void SPI_API_DESTROY(SPI_API_PTR instance) {
	free(instance);
}

static inline uint32_t spi_fillTransfer(uint16_t *txbuff, uint32_t transferSize){
	uint32_t transfered = 0;
	xf_setup.length = transferSize; /* total number of SPI transfers */
	xf_setup.tx_data = &txbuff[0]; /* SPI TX buffer */
	xf_setup.rx_cnt = xf_setup.tx_cnt = 0;
	/* Transfer message as SPI master via polling */
	Chip_GPIO_SetPinState(LPC_GPIO_PORT, 1, 8, false);
	transfered = Chip_SSP_RWFrames_Blocking(LPC_SSP, &xf_setup);
	Chip_GPIO_SetPinState(LPC_GPIO_PORT, 1, 8, true);
	return transfered;
}

/* Master SPI transmit in polling mode */
static uint32_t spi_write16(uint16_t *txbuff, uint32_t transferSize){
	/* Setup transfer record */
	xf_setup.rx_data = NULL;
	return spi_fillTransfer(txbuff, transferSize);
}

static uint32_t spi_transfer16(uint16_t *txbuff, uint16_t *rxbuff, uint32_t transferSize){
	/* Setup transfer record */
	xf_setup.rx_data = rxbuff;
	return spi_fillTransfer(txbuff, transferSize);
}
