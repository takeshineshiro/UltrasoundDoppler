/*
 * BoardSetup.c
 *
 *  Created on: 27.05.2015
 *      Author: Andreas
 */

#include <stdio.h>
#include "BoardSetup.h"
#include "string.h"
#include "app_usbd_cfg.h"

/* System configuration variables used by chip driver */
//const uint32_t ExtRateIn = 0;
//const uint32_t OscRateIn = 12000000;



static Chip_SSP_DATA_SETUP_T xf_setup;



uint8_t ssp_transmit(LPC_SSP_T *pSSP, uint16_t *txbuff, uint16_t *rxbuff, uint32_t transferSize){
	xf_setup.length = transferSize;
	xf_setup.tx_data = txbuff;
	xf_setup.rx_data = rxbuff;
	xf_setup.rx_cnt = xf_setup.tx_cnt = 0;

	Chip_SSP_RWFrames_Blocking(pSSP, &xf_setup);
	return 0;//Buffer_Verify(txbuff, rxbuff, transferSize);
}

/*****************************************************************************
 * Private types/enumerations/variables
 ****************************************************************************/

/* Structure for initial base clock states */
struct CLK_BASE_STATES {
	CHIP_CGU_BASE_CLK_T clk;	/* Base clock */
	CHIP_CGU_CLKIN_T clkin;	/* Base clock source, see UM for allowable souorces per base clock */
	bool autoblock_enab;/* Set to true to enable autoblocking on frequency change */
	bool powerdn;		/* Set to true if the base clock is initially powered down */
};

/* Initial base clock states are mostly on */
STATIC const struct CLK_BASE_STATES InitClkStates[] = {

	/* Ethernet Clock base */
	//{CLK_BASE_PHY_TX, CLKIN_ENET_TX, true, false},
	//{CLK_BASE_PHY_RX, CLKIN_ENET_TX, true, false},

	/* Clocks derived from dividers */
	{CLK_BASE_USB1, CLKIN_IDIVD, true, true}
};

STATIC const PINMUX_GRP_T pinmuxing[] = {

	/* Board LEDs */
	//{0x6, 9, (SCU_MODE_INBUFF_EN | SCU_MODE_PULLUP | SCU_MODE_FUNC0)},
	//{0x6, 11, (SCU_MODE_INBUFF_EN | SCU_MODE_PULLUP | SCU_MODE_FUNC0)},
	//{0x2, 7, (SCU_MODE_INBUFF_EN | SCU_MODE_PULLUP | SCU_MODE_FUNC0)},

	/* USB1 V-BUS Enable pin */
	{0x2, 5, (SCU_MODE_INBUFF_EN | SCU_MODE_PULLUP | SCU_MODE_FUNC4)},
};


/* Sets up system pin muxing */
/*
static void USD_SetupMuxing(void)
{
	// Setup system level pin muxing
	Chip_SCU_SetPinMuxing(pinmuxing, sizeof(pinmuxing) / sizeof(PINMUX_GRP_T));
}
*/

/* Set up and initialize clocking prior to call to main */
static void USD_SetupClocking(void)
{
	int i;

	/* Enable Flash acceleration and setup wait states */
	Chip_CREG_SetFlashAcceleration(MAX_CLOCK_FREQ);

	/* Setup System core frequency to MAX_CLOCK_FREQ */
	Chip_SetupCoreClock(CLKIN_CRYSTAL, MAX_CLOCK_FREQ, true);
	//Chip_SetupCoreClock(CLKIN_IRC, MAX_CLOCK_FREQ, true);

	/* Setup system base clocks and initial states. This won't enable and
	   disable individual clocks, but sets up the base clock sources for
	   each individual peripheral clock. */
	for (i = 0; i < (sizeof(InitClkStates) / sizeof(InitClkStates[0])); i++) {
		Chip_Clock_SetBaseClock(InitClkStates[i].clk, InitClkStates[i].clkin,
								InitClkStates[i].autoblock_enab, InitClkStates[i].powerdn);
	}

	/* Reset and enable 32Khz oscillator */
	//LPC_CREG->CREG0 &= ~((1 << 3) | (1 << 2));
	//LPC_CREG->CREG0 |= (1 << 1) | (1 << 0);
}

/* Set up and initialize hardware prior to call to main */
void USD_SystemInit(void)
{
	/* Initialize board and chip */
	SystemCoreClockUpdate();

	/* Initializes GPIO */
	Chip_GPIO_Init(LPC_GPIO_PORT);

	/* Setup system clocking and memory. This is done early to allow the
	   application and tools to clear memory and use scatter loading to
	   external memory. */
	//USD_SetupMuxing();
	USD_SetupClocking();

	Chip_SCU_PinMuxSet(0x6, 7, (SCU_PINIO_FAST | SCU_MODE_FUNC4));
	Chip_GPIO_SetPinDIROutput(LPC_GPIO_PORT, 5, 15); //reset cpld
	Chip_GPIO_SetPinState(LPC_GPIO_PORT, 5, 15, true);
	Chip_GPIO_SetPinState(LPC_GPIO_PORT, 5, 15, false);
	Chip_GPIO_SetPinState(LPC_GPIO_PORT, 5, 15, true);

	Chip_GPIO_SetPinDIROutput(LPC_GPIO_PORT, 0, 8); //LED
	Chip_GPIO_SetPinState(LPC_GPIO_PORT, 0, 8, false); //LED off



}
