/* Verilog model created from schematic BeamScanner.sch -- Aug 29, 2013 14:23 */

module BeamScanner( ADC_CLK, ADC_PWDN, CLK_PIC, neg_burst, nENABLE, nRESET, nSRSYNC,
                    PDWN_0, PDWN_1, pos_burst, SRCLK, SRDATA, SWR, Xin );
output ADC_CLK;
output ADC_PWDN;
output CLK_PIC;
output neg_burst;
 input nENABLE;
 input nRESET;
 input nSRSYNC;
output PDWN_0;
output PDWN_1;
output pos_burst;
 input SRCLK;
 input SRDATA;
 input SWR;
 input Xin;
  wire [31:0] SRBUS;

  wire [15:0] CNT;

  wire [31:0] CTRL;

wire ERROR_CTRL;

wire RSTCNT;

wire N_38;

wire N_39;

wire nCLK_PIC;

wire nXin;

wire nRD_ctrlFF;

wire N_18;

wire N_19;

wire N_20;

wire N_21;

wire N_22;

wire F_ctrlFF;

wire E_ctrlFF;

wire nCLK;

wire N_17;

wire WR_Freq;

wire vlo;

wire vhi;

wire nADC_ON;

wire ADC_ON;

wire SV1;

wire SV2;

wire CLK;

wire RESET;

wire N_7;

wire AeqB;

wire RES_ctrlFF;

wire RT_ctrlFF;

wire RD_ctrlFF;

wire WR_ctrlFF;

wire BURST;

wire FF_RT;

wire ENABLE;




FD1S1A I191 ( .CK(nRD_ctrlFF), .D(CTRL[16]), .Q(N_18) );
FD1S1A I192 ( .CK(nRD_ctrlFF), .D(CTRL[17]), .Q(N_19) );
FD1S1A I193 ( .CK(nRD_ctrlFF), .D(CTRL[18]), .Q(N_20) );
FD1S1A I194 ( .CK(nRD_ctrlFF), .D(CTRL[19]), .Q(N_21) );
FD1S1A I195 ( .CK(nRD_ctrlFF), .D(CTRL[20]), .Q(N_22) );
OB I197 ( .I(vhi), .O(PDWN_1) );
OB I198 ( .I(vhi), .O(PDWN_0) );
OB I196 ( .I(vlo), .O(ADC_PWDN) );
VHI I90 ( .Z(vhi) );
PUR PUR_INST ( .PUR(vhi) );
GSR GSR_INST ( .GSR(vhi) );
FD1S1D I45 ( .CD(nENABLE), .CK(Xin), .D(N_39), .Q(AeqB) );
AND3 I46 ( .A(AeqB), .B(ENABLE), .C(N_7), .Z(RD_ctrlFF) );
AND3 I47 ( .A(vhi), .B(ENABLE), .C(FF_RT), .Z(RT_ctrlFF) );
AND2 I48 ( .A(nRESET), .B(N_38), .Z(RSTCNT) );
AND2 I93 ( .A(CLK), .B(ADC_ON), .Z(ADC_CLK) );
AND2 I74 ( .A(N_22), .B(ENABLE), .Z(ADC_ON) );
AND2 I58 ( .A(N_21), .B(ENABLE), .Z(SV2) );
AND2 I42 ( .A(N_18), .B(ENABLE), .Z(FF_RT) );
AND2 I43 ( .A(N_19), .B(ENABLE), .Z(BURST) );
AND2 I44 ( .A(N_20), .B(ENABLE), .Z(SV1) );
AND2 I59 ( .A(SRBUS[29]), .B(SWR), .Z(WR_Freq) );
AND2 I60 ( .A(SRBUS[28]), .B(SWR), .Z(N_17) );
AND2 I49 ( .A(SRBUS[31]), .B(SWR), .Z(WR_ctrlFF) );
AND2 I50 ( .A(SRBUS[30]), .B(SWR), .Z(RES_ctrlFF) );
VLO I22 ( .Z(vlo) );
INV I51 ( .A(RT_ctrlFF), .Z(N_38) );
INV I175 ( .A(CLK_PIC), .Z(nCLK_PIC) );
INV I170 ( .A(CLK), .Z(nCLK) );
INV I184 ( .A(Xin), .Z(nXin) );
INV I57 ( .A(nRESET), .Z(RESET) );
INV I56 ( .A(nENABLE), .Z(ENABLE) );
INV I190 ( .A(RD_ctrlFF), .Z(nRD_ctrlFF) );
INV I91 ( .A(ADC_ON), .Z(nADC_ON) );
INV I53 ( .A(FF_RT), .Z(N_7) );

endmodule // BeamScanner
