`include "Modules/Defines.v"

module UltrasoundDopplerTop(	
	input	wire 		CLK_EXT,	// System Clock (64 MHz)
	input	wire 		ENABLE,		// System Reset / GSR
	// SPI interface
    input  	wire		spi_clk,	// Hard SPI serial clock
    output 	wire		spi_miso,	// Hard SPI serial output data
    input  	wire		spi_mosi,	// Hard SPI serial input data
    input  	wire		spi_csn,	// Hard SPI chip-select (active low)
	// Transmitter
	output	wire [1:0]	TX_PWDN,	// Transmitter Power down
	output	wire [1:0]	TX_CLK,		// Transmitter bipolar Signal
	output	wire		TX_SWITCH,	// Switch to enable resistance for 2 MHz transducer
	// Receiver
	input	wire 		RX_OTR,		// Receiver OUT OF RANGE / CARRY BIT
	input  	wire [13:0]	RX,			// Receiver 14 bit parallel input 2er Complement
	output	wire		RX_CLK, 	// Receiver Sample Clock
	output	wire		RX_PWDN,	// Receiver Power down (8 cycles needed to setup)
	// DATA Transfer
	output	wire		DATA_CLK,	// Transfer Clock
	output	wire		ROI_SYNC,	// Transfer µGate transmitted
	input	wire		DATA_IN_CLK,// Transfer value transmitted
	output	wire [7:0]	DATA_OUT,	// Transfer 8 bit data port -> 4 transactions for 1 value and 8/16 transactions for 1 µGate
	output 	wire [5:0]  TP			// Testpoints for special useage
	); ///* synthesis GSR=”ENABLED” */
	
	wire CLK_64MHz, transferDone;
	GSR GSR_INST (.GSR (ENABLE));
assign CLK_64MHz = CLK_EXT;
assign HARM_SYNC = 0;
	wire d, r;
	localparam freq = `freq8MHz;
	wire en;
	
	wire       						mem_clk;
	wire       						mem_wr;
	wire   	[`MEM_ADDR_WIDTH-1:0]	mem_addr;
	wire   	[`DATABusWidth-1:0]		mem_rdata;
	wire   	[`DATABusWidth-1:0] 	mem_wdata;
	wire	[1:0]					frequency_i;
	 
  CommunicationLayer com(
			.CLK(CLK_64MHz),		// System clock
			.RESET(~ENABLE),		// System asynchronouse reset (active low)
			// SPI interface
			.CCLK(spi_clk),			// Hard SPI serial clock
			.SO(spi_miso),			// Hard SPI serial output data
			.SI(spi_mosi),			// Hard SPI serial input data
			.SCSN(spi_csn),			// Hard SPI chip-select (active low)
			.MEM_CLK(mem_clk),		// Memory clock (copy of CLK)
			.MEM_WR(mem_wr),		// Memory write enable                     
			.MEM_ADDR(mem_addr),	// Memory address
			.MEM_WDATA(mem_wdata),	// Memory write data
			.MEM_RDATA(mem_rdata),	// Memory read data
			.ENABLE(en),			// ENABLE for FSM
			.RESETEN(transferDone)
  );
	
  wire 		[15:0] state1, state2, state3, state4;
  wire[7:0] gatelength;

  	reg[7:0] divider;
	wire readyToRead, readyToWrite;
  
  wire CoreEN;
  
  MemoryMap mem(
	.MEM_CLK(mem_clk),		// Memory clock
	.MEM_ADDR(mem_addr),	// Memory address
	.MEM_WDATA(mem_wdata),	// Memory write data
	.ENABLE(CoreEN),		// System Enable State
	.RX_ON(RX_PWDN),		// Receiver ENABLE
	.TX_ON(TX_PWDN),		// Transmitter ENABLE
	.FREQUENCY(frequency_i),// Transducer Frequency
	.GATE_LENGTH(gatelength),	// Countervalue for µGate length
	.STATE0VALUE(state1),	// Statemachine - value for state 0
	.STATE1VALUE(state2),	// Statemachine - value for state 1
	.STATE2VALUE(state3),	// Statemachine - value for state 2
	.STATERVALUE(state4),	// Statemachine - value for state Retransmit
	.MEM_RDATA(mem_rdata)	// Memory read data
  );
	wire[1:0] tx;
	assign TX_CLK = 	(TX_PWDN == 2'b11) ? tx : 2'b10;
	assign TX_SWITCH  = (frequency_i == `freq2MHz) ? 1 : 0;
	
CoreLayer core(
	.coreClock(CLK_64MHz),
	.RESET(~ENABLE),
	.ENABLE(CoreEN),
	.freq(frequency_i),
	.State0Value(state1),
	.State1Value(state2),
	.State2Value(state3),
	.StateRValue(state4),
	.TX_CLK(tx),
	.RX_CLK(RX_CLK),
	.DEMOD_ON(d),
	.RETRANSMIT(r)
	);
	
always@(posedge CLK_64MHz or posedge ~en) begin
	if(~en) begin
		divider <= 0;
	end
	else
		divider <= divider + 1'b1;
end
	
	wire [7:0] MEM_DATA_OUT;
	wire MEM_DATA_RD_CLK;
	

wire signed[15:0] ADCData = $signed(RX);

Storeage fifo(
.CLK(RX_CLK),		// System clock
.MODE(`OSZI_MODE),
.WRITE(RX_CLK && readyToWrite && d),
.READ(MEM_DATA_RD_CLK),
.DIN(ADCData),
.RE_IN(), .IM_IN(),
.ENABLE(ENABLE),
.RESET(~ENABLE),
.DOUT(MEM_DATA_OUT),
.READY2READ(readyToRead),
.READY2WRITE(readyToWrite)
);
	
parallelInterface dataOut(
	.CLK(divider[0]),			// System clock divider[0]
	//.ENABLE_SHIFT(readyToRead),
	.RESET(~en),				// System asynchronouse reset (active low)
	// Parallel interface
	.DATA_OUT_CLK(DATA_CLK),	// Hardware parallel Data clock
	.FLAG_FRAME(ROI_SYNC),		// Hardware Region of Interest Data Flag
	.DATA_OUT(DATA_OUT),		// Hardware parallel output data
	// MEM interface
	.FRAME_LENGH(16'd64),			// ROI Counter value for Sync
	.DATA_IN(MEM_DATA_OUT),	// Memory Data
	.READ_NEXT(MEM_DATA_RD_CLK),//
	.FRAME_DONE(transferDone)
);

assign TP[2]		= TX_CLK[0];			//16
assign TP[1]		= r;		//15
assign TP[0]		= readyToWrite;		//14
assign TP[5]		= d;		//19
assign TP[4]		= readyToRead;		//18
assign TP[3]		= RX_CLK;		//17

//assign DATACLK		= 0;
//assign DATASYNC		= 0;
//assign DATAHREF		= 0;
//assign DATA		= 0;

endmodule