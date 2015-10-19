`include "Defines.v"

module MemoryMap(
  input 	wire 						MEM_CLK,		// Memory clock
  input		wire[`MEM_ADDR_WIDTH-1:0] 	MEM_ADDR,		// Memory address
  input 	wire[`DATABusWidth-1:0] 	MEM_WDATA,		// Memory write data
  output	wire		 				ENABLE,			// System Enable State
  output	wire		 				RX_ON,			// Receiver ENABLE
  output	wire[1:0] 					TX_ON,			// Transmitter ENABLE
  output	wire[1:0] 					FREQUENCY,		// Transducer Frequency
  output	wire[7:0] 					GATE_LENGTH,	// Countervalue for µGate length
  output	wire[15:0] 					STATE0VALUE,	// Statemachine - value for state 0
  output	wire[15:0] 					STATE1VALUE,	// Statemachine - value for state 1
  output	wire[15:0] 					STATE2VALUE,	// Statemachine - value for state 2
  output	wire[15:0] 					STATERVALUE,	// Statemachine - value for state Retransmit
  output	wire[`DATABusWidth-1:0] 	MEM_RDATA		// Memory read data
  );

  reg 		[`DATABusWidth-1:0] MEM [0:4];
  wire		[`DATABusWidth-1:0] SETTINGS = MEM[4];

initial begin : LAOD_INITIALS
	$readmemb("../Settings/MEM.ini", MEM);
end
assign MEM_RDATA = MEM[MEM_ADDR];

always @(posedge MEM_CLK) begin
	MEM[MEM_ADDR] <= MEM_WDATA;
end

// future always@(SETFREQUENCY) MEM[4][15:14] <= SETFREQUENCY; // future


assign STATE0VALUE	= MEM[0]; //Delay1StartValue
assign STATE1VALUE	= MEM[1]; //DemodStartValue
assign STATE2VALUE	= MEM[2]; //Delay2StartValue
assign STATERVALUE	= MEM[3]; //RetransmitValue

//1001 1111

assign TX_ON		= SETTINGS[0] ? 2'b11 : 2'b00;
assign RX_ON		= ~SETTINGS[1]; //if PWDN == 1 then standby
assign ENABLE		= SETTINGS[2];
assign GATE_LENGTH 	= SETTINGS[13:6];
assign FREQUENCY	= SETTINGS[15:14];


endmodule
