module Receiver #(
	parameter Divbit = 3, ADCdelay = 7, ADCbits = 14, StartAt = 1'b1)
   (input wire clk, enable,
	input wire [ADCbits-1:0] pins,
	output wire adcClk,
	output wire ready, pwdn,
	output wire [ADCbits-1:0] out);

reg [Divbit-1:0] clkCnt;
reg [2:0] adcClkCnt;

assign pwdn = 0;//~enable;
assign out 		= (enable) ? pins : 0;
assign adcClk 	= (Divbit != 0) ? clkCnt[Divbit-1] : clk;
assign ready	= (adcClkCnt == ADCdelay);

always@(posedge clk) clkCnt <= (enable) ? clkCnt + 1 : (Divbit != 0) ? {Divbit{StartAt}} : 0;

always@(posedge adcClk) begin
	if(enable) adcClkCnt <= (adcClkCnt != ADCdelay) ? adcClkCnt + 1 : adcClkCnt;
	else 	   adcClkCnt <= 0;
	end

endmodule
