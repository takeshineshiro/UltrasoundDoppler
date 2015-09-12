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
	  frameCounter		<= frameCounter - 1;
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
  
  /*
  always@(posedge CLK, posedge RESET) begin : ALWAYS
	if(RESET) begin : RESET
	  DATA_OUT 			= #`DELAY DATA_IN;
	  FRAME_DONE 		= #`DELAY 0;
	  DATA_OUT_CLK 		= #`DELAY 0;
	  FLAG_FRAME		= #`DELAY 0;
	  frameCounter 		= #`DELAY FRAME_LENGH;
	end // RESET
	else begin : NORMAL
	  if(ENABLE_SHIFT) begin
	    frameCounter		= frameCounter - 1;
	    if(frameCounter == 0 || FRAME_DONE)  begin : FRAME_FINISH
		  DATA_OUT 		= #`DELAY DATA_IN;
		  FRAME_DONE 		= #`DELAY 1'b1;
		  FLAG_FRAME 		= #`DELAY 1'b0;
	    end // FRAME_FINISH
	    else begin : FRAME
		  FRAME_DONE		= #`DELAY 0;
		  if(FLAG_FRAME) begin : CLK_OUT
		    DATA_OUT_CLK 	= #`DELAY !DATA_OUT_CLK;
		  end // CLK_OUT
	    end // FRAME
	  end
	  FLAG_FRAME		= #`DELAY 1;
	end // NORMAL
  end // ALWAYS
*/
endmodule

