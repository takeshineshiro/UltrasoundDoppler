/* Verilog model created from schematic USD.sch -- May 31, 2014 20:44 */

module USD( ADC_CLK, ADC_PWDN, CLK_64MHz, neg_burst, nENABLE, PDWN_0, PDWN_1,
            pos_burst );
output ADC_CLK;
output ADC_PWDN;
 input CLK_64MHz;
output neg_burst;
 input nENABLE;
output PDWN_0;
output PDWN_1;
output pos_burst;
  wire [7:0] RegBus;
  wire [15:0] RegValueBus;
  wire [15:0] ADC_DATA;
wire N_5;
wire N_6;
wire N_7;
wire N_8;
wire N_9;
wire ENABLE;
wire N_10;
wire N_1;
wire N_2;
wire N_3;
wire N_4;



DataFIFO I213 ( .RdEn(N_7), .Reset(N_6), .WrClock(N_5), .WrEn(N_8) );
IB I240 ( .I(ADC_OUT[8]), .O(ADC_DATA[8]) );
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
IB I241 ( .I(ADC_OUT[9]), .O(ADC_DATA[9]) );
IB I242 ( .I(ADC_OUT[10]), .O(ADC_DATA[10]) );
AND2 I210 ( .A(N_2), .B(N_3), .Z(N_4) );
CommunicationLayer I209 ( .mosi(SRDATA), .Reg(RegBus[7:0]),
                       .RegValue(RegValueBus[15:0]), .sck(SRCLK),
                       .SendDataMode(N_1), .ss(nSRSYNC), .Transfered(N_2) );
INV I208 ( .A(nENABLE), .Z(ENABLE) );
INV I243 ( .A(N_10), .Z(ADC_DATA[15]) );
INV I244 ( .A(N_10), .Z(ADC_DATA[14]) );
INV I245 ( .A(ADC_DATA[13]), .Z(N_10) );
INV I211 ( .A(N_1), .Z(N_3) );
USDCoreLayer I1 ( .clock(CLK_64MHz), .cmd(RegBus[7:0]), .enable(ENABLE),
               .PullData(N_1), .RX_clock(ADC_CLK), .RX_pwdn(ADC_PWDN),
               .RX_read(N_9), .TX_neg(neg_burst), .TX_pos(pos_burst),
               .TX_pwdn0(PDWN_0), .TX_pwdn1(PDWN_1),
               .value(RegValueBus[15:0]), .write(N_4) );

endmodule // USD
