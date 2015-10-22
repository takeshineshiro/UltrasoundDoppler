`timescale 1 ns / 100 ps
`define clkToggle 10
`include "Quad_Table.v"
`include "/LatticeLibs/FD1P3DX.v"

module tb_Quad_Table();

wire[7:0] sin, cos;
reg clk, enable;
reg[2:0] quadTableRotation;

PUR PUR_INST(.PUR(1'b1));
GSR GSR_INST(.GSR(1'b1));

Quad_Table quad(.Clock(clk), .ClkEn(enable), .Reset(~enable), .Theta(quadTableRotation), .Sine(sin), .Cosine(cos));	

event start_sim;
initial begin: EVENT_START_SIM
	@(start_sim);
	$display("RUN => Unit Quad_Table.v");
	$display("TIME = %d << CLK periode = %d units >>", $time, 2*`clkToggle);
	$display("TIME = %d << Starting the Simulation >> ", $time);
	clk <= 0;
	enable <= 0;
	quadTableRotation <= 0;
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

task rotate;
	begin
	#20 quadTableRotation <= quadTableRotation + 1;
	#20 quadTableRotation <= quadTableRotation + 1;
	#20 quadTableRotation <= quadTableRotation + 1;
	#20 quadTableRotation <= quadTableRotation + 1;
	#20 quadTableRotation <= quadTableRotation + 1;
	end
endtask

initial begin
	->start_sim;
	//#20 ->toggle_freqSelector;
	#20 ->toggle_enable;
	#20 rotate;
	#20 rotate;
	#20 rotate;
	#20 rotate;
	#20 rotate;
	#20 ->terminate_sim;
	end
	
always #`clkToggle clk <= !clk;
always #20 $display($time, " << Clk=%b | enable=%b | TableReg=%b | Sinus=%d | Cosinus=%d >> ", clk, enable, quadTableRotation, sin, cos);

endmodule

`include "ALU.v"
`define Add   2'b00
`define Sub   2'b01
`define Multi 2'b10
`define Div	  2'b11
module tb_alu();

reg clk, enable;
reg[7:0] sin, cos;
reg[13:0] adcValue;
wire[21:0] result1, result2;
wire[31:0] transform1, transform2, add11, add12;
reg[31:0] calculated1, calculated2;
wire[63:0] Out;

always@(posedge clk) begin
	calculated1 <= (enable) ? add11 : 0;
	calculated2 <= (enable) ? add12 : 0;
	end

ALU #(.Width(22), .WidthA(8), .WidthB(14)) m1(.clk(~clk), .a(sin), .b(adcValue), .op(`Multi), .result(result1));
ALU #(.Width(22), .WidthA(8), .WidthB(14)) m2(.clk(~clk), .a(cos), .b(adcValue), .op(`Multi), .result(result2));

assign transform1 = (result1[21] == 1) ? ({10{1'b1}} << 22) | result1 : ({10{1'b0}} << 22) | result1;
assign transform2 = (result2[21] == 1) ? ({10{1'b1}} << 22) | result2 : ({10{1'b0}} << 22) | result2;

ALU #(.Width(32)) alu11(.clk(~clk), .a(transform1), .b(calculated1), .op(`Add), .result(add11));
ALU #(.Width(32)) alu12(.clk(~clk), .a(transform2), .b(calculated2), .op(`Add), .result(add12));

assign Out = add11 | ( add12 << 32);

event start_sim;
initial begin: EVENT_START_SIM
	@(start_sim);
	$display("RUN => Unit ALU.v");
	$display("TIME = %d << CLK periode = %d units >>", $time, 2*`clkToggle);
	$display("TIME = %d << Starting the Simulation >> ", $time);
	clk <= 0;
	enable <= 0;
	sin <= 0;
	cos <= 0;
	adcValue <= 0;
	calculated1 <= 0;
	calculated2 <= 0;
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

task setValues;
	begin
	#20 adcValue <= 200;
	#40 sin <= 4;
		cos <= 3;
	#20 adcValue <= 50;
	end
endtask

initial begin
	->start_sim;
	#5 setValues;
	#5 ->toggle_enable;
	#5 setValues;
	#20->toggle_enable;
	#50 ->terminate_sim;
end

always #`clkToggle clk <= !clk;
always #20 $display($time, " << Clk=%b | enable=%b | TableReg=%d | Sinus=%d | Cosinus=%d | Result1=%d | Result2=%d >> ", clk, enable, adcValue, sin, cos, add11, add12);


endmodule
