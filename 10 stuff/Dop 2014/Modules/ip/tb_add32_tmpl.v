//Verilog testbench template generated by SCUBA Diamond (64-bit) 3.4.0.80
`timescale 1 ns / 1 ps
module tb;
    reg [31:0] DataA = 32'b0;
    reg [31:0] DataB = 32'b0;
    wire [31:0] Result;

    integer i0 = 0, i1 = 0, i2 = 0;

    GSR GSR_INST (.GSR(1'b1));
    PUR PUR_INST (.PUR(1'b1));

    add32 u1 (.DataA(DataA), .DataB(DataB), .Result(Result)
    );

    initial
    begin
       DataA <= 0;
      for (i1 = 0; i1 < 200; i1 = i1 + 1) begin
        #10;
         DataA <= DataA + 1'b1;
      end
    end
    initial
    begin
       DataB <= 0;
      for (i2 = 0; i2 < 200; i2 = i2 + 1) begin
        #10;
         DataB <= DataB + 1'b1;
      end
    end
endmodule