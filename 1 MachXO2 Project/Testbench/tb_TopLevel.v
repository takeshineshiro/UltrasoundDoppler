`timescale 1 ns / 100 ps
`define clkToggle 1	   		   
//--- Defines
`include "../Modules/Defines.v"
//--- TopLevel unit
`include "../UltrasoundDopplerTop.v"
`include "../Modules/MemoryMap.v"
`include "../Modules/CommunicationLayer.v"
`include "../Modules/spi_slave.v"
`include "../Modules/parallelInterface.v"
//--- Corelayer
`include "../Modules/CoreLayer.v"
//--- Demodulation
//`include "../Modules/demodulation.v"
//`include "../Modules/Quad_Table.v"

//`include "../Modules/ip/multiply.v"
//`include "../Modules/ip/add32.v"  
//`include "../Modules/ip/quad_table.v"  

//--- Storage
`include "../Modules/StorageLayer.v"
`include "../Modules/MachXO2/FIFO_OUT.v"
//`include "../Modules/FIFO_EBR_1x.v"
//`include "../Modules/FIFO_EBR_2x.v"
//`include "../LatticeLibs/FIFO8KA.v"


module tb_TopLevel();						  
											 
GSR GSR_INST (.GSR (~ENABLE));
PUR PUR_INST (.PUR (~ENABLE));
	
reg CLK_64MHz, SPI_SCK, SPI_MOSI, ENABLE, SPI_csn;
reg[13:0] ADC;
//assign ADC[13:0] = 2;

wire INTERRUPT, ADC_CLK, ADC_PWDN, SPI_MISO, SWITCH, ROI_SYNC;
wire [1:0] TX_PDWN, TX_CLK;
	
UltrasoundDopplerTop main(
  .CLK_EXT(CLK_64MHz),	// System Clock (64 MHz)
  .ENABLE(ENABLE),		// System Reset / GSR
	// SPI interface
  .spi_clk(SPI_SCK),	// Hard SPI serial clock
  .spi_miso(SPI_MISO),	// Hard SPI serial output data
  .spi_mosi(SPI_MOSI),	// Hard SPI serial input data
  .spi_csn(SPI_csn),	// Hard SPI chip-select (active low)
  // Transmitter
  .TX_PWDN(TX_PDWN),	// Transmitter Power down
  .TX_CLK(TX_CLK),		// Transmitter bipolar Signal
  .TX_SWITCH(SWITCH),	// Switch to enable resistance for 2 MHz transducer
  // Receiver
  .RX_OTR(INTERRUPT),		// Receiver OUT OF RANGE / CARRY BIT
  .RX(ADC),			// Receiver 14 bit parallel input 2er Complement
  .RX_CLK(ADC_CLK), 	// Receiver Sample Clock
  .RX_PWDN(ADC_PWDN),	// Receiver Power down (8 cycles needed to setup)
  // DATA Transfer
  .DATA_CLK(),	// Transfer Clock
  .ROI_SYNC(ROI_SYNC),	// Transfer µGate transmitted
  .DATA_IN_CLK(),	// Transfer value transmitted
  .DATA_OUT(),		// Transfer 8 bit data port -> 4 transactions for 1 value and 8/16 transactions for 1 µGate
  .TP()
  );
	
	
event start_sim;
initial begin : START_UP
	@(start_sim);
	$display("RUN => USD_TopLevel.v");
	$display("TIME = %d << CLK periode = %d units >>", $time, 2*`clkToggle);
	$display("TIME = %d << SPI Clock periode = %d units >>", $time, 4*`clkToggle);
	CLK_64MHz <= 0;			
	ENABLE <= 1;
	SPI_MOSI <= 0;		 
	SPI_SCK <= 0; 
	SPI_csn <= 1;
	ADC <= 14'sb00000100001001;
end

event terminate_sim;
initial begin : EVENT_TERMINATE_SIM
	@(terminate_sim);
	#5 $display("TIME = %d << Simulation Complete >> ", $time);
	$finish;
end
		   
			

event ReadingActivated;
always begin : EVENT_Reading_ACTIVATED
	@(ReadingActivated);
	$display("TIME = %d << Reading Event is called >> ", $time);
	read_FIFO;
end

task read_FIFO;
	begin
		repeat (512) begin 
			writeToReg(0);
		end
	end
endtask	

	
task toggle_maschine_enable;
	begin
		ENABLE <= !ENABLE;
		if(ENABLE) 	$display("TIME = %d << StateMaschine get down >> ", $time);
		else 		$display("TIME = %d << StateMaschine get up >> ", $time);
	end
endtask				 

task Setup_SPI_Mode3;
begin			
	
	SPI_SCK = 1;
	SPI_MOSI = 1;	  
	end
endtask				  

task Setup_SPI_Mode1;
begin	
	#1 SPI_MOSI = 0;	 
	#1 SPI_SCK = 0;			   
	end
endtask

reg[4:0] i = 16;
task writeToReg;
	input[15:0] dataToSend;
	begin			  
	SPI_MOSI <= 0;
	
	repeat (16) begin 
		i <= i-1;
		#4 SPI_SCK <= 0;
		 SPI_MOSI <= dataToSend[i];
		#4 SPI_SCK <= 1;
	end
	#1 i = 16;		
	
	//#1 $display("TIME = %d << Data %b was written >> ", $time, dataToSend);
	end
endtask		  

task fillFIFO;
begin						
	#1 SPI_csn <= 0;
	#1 writeToReg(`C_MEM_WR);
	#1 writeToReg(0);
	#1 writeToReg(50);
	#1 writeToReg(1490-4);	 
	#1 writeToReg(3128+2); 
	#1 SPI_csn <= 1;
	  									 		 				   		   
	#1 $display("TIME = %d << FIFO filled >> ", $time);
	end
endtask


event ROI_deactivated;
always begin : EVENT_ACTIVATED
	@(ROI_deactivated);			
	if(ENABLE) begin
	$display("TIME = %d << ROI Event is called >> ", $time);

	#1 SPI_csn <= 0;
	#5 writeToReg(`C_EN_SET);
	#1 SPI_csn <= 1;
	end
end			  

event SamplingActivated;
always begin : EVENT_Sampling_ACTIVATED
	@(SamplingActivated);
	ADC <= ADC + 1;
	//$display("TIME = %d << Sampling Event is called Sampling %b >> ", $time, ADC_CLK);
end	

always@(posedge ADC_CLK)			->SamplingActivated;				 
always@(posedge INTERRUPT)	->ReadingActivated;
always@(negedge ROI_SYNC)	->ROI_deactivated;
	
initial begin
	->start_sim;
	#5 Setup_SPI_Mode3;	  
	#5 toggle_maschine_enable;
	#5 toggle_maschine_enable;
	//#5 toggle_maschine_enable; 
	
	#1 fillFIFO;		 
	
	#5 SPI_csn <= 0;
	#1 writeToReg(8);
	#1 writeToReg(8'h0);	
	#1 writeToReg(0);
	#1 writeToReg(0);
	#1 writeToReg(0);
	#1 writeToReg(0);
	#1 writeToReg(0);
	#1 writeToReg(0);
	#1 SPI_csn <= 1;
	/*
	#1 SPI_csn <= 0;
	#1 writeToReg(`C_EN_SET);
	#1 SPI_csn <= 1;
	*/
	#1 SPI_csn <= 0;
	#1 writeToReg(`C_MEM_WR);
	#1 writeToReg(4);	
	#1 writeToReg((0 << 0) | (1 << 1) | (1 << 2) | (8 << 6) | (`freq8MHz << 14));			  
	#1 SPI_csn <= 1;
	
	#50 ->ROI_deactivated;
	//#1 SPI_csn <= 0;
	//#50 writeToReg(`C_EN_CLR);
	//#1 SPI_csn <= 1;
	#48100 ->terminate_sim;
	
end

always #`clkToggle CLK_64MHz <= !CLK_64MHz;
	
endmodule