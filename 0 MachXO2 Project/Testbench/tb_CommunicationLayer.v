`timescale 1 ns / 100 ps
`define clkToggle 10
`include "../Modules/CommunicationLayer.v"
`include "../Modules/spi_slave.v"
`include "../Modules/Defines.v"

module tb_CommunicationLayer();
	
	reg[`RegBusWidth-1:0] DataBus;
	wire[7:0] RegBus;
	wire[`RegBusWidth-1:0] RegValueBus;
	
	reg CLK_64MHz, SPI_SCK, SPI_SS, SPI_MOSI, ENABLE;
	reg PullData, Reset;
	
	wire SPI_MISO, Transfered;
	
CommunicationLayer comm(
	.CLK(CLK_64MHz),
	.SI(SPI_MOSI), .SCSN(SPI_SS), .CCLK(SPI_SCK), .RST_N(Reset), //.SendDataMode(PullData),
	.Reg(RegBus), .RegValue(RegValueBus),
	.outdone(Transfered), .SO(SPI_MISO), .DataOut(DataBus) );
	
/* Testbench*/
event start_sim;
initial begin : EVENT_START_SIM
	@(start_sim);
	$display("RUN => Unit CommunicationLayer.v");
	$display("TIME = %d << CLK periode = %d units >>", $time, 2*`clkToggle);
	$display("TIME = %d << Starting the Simulation >> ", $time);
	
	DataBus <= 16'hAAAA;
	CLK_64MHz <= 1;
	SPI_SCK <= 1;
	SPI_SS <= 1;
	SPI_MOSI <= 0;
	ENABLE <= 0;		   
	PullData <= 0;
	Reset <= 1;
	
end		

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
		#2 SPI_SCK <= 0;
		 SPI_MOSI <= dataToSend[i];
		#2 SPI_SCK <= 1;
	end
	#1 i = 16;		 	  
	//#1 $display("TIME = %d << Data %b was written >> ", $time, dataToSend);
	end
endtask			 

task fillFIFO;
begin							
	#1 writeToReg(`cmdSetDELAY1);
	#1 writeToReg(100);
	//#1 writeToReg(50);
	
	#1 writeToReg(`cmdSetDEMOD);
	#1 writeToReg(3000);
	//#1 writeToReg(1490-4);
					   
	#1 writeToReg(`cmdSetDELAY2);
	#1 writeToReg(3000+1024+32);
	//#1 writeToReg(3128+2);
						  
	#1 writeToReg(`cmdSetRETRANSMIT);
	#1 writeToReg(6400);		
	//#1 writeToReg(3200);
	  									 		 				   		   
	#1 $display("TIME = %d << FIFO filled >> ", $time);
	end
endtask

event terminate_sim;
initial begin : EVENT_TERMINATE_SIM
	@(terminate_sim);
	#5 $display("TIME = %d << Simulation Complete >> ", $time);
	$finish;
end

initial begin
	->start_sim;
	#5 Setup_SPI_Mode3;	  		 
	#5 Reset <= 0;
	#5 Reset <= 1;
	#5 toggle_maschine_enable;
	#5 toggle_maschine_enable;
	#5 toggle_maschine_enable;
	#5 fillFIFO;			  
	#1 writeToReg(`cmdSetSettings);
	#1 writeToReg((1 << 0) | (1 << 1) | (1 << 2) | (3 << 3) | (8 << 6) | (`freq2MHz << 14));
	//#3500000 writeToReg(`RegStatics);   		 
	//#1 writeToReg((`freq2MHz << 1) | (1 << 3) | (1 << 4));
	#300 ->terminate_sim;
	
end

always #`clkToggle CLK_64MHz <= !CLK_64MHz;
	
endmodule