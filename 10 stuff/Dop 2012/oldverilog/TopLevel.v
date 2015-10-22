`timescale 10 ps / 10 ps

module TopLevel(
	input wire T1, T2, Xin, U0, U1,
	output wire TRIGGER, T0);

wire[15:0] Data;
reg[15:0] tData = 16'hAAAA;

SPI_slave #(1)	mode3(.rstb(~T2), .ten(1'b1), .tdata(tData), .ss(1'b0), .sck(T1),
						.mosi(U1), .miso(T0), .done(SegDone), .rdata(Data));
					
assign TRIGGER = Data[3];
					
endmodule
