`include "Defines.v"

module Demodulate(
	input DEMODCLK, ENABLE, RESET, //CORECLK,
	//input wire[1:0] FREQUENCY,
	input wire[2:0] GATEdiv,
	input wire[13:0] adcValue,
	input wire[7:0] SVLength,
	output reg[31:0] IN, QUAD,
	output wire WRITE);
	
localparam
InitState 		= 3'd0,
Add1State 		= 3'd1,
Add1ToSVState 	= 3'd2,
Add2State		= 3'd3,
Add2ToSVState	= 3'd4;
	
reg[2:0] currentState, nextState;
reg[15:0] Count, SVBuildCount;
reg[31:0] Result_Re[0:1], Result_Im[0:1];
wire[7:0] sine, cosine;
wire [21:0] re_wire, im_wire;


// --- LUT Sin-Cosine Table ---
Quad_Table quad(.Theta(Count[2:0]), .Sine(sine), .Cosine(cosine));
multiply m_im(.Clock(DEMODCLK), .ClkEn(ENABLE), .Aclr(RESET), .DataA(cosine), .DataB(adcValue), .Result(im_wire));
multiply m_re(.Clock(DEMODCLK), .ClkEn(ENABLE), .Aclr(RESET), .DataA(sine), .DataB(adcValue), .Result(re_wire));
//Transform Bitarray form 22 bits to 32bits (for overflow reduction)
wire[31:0] transformRe = (re_wire[21] == 1) ? {{10{1'b1}}, re_wire} : {{10{1'b0}}, re_wire};
wire[31:0] transformIm = (im_wire[21] == 1) ? {{10{1'b1}}, im_wire} : {{10{1'b0}}, im_wire};

assign WRITE = (SVBuildCount == SVLength);
	
always@(posedge DEMODCLK) begin
	case (currentState)
		InitState 		: begin
			IN 	 <= 0; 
			QUAD <= 0;
			Result_Re[0] <= 0;
			Result_Im[0] <= 0;
			Result_Re[1] <= 0;
			Result_Im[1] <= 0;
			SVBuildCount <= 0;
		end
		Add1State		: begin
			IN <= IN;
			QUAD <= QUAD;
			Result_Re[0] <= transformRe + Result_Re[0];
			Result_Im[0] <= transformIm + Result_Im[0];
			Result_Re[1] <= 0;
			Result_Im[1] <= 0;
			end
		Add1ToSVState	: begin
			IN 	 <= (SVBuildCount != 0) ? Result_Re[0] : 0;
			QUAD <= (SVBuildCount != 0) ? Result_Im[0] : 0;
			Result_Re[0] <= Result_Re[0];
			Result_Im[0] <= Result_Im[0];
			Result_Re[1] <= transformRe + Result_Re[1];
			Result_Im[1] <= transformIm + Result_Im[1];
			SVBuildCount <= (WRITE) ? 0 : SVBuildCount;
		end
		Add2State		: begin
			IN <= IN;
			QUAD <= QUAD;
			Result_Re[0] <= 0;
			Result_Im[0] <= 0;
			Result_Re[1] <= transformRe + Result_Re[1];
			Result_Im[1] <= transformIm + Result_Im[1];
			end
		Add2ToSVState	: begin
			IN 	 <= Result_Re[1];
			QUAD <= Result_Im[1];
			Result_Re[0] <= transformRe + Result_Re[0];
			Result_Im[0] <= transformIm + Result_Im[0];
			Result_Re[1] <= Result_Re[1];
			Result_Im[1] <= Result_Im[1];	 
			SVBuildCount <= SVBuildCount + 1'b1;
		end
		default			: begin
			IN 	 <= IN;
			QUAD <= QUAD;
			Result_Re[0] <= Result_Re[0];
			Result_Im[0] <= Result_Im[0];
			Result_Re[1] <= Result_Re[1];
			Result_Im[1] <= Result_Im[1];
		end
		endcase
end
reg[2:0] preCount;
always@(posedge DEMODCLK, posedge RESET) begin : FSM
	if(RESET) begin : RESET
		Count 		 <= #`DELAY 0;
		preCount	 <= #`DELAY 0;
		currentState <= InitState;
	end
	else begin : RUN
		preCount	 <= #`DELAY (ENABLE && preCount <= 3) ? preCount + 1'b1 : preCount;
		Count 		 <= #`DELAY (ENABLE && preCount >= 3) ? Count + 1'b1 : 0;
		currentState <= #`DELAY (ENABLE) ? nextState : InitState;
	end
end				 
	
always@(*) begin : NextStateLogic
	nextState = currentState;
	case (currentState)
	InitState 		: 						nextState = Add1State;
	Add1State 		: if(Count[GATEdiv])	nextState = Add1ToSVState;
	Add1ToSVState	: 						nextState = Add2State;
	Add2State		: if(~Count[GATEdiv])	nextState = Add2ToSVState;
	Add2ToSVState	: 						nextState = Add1State;
	endcase
end

endmodule

/* CoreClock und clk sync probleme, da start sync.. */
/*
quad t1(clk, ENdemod, reset, GateDivider, adcValue, SV_re, SV_im);

reg[7:0] counter;
reg writeData;
always@(posedge clk or posedge reset) begin : count
	if(reset) begin : reset
		counter <= #`DELAY 0;
		writeData <= #`DELAY 0;
	end
	else begin : run
		counter <= #`DELAY (~ENwrite || writeData) ? 0 : counter + 1;
		writeData <= #`DELAY (counter == sampleVolumeLength && ~writeData);
	end
end
 
 assign Write = writeData;

endmodule*/
/*
module quad(
	input wire clk, enable, reset,
	input wire[2:0] GateDivider,
	input wire[13:0] adcValue,
	output reg[31:0] Re, Im);

wire [21:0] re_wire, im_wire;
wire [7:0] sine, cosine;
wire[31:0] transformRe, transformIm, Result_Re, Result_Im;//, Result_Sv_Re, Result_Sv_Im;

reg[31:0] uGateRePos, uGateReNeg, uGateImPos, uGateImNeg;

reg[7:0] GateCounter;
always@(posedge clk or posedge reset) begin : FSM
	if(reset || ~enable) begin : RESET
		GateCounter <= #`DELAY 0;
		uGateRePos <= #`DELAY 0;
		uGateImPos <= #`DELAY 0;
		uGateReNeg <= #`DELAY 0;
		uGateImNeg <= #`DELAY 0;
		Re <= #`DELAY 0;
		Im <= #`DELAY 0;
	end
	else begin : RUN
		GateCounter <= #`DELAY GateCounter + 1'b1;
		uGateRePos  <= #`DELAY (GateCounter[GateDivider]) ? Result_Re : 0;
		uGateImPos  <= #`DELAY (GateCounter[GateDivider]) ? Result_Im : 0;
		uGateReNeg  <= #`DELAY (~GateCounter[GateDivider]) ? Result_Re : 0;
		uGateImNeg  <= #`DELAY (~GateCounter[GateDivider]) ? Result_Im : 0;
		Re <= #`DELAY Result_Re;
		Im <= #`DELAY Result_Im;
	end
end
quad_table quad(.Clock(clk), .ClkEn(enable), .Reset(reset), .Theta(GateCounter[2:0]), .Sine(sine), .Cosine(cosine));
multiply m_re(.Clock(clk), .ClkEn(enable), .Aclr(reset), .DataA(sine), .DataB(adcValue), .Result(re_wire));
multiply m_im(.Clock(clk), .ClkEn(enable), .Aclr(reset), .DataA(cosine), .DataB(adcValue), .Result(im_wire));


// --- TESTED ---
//Transform Bitarray form 22 bits to 32bits (for overflow reduction)
assign transformRe = (re_wire[21] == 1) ? {{10{1'b1}}, re_wire} : {{10{1'b0}}, re_wire};
assign transformIm = (im_wire[21] == 1) ? {{10{1'b1}}, im_wire} : {{10{1'b0}}, im_wire};

add32 a_re(.DataA(GateCounter[GateDivider] ? uGateRePos : uGateReNeg), .DataB(transformRe), .Result(Result_Re));
add32 a_im(.DataA(GateCounter[GateDivider] ? uGateImPos : uGateImNeg), .DataB(transformIm), .Result(Result_Im));

endmodule
	*/