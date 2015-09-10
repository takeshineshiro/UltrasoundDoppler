/*
 * SCT.h
 *
 *  Created on: 13.08.2015
 *      Author: rehna
 */

#ifndef SCT_H_
#define SCT_H_

#include "chip.h"

#define DATA_GPIO_PORT 		0x3 //1 //3 für platine 1 für eval

//sct inputs
#define SCT_CLK		1
#define	SCT_ROI		0
#define	SCT_HARM	3

#define SAMPLES 2048

//events
enum{
	ROI_fall = 0,
	ROI_rise,
	HARM_fall,
	HARM_rise,
	CLK_rise
} SCTevents;

//states
enum{
	ROI = 0,
	ROI_READ,
	HARMONICS
};

void setupSCTevents(void);

typedef enum{
	ROI_Base,
	ROI_Harmonics,
	ROI_RF
}TransferType;

extern volatile uint16_t buffer[5*SAMPLES];
extern uint32_t counter;

void USD_HW_DATAPORT_CREATE(void (*ROI_dataReceived)(TransferType dataType));
void USD_HW_DATAPORT_BUFFER_SET(void* buffer, uint16_t bufferSize, uint16_t bufferIncrement, TransferType dataType);
void USD_HW_DATAPORT_START(void);
#endif /* SCT_H_ */
