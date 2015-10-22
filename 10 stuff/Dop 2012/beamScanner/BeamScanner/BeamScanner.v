/* Verilog model created from schematic BeamScanner.sch -- May 31, 2014 20:44 */

module BeamScanner( ADC_CLK, ADC_OUT, ADC_PWDN, CLK_64MHz, CLK_PIC, neg_burst,
                    nENABLE, nRESET, nSRSYNC, PDWN_0, PDWN_1, pos_burst,
                    RD_DATA, SPP_DATA, SPP_RDCLK, SRCLK, SRDATA, SWR );
output ADC_CLK;
 input [13:0] ADC_OUT;
output ADC_PWDN;
 input CLK_64MHz;
output CLK_PIC;
output neg_burst;
 input nENABLE;
 input nRESET;
 input nSRSYNC;
output PDWN_0;
output PDWN_1;
output pos_burst;
output RD_DATA;
output [7:0] SPP_DATA;
 input SPP_RDCLK;
 input SRCLK;
 input SRDATA;
 input SWR;
  wire [15:0] CTRL_CNT;
  wire [23:0] X;
  wire [7:0] CTRL;
  wire [23:0] SRBUS;
  wire [15:0] CNT;
  wire [15:0] ADC_DATA;
wire N_34;
wire N_32;
wire N_33;
wire N_31;
wire N_29;
wire N_30;
wire HALT;
wire vhi;
wire N_27;
wire N_28;
wire RESET;
wire SAMPLE;
wire ERROR_CTRL;
wire N_19;
wire N_21;
wire SAMPLE_ON;
wire WR_ctrlFF;
wire RD_ctrlFF;
wire RES_ctrlFF;
wire FF_RT;
wire ENABLE;
wire WR_Freq;
wire BURST;
wire ADC_ON;
wire AeqB;
wire RT_ctrlFF;
wire N_17;



OR2 I224 ( .A(nENABLE), .B(N_29), .Z(N_30) );
flag_ctrl I216 ( .AE(N_33), .AF(N_32), .CLK(CLK_64MHz), .read(RD_DATA),
              .Reset(RESET) );
DataFIFO I213 ( .AlmostEmpty(N_33), .AlmostFull(N_32), .Data(ADC_DATA[15:0]),
             .Q(SPP_DATA[7:0]), .RdClock(SPP_RDCLK), .RdEn(ENABLE),
             .Reset(RESET), .WrClock(SAMPLE), .WrEn(ENABLE) );
CLK_gen I212 ( .ADC_EN(ADC_ON), .BURST_EN(BURST), .BURST_N(neg_burst),
            .BURST_P(pos_burst), .CLK64(CLK_64MHz), .CLK_4MHz(CLK_PIC),
            .CLK_ADC(ADC_CLK), .CLK_SMPL(SAMPLE), .F2(SRBUS[1]),
            .F4(SRBUS[2]), .F8(SRBUS[3]), .RES_n(nRESET), .SMPL_EN(SAMPLE_ON),
            .WR_Freq(WR_Freq) );
splitter24_16_8 Splitter_Ctrl_Comp ( .Cnt(CTRL_CNT[15:0]), .Ctrl(CTRL[7:0]),
                                  .D(X[23:0]) );
fifo24bit Ctrl_Fifo ( .D(SRBUS[23:0]), .Q(X[23:0]), .RD(RD_ctrlFF),
                   .RES(RES_ctrlFF), .RET(RT_ctrlFF), .WR(WR_ctrlFF) );
sr24bit SPI_Interface ( .DIN(SRDATA), .nSYNC(nSRSYNC), .Q(SRBUS[23:0]),
                     .SCLK(SRCLK) );
VHI I220 ( .Z(PDWN_0) );
VHI I219 ( .Z(PDWN_1) );
VHI I90 ( .Z(N_31) );
VHI I200 ( .Z(vhi) );
PUR PUR_INST ( .PUR(N_31) );
GSR GSR_INST ( .GSR(N_31) );
FD1S1D I45 ( .CD(nENABLE), .CK(CLK_64MHz), .D(N_28), .Q(AeqB) );
AND3 I46 ( .A(AeqB), .B(ENABLE), .C(N_27), .Z(RD_ctrlFF) );
AND3 I47 ( .A(vhi), .B(ENABLE), .C(FF_RT), .Z(RT_ctrlFF) );
AND2 I226 ( .A(RD_DATA), .B(HALT), .Z(N_29) );
AND2 I225 ( .A(CTRL[4]), .B(N_17), .Z(HALT) );
AND2 I42 ( .A(CTRL[0]), .B(N_17), .Z(FF_RT) );
AND2 I48 ( .A(nRESET), .B(N_19), .Z(N_21) );
AND2 I43 ( .A(CTRL[1]), .B(N_17), .Z(BURST) );
AND2 I44 ( .A(CTRL[3]), .B(N_17), .Z(SAMPLE_ON) );
AND2 I74 ( .A(CTRL[2]), .B(N_17), .Z(ADC_ON) );
AND2 I59 ( .A(SRBUS[21]), .B(SWR), .Z(WR_Freq) );
AND2 I49 ( .A(SRBUS[22]), .B(SWR), .Z(WR_ctrlFF) );
AND2 I50 ( .A(SRBUS[23]), .B(SWR), .Z(RES_ctrlFF) );
cnt16bit Ctrl_Counter ( .CLK(CLK_64MHz), .nCLR(N_21), .nEN(N_30), .Q(CNT[15:0]) );
cmp16bit Ctrl_Comparator ( .AeqB(N_28), .AltB(ERROR_CTRL), .DataA(CNT[15:0]),
                        .DataB(CTRL_CNT[15:0]) );
VLO I221 ( .Z(ADC_PWDN) );
IB I229 ( .I(ADC_OUT[13]), .O(ADC_DATA[13]) );
IB I230 ( .I(ADC_OUT[12]), .O(ADC_DATA[12]) );
IB I231 ( .I(ADC_OUT[11]), .O(ADC_DATA[11]) );
IB I232 ( .I(ADC_OUT[0]), .O(ADC_DATA[0]) );
IB I233 ( .I(ADC_OUT[1]), .O(ADC_DATA[1]) );
IB I234 ( .I(ADC_OUT[2]), .O(ADC_DATA[2]) );
IB I235 ( .I(ADC_OUT[3]), .O(ADC_DATA[3]) );
IB I236 ( .I(ADC_OUT[4]), .O(ADC_DATA[4]) );
IB I237 ( .I(ADC_OUT[5]), .O(ADC_DATA[5]) );
IB I238 ( .I(ADC_OUT[6]), .O(ADC_DATA[6]) );
IB I239 ( .I(ADC_OUT[7]), .O(ADC_DATA[7]) );
IB I240 ( .I(ADC_OUT[8]), .O(ADC_DATA[8]) );
IB I241 ( .I(ADC_OUT[9]), .O(ADC_DATA[9]) );
IB I242 ( .I(ADC_OUT[10]), .O(ADC_DATA[10]) );
INV I243 ( .A(N_34), .Z(ADC_DATA[15]) );
INV I244 ( .A(N_34), .Z(ADC_DATA[14]) );
INV I245 ( .A(ADC_DATA[13]), .Z(N_34) );
INV I215 ( .A(nRESET), .Z(RESET) );
INV I53 ( .A(FF_RT), .Z(N_27) );
INV I51 ( .A(RT_ctrlFF), .Z(N_19) );
INV I201 ( .A(nENABLE), .Z(N_17) );
INV I208 ( .A(nENABLE), .Z(ENABLE) );

endmodule // BeamScanner
