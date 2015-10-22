module Transmitter(
	input wire clk, gate,
	input wire[1:0] freqSel,
	output wire burstPos, burstNeg, PDWN_0, PDWN_1);

parameter freq8MHz = 2'b11, freq4MHz = 2'b10, freq2MHz = 2'b01;

reg[4:0] DivCnt;
wire freq;

always@(posedge clk) begin
	DivCnt <= (gate) ? DivCnt + 1 : 0;
	end
	
assign freq = (freqSel == freq8MHz) ? DivCnt[2] :
			  (freqSel == freq4MHz) ? DivCnt[3] :
			  (freqSel == freq2MHz) ? DivCnt[4] : DivCnt[2];

	assign burstPos = (freq && gate)? 1:0;
	assign burstNeg = (freq && gate)? 0:1;
	//DSL PowerDown := (0&&1) == High => FullPower (18mA); (0&&1) == low => Disabled (300µA); 0 && 1 != high => Standby (9mA)
	assign PDWN_0 = (gate) ? 1 : 0;
	assign PDWN_1 = (gate) ? 1 : 0;
 endmodule