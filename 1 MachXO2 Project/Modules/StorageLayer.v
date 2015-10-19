`include "Defines.v"
module Storeage(
// ------------------------------------------------------------
// Inputs
// ------------------------------------------------------------
input wire CLK,
input wire MODE,
input wire WRITE,
input wire READ,
input wire[15:0] DIN,
input wire[31:0] RE_IN, IM_IN,
input wire ENABLE,
input wire RESET,
// ------------------------------------------------------------

// ------------------------------------------------------------
// Outputs
// ------------------------------------------------------------
output wire[`MEM_ADDR_WIDTH-1:0] DOUT,
output reg READY2READ,
output reg READY2WRITE
//output wire FLAGHIGH, FLAGLOW
// ------------------------------------------------------------
);
wire [`MEM_ADDR_WIDTH-1:0] Data_DOP;
wire FlagAE_DOP, FlagAF_DOP, FlagFULL_DOP, FlagEmpty_DOP;

assign DOUT 	= Data_DOP;


wire [7:0] Data_OSZI;
wire FlagAE_OSZI, FlagAF_OSZI, FlagFULL_OSZI, FlagEmpty_OSZI;				
wire FlagAE	 	= (MODE == `OSZI_MODE) ? FlagAE_OSZI : FlagAE_DOP;
wire FlagAF 	= (MODE == `OSZI_MODE) ? FlagAF_OSZI : FlagAF_DOP;
assign DOUT 	= (MODE == `OSZI_MODE) ? Data_OSZI : Data_DOP;

 reg[1:0] canReadAF;
 reg[1:0] canReadAE;
always@(posedge CLK or posedge RESET) begin : FLAG_UPDATE
	if(RESET) begin 
		READY2READ  <= 1'b0;
		READY2WRITE <= 1'b1;
		canReadAF <= 2'b00;
		canReadAE <= 2'b00;
	end
	else begin
		canReadAE <= {canReadAE[0], FlagAE};
		canReadAF <= {canReadAF[0], FlagAF};
		READY2WRITE <= (canReadAF == 3'b01) ? 0 : (canReadAE == 3'b01) ? 1 : READY2WRITE;
		READY2READ  <= (canReadAF == 3'b01) ? 1 : (canReadAE == 3'b01) ? 0 : READY2READ;
	end
end

FIFO_OUT ebr1	(.Data(DIN), .WrClock(WRITE && (MODE == `OSZI_MODE)), .RdClock(READ && (MODE == `OSZI_MODE)), .WrEn(ENABLE), .RdEn(ENABLE), .Reset(RESET), .RPReset(RESET), 
    .Q(Data_OSZI), .Empty(FlagEmpty_OSZI), .Full(FlagFULL_OSZI), .AlmostEmpty(FlagAE_OSZI), .AlmostFull(FlagAF_OSZI));

//
//first Q is ever Zero!!!
/*
FIFO_EBR_2x ebr2	(.Data({IM_IN, RE_IN}), .WrClock(WRITE), .RdClock(READ), .WrEn(ENABLE), .RdEn(ENABLE), .Reset(RESET), .RPReset(RESET), 
    .Q(Data_DOP), .Empty(FlagEmpty_DOP), .Full(FlagFULL_DOP), .AlmostEmpty(FlagAE_DOP), .AlmostFull(FlagAF_DOP));
*/
endmodule