/*
 * usd_api.h
 *
 *  Created on: 25.06.2015
 *      Author: Andreas
 */

#ifndef API_USD_API_H_
#define API_USD_API_H_

#include "chip.h"
#include "boardSetup.h"

/**
 * @brief possible frequencies for ultrasonic probe
 *
 */
typedef enum{
	Freq2MHz 		= 0x01,	/**< 2 MHz Transmitter frequency */
	Freq4MHz 		= 0x02,	/**< 4 MHz Transmitter frequency */
	Freq8MHz 		= 0x03,	/**< 8 MHz Transmitter frequency */
} Frequency;

/**
 * @brief usb request commands for CPLD controlling
 *
 */
typedef enum {
	FREQUENCY		= 5,		/**< write frequency to \ref USD_HW_VALUES */
	PRF				= 6,		/**< write PRF to \ref USD_HW_VALUES */
	BURST			= 7,		/**< write Burst to \ref USD_HW_VALUES */
	SAMPLE			= 8,		/**< write StartSampling to \ref USD_HW_VALUES */
	DEPTH			= 9,		/**< write Depth (Stop Sampling) to \ref USD_HW_VALUES */
	GATE			= 10,
	MODE			= 11,		/**< start / stop CPLD Doppler Mode */
	TX_ON			= 12,
	RX_ON			= 13,
	RESETDEV		= 14

} USB_CMD_REQUEST;

typedef enum {
	cmdPullData 	= 0x00,
	SETDELAY1		= 0x01,
	SETDEMOD		= 0x02,
	SETDELAY2		= 0x03,
	SETRETRANSMIT	= 0x04,
	SETSettings		= 0x05,
	GETDELAY1		= 0xF1,
	GETDEMOD		= 0xF2,
	GETDELAY2		= 0xF3,
	GETRETRANSMIT	= 0xF4,
	GETSettings		= 0xF5
} USD_REGISTER_REQUESTS;

typedef struct {
	uint8_t TX_ON;		/**< set Transmitter to on */
	uint8_t RX_ON;		/**< set Receiver to on */
	uint8_t ENABLE;		/**< set Statemaschine to run */
	uint8_t GATE_LENGTH;/**< set the Gate length */
	uint8_t FREQUENCY;	/**< set The Frequency (2 MHz = 1, 4 MHz = 2, 8 MHz = 3 */
} Settings;

/**
 * @brief CPLD state machine parameter structure
 *
 * This structure declares parameter for the state machine
 */
typedef struct {
	uint16_t prf;       /**< puls repetition frequency */
	uint16_t burst;     /**< burst volume [nr of cycles] */
	uint16_t sample;    /**< sample volume [nr of cycles] */
	uint16_t depht;     /**< midlle sample position [mm] */
	Settings settings;
} USD_HW_VALUES;

/**
 * \var typedef struct USD_HW_API* USD_HW_API_PTR
 * @brief class pointer / abstraction layer to handle CPLD state machine
 */
typedef struct USD_HW_API* USD_HW_API_PTR;

/** Sender class. Can be used to send a command to the server.
 *  The receiver will acknowledge the command by calling Ack().
 *  \msc
 *    Sender[label="USD_HW_API"],Receiver;
 *    Sender=>Receiver [label="Command()", URL="\ref Receiver::Command()"];
 *    Sender<=Receiver [label="Ack()", URL="\ref Ack()", ID="1"];
 *  \endmsc
 */
struct USD_HW_API{
	USD_HW_VALUES 	Config;
//	uint8_t			Mode;
	void 			(*ResetUSD)(void);
	void 			(*WriteConfig)(void);
	void 			(*ReadConfig)(uint16_t* data);
	void 			(*Start)(void);
	void 			(*Stop)(void);
};
extern USD_HW_API_PTR usdhandle;

USD_HW_API_PTR USD_HW_API_CREATE(void);
void USD_HW_API_DESTROY(USD_HW_API_PTR);


#endif /* API_USD_API_H_ */
