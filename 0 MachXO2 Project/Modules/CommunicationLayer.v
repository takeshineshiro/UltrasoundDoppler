`include "Defines.v"

module CommunicationLayer(
  input  	wire						CLK,		// System clock
  input  	wire						RESET,		// System asynchronouse reset (active low)
  // SPI interface
  input  	wire						CCLK,		// Hard SPI serial clock
  output	wire						SO,			// Hard SPI serial output data
  input 	wire						SI,			// Hard SPI serial input data
  input		wire						SCSN,		// Hard SPI chip-select (active low)
	
  output	reg	        				MEM_CLK,	// Memory clock (copy of CLK)
  output	reg	        				MEM_WR,		// Memory write enable                     
  output	reg	[`MEM_ADDR_WIDTH-1:0]	MEM_ADDR,	// Memory address
  output	reg	[`DATABusWidth-1:0]		MEM_WDATA,	// Memory write data
  input 	wire[`DATABusWidth-1:0]		MEM_RDATA,	// Memory read data*/
  
  output	reg							ENABLE,		// ENABLE for FSM
  input 	wire						RESETEN
  );
	parameter MAX_MEM_BURST_NUM = 5;       // Maximum memory burst number
	wire	[`DATABusWidth-1:0] rd_data;
	wire 	xfer_done;
	reg		[`DATABusWidth-1:0] dataOut;
			
	parallelIN_serialOUT #(`DATABusWidth) mode3out (.clock(CCLK), .reset(RESET), .dataOut(dataOut), .next(xfer_done), .out(SO));
	serialIN_parallelOUT #(`DATABusWidth) mode3in  (.clock(CCLK), .reset(RESET), .csn(SCSN), .dataIn(rd_data), .done(xfer_done), .in(SI));
										  
/* --- Register Initialvalues ---*/	
reg [3:0]  	main_sm;           // The state register of the main state machine
reg [3:0] 	spi_cmd;           // The slim buffer version of the SPI command used for the performance


always@(posedge CLK) begin : NextStateLogic
	if(RESET) begin
		ENABLE 		<= 1'b0;
		MEM_ADDR 	<= 0;
		MEM_CLK		<= 1'b0;
		MEM_WDATA 	<= MEM_RDATA;
		dataOut		<= `C_REV_ID;
		main_sm		<= `S_IDLE;
		spi_cmd 	<= `REV_ID;
		MEM_WR 		<= 1'b0;
	end
	else begin : NormalStateLogic
		if(RESETEN) ENABLE 		<= 1'b0;
		dataOut <= (spi_cmd == `INVALID) ? `C_REV_ID : MEM_RDATA;
		case (main_sm)
		// IDEL state
        `S_IDLE		:	begin
						MEM_CLK	<= 1'b0;
						MEM_WR <= 1'b0;
						spi_cmd <= `INVALID;
						if (~SCSN && ~xfer_done) begin
							main_sm <= `S_CMD_ST;	// Go to `S_CMD_ST state when the TXDR register write is done
						end
					end
		// Wait for the SPI command is ready in the RXDR register                                              
		`S_CMD_ST	:	if(xfer_done) main_sm <= `S_CMD_LD;
						else if(SCSN) main_sm <= `S_IDLE;
		// Load the SPI command to improve the performance because the path delay from the RXDR register is very big 
		`S_CMD_LD	:	begin
							main_sm <= `S_CMD_DEC;            // Go to `S_CMD_DEC state when the RXDR register read is done
							case (rd_data)
							`C_EN_SET:     spi_cmd <= `EN_SET;   
							`C_EN_CLR:     spi_cmd <= `EN_CLR;  
							`C_MEM_WR:     spi_cmd <= `MEM_WR;  
							`C_MEM_RD:     spi_cmd <= `MEM_RD;  
							`C_REV_ID:     spi_cmd <= `REV_ID;    
							default:       spi_cmd <= `INVALID;
							endcase
						end
		`S_CMD_DEC	:  	begin
							case(spi_cmd)
							`EN_SET	:	begin
								ENABLE <= 1'b1;
								main_sm <= `S_IDLE;
											end
							`EN_CLR	:	begin
								ENABLE <= 1'b0;
								main_sm <= `S_IDLE;
											end
							`MEM_WR	: 	begin
								MEM_WR <= 1'b1;
								main_sm <= `S_ADDR_ST;
											end
							`MEM_RD	: 	begin
								MEM_WR <= 1'b0;
								main_sm <= `S_ADDR_ST;
											end
							default		: 	begin
								MEM_WR <= 1'b0;
								main_sm <= `S_IDLE;
											end
							endcase
							MEM_ADDR 	  <= 0;
						end
		`S_ADDR_ST	:	begin
						if(~xfer_done) main_sm <= `S_ADDR_LD;
						else if(SCSN) main_sm <= `S_IDLE;
						end
		`S_ADDR_LD	:	if(xfer_done) begin
						  main_sm <= `S_DATA_ST;  // Go to `S_DATA_RD state when the SPI command is Read Memory
						  MEM_ADDR <= rd_data[`MEM_ADDR_WIDTH-1:0];
						  if(spi_cmd == `REV_ID) 
							  main_sm <= `S_IDLE;        // Go to `S_IDLE state when the SPI command is Revision ID   
                       end
		`S_DATA_ST	: 	begin
						if(~xfer_done) main_sm <= `S_DATA_SET;
						else if(SCSN) main_sm <= `S_IDLE;
						end
		`S_DATA_SET	:	if(xfer_done) begin
						if(spi_cmd == `MEM_WR) begin
										MEM_WDATA <= rd_data;
										MEM_CLK	<= 1'b0;
										main_sm <= (~SCSN) ? `S_DATA_UPDATE : `S_IDLE; // Go to `S_WDATA_ST state when the SPI command is Write Memory but
																// the current SPI transaction is not ended
								end
						else begin
							main_sm <= (~SCSN) ? `S_ADDRESS_UP : `S_IDLE; // Go to `S_WDATA_ST state when the SPI command is Write Memory but
																// the current SPI transaction is not ended
							end
						end
						//else if(SCSN) main_sm <= `S_DATA_ST;
		`S_DATA_UPDATE	:	begin
								MEM_CLK <= 1'b1;
								main_sm <= (~SCSN) ? `S_ADDRESS_UP : `S_IDLE;
							end
		`S_ADDRESS_UP	:	begin
								MEM_CLK	<= 1'b0;
								MEM_ADDR <= (SCSN || (MEM_ADDR == MAX_MEM_BURST_NUM)) ? 0 : MEM_ADDR + 1;
								main_sm <= (~SCSN) ? `S_DATA_ST : `S_IDLE;
							end
		endcase
	end
end


endmodule
