`timescale 1 ns / 100 ps
`define clkToggle 5
`include "OutputInterface.v"
`include "spi_slave.v"
`include "OutBuffer.v"
`include "LatticeLibs/FIFO8KA.v"

module tb_OutputInterface();
	
reg[63:0] Data;
wire[15:0] DATA; // 16bit Interface		  
reg[15:0] InterfaceData;
reg Retransmit, nextbuffer, clk;
wire DATA_READY, finish;  

assign DATA = InterfaceData;

PUR PUR_INST(.PUR(1'b1));
GSR GSR_INST(.GSR(1'b1));

OutputInterface	#(64)	dataOut( .reset(Retransmit), .pins(DATA), .iOut(2'b00), .bufferNxt(nextbuffer), .DataReady(DATA_READY),
											.data(Data), .finish(finish));	

event start_sim;
initial begin: EVENT_START_SIM
	@(start_sim);
	$display("RUN => Unit OutputInterface.v");
	$display("TIME = %d << CLK periode = %d units >>", $time, 2*`clkToggle);
	$display("TIME = %d << Starting the Simulation >> ", $time);
	Data <= 0;
	InterfaceData <= 0;	 
	clk <= 0;
	Retransmit <= 0;
	nextbuffer <= 0;
	InterfaceData[1] <= 1;
	InterfaceData[3] <= 1'bz;
	end

event terminate_sim;
initial begin: EVENT_TERMINATE_SIM
	@(terminate_sim);
	#5 $display("TIME = %d << Simulation Complete >> ", $time);
	$finish;
	end

event toggle_nextbuffer;
always begin : EVENT_TOGGLE_ENABLE
	@(toggle_nextbuffer);
	nextbuffer <= 1;
	#5 nextbuffer <= 0;
	$display("TIME = %d << nextbuffer triggered | Clk=%b >> ", $time, clk);
	end

task pushData;
	begin
		#5 Data <= {32{1'b1}} << 32 | {32{1'b0}};
		#5 nextbuffer <= 1;
		#5 nextbuffer <= 0;
		#5 Data <= {32{1'b0}} << 32 | {32{1'b1}};
		#5 nextbuffer <= 1;
		#5 nextbuffer <= 0;
		#5 Data <= {16{1'b1}} << 48 | {16{1'b0}} << 32  | {16{1'b0}} << 16 | {16{1'b1}};
		#5 nextbuffer <= 1;
		#5 nextbuffer <= 0;
		#5 Data <= {32{1'b1}} << 32 | {32{1'b0}};
		#5 nextbuffer <= 1;
		#5 nextbuffer <= 0;
	end
endtask

task pullData;
	begin
		InterfaceData[1] <= 0;
		->pull;
	end
endtask

event pull;
always begin: EVENT_PULL
	@(pull);
	#5 $display("TIME = %d << pull Data >> ", $time);
	end
	
event pull_finish;
always begin: EVENT_PULL_FINISH
	@(pull_finish);
	#5 $display("TIME = %d << pull Data >> ", $time);
	pullData;
	end

initial begin
	->start_sim;
	#5 Retransmit <= 1;
	#5 Retransmit <= 0;
	#5 pushData;
	#5 pushData;
	#5 pushData;
	#40 pullData;
	#6000 ->terminate_sim;
end

always #`clkToggle clk <= !clk;
always@(posedge clk) InterfaceData[0] <= !InterfaceData[0];
always@(posedge finish) begin
	//InterfaceData[1] <= 1;
	#5 ->pull_finish;
	end

endmodule
