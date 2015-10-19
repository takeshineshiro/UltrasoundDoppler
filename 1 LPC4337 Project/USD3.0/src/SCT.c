/*
 * SCT.c
 *
 *  Created on: 13.08.2015
 *      Author: rehna
 */

#include "SCT.h"
#include "chip.h"
#include "board.h"
#include <stdlib.h>
#include <stdio.h>
#include <string.h>


typedef struct DATAPORT_T* DATAPORT_PTR;
typedef struct {
	uint32_t* ADDRESS;
	uint16_t  LENGTH;
	uint16_t  INCREMENT;
} BUFFER_T;

struct DATAPORT_T{
	void (*callback)(TransferType dataType);
	BUFFER_T base;
	BUFFER_T harmonic;
	BUFFER_T rf;
} DATAPORT;

#define DATA_TO_TRANSFER		1024
#define TRANSFER_COUNT			1024
#define USB_DEST_ADDR           buffer

#define DATA0()		   LPC_SCU->SFSP[7][3] = (SCU_MODE_INACT | SCU_MODE_INBUFF_EN | SCU_MODE_PULLDOWN | SCU_MODE_HIGHSPEEDSLEW_EN | SCU_MODE_FUNC1)	// input low (pull down)
#define DATA1()		   LPC_SCU->SFSP[7][3] = (SCU_MODE_INACT | SCU_MODE_INBUFF_EN | SCU_MODE_PULLUP   | SCU_MODE_HIGHSPEEDSLEW_EN | SCU_MODE_FUNC1)	// input high (pull up)

//#define DATA0()		   LPC_SCU->SFSP[2][4] = 0x5B	// input low (pull down)
//#define DATA1()		   LPC_SCU->SFSP[2][4] = 0x43	// input high (pull up)

/*! @brief Initialize for next DMA xfer, data flow from GPIO to SDRAM
*
* @ Use of GPDMA is critical for this application to offload CPU. GPDMA has 2 bus masters,
* #0 master can only do memory xfer, while #1 master can do both memory and peripheral xfer
* unlike memory xfer, peripheral xfer do only 1 bust per request, while the former stops only all done
* so we need to use peripheral -> memory xfer, and give #1 master to source, #0 master to dest (SDRAM).
*/
inline void prvInitDMAXferDir(bool zero)
{
	if(zero) counter = 0;
	LPC_GPDMA->CH[0].CONFIG =	(0 <<  0) | // Channel disabled
								(8 <<  1) | // Source request peripheral from SCT DMA request 1
								(0 <<  6) | // DMA Destination request peripheral (memory)
								(2 << 11) | // Peripheral to memory
								(1 << 15);	// Interrupts enabled
	LPC_GPDMA->CH[0].LLI = 0;
	LPC_GPDMA->CH[0].SRCADDR =  (uint32_t) &LPC_GPIO_PORT->PIN[DATA_GPIO_PORT];
	LPC_GPDMA->CH[0].DESTADDR = (uint32_t) USB_DEST_ADDR + counter;
	counter += TRANSFER_COUNT;
	if(counter >= 8*SAMPLES) counter = 0;

	//TODO: ACHTUNG!! + 1 für Size sonst lücke..
	LPC_GPDMA->CH[0].CONTROL = 	(uint32_t)
						  ((DATA_TO_TRANSFER) <<  0) | //size
								(0 << 12) | //SrcBurst=1
								(1 << 15) | //DesBurst=4
								(0 << 18) | //SrcWidth=8
								(2 << 21) | //DesWidth=32 // 2 for 32
								(1 << 24) | //SrcBusMaster=1
								(0 << 25) | //SrcBusMaster=0
								(0 << 26) | //SrcIncrement=false
								(1 << 27) | //DesIncrement=true
								(1 << 28) | //Privilege
								(3 << 29) | //B,C ???
								(1 << 31);  //Interrupt=true

	LPC_GPDMA->CH[0].CONFIG |= 1; 	// Channel Enable 3073 4096

	//CTIN3

}

void DMA_IRQHandler(void){
	uint32_t intTCStat = LPC_GPDMA->INTTCSTAT;
	if (intTCStat & (1 << 0))
		{
			prvInitDMAXferDir(false);
			DATAPORT.callback(ROI_Base);
		}
	LPC_GPDMA->INTTCCLEAR = intTCStat;

}

/*! @brief SCT IRQ handler, mainly for initializing the next DMA trnafer
*
* Respond to events:
*
*		HARM rising edge ( prepare for next DMA xfer)
*		ROI falling edge ( reset rx buffer and prepare for next (1st) DMA xfer)
*/
void SCT_IRQHandler(void)
{
	LPC_SCT->EVFLAG 		= 0xFFFF;	// clear evt flags

	//DATAPORT.callback(ROI_Base);
	//LPC_SCT->CTRL_U |= (1 << 3) | (1 << 19);			// clear the L & H counter
	/*	LPC_SCT->CTRL_L |=  (1 << 3);                      // clear the L counter
	LPC_SCT->CTRL_H |=  (1 << 3);                      // clear the H counter



	LPC_SCT->CTRL_L &= ~(1 << 1);                      // start the L counter
	LPC_SCT->CTRL_H &= ~(1 << 1);                      // start the H counter


	LPC_SCT->CTRL_U &= ~(1 << 1) | ~(1 << 17);			// start the L & H counter
*/

}

static void pinmuxDataPort(uint8_t port){
	PINMUX_GRP_T DataPort[] = {
		// BUS - Port, Pin, Function
		{port, 1, (SCU_PINIO_FAST | SCU_MODE_FUNC0)},
		{port, 2, (SCU_PINIO_FAST | SCU_MODE_FUNC0)},
		{port, 3, (SCU_PINIO_FAST | SCU_MODE_FUNC0)},
		{port, 4, (SCU_PINIO_FAST | SCU_MODE_FUNC0)},
		{port, 5, (SCU_PINIO_FAST | SCU_MODE_FUNC0)},
		{port, 9, (SCU_PINIO_FAST | SCU_MODE_FUNC0)},
		{port, 10, (SCU_PINIO_FAST | SCU_MODE_FUNC0)},
		{port, 11, (SCU_PINIO_FAST | SCU_MODE_FUNC0)},
	};

	for(int i=0; i < sizeof(DataPort) / sizeof(PINMUX_GRP_T); i++){
		Chip_SCU_PinMuxSet(DataPort[i].pingrp, DataPort[i].pinnum, DataPort[i].modefunc);
		Chip_GPIO_SetPinDIRInput(LPC_GPIO_PORT, port, i);
	}

	//CONTROL
	PINMUX_GRP_T DataPortCTRL[] = {
		{0x2,  4, (SCU_MODE_INACT | SCU_MODE_INBUFF_EN | SCU_MODE_HIGHSPEEDSLEW_EN | SCU_MODE_FUNC3)},	// SCTIN_0
		{0x2,  3, (SCU_MODE_INACT | SCU_MODE_INBUFF_EN | SCU_MODE_HIGHSPEEDSLEW_EN | SCU_MODE_FUNC3)},	// SCTIN_1
		{0x2,  5, (SCU_MODE_INACT | SCU_MODE_INBUFF_EN | SCU_MODE_HIGHSPEEDSLEW_EN | SCU_MODE_FUNC1)},	// SCTIN_2
		{0x7,  3, (SCU_MODE_INACT | SCU_MODE_INBUFF_EN | SCU_MODE_HIGHSPEEDSLEW_EN | SCU_MODE_FUNC1)},	// SCTIN_3
		{0x2, 13, (SCU_MODE_INACT | SCU_MODE_INBUFF_EN | SCU_MODE_HIGHSPEEDSLEW_EN | SCU_MODE_FUNC1)},	// SCTIN_4
		{0x1,  6, (SCU_MODE_INACT | SCU_MODE_INBUFF_EN | SCU_MODE_HIGHSPEEDSLEW_EN | SCU_MODE_FUNC1)},	// SCTIN_5 DATA_CLK
		{0x2,  2, (SCU_MODE_INACT | SCU_MODE_INBUFF_EN | SCU_MODE_HIGHSPEEDSLEW_EN | SCU_MODE_FUNC5)},	// SCTIN_6
		{0x2,  6, (SCU_MODE_INACT | SCU_MODE_INBUFF_EN | SCU_MODE_HIGHSPEEDSLEW_EN | SCU_MODE_FUNC5)},	// SCTIN_7

		{0x2, 10, (SCU_MODE_INACT | SCU_MODE_FUNC1)}	// SCTOUT2 (GPIO0[7])
	};

	for(int i=0; i < sizeof(DataPortCTRL) / sizeof(PINMUX_GRP_T); i++){
		Chip_SCU_PinMuxSet(DataPortCTRL[i].pingrp, DataPortCTRL[i].pinnum, DataPortCTRL[i].modefunc);
	}
	Chip_GPIO_SetPinDIROutput(LPC_GPIO_PORT, 2, 10);
	//Chip_SCU_PinMuxSet(  2,  8, (MD_PLN | FUNC1));            // pin P2_8  is SCT_OUT0
}



#define freq 13000000
#define counts 16

static void setupSCT(void){
	Chip_SCT_Init(LPC_SCT);

	LPC_SCT->CONFIG		= SCT_CONFIG_32BIT_COUNTER  |				// unified counter (16 bit)
						  SCT_CONFIG_CLKMODE_BUSCLK |				// clock for SCT is BUS clock
						  //0 << 9;
						  (_BIT(SCT_ROI) | _BIT(SCT_CLK) << 9); 	// synced inputs

	LPC_SCT->LIMIT_L 	= 0xFFFF; // EventClearCounter

	LPC_SCT->STATE_L = ROI_READ;

	// setup channel 0 event
	LPC_SCT->EVENT[ROI_fall].STATE = (1 << ROI_READ);        	// event happens in state ROI_READ
	LPC_SCT->EVENT[ROI_fall].CTRL  = (SCT_ROI <<  6) |	// IN_7
									       (2 << 10) |	// falling edge
										   (2 << 12) |	// IO condition only
										   (1 << 14) |	// STATELD [14]	= STATEV is loaded into state
										 (ROI << 15);	// STATEV [15]	= new state is ROI

	LPC_SCT->EVENT[ROI_rise].STATE = (1 << ROI);        		// event happens in state ROI
	LPC_SCT->EVENT[ROI_rise].CTRL  = (SCT_ROI <<  6) |	// IN_7
										   (1 << 10) |	// rising edge
										   (2 << 12) |	// IO condition only
										   (1 << 14) |	// STATELD [14]	= STATEV is loaded into state
								    (ROI_READ << 15);	// STATEV [15]	= new state is ROI_READ

	// setup channel 1 event
	LPC_SCT->EVENT[CLK_rise].STATE = (1 << ROI_READ);        	// event happens in state ROI_READ
	LPC_SCT->EVENT[CLK_rise].CTRL  = (SCT_CLK <<  6) |	// IN_7
									 	   (1 << 10) |	// rising edge
									 	   (2 << 12) |	// IO condition only
										   (1 << 14) |	// STATELD [14]	= STATEV is loaded into state
								    (ROI_READ << 15);	// STATEV [15]	= new state is ROI_READ

	LPC_SCT->DMA1REQUEST	= (1 << CLK_rise);
	LPC_SCT->EVFLAG 		= 0xFFFF;	// clear evt flags
	LPC_SCT->EVEN 			= (1 << ROI_fall);

	NVIC_EnableIRQ(SCT_IRQn);


	/* Start the SCT */
	LPC_SCT->CTRL_U &= ~(SCT_CTRL_HALT_L | SCT_CTRL_STOP_L | SCT_CTRL_STOP_H | SCT_CTRL_HALT_H);
}
static void initDMA() {
	// configure DMAMUX to select SCT as the request source

	uint32_t temp = LPC_CREG->DMAMUX & (~(0x03 << (2 * 8)));
	LPC_CREG->DMAMUX = temp | (2 << (2 * 8));
	// Initialize GPDMA controller
	Chip_GPDMA_Init(LPC_GPDMA);
	// Reset all channel configuration register
	for (int ch = 0; ch < GPDMA_NUMBER_CHANNELS; ch++) {
		LPC_GPDMA->CH[ch].CONFIG = 0;
	}
	// Clear all DMA interrupt and error flag
	LPC_GPDMA->INTTCCLEAR = 0xFF;
	LPC_GPDMA->INTERRCLR = 0xFF;
	// Clear DMA configure
	// Enable DMA channels, little endian
	LPC_GPDMA->CONFIG = GPDMA_DMACConfig_E;
	LPC_GPDMA->SYNC = 0;

	LPC_GPDMA->CH[0].CONFIG = (0 << 0) | // Channel disabled
				(8 << 1) | // Source request peripheral from SCT DMA request 1
				(0 << 6) | // DMA Destination request peripheral (memory)
				(2 << 11)| // Peripheral to memory
				(1 << 15); // IRQ ENable

	LPC_GPDMA->CH[0].CONTROL = 0x00;
	LPC_GPDMA->CH[0].LLI = 0;
	LPC_GPDMA->CH[0].SRCADDR = (uint32_t) &LPC_GPIO_PORT->PIN[DATA_GPIO_PORT];
	LPC_GPDMA->CH[0].DESTADDR = (uint32_t) USB_DEST_ADDR;
	LPC_GPDMA->CH[0].CONTROL = (uint32_t) ((DATA_TO_TRANSFER) << 0) | //size
			(0 << 12) | //SrcBurst=1
			(1 << 15) | //DesBurst=4
			(0 << 18) | //SrcWidth=8
			(2 << 21) | //DesWidth=32 // 2 for 32
			(1 << 24) | //SrcBusMaster=1
			(0 << 25) | //SrcBusMaster=0
			(0 << 26) | //SrcIncrement=false
			(1 << 27) | //DesIncrement=true
			(1 << 28) | //Privilege
			(3 << 29) | //B,C ???
			(1 << 31);  //Interrupt=true
	counter += TRANSFER_COUNT;


	/* Enable GPDMA interrupt */
	NVIC_EnableIRQ(DMA_IRQn);
	LPC_GPDMA->CH[0].CONFIG |= 1; // Channel Enable
}

void USD_HW_DATAPORT_CREATE(void (*ROI_dataReceived)(TransferType dataType)){
	DATAPORT.callback = ROI_dataReceived;
}

void USD_HW_DATAPORT_BUFFER_SET(void* buffer, uint16_t bufferSize, uint16_t bufferIncrement, TransferType dataType){
	switch(dataType){
	case ROI_Base:
		DATAPORT.base.ADDRESS = buffer;
		DATAPORT.base.LENGTH = bufferSize;
		DATAPORT.base.INCREMENT = bufferIncrement;
		break;
	case ROI_Harmonics:
		DATAPORT.harmonic.ADDRESS = buffer;
		DATAPORT.harmonic.LENGTH = bufferSize;
		DATAPORT.harmonic.INCREMENT = bufferIncrement;
		break;
	case ROI_RF:
		DATAPORT.rf.ADDRESS = buffer;
		DATAPORT.rf.LENGTH = bufferSize;
		DATAPORT.rf.INCREMENT = bufferIncrement;
		break;
	}
}

void USD_HW_DATAPORT_START(void){
	pinmuxDataPort(DATA_GPIO_PORT+3);
	initDMA();
	/* Initialize SCT */
	setupSCT();

}
