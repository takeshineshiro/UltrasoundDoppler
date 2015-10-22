`timescale 1 ns / 100 ps
`define clkToggle 10
`include "ShiftInRegister.v"
module tb_shifter();
parameter width = 4, finishtime = 200;

reg MOSI, SCLK, SS;
wire [width-1:0] value;

shiftInRegister #(width) s1(.dataIn(MOSI), .sclk(SCLK), .cs(SS), .Q(value));

event start_sim;
initial begin : EVENT_START_SIM
	@(start_sim);
	$display("RUN => Unit shiftInRegister.v");
	$display("TIME = %d << CLK periode = %d units >>", $time, 2*`clkToggle);
	$display("TIME = %d << Starting the Simulation >> ", $time);
	$display("TIME = %d << MOSI = high >> ", $time);
	$display("TIME = %d << chipSelect deactivated >> ", $time);
	SCLK <= 0;
	SS <= 1;
	MOSI <= 1;
	end

event terminate_sim;
initial begin : EVENT_TERMINATE_SIM
	@(terminate_sim);
	#5 $display("TIME = %d << Simulation Complete >> ", $time);
	$finish;
	end

event toggle_mosi;
always begin : EVENT_TOGGLE_MOSI
	@(toggle_mosi);
	MOSI <= !MOSI;
	#1 if(MOSI)	$display("TIME = %d << MOSI = high >> ", $time);
		else 	$display("TIME = %d << MOSI = low >> ", $time);
	end

event toggle_SS;
always begin : EVENT_TOGGLE_SS
	@(toggle_SS);
	SS <= !SS;
	#1 	if(SS)	$display("TIME = %d << ChipSelect deactivated >> ", $time);
		else	$display("TIME = %d << ChipSelect activated >> ", $time);
	end

initial begin : RUN
	->start_sim;
	#40 ->toggle_SS;
	#60 ->toggle_mosi;
	#60 ->toggle_mosi;
	#90 ->toggle_SS;
	#20	->terminate_sim;
	end					// stop the simulation
	
always #`clkToggle SCLK <= !SCLK;
always #20 $display("TIME = %d :: Out=%b | MOSI=%b |SS=%b", $time, value, MOSI, SS);

endmodule

`include "CompareState.v"
module tb_compare();
parameter width = 4, finishtime = 200, compareValue = 4'b1011;
reg SCLK, reset;
wire equal, error;
reg[width-1:0] dataToCompare;

CompareState #(width) c1(.mainclk(SCLK), .reset(reset), .dataB(dataToCompare), .Equal(equal), .StateError(error));

event start_sim;
initial begin : EVENT_START_SIM
	@(start_sim);
	$display("RUN => Unit CompareState.v");
	$display("TIME = %d << CLK periode = %d units >>", $time, 2*`clkToggle);
	$display("TIME = %d << Starting the Simulation >> ", $time);
	$display("TIME = %d << reset = high >> ", $time);
	$display("TIME = %d << CompareValue = %d >> ", $time, compareValue);
	SCLK <= 0;
	reset <= 1;
	dataToCompare <= compareValue;
	end

event terminate_sim;
initial begin : EVENT_TERMINATE_SIM
	@(terminate_sim);
	#5 $display("TIME = %d << Simulation Complete >> ", $time);
	$finish;
	end

event toggle_reset;
always begin : EVENT_TOGGLE_RESET
	@(toggle_reset);
	reset <= !reset;
	#1 if(reset)$display("TIME = %d << reset = high | Clk=%b >> ", $time, SCLK);
		else 	$display("TIME = %d << reset = low | Clk=%b >> ", $time, SCLK);
	end

event state_equal;
always begin : EVENT_STATE_EQUAL
	@(state_equal);
	$display("TIME = %d << StateValue reached >> ", $time);
	end

event state_error;
always begin : EVENT_STATE_ERROR
	@(state_error);
	$display("TIME = %d << StateError / Compare overflow - reset! >> ", $time);
	end



initial begin : RUN
	->start_sim;
	#40 ->toggle_reset;
	#400 ->toggle_reset;
	#1 ->toggle_reset;
	end

always #`clkToggle  SCLK <= !SCLK;
always #20 $display($time, " << Clk=%b | reset=%b | Equal=%b | Error=%b >> ", SCLK, reset, equal, error);
always@(posedge equal) ->state_equal;
always@(posedge error) begin
	->state_error;
	#1 ->toggle_reset;
	#25 ->toggle_reset;
	#25->terminate_sim;
end
endmodule

`include "FIFOVar.v"
module tb_eventhandler();
parameter Width = 4, inValue = 4'b1011;

reg SCLK, enable, write, equal, retransmit;
reg[Width-1:0] InBuffer;
wire[Width-1:0] StateBuffer;

FIFOVar #(Width, 4) 	  	h1(.dataIn(InBuffer), .readEnable(enable), .reset(~write && enable), 
												.readNext(equal), .writeNext(write), .goToReg0(retransmit), .Q(StateBuffer));

event start_sim;
initial begin : EVENT_START_SIM
	@(start_sim);
	$display("RUN => Unit FIFOVar.v");
	$display("TIME = %d << Starting the Simulation >> ", $time);
	$display("TIME = %d << enable = low >> ", $time);
	SCLK <= 0;
	enable <= 0;
	retransmit <= 0;
	write <= 1;
	equal <= 0;
	end

event terminate_sim;
initial begin : EVENT_TERMINATE_SIM
	@(terminate_sim);
	#5 $display("TIME = %d << Simulation Complete >> ", $time);
	$finish;
	end

event toggle_enable;
always begin : EVENT_TOGGLE_ENABLE
	@(toggle_enable);
	enable <= !enable;
	#1 if(enable)$display("TIME = %d << enable = high | Clk=%b >> ", $time, SCLK);
		else 	$display("TIME = %d << enable = low | Clk=%b >> ", $time, SCLK);
	end

task readNextFIFO;
	begin
	$display("TIME = %d << Data %b at current State >> ", $time, StateBuffer);
	equal <= 1;
	#5 equal <= 0;
	end
endtask
	
task writeToFIFO;
	begin
	write = 1;
	#5 write = 0;
	#1 $display("TIME = %d << Data %b was written >> ", $time, InBuffer);
	end
endtask 

task fillFIFO;
	begin
	write  <= 1;
	#5 enable <= 1;
	#5 write <= 0;
	#5 enable <= 0;
	InBuffer = inValue;
	#5 writeToFIFO();
	InBuffer = 4'b0011;
	#5 writeToFIFO();
	InBuffer = 4'b1100;
	#5 writeToFIFO();
	InBuffer = 4'b0110;
	#5 writeToFIFO();
	#20 $display("TIME = %d << FIFO filled >> ", $time);
	write <= 1;
	//#5 enable <= 1;
	end
endtask

task readAllFIFO;
begin
	if(enable) $display("TIME = %d << Try to read FIFO with enable >> ", $time);
		else $display("TIME = %d << Try to read FIFO without enable >> ", $time);
	#5 readNextFIFO();
	#5 readNextFIFO();
	#5 readNextFIFO();
	#5 readNextFIFO();
	end
endtask

initial begin : RUN
	->start_sim;
	fillFIFO();
	#5 readAllFIFO();
	#5->toggle_enable;
	#5 readAllFIFO();
	#5 $display("TIME = %d << Try to read Overflow>> ", $time);
	#5 readNextFIFO();
	#5 readNextFIFO();
	#5 $display("TIME = %d << GoToReadPtr 0 FIFO and read 2 States with Reset = high>> ", $time);
	retransmit <= 1;
	#5 readNextFIFO();
	#5 readNextFIFO();
	#5 retransmit <= 0;
	#5 $display("TIME = %d << GoToReadPtr at 0 and read States with Reset = low>> ", $time);
	#1 readAllFIFO();
	#5->terminate_sim;
	end

	
endmodule
`include "StateHandler.v"
module tb_statemachine();

reg clk, data, clock, sync, enable;
wire error, transmitter, retransmit, trigger, measure;
wire[1:0] freq, samp, interface;
reg[31:0] StateControl = 0;

	StateHandler h2(.mainclk(clk), .dataIn(data), .ctr_clk(clock), .ctr_cs(sync), .ctr_enable(enable),
								.StateError(error), .TransmitterOn(transmitter), .Retransmit(retransmit), 
								.MeasureType(measure), .TriggerOn(trigger), .Frequency(freq), .Sampling(samp),
								.OutputInterface(interface));

event start_sim;
initial begin : START_UP
	@(start_sim);
	$display("RUN => integration StateHandler.v");
	$display("TIME = %d << CLK periode = %d units >>", $time, 2*`clkToggle);
	$display("TIME = %d << SPI Clock periode = %d units >>", $time, 4*`clkToggle);
	clk <= 0;
	data <= 0;
	clock <= 0;
	sync <= 1;
	enable <= 1;
end

event terminate_sim;
initial begin : EVENT_TERMINATE_SIM
	@(terminate_sim);
	#5 $display("TIME = %d << Simulation Complete >> ", $time);
	$finish;
	end

event triggerActivated;
always begin : EVENT_TRIGGER_ACTIVATED
	@(triggerActivated);
	if(trigger) $display("TIME = %d << Trigger high Event is called >> ", $time);
		else 	$display("TIME = %d << Trigger low  Event is called >> ", $time);
	end

event measureActivated;
always begin : EVENT_MEASURE_ACTIVATED
	@(measureActivated);
	if(measure) $display("TIME = %d << measure static  Event is called >> ", $time);
		else 	$display("TIME = %d << measure dynamic Event is called >> ", $time);
	end

event retransmitActivated;
always begin : EVENT_RETRANSMIT_ACTIVATED
	@(retransmitActivated);
	if(retransmit) 	$display("TIME = %d << retransmit high Event is called >> ", $time);
		else 		$display("TIME = %d << retransmit low  Event is called >> ", $time);
	end

event SamplingActivated;
always begin : EVENT_Sampling_ACTIVATED
	@(SamplingActivated);
	$display("TIME = %d << Sampling Event is called Sampling %b >> ", $time, samp);
	end

event transmitterActivated;
always begin : EVENT_TRANSMITTER_ACTIVATED
	@(transmitterActivated);
	if(transmitter) $display("TIME = %d << transmitter high Event is called >> ", $time);
		else 		$display("TIME = %d << transmitter low  Event is called >> ", $time);
	end

event errorActivated;
always begin : EVENT_ERROR_ACTIVATED
	@(errorActivated);
	if(error) 	$display("TIME = %d << Error high Event is called >> ", $time);
		else 	$display("TIME = %d << Error low  Event is called >> ", $time);
	end


task toggle_maschine_enable;
	begin
		enable <= !enable;
		if(enable) 	$display("TIME = %d << StateMaschine get down >> ", $time);
		else 		$display("TIME = %d << StateMaschine get up >> ", $time);
	end
endtask

reg[4:0] i = 32;
task writeToFIFO;
	input[31:0] dataToSend;
	begin
	#5 sync <= 0;
	#5
	repeat (33) begin
		#1 data <= dataToSend[i];
		#1 clock <= 1;
		#1 clock <= 0;
		#1 i <= i - 1;
	end
	#5 i = 32;
	#5 sync = 1;
	#5 sync = 0;
	#1 $display("TIME = %d << Data %b was written >> ", $time, dataToSend);
	end
endtask 

task fillFIFO;
	begin
	enable <= 1;
	#5 sync  <= 1;
	#5 sync <= 0;
	#5 enable <= 0;
	StateControl <= 2'b11 | (1'b1 << 2)  | (2'b00 << 6) | (1'b0 << 8) | (1'b1 << 9) | (4'b0011 << 32-16);
	#1 writeToFIFO(StateControl);
	#1 StateControl = 0;
	StateControl <= 2'b11 | (2'b01 << 3) | (2'b00 << 6) | (1'b0 << 8) | (1'b1 << 9) | (4'b0111 << 32-16);
	#1 writeToFIFO(StateControl);
	#1 StateControl = 0;
	StateControl <= 2'b11 | (2'b10 << 3) | (2'b00 << 6) | (1'b0 << 8) | (1'b1 << 9) | (4'b1011 << 32-16);
	#1 writeToFIFO(StateControl);
	#1 StateControl = 0;
	StateControl <= 2'b11 | (1'b1 << 5)  | (2'b00 << 6) | (1'b0 << 8) | (1'b0 << 9) | (4'b1110 << 32-16);
	#1 writeToFIFO(StateControl);
	#1 $display("TIME = %d << FIFO filled >> ", $time);
	#5 enable <= 1;
	#5 sync <= 1;
	end
endtask

initial begin
	->start_sim;
	#5 fillFIFO;
	#200 toggle_maschine_enable;
	#200 toggle_maschine_enable;
	#400 ->terminate_sim;
	
end


always@(error) 		->errorActivated;
always@(transmitter)->transmitterActivated;
always@(retransmit)	->retransmitActivated;
always@(trigger)	->triggerActivated;
always@(measure)	->measureActivated;
always@(samp)		->SamplingActivated;

always #`clkToggle clk <= !clk;
endmodule