`timescale 1 ns / 100 ps
`define clkToggle 10
`include "CoreLayer.v" 

`define RegBurst 		8'h01
`define RegADC 			8'h02
`define RegTrigger 		8'h03
`define RegSample		8'h04
`define RegStop 		8'h05
`define RegRetransmit	8'h06
`define RegStatics		8'h07
`define RegPullData 	8'h08

`define freq8MHz 		2'b11
`define freq4MHz 		2'b10
`define freq2MHz 		2'b01

module tb_CoreLayer();
	
reg[7:0] RegBus;
reg[15:0] RegValueBus;
reg Transfered, CLK_64MHz, ENABLE;

wire Reset, TX_POS, TX_NEG, TX_PDWN_0, TX_PDWN_1, ADC_CLK, ADC_PWDN, SampleClock, TRIGGER, PullData;
	
CoreLayer #(16) core(
	.cmd(RegBus), .value(RegValueBus),
	.write(Transfered), .clock(CLK_64MHz), .enable(ENABLE), .Reset(Reset),
	.TX_pos(TX_POS), .TX_neg(TX_NEG), .TX_pwdn0(TX_PDWN_0), .TX_pwdn1(TX_PDWN_1),
	.RX_clock(ADC_CLK), .RX_pwdn(ADC_PWDN), .PullData(PullData), .RX_Sample_clock(SampleClock),
	.Trigger(TRIGGER) );
	
/* Testbench*/
event start_sim;
initial begin : EVENT_START_SIM
	@(start_sim);
	$display("RUN => Unit CoreLayer.v");
	$display("TIME = %d << CLK periode = %d units >>", $time, 2*`clkToggle);
	$display("TIME = %d << Starting the Simulation >> ", $time);
	$display("TIME = %d << Data == 0, Nothing transfered, Enable == 0, Clock high >> ", $time);
	RegBus <= 0;
	RegValueBus <= 0;
	Transfered <= 0;
	CLK_64MHz <= 1;
	ENABLE <= 0;		   
end			   

event toggle_enable_Core;
always begin : EVENT_TOGGLE_ENABLE_CORE
	@(toggle_enable_Core);				
	ENABLE <= !ENABLE;
	if(ENABLE)  $display("TIME = %d << System Enabled >> ", $time);
	else 		$display("TIME = %d << System Disnabled >> ", $time);
	end					   
	
task WriteToRegs (input [7:0] cmd, input [15:0] value); 
begin
	RegBus <= cmd;
	RegValueBus <= value;	 
	#1 Transfered <= 1;
	#2 Transfered <= 0;
end
endtask	  

task WriteRegStatics (input [7:0] cmd); 
begin
	RegBus <= cmd;	 
	#1 Transfered <= 1;
	#2 Transfered <= 0;
end
endtask

event terminate_sim;
initial begin : EVENT_TERMINATE_SIM
	@(terminate_sim);
	#5 $display("TIME = %d << Simulation Complete >> ", $time);
	$finish;
end
	
initial begin : RUN
	->start_sim;
	#5 	WriteRegStatics	((`RegStatics | (`freq8MHz << 4)));
	#10 ->toggle_enable_Core;
	#5 	WriteRegStatics	((`RegStatics | (`freq8MHz << 4) | (1 << 7)));	 
	WriteRegStatics	((`RegStatics | (`freq8MHz << 4) | (0 << 7)));	
	#5 	WriteToRegs		( `RegBurst		, 25);
	#5 	WriteToRegs		( `RegADC		, 30); 
	#5 	WriteToRegs		( `RegStop		, 35);
	#5 	WriteToRegs		( `RegRetransmit, 50 );	   
	//#5 ->toggle_enable_Core;
	#1500->terminate_sim;
end				// stop the simulation	
	
always #`clkToggle CLK_64MHz <= !CLK_64MHz;
always@(posedge ENABLE) $display("System is Running!");
always@(negedge ENABLE) $display("System is stop Working!");
always@(posedge Reset) $display("System Reset High!");
always@(negedge Reset) $display("System Reset low!");


endmodule