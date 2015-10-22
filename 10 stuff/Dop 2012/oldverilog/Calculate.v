`define Add   2'b00
`define Sub   2'b01
`define Multi 2'b10
`define Div	  2'b11

module Demodulate(
	input wire clk, enable, reset,
	input wire[1:0] freqSel,
	input wire[13:0] adcValue,
	output wire modulated,
	output wire[63:0] Out);
	
parameter MG1 = 2'b01, MG2 = 2'b10;
parameter freq8MHz = 2'b11, freq4MHz = 2'b10, freq2MHz = 2'b01;

wire[7:0] sin, cos;
wire[21:0] result1, result2;
reg[2:0] quadTableRotation;

wire[31:0] transform1, transform2, add11, add12;
reg[31:0] calculated1, calculated2;

wire write;

reg[4:0] DivCnt;
wire freq;
always@(posedge write) begin
	DivCnt <= (enable) ? DivCnt + 1 : 0;
	end
	
assign freq = (freqSel == freq8MHz) ? DivCnt[2] :
			  (freqSel == freq4MHz) ? DivCnt[3] :
			  (freqSel == freq2MHz) ? DivCnt[4] : DivCnt[2];

assign write = freq | reset;

always@(negedge write) begin
	quadTableRotation <= (enable) ? quadTableRotation + 1 : quadTableRotation;
	calculated1 <= (enable) ? add11 : {32{1'b0}};
	calculated2 <= (enable) ? add12 : {31{1'b0}};
	if(reset) quadTableRotation <= 0;
	end

/* --- TESTED --- */
Quad_Table quad(.Clock(clk), .ClkEn(enable), .Reset(~enable), .Theta(quadTableRotation), .Sine(sin), .Cosine(cos));	

/* --- TESTED --- */
ALU #(.Width(22), .WidthA(8), .WidthB(14)) m1(.clk(~clk), .a(sin), .b(adcValue), .op(`Multi), .result(result1));
ALU #(.Width(22), .WidthA(8), .WidthB(14)) m2(.clk(~clk), .a(cos), .b(adcValue), .op(`Multi), .result(result2));

/* --- TESTED --- */
assign transform1 = (result1[21] == 1) ? ({10{1'b1}} << 22) | result1 : ({10{1'b0}} << 22) | result1;
assign transform2 = (result2[21] == 1) ? ({10{1'b1}} << 22) | result2 : ({10{1'b0}} << 22) | result2;

/* --- TESTED --- */
ALU #(.Width(32)) alu11(.clk(~clk), .a(transform1), .b(calculated1), .op(`Add), .result(add11));
ALU #(.Width(32)) alu12(.clk(~clk), .a(transform2), .b(calculated2), .op(`Add), .result(add12));


assign Out = add11 | ( add12 << 32);
assign modulated = quadTableRotation[0];

endmodule