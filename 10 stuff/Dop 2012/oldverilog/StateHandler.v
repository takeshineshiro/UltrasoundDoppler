`define ShiftWidth 32
module StateHandler
   (input wire mainclk, dataIn, ctr_clk, ctr_cs, ctr_enable,
    output wire StateError, TransmitterOn, Retransmit, MeasureType, TriggerOn,
	output wire[1:0] Frequency, Sampling, OutputInterface
	);
	
wire[`ShiftWidth-1:0] ShiftBuffer, StateBuffer;
 
assign Frequency 		= (ctr_enable) ? StateBuffer[1:0] : 2'b0;
assign TransmitterOn 	= (ctr_enable) ? StateBuffer[2] : 1'b0;
assign Sampling  	 	= (ctr_enable) ? StateBuffer[4:3] : 2'b00;
assign Retransmit 		= (ctr_enable) ? StateBuffer[5] : 1'b1;
assign OutputInterface	= (ctr_enable) ? StateBuffer[7:6] : 2'b00;
assign MeasureType 		= (ctr_enable) ? StateBuffer[8] : 1'b0;
assign TriggerOn 		= (ctr_enable) ? StateBuffer[9] : 1'b0;

/* --- SPI IN --------- */
	shiftInRegister #(`ShiftWidth) 	shifter(.dataIn(dataIn), .sclk(ctr_clk), .cs(ctr_cs), .Q(ShiftBuffer));
/* --- FIFO --- */
	FIFOVar #(`ShiftWidth, 5) 	  	eventhandler(.dataIn(ShiftBuffer), .readEnable(ctr_enable), .reset(~ctr_enable && ctr_cs), 
												.readNext(Equal), .writeNext(ctr_cs), .goToReg0(Retransmit || !(ctr_enable && ctr_cs)), .Q(StateBuffer));
/* --- COMPARE STATE--- */	
	CompareState #(`ShiftWidth-16) 	compare(.mainclk(mainclk), .reset(Retransmit || StateError || !(ctr_enable && ctr_cs)),
												.dataB(StateBuffer[`ShiftWidth-1:`ShiftWidth-16]), .Equal(Equal), .StateError(StateError));
	
endmodule