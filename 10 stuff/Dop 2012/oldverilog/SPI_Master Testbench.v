/*
quit -sim
vlog -work work -L mtiAvm -L mtiOvm -L mtiUPF {F:/San Docments/xilinx/_mODELSIM/s@n_spi/SPI_master.v}
vlog -work work -L mtiAvm -L mtiOvm -L mtiUPF {F:/San Docments/xilinx/_mODELSIM/s@n_spi/TestBench_SPI_MAS.v}
vsim -novopt work.tb_MASTER
add wave *
run 2200ns
*/
`timescale 1ns/10ps
module tb_MASTER;
    reg rstb;
    reg clk = 1'b0;
    reg t_rb = 1'b0;
    reg mlb = 1'b0;
    reg start = 1'b0;
    reg [7:0] tdat = 8'b00000000;
    reg [1:0] cdiv = 0;
    wire din;
    wire ss;
    wire sck;
    wire dout;
    wire done;
    wire [7:0] rdata;

assign din=dout;

	initial #6000 $stop;

	
    parameter PERIOD = 50;
    parameter real DUTY_CYCLE = 0.5;
    parameter OFFSET = 100;
    initial    // Clock process for clk
    begin
        #OFFSET;
        forever
        begin
            clk = 1'b0;
            #(PERIOD-(PERIOD*DUTY_CYCLE)) clk = 1'b1;
            #(PERIOD*DUTY_CYCLE);
        end
    end

    spi_master UUT (
        .rstb(rstb),
        .clk(clk),
        .mlb(mlb),
        .start(start),
        .tdat(tdat),
        .cdiv(cdiv),
        .din(din),
        .ss(ss),
        .sck(sck),
        .dout(dout),
        .done(done),
        .rdata(rdata));

//	$dumpfile("vcd_spi_master.vcd");  	$dumpvars;
/*
wire [7:0] treg,rreg;	
wire [3:0] nbit;	
assign treg=UUT.treg;
assign rreg=UUT.rreg;
assign nbit=UUT.nbit;
wire [1:0] cur;
assign cur=UUT.cur;
wire shift,clr;
assign clr=UUT.clr;
assign shift=UUT.shift;
*/

initial begin

        #10 rstb = 1'b0;
        #100;
        rstb = 1'b1;start = 1'b0;
        t_rb = 1'b1;
        tdat = 8'b01111100;
        cdiv = 2'b00;
   
        #100        start = 1'b1;
        #100         start = 1'b0;
 

        #1800 mlb = 1'b1; cdiv=2'b01; tdat=8'b00011100;
        #100  start = 1'b1;
		    #100  start = 1'b0;
		    #2000;


   end

endmodule


