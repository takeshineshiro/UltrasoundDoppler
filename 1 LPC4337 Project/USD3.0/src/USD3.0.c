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
#include "usd_api.h"
#include "SCT.h"

// TODO: insert other definitions and declarations here
USB_API_PTR usb;
USD_HW_API_PTR usdhandle;

volatile uint8_t buffer[8*SAMPLES] = {0};
uint32_t counter = 0;
uint8_t config_changed;

void ROI_dataReceived(TransferType dataType){
	if(config_changed) {
		usdhandle->WriteConfig();
		config_changed = 0;
	}
	if(usdhandle->Config.settings.ENABLE == 1) usdhandle->Start();
	else {
		usdhandle->WriteConfig();
	}
}

void PerformUSB_Vendor(uint8_t cmd, uint16_t value){
	switch(cmd){
		case FREQUENCY:
			usdhandle->Config.settings.FREQUENCY = value;
			config_changed = 1;
			break;
		case PRF:
			usdhandle->Config.prf = value;
			config_changed = 1;
			break;
		case BURST:
			usdhandle->Config.burst = value;
			config_changed = 1;
			break;
		case SAMPLE:
			usdhandle->Config.sample = value;
			config_changed = 1;
			break;
		case DEPTH:
			usdhandle->Config.depht = value;
			config_changed = 1;
			break;
	/*	case GATE:
			usdhandle->Config.settings.GATE_LENGTH = value;
			usdhandle->WriteConfig();
			break;*/
		case TX_ON:
			usdhandle->Config.settings.TX_ON = value;
			config_changed = 1;
			break;
		case RX_ON:
			usdhandle->Config.settings.RX_ON = value;
			config_changed = 1;
			break;
		case MODE:
			/*if(value == 1) usdhandle->Start();
			*/
			if(value == 1){
				usdhandle->Config.settings.ENABLE = 1;
				prvInitDMAXferDir(true);
				usdhandle->Start();
			}
			else{
				usdhandle->Config.settings.ENABLE = 0;
			}
			break;
		case RESETDEV:
			usdhandle->ResetUSD();
			break;
		default:
			break;
	} //end switch
}

int main(void) {
	USD_SystemInit();
    usdhandle = USD_HW_API_CREATE();

    USD_HW_DATAPORT_CREATE(ROI_dataReceived);
    USD_HW_DATAPORT_START();

    usb = USB_API_CREATE();

    // Enter an infinite loop, just incrementing a counter
    while(1){

    }
}
