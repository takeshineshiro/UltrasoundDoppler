module parallelInterface (
  input  	wire						CLK,			// System clock
  //input		wire						ENABLE_SHIFT,
  input  	wire						RESET,			// System asynchronouse reset (active low)
  // Parallel interface
  output  	reg							DATA_OUT_CLK,	// Hardware parallel Data clock
  output  	reg							FLAG_FRAME,		// Hardware Region of Interest Data Flag
  //output  	wire						HARMONIC,	// Hardware Harmonic Data Flag
  output	wire[7:0]					DATA_OUT,		// Hardware parallel output data
  output	wire						READ_NEXT,
  // MEM interface
  input		wire[`DATABusWidth-1:0]		FRAME_LENGH,	// ROI Counter value for Sync
  input		wire[7:0]      				DATA_IN,		// Memory Data
  output	reg							FRAME_DONE
  );
  
  reg [`DATABusWidth-1:0] frameCounter;
  
  assign READ_NEXT 	= !DATA_OUT_CLK;
  assign DATA_OUT 	= DATA_IN;
  
  always@(posedge CLK, posedge RESET) begin : ALWAYS
	if(RESET) begin : RESET
	  frameCounter 		<= #`DELAY FRAME_LENGH;
	  DATA_OUT_CLK		<= #`DELAY 1'b0;
	end // RESET
	else begin : NORMAL
	  if(frameCounter != 0) frameCounter		<= frameCounter - 1;
	  if(FLAG_FRAME) begin
		DATA_OUT_CLK <= !DATA_OUT_CLK;
	  end
	end // NORMAL
  end // ALWAYS
  
  always@(*) begin
	if((frameCounter == 0 && !DATA_OUT_CLK) || RESET) begin
		FLAG_FRAME = 1'b0;
		FRAME_DONE = 1'b1;
	end
	else begin
		FLAG_FRAME = 1'b1;
		FRAME_DONE = 1'b0;
	end
  end
endmodule

