`define Add   2'b00
`define Sub   2'b01
`define Multi 2'b10
`define Div	  2'b11
`define freq8MHz 2'b11
`define freq4MHz 2'b10
`define freq2MHz 2'b01

module Math(
	input wire clk, enable, reset,
	input wire[1:0] freqSel,
	input wire[13:0] adcValue,
	output wire modulated,
	output wire[63:0] Out);
	
parameter MG1 = 2'b01, MG2 = 2'b10;

wire[7:0] sin, cos;
wire[21:0] result1, result2;
reg[2:0] quadTableRotation;

wire[31:0] transform1, transform2, add11, add12;
reg[31:0] calculated1, calculated2;

wire write;
reg[5:0] DivCnt;
wire freq;

//Clockgeration for Sin/Cos LUT (8 Values => SamplingFrequency/8)
always@(posedge clk) DivCnt <= (enable) ? DivCnt + 1 : 0;
assign freq	= (freqSel == `freq8MHz) ? DivCnt[3] : //64/2/2/2 = 8 MHz
			  (freqSel == `freq4MHz) ? DivCnt[4] : //64/2/2/2/2 = 4 MHz
			  (freqSel == `freq2MHz) ? DivCnt[5] : DivCnt[0]; //64/2/2/2/2/2 = 2 MHz
assign write = freq | reset;

//LUT rotation + sync for addition
always@(negedge write) begin
	quadTableRotation <= (enable) ? quadTableRotation + 1 : quadTableRotation;
	calculated1 <= (enable) ? add11 : {32{1'b0}};
	calculated2 <= (enable) ? add12 : {31{1'b0}};
	if(reset) quadTableRotation <= 0;
	end

/* --- TESTED --- */
//Demodulation LUT and rotaiton
Quad_Table quad(.Clock(clk), .ClkEn(enable), .Reset(~enable), .Theta(quadTableRotation), .Sine(sin), .Cosine(cos));	

/* --- TESTED --- */
//Demodulation HF => NF
ALU #(.Width(22), .WidthA(8), .WidthB(14)) m1(.clk(~clk), .a(sin), .b(adcValue), .op(`Multi), .result(result1));
ALU #(.Width(22), .WidthA(8), .WidthB(14)) m2(.clk(~clk), .a(cos), .b(adcValue), .op(`Multi), .result(result2));

/* --- TESTED --- */
//Transform Bitarray form 22 bits to 32bits (for overflow reduction)
assign transform1 = (result1[21] == 1) ? ({10{1'b1}} << 22) | result1 : ({10{1'b0}} << 22) | result1;
assign transform2 = (result2[21] == 1) ? ({10{1'b1}} << 22) | result2 : ({10{1'b0}} << 22) | result2;

/* --- TESTED --- */
//lowpass filter - addition
ALU #(.Width(32)) alu11(.clk(~clk), .a(transform1), .b(calculated1), .op(`Add), .result(add11));
ALU #(.Width(32)) alu12(.clk(~clk), .a(transform2), .b(calculated2), .op(`Add), .result(add12));

//create defined 64bitfiled (32 bit sin and 32 high bits cos)
assign Out = add11 | ( add12 << 32);
//actully not in use
assign modulated = quadTableRotation[0];

endmodule