`define adcWidth 14
module Peripherie
   (input wire clk, txEnable, rxEnable,
	input wire[1:0] freqSel,
	input wire [`adcWidth-1:0] adcPins,
	output wire txBurstPos, txBurstNeg, txPwdn_0, txPwdn_1, rxClk, rxPwdn, rxReady,
	output wire[`adcWidth-1:0] adcIn);

/* --- TESTED --- */
	Transmitter 	tx(.burstNeg(txBurstNeg), .burstPos(txBurstPos), .clk(clk), .freqSel(freqSel),
									.gate(txEnable), .PDWN_0(txPwdn_0), .PDWN_1(txPwdn_1));
	
/* --- TESTED --- */
	Receiver #(.Divbit(3), .ADCdelay(7), .ADCbits(`adcWidth), .StartAt(1'b1))
					rx (.clk(clk), .enable(rxEnable), .pins(adcPins), .adcClk(rxClk), 
							.ready(rxReady), .pwdn(rxPwdn), .out(adcIn));
	
endmodule
