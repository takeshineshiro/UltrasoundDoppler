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

`define Init			16'hFFFF

module USDCoreLayer #(
	parameter valueWidth = 16)
   (input wire[8-1:0] cmd,
	input wire[valueWidth-1:0] value,
	input wire write, clock, enable,
	
	output wire Trigger, TX_pos, TX_neg, TX_pwdn0, TX_pwdn1, RX_clock, RX_pwdn, RX_read,
	output reg PullData=0);
	
/* --- Register Initialvalues ---*/	
	reg[valueWidth-1:0] burst	=`Init,
						adc		=`Init, 
						trigger	=`Init, 
						sample	=`Init, 
						stop	=`Init, 
						retransmit	=0;
	wire Burst, ADC, BurstFreq, Stop, Retransmit;
	reg[1:0] Frequency;
	reg[valueWidth-1:0] Count;
	reg[4:0] DivCnt;

/* --- register values ---*/
always@(posedge write) begin
		burst 		<= (`RegBurst 		&& cmd) ? value 	: burst;
		adc 		<= (`RegADC 		&& cmd) ? value 	: adc;
		trigger 	<= (`RegTrigger 	&& cmd) ? value 	: trigger;
		sample 		<= (`RegSample		&& cmd) ? value 	: sample;
		stop 		<= (`RegStop 		&& cmd) ? value 	: stop;
		retransmit	<= (`RegRetransmit	&& cmd) ? value 	: retransmit;
		Frequency 	<= (`RegStatics 	&& cmd) ? cmd[5:4]	: Frequency;
		PullData 	<= (`RegStatics 	&& cmd) ? cmd[6]	: PullData; 
	end

/* --- Counting and Divide logic ---*/
always@(posedge clock) begin
		Count 	<= (~Retransmit && enable)	? Count  + 1 : 0;	//Counter for States
		DivCnt 	<= (Burst || ADC && enable)	? DivCnt + 1 : 0;	//Clock Divider
	end
	
/* --- state logic ---*/
assign Burst 		= (Count >= burst) && ~ADC && ~Stop; //realizeable by XOR :)
assign ADC 			= (Count >= adc) && ~Stop;
assign Trigger 		= (Count >= trigger) && ~Stop;	// with source Clock
assign Stop 		= (Count >= stop);
assign Retransmit 	= (Count >= retransmit) && enable;
/* --- TX logic ---*/
assign BurstFreq	= (Frequency == `freq8MHz) ? DivCnt[2] : //64/2/2 = 16 MHz und davon einmal High und einmal Low -> 8 MHz Ausgang
					  (Frequency == `freq4MHz) ? DivCnt[3] :
					  (Frequency == `freq2MHz) ? DivCnt[4] : 0;
assign TX_pos		= (BurstFreq && Burst) ? 1:0;
assign TX_neg		= (BurstFreq && Burst) ? 0:1;
assign TX_pwdn0		= 1;
assign TX_pwdn1		= 1;
/* --- RX logic ---*/
assign RX_clock		= clock && ADC;
assign RX_pwdn		= 0;
assign RX_read 		= (Count >= sample) && clock && ~Stop;

endmodule
	
