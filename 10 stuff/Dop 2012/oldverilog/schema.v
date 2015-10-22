/* Verilog model created from schematic PLDSchema.sch -- Nov 13, 2013 13:09 */

module PLDSchema( Burst_N, Burst_P, CTR_CLOCK, CTR_DATA, CTR_FEEDBACK, CTR_SYNC );
output Burst_N;
output Burst_P;
 input CTR_CLOCK;
 input CTR_DATA;
 input CTR_FEEDBACK;
 input CTR_SYNC;
  wire [31:0] InBus;

  wire [31:0] State;

wire N_22;

wire N_23;

wire N_16;

wire N_17;

wire N_18;

wire N_19;

wire N_20;

wire N_21;

wire Reset;

wire N_7;

wire N_8;

wire N_10;

wire N_11;

wire N_12;

wire N_13;

wire NextState;

wire N_14;

wire N_15;

wire N_4;

wire N_6;

wire Xin;

wire vhi;

wire vlo;




OR2 I105 ( .A(State[16]), .B(CTR_FEEDBACK), .Z(N_16) );
OR2 I106 ( .A(State[17]), .B(CTR_SYNC), .Z(N_17) );
OR2 I107 ( .A(State[18]), .B(CTR_CLOCK), .Z(N_18) );
OR2 I108 ( .A(State[19]), .B(CTR_DATA), .Z(N_19) );
INV I109 ( .A(N_20), .Z(N_21) );
INV I100 ( .A(State[22]), .Z(N_7) );
INV I101 ( .A(N_8), .Z(Reset) );
INV I102 ( .A(N_10), .Z(N_13) );
AND2 I103 ( .A(NextState), .B(State[22]), .Z(N_8) );
AND2 I104 ( .A(NextState), .B(N_7), .Z(N_10) );
AND2 I95 ( .A(N_11), .B(N_19), .Z(N_22) );
AND2 I97 ( .A(N_15), .B(N_17), .Z(N_12) );
AND2 I96 ( .A(N_14), .B(N_18), .Z(N_23) );
GenFrequency I98 ( .full(N_11), .half(N_14), .mainclk(N_4), .quarter(N_15),
                .reset(N_6) );
GenFrequency I99 ( .eighth(N_4), .mainclk(Xin), .reset(N_6) );
shiftIn32bit I94 ( .cs(CTR_SYNC), .dataIn(CTR_DATA), .Q(InBus[31:0]),
                .sclk(CTR_CLOCK) );
GenBurst I91 ( .burstNeg(Burst_N), .burstPos(Burst_P), .freqIn(N_23),
            .gate(N_16) );
CompareState I92 ( .clk(Xin), .dataB(State[15:0]), .enable(Reset),
                .Equal(NextState), .reset(Reset) );
FIFOVar I93 ( .data(InBus[31:0]), .goToReg0(Reset), .Q(State[31:0]),
           .readEnable(N_21), .readNext(N_13), .reset(N_21), .writeNext(N_21) );
PUR PUR_INST ( .PUR(vhi) );
VHI I110 ( .Z(N_20) );
VHI I90 ( .Z(vhi) );
GSR GSR_INST ( .GSR(vhi) );
VLO I22 ( .Z(vlo) );

endmodule // PLDSchema
