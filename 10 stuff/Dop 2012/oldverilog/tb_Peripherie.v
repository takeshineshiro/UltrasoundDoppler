`timescale 1 ns / 100 ps
`define clkToggle 10
`include "Transmitter.v"
module tb_transmitter();

parameter freq8MHz = 2'b11, freq4MHz = 2'b10, freq2MHz = 2'b01;

wire burstNeg, burstPos, pwdn0, pwdn1;
reg clk, enable;
reg[1:0] freqSel;
	
	Transmitter 	tx(.burstNeg(burstNeg), .burstPos(burstPos), .clk(clk), .freqSel(freqSel),
									.gate(enable), .PDWN_0(pwdn0), .PDWN_1(pwdn1));
	
event start_sim;
initial begin: EVENT_START_SIM
	@(start_sim);
	$display("RUN => Unit Transmitter.v");
	$display("TIME = %d << CLK periode = %d units >>", $time, 2*`clkToggle);
	$display("TIME = %d << Starting the Simulation >> ", $time);
	clk <= 0;
	enable <= 0;
	freqSel <= freq8MHz;
	end

event terminate_sim;
initial begin: EVENT_TERMINATE_SIM
	@(terminate_sim);
	#5 $display("TIME = %d << Simulation Complete >> ", $time);
	$finish;
	end

event toggle_enable;
always begin : EVENT_TOGGLE_ENABLE
	@(toggle_enable);
	enable <= !enable;
	#1 if(enable)$display("TIME = %d << enable = high | Clk=%b >> ", $time, clk);
		else 	$display("TIME = %d << enable = low | Clk=%b >> ", $time, clk);
	end

event toggle_freqSelector;
always begin : EVENT_TOGGLE_FREQ_SELECTOR
	@(toggle_freqSelector);
	freqSel <= freqSel +1;
	#1
	case(freqSel)
		freq8MHz: $display("TIME = %d << Freq: 8 MHz | Clk=%b >> ", $time, clk);
		freq4MHz: $display("TIME = %d << Freq: 8 MHz | Clk=%b >> ", $time, clk);
		freq2MHz: $display("TIME = %d << Freq: 8 MHz | Clk=%b >> ", $time, clk);
		default:  $display("TIME = %d << Freq: don't care | Clk=%b >> ", $time, clk);
		endcase
	end

initial begin: RUN
	->start_sim;
	//#20 ->toggle_freqSelector;
	#20 ->toggle_enable;
	#300 ->toggle_freqSelector;
	#300 ->toggle_freqSelector;
	#300 ->toggle_freqSelector;
	#300 ->toggle_freqSelector;
	#300 ->toggle_enable;
	#100 ->terminate_sim;				   
	end

always #`clkToggle clk <= !clk;
always #20 $display($time, " << Clk=%b | enable=%b | Burst: pos=%b | neg=%b >> ", clk, enable, burstPos, burstNeg);

endmodule

`include "Receiver.v"
`define adcbits 14
module tb_receiver();

wire rxReady, rxPwdn, rxClk;
wire[`adcbits-1:0] adcIn;
reg[`adcbits-1:0] adcPins;
reg enable, clk;

Receiver #(.Divbit(0), .ADCdelay(7), .ADCbits(`adcbits), .StartAt(1'b1))
					rx (.clk(clk), .enable(enable), .pins(adcPins), .adcClk(rxClk), 
							.ready(rxReady), .pwdn(rxPwdn), .out(adcIn));

event start_sim;
initial begin: EVENT_START_SIM
	@(start_sim);
	$display("RUN => Unit Receiver.v");
	$display("TIME = %d << CLK periode = %d units >>", $time, 2*`clkToggle);
	$display("TIME = %d << Starting the Simulation >> ", $time);
	clk <= 0;
	enable <= 0;
	adcPins <= 0;
	end

event terminate_sim;
initial begin: EVENT_TERMINATE_SIM
	@(terminate_sim);
	#5 $display("TIME = %d << Simulation Complete >> ", $time);
	$finish;
	end
	
event toggle_enable;
always begin : EVENT_TOGGLE_ENABLE
	@(toggle_enable);
	enable <= !enable;
	#1 if(enable)$display("TIME = %d << enable = high | Clk=%b >> ", $time, clk);
		else 	$display("TIME = %d << enable = low | Clk=%b >> ", $time, clk);
	end

task setADC_values;
	begin
	#15 adcPins <= 7;
	#15 adcPins <= 14;
	#15 adcPins <= 20;
	#15 adcPins <= 400;
	#15 adcPins <= 0;
	#15 adcPins <= 1200;
	end
endtask

initial begin: RUN
	->start_sim;
	#5 setADC_values;
	#5 ->toggle_enable;
	#5 setADC_values;
	#5 setADC_values;
	#5 ->toggle_enable;
	#5 setADC_values;
	#100 ->terminate_sim;
end

always #`clkToggle clk <= !clk;
always #20 $display($time, " << Clk=%b | adcClk=%b | enable=%b | PowerDown=%b | out=%d >> ", clk, rxClk, enable, rxPwdn, adcIn);

endmodule
