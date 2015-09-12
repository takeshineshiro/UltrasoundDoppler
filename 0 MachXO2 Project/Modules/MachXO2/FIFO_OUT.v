/* Verilog netlist generated by SCUBA Diamond (64-bit) 3.5.1.302 */
/* Module Version: 5.8 */
/* C:\lscc\diamond\3.5_x64\ispfpga\bin\nt64\scuba.exe -w -n FIFO_OUT -lang verilog -synth synplify -bb -arch xo2c00 -type ebfifo -depth 1024 -width 16 -rwidth 8 -regout -resetmode ASYNC -reset_rel ASYNC -no_enable -pe 256 -pf 960  */
/* Thu Sep 10 16:39:40 2015 */


`timescale 1 ns / 1 ps
module FIFO_OUT (Data, WrClock, RdClock, WrEn, RdEn, Reset, RPReset, Q, 
    Empty, Full, AlmostEmpty, AlmostFull)/* synthesis NGD_DRC_MASK=1 */;
    input wire [15:0] Data;
    input wire WrClock;
    input wire RdClock;
    input wire WrEn;
    input wire RdEn;
    input wire Reset;
    input wire RPReset;
    output wire [7:0] Q;
    output wire Empty;
    output wire Full;
    output wire AlmostEmpty;
    output wire AlmostFull;

    wire Empty_int;
    wire Full_int;
    wire scuba_vhi;
    wire scuba_vlo;

    defparam FIFO_OUT_0_1.FULLPOINTER1 = "0b01111111111000" ;
    defparam FIFO_OUT_0_1.FULLPOINTER = "0b10000000000000" ;
    defparam FIFO_OUT_0_1.AFPOINTER1 = "0b01110111111000" ;
    defparam FIFO_OUT_0_1.AFPOINTER = "0b01111000000000" ;
    defparam FIFO_OUT_0_1.AEPOINTER1 = "0b00010000000100" ;
    defparam FIFO_OUT_0_1.AEPOINTER = "0b00010000000000" ;
    defparam FIFO_OUT_0_1.ASYNC_RESET_RELEASE = "ASYNC" ;
    defparam FIFO_OUT_0_1.GSR = "DISABLED" ;
    defparam FIFO_OUT_0_1.RESETMODE = "ASYNC" ;
    defparam FIFO_OUT_0_1.REGMODE = "OUTREG" ;
    defparam FIFO_OUT_0_1.CSDECODE_R = "0b11" ;
    defparam FIFO_OUT_0_1.CSDECODE_W = "0b11" ;
    defparam FIFO_OUT_0_1.DATA_WIDTH_R = 4 ;
    defparam FIFO_OUT_0_1.DATA_WIDTH_W = 9 ;
    FIFO8KB FIFO_OUT_0_1 (.DI0(Data[0]), .DI1(Data[1]), .DI2(Data[2]), .DI3(Data[3]), 
        .DI4(Data[8]), .DI5(Data[9]), .DI6(Data[10]), .DI7(Data[11]), .DI8(scuba_vlo), 
        .DI9(scuba_vlo), .DI10(scuba_vlo), .DI11(scuba_vlo), .DI12(scuba_vlo), 
        .DI13(scuba_vlo), .DI14(scuba_vlo), .DI15(scuba_vlo), .DI16(scuba_vlo), 
        .DI17(scuba_vlo), .CSW0(scuba_vhi), .CSW1(scuba_vhi), .CSR0(RdEn), 
        .CSR1(scuba_vhi), .FULLI(Full_int), .EMPTYI(Empty_int), .WE(WrEn), 
        .RE(scuba_vhi), .ORE(scuba_vhi), .CLKW(WrClock), .CLKR(RdClock), 
        .RST(Reset), .RPRST(RPReset), .DO0(Q[0]), .DO1(Q[1]), .DO2(Q[2]), 
        .DO3(Q[3]), .DO4(), .DO5(), .DO6(), .DO7(), .DO8(), .DO9(), .DO10(), 
        .DO11(), .DO12(), .DO13(), .DO14(), .DO15(), .DO16(), .DO17(), .EF(Empty_int), 
        .AEF(AlmostEmpty), .AFF(AlmostFull), .FF(Full_int));

    VHI scuba_vhi_inst (.Z(scuba_vhi));

    VLO scuba_vlo_inst (.Z(scuba_vlo));

    defparam FIFO_OUT_1_0.FULLPOINTER1 = "0b00000000000000" ;
    defparam FIFO_OUT_1_0.FULLPOINTER = "0b11111111111100" ;
    defparam FIFO_OUT_1_0.AFPOINTER1 = "0b00000000000000" ;
    defparam FIFO_OUT_1_0.AFPOINTER = "0b11111111111100" ;
    defparam FIFO_OUT_1_0.AEPOINTER1 = "0b00000000000000" ;
    defparam FIFO_OUT_1_0.AEPOINTER = "0b11111111111100" ;
    defparam FIFO_OUT_1_0.ASYNC_RESET_RELEASE = "ASYNC" ;
    defparam FIFO_OUT_1_0.GSR = "DISABLED" ;
    defparam FIFO_OUT_1_0.RESETMODE = "ASYNC" ;
    defparam FIFO_OUT_1_0.REGMODE = "OUTREG" ;
    defparam FIFO_OUT_1_0.CSDECODE_R = "0b11" ;
    defparam FIFO_OUT_1_0.CSDECODE_W = "0b11" ;
    defparam FIFO_OUT_1_0.DATA_WIDTH_R = 4 ;
    defparam FIFO_OUT_1_0.DATA_WIDTH_W = 9 ;
    FIFO8KB FIFO_OUT_1_0 (.DI0(Data[4]), .DI1(Data[5]), .DI2(Data[6]), .DI3(Data[7]), 
        .DI4(Data[12]), .DI5(Data[13]), .DI6(Data[14]), .DI7(Data[15]), 
        .DI8(scuba_vlo), .DI9(scuba_vlo), .DI10(scuba_vlo), .DI11(scuba_vlo), 
        .DI12(scuba_vlo), .DI13(scuba_vlo), .DI14(scuba_vlo), .DI15(scuba_vlo), 
        .DI16(scuba_vlo), .DI17(scuba_vlo), .CSW0(scuba_vhi), .CSW1(scuba_vhi), 
        .CSR0(RdEn), .CSR1(scuba_vhi), .FULLI(Full_int), .EMPTYI(Empty_int), 
        .WE(WrEn), .RE(scuba_vhi), .ORE(scuba_vhi), .CLKW(WrClock), .CLKR(RdClock), 
        .RST(Reset), .RPRST(RPReset), .DO0(Q[4]), .DO1(Q[5]), .DO2(Q[6]), 
        .DO3(Q[7]), .DO4(), .DO5(), .DO6(), .DO7(), .DO8(), .DO9(), .DO10(), 
        .DO11(), .DO12(), .DO13(), .DO14(), .DO15(), .DO16(), .DO17(), .EF(), 
        .AEF(), .AFF(), .FF());

    assign Empty = Empty_int;
    assign Full = Full_int;


    // exemplar begin
    // exemplar end

endmodule