/* SPI MODE 3
		CHANGE DATA (miso) @ NEGEDGE SCK
		read data (mosi) @posedge SCK
*/
/* Params
	rstb 	-> active low asyn reset
	ten		-> active high MOSI enabled - else don't care /tri-state
	tdata	-> 114 bit data to transmit
	mlb		-> if high -> Bit15to0 else -> Bit0to15
	ss		-> active low - slave select
	sck		-> SPI Clock
	mosi	-> Master out Slave in
	miso	-> Master in Slave out
	done	-> active high -> low if 16 bit not transmitted else high
	rdata	-> 16 bit parallel MOSI data REGISTER!!!
*/
/*
	http://www.elecdude.com/2013/10/serial-communication-protocol-ic-vs-spi.html
	http://www.elecdude.com/2013/09/spi-master-slave-verilog-code-spi.html
	http://www.elecdude.com/2013/10/spi-verilog-code-master-slave-code-with.html
	http://www.fpga4fun.com/SPI2.html  // synthesis syn_keep=1 opt="keep"//
*/

`include "Defines.v"

module parallelIN_serialOUT #(parameter Width = 16)
   (input wire clock,
	input wire reset,
	input wire [Width-1:0] dataOut,
	input wire next,
	output wire out);
	 
	reg [Width-1:0] outreg;
	reg [Width-1:0] counter;
	
always@(negedge clock or posedge reset) begin : SHIFT_OUT
  if (reset) begin 
	outreg 	= #`DELAY {Width{1'b0}}; 
	counter = #`DELAY {1'b0, {Width{1'b1}}};
  end
  else begin
	  if(counter != 0 && !next) begin
`ifdef LSB //LSB first, in@msb -> right shift
		outreg = #`DELAY {1'b1,outreg[Width-1:1]};
`else     //MSB first, in@lsb -> left shift
		outreg = #`DELAY {outreg[Width-2:0],1'b1};
`endif
		counter = #`DELAY {1'b0, counter[Width-1:1]};
	  end
		if(next) begin
		outreg = #`DELAY {dataOut};
		counter = #`DELAY {1'b0, {Width{1'b1}}};
	  end
  end
end

`ifdef LSB
	assign out = outreg[0];
`else
	assign out = outreg[15];
`endif										
endmodule 

module serialIN_parallelOUT #(parameter Width = 16)
   (input wire clock,
	input wire reset,
	input wire in,
	input wire csn,
	output reg [Width-1:0] dataIn,
	output reg done);
	
	reg [Width-1:0] counter, inreg;
	
always@(posedge clock or posedge reset) begin : SHIFT_OUT
  if (reset) begin 
	inreg = #`DELAY {Width{1'b0}};
	dataIn = #`DELAY {Width{1'b0}};
	done = #`DELAY 0;
	counter =  #`DELAY {Width{1'b1}};
  end
  else begin
`ifdef LSB //LSB first, in@msb -> right shift
			inreg = #`DELAY {in,inreg[Width-1:1]};
`else     //MSB first, in@lsb -> left shift
			inreg = #`DELAY {inreg[Width-2:0],in};
`endif
	counter = #`DELAY {1'b0, counter[Width-1:1]};
	if(counter != 0 || csn) done = 0;
	else begin
	  dataIn = #`DELAY inreg;
	  done = 1;
	  counter =  #`DELAY {Width{1'b1}};
	end
  end
end


endmodule 