// Verilog netlist produced by program LSE :  version Diamond (64-bit) 3.5.1.302
// Netlist written on Sat Sep 12 12:05:28 2015
//
// Verilog Description of module UltrasoundDopplerTop
//

module UltrasoundDopplerTop (CLK_EXT, ENABLE, spi_clk, spi_miso, spi_mosi, 
            spi_csn, TX_PWDN, TX_CLK, TX_SWITCH, RX_OTR, RX, RX_CLK, 
            RX_PWDN, DATA_CLK, ROI_SYNC, HARM_SYNC, DATA_OUT, TP) /* synthesis syn_module_defined=1 */ ;   // d:/workspace/ultrasounddoppler/0 machxo2 project/ultrasounddopplertop.v(3[8:28])
    input CLK_EXT;   // d:/workspace/ultrasounddoppler/0 machxo2 project/ultrasounddopplertop.v(4[15:22])
    input ENABLE;   // d:/workspace/ultrasounddoppler/0 machxo2 project/ultrasounddopplertop.v(5[15:21])
    input spi_clk;   // d:/workspace/ultrasounddoppler/0 machxo2 project/ultrasounddopplertop.v(7[19:26])
    output spi_miso;   // d:/workspace/ultrasounddoppler/0 machxo2 project/ultrasounddopplertop.v(8[19:27])
    input spi_mosi;   // d:/workspace/ultrasounddoppler/0 machxo2 project/ultrasounddopplertop.v(9[19:27])
    input spi_csn;   // d:/workspace/ultrasounddoppler/0 machxo2 project/ultrasounddopplertop.v(10[19:26])
    output [1:0]TX_PWDN;   // d:/workspace/ultrasounddoppler/0 machxo2 project/ultrasounddopplertop.v(12[20:27])
    output [1:0]TX_CLK;   // d:/workspace/ultrasounddoppler/0 machxo2 project/ultrasounddopplertop.v(13[20:26])
    output TX_SWITCH;   // d:/workspace/ultrasounddoppler/0 machxo2 project/ultrasounddopplertop.v(14[15:24])
    input RX_OTR;   // d:/workspace/ultrasounddoppler/0 machxo2 project/ultrasounddopplertop.v(16[15:21])
    input [13:0]RX;   // d:/workspace/ultrasounddoppler/0 machxo2 project/ultrasounddopplertop.v(17[21:23])
    output RX_CLK;   // d:/workspace/ultrasounddoppler/0 machxo2 project/ultrasounddopplertop.v(18[15:21])
    output RX_PWDN;   // d:/workspace/ultrasounddoppler/0 machxo2 project/ultrasounddopplertop.v(19[15:22])
    output DATA_CLK;   // d:/workspace/ultrasounddoppler/0 machxo2 project/ultrasounddopplertop.v(21[15:23])
    output ROI_SYNC;   // d:/workspace/ultrasounddoppler/0 machxo2 project/ultrasounddopplertop.v(22[15:23])
    output HARM_SYNC;   // d:/workspace/ultrasounddoppler/0 machxo2 project/ultrasounddopplertop.v(23[15:24])
    output [7:0]DATA_OUT;   // d:/workspace/ultrasounddoppler/0 machxo2 project/ultrasounddopplertop.v(24[20:28])
    output [5:0]TP;   // d:/workspace/ultrasounddoppler/0 machxo2 project/ultrasounddopplertop.v(25[22:24])
    
    wire CLK_EXT_c /* synthesis SET_AS_NETWORK=CLK_EXT_c, is_clock=1 */ ;   // d:/workspace/ultrasounddoppler/0 machxo2 project/ultrasounddopplertop.v(4[15:22])
    wire spi_clk_c /* synthesis is_clock=1 */ ;   // d:/workspace/ultrasounddoppler/0 machxo2 project/ultrasounddopplertop.v(7[19:26])
    wire n2239 /* synthesis is_clock=1, SET_AS_NETWORK=n2239 */ ;   // d:/workspace/ultrasounddoppler/0 machxo2 project/ultrasounddopplertop.v(18[15:21])
    wire [7:0]divider /* synthesis is_clock=1, SET_AS_NETWORK=divider[0] */ ;   // d:/workspace/ultrasounddoppler/0 machxo2 project/ultrasounddopplertop.v(64[13:20])
    wire MEM_DATA_OUT_7__N_13 /* synthesis is_clock=1 */ ;   // d:/workspace/ultrasounddoppler/0 machxo2 project/ultrasounddopplertop.v(117[13:25])
    wire clock_N_160 /* synthesis is_inv_clock=1 */ ;   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/spi_slave.v(33[18:24])
    
    wire GND_net, VCC_net, n2242_c, spi_miso_c, spi_mosi_c, spi_csn_c, 
        n401, TX_CLK_c_1, TP_c, n470, RX_c_12, RX_c_11, RX_c_10, 
        RX_c_9, RX_c_8, RX_c_7, RX_c_6, RX_c_5, RX_c_4, RX_c_3, 
        RX_c_2, RX_c_1, RX_c_0, RX_PWDN_c, DATA_CLK_c, DATA_OUT_c_7, 
        DATA_OUT_c_6, DATA_OUT_c_5, DATA_OUT_c_4, DATA_OUT_c_3, DATA_OUT_c_2, 
        DATA_OUT_c_1, DATA_OUT_c_0, TP_c_5, TP_c_2, mem_clk;
    wire [7:0]mem_addr;   // d:/workspace/ultrasounddoppler/0 machxo2 project/ultrasounddopplertop.v(38[32:40])
    wire [15:0]mem_rdata;   // d:/workspace/ultrasounddoppler/0 machxo2 project/ultrasounddopplertop.v(39[31:40])
    wire [15:0]mem_wdata;   // d:/workspace/ultrasounddoppler/0 machxo2 project/ultrasounddopplertop.v(40[31:40])
    
    wire n616, readyToWrite, n440, n437, n476, n485, MEM_DATA_RD_CLK, 
        ADCData_c_1, ENABLE_N_2, TP_2__N_4, n482;
    wire [3:0]spi_cmd;   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/communicationlayer.v(32[12:19])
    
    wire n410, n407, MEM_CLK_N_130, n362, n404, n467, MEM_CLK_N_127, 
        n488, n1619, n479, n371, n374, n377, n380, n383, n386, 
        n389, n392, n395, n398, n536, n533, n530, n527, n524, 
        n521, n6, n518, n515, n512, n509, n506, n503, n500, 
        n497, n494, n491, n365, n368, n461, n464, n359, n356, 
        n353, n350, n347, n344, n341, n305, n443, n446, n449, 
        n452, n455, n458, n434, n431, n428, n425, n422, n419, 
        n416, n413, TX_PWDN_c, n473, n10, n6692, n6686, n6701, 
        n6681, n6894;
    
    VHI i2 (.Z(VCC_net));
    INV i5410 (.A(spi_clk_c), .Z(clock_N_160));   // d:/workspace/ultrasounddoppler/0 machxo2 project/ultrasounddopplertop.v(7[19:26])
    PUR PUR_INST (.PUR(VCC_net));
    defparam PUR_INST.RST_PULSE = 1;
    VLO i1 (.Z(GND_net));
    LUT4 CLK_EXT_I_0_2_lut (.A(CLK_EXT_c), .B(readyToWrite), .Z(MEM_DATA_OUT_7__N_13)) /* synthesis lut_function=(A (B)) */ ;   // d:/workspace/ultrasounddoppler/0 machxo2 project/ultrasounddopplertop.v(131[8:32])
    defparam CLK_EXT_I_0_2_lut.init = 16'h8888;
    MemoryMap mem (.n416(n416), .CLK_EXT_c(CLK_EXT_c), .mem_wdata({mem_wdata}), 
            .n365(n365), .n419(n419), .n368(n368), .n371(n371), .\mem_addr[2] (mem_addr[2]), 
            .mem_rdata({mem_rdata}), .n512(n512), .n464(n464), .\mem_addr[0] (mem_addr[0]), 
            .n374(n374), .n377(n377), .n380(n380), .\mem_addr[1] (mem_addr[1]), 
            .n401(n401), .n383(n383), .n386(n386), .n389(n389), .n392(n392), 
            .n407(n407), .MEM_CLK_N_127(MEM_CLK_N_127), .n536(n536), .n533(n533), 
            .n530(n530), .n527(n527), .n524(n524), .n521(n521), .n518(n518), 
            .n515(n515), .n509(n509), .n506(n506), .n503(n503), .n500(n500), 
            .n497(n497), .n494(n494), .n491(n491), .n488(n488), .n485(n485), 
            .n482(n482), .n479(n479), .n476(n476), .n473(n473), .n470(n470), 
            .n467(n467), .n461(n461), .n458(n458), .n455(n455), .n452(n452), 
            .n449(n449), .n446(n446), .n443(n443), .n440(n440), .n437(n437), 
            .n434(n434), .n431(n431), .n428(n428), .n425(n425), .n422(n422), 
            .TX_PWDN_c(TX_PWDN_c), .n404(n404), .n305(n305), .n395(n395), 
            .n341(n341), .n344(n344), .n347(n347), .n350(n350), .n353(n353), 
            .n356(n356), .n359(n359), .n398(n398), .n413(n413), .n410(n410), 
            .n362(n362), .RX_PWDN_c(RX_PWDN_c), .n2242_c(n2242_c), .mem_clk(mem_clk), 
            .n616(n616), .n6681(n6681), .MEM_CLK_N_130(MEM_CLK_N_130)) /* synthesis syn_module_defined=1 */ ;   // d:/workspace/ultrasounddoppler/0 machxo2 project/ultrasounddopplertop.v(77[13] 91[4])
    OB TX_PWDN_pad_1 (.I(TX_PWDN_c), .O(TX_PWDN[1]));   // d:/workspace/ultrasounddoppler/0 machxo2 project/ultrasounddopplertop.v(12[20:27])
    OB spi_miso_pad (.I(spi_miso_c), .O(spi_miso));   // d:/workspace/ultrasounddoppler/0 machxo2 project/ultrasounddopplertop.v(8[19:27])
    FD1S3DX divider_849_873__i1 (.D(n10), .CK(CLK_EXT_c), .CD(TP_2__N_4), 
            .Q(divider[0])) /* synthesis syn_use_carry_chain=1 */ ;   // d:/workspace/ultrasounddoppler/0 machxo2 project/ultrasounddopplertop.v(114[14:28])
    defparam divider_849_873__i1.GSR = "DISABLED";
    OB TX_PWDN_pad_0 (.I(TX_PWDN_c), .O(TX_PWDN[0]));   // d:/workspace/ultrasounddoppler/0 machxo2 project/ultrasounddopplertop.v(12[20:27])
    LUT4 i4_4_lut (.A(n6692), .B(spi_cmd[3]), .C(n2242_c), .D(n6), .Z(n1619)) /* synthesis lut_function=(!((B+!(C (D)))+!A)) */ ;   // d:/workspace/ultrasounddoppler/0 machxo2 project/ultrasounddopplertop.v(5[15:21])
    defparam i4_4_lut.init = 16'h2000;
    OB TX_CLK_pad_1 (.I(TX_CLK_c_1), .O(TX_CLK[1]));   // d:/workspace/ultrasounddoppler/0 machxo2 project/ultrasounddopplertop.v(13[20:26])
    OB TX_CLK_pad_0 (.I(TP_c), .O(TX_CLK[0]));   // d:/workspace/ultrasounddoppler/0 machxo2 project/ultrasounddopplertop.v(13[20:26])
    OB TX_SWITCH_pad (.I(GND_net), .O(TX_SWITCH));   // d:/workspace/ultrasounddoppler/0 machxo2 project/ultrasounddopplertop.v(14[15:24])
    OB RX_CLK_pad (.I(n2239), .O(RX_CLK));   // d:/workspace/ultrasounddoppler/0 machxo2 project/ultrasounddopplertop.v(18[15:21])
    OB RX_PWDN_pad (.I(RX_PWDN_c), .O(RX_PWDN));   // d:/workspace/ultrasounddoppler/0 machxo2 project/ultrasounddopplertop.v(19[15:22])
    OB DATA_CLK_pad (.I(DATA_CLK_c), .O(DATA_CLK));   // d:/workspace/ultrasounddoppler/0 machxo2 project/ultrasounddopplertop.v(21[15:23])
    OB ROI_SYNC_pad (.I(n6894), .O(ROI_SYNC));   // d:/workspace/ultrasounddoppler/0 machxo2 project/ultrasounddopplertop.v(22[15:23])
    OB HARM_SYNC_pad (.I(GND_net), .O(HARM_SYNC));   // d:/workspace/ultrasounddoppler/0 machxo2 project/ultrasounddopplertop.v(23[15:24])
    OB DATA_OUT_pad_7 (.I(DATA_OUT_c_7), .O(DATA_OUT[7]));   // d:/workspace/ultrasounddoppler/0 machxo2 project/ultrasounddopplertop.v(24[20:28])
    OB DATA_OUT_pad_6 (.I(DATA_OUT_c_6), .O(DATA_OUT[6]));   // d:/workspace/ultrasounddoppler/0 machxo2 project/ultrasounddopplertop.v(24[20:28])
    OB DATA_OUT_pad_5 (.I(DATA_OUT_c_5), .O(DATA_OUT[5]));   // d:/workspace/ultrasounddoppler/0 machxo2 project/ultrasounddopplertop.v(24[20:28])
    OB DATA_OUT_pad_4 (.I(DATA_OUT_c_4), .O(DATA_OUT[4]));   // d:/workspace/ultrasounddoppler/0 machxo2 project/ultrasounddopplertop.v(24[20:28])
    OB DATA_OUT_pad_3 (.I(DATA_OUT_c_3), .O(DATA_OUT[3]));   // d:/workspace/ultrasounddoppler/0 machxo2 project/ultrasounddopplertop.v(24[20:28])
    OB DATA_OUT_pad_2 (.I(DATA_OUT_c_2), .O(DATA_OUT[2]));   // d:/workspace/ultrasounddoppler/0 machxo2 project/ultrasounddopplertop.v(24[20:28])
    OB DATA_OUT_pad_1 (.I(DATA_OUT_c_1), .O(DATA_OUT[1]));   // d:/workspace/ultrasounddoppler/0 machxo2 project/ultrasounddopplertop.v(24[20:28])
    OB DATA_OUT_pad_0 (.I(DATA_OUT_c_0), .O(DATA_OUT[0]));   // d:/workspace/ultrasounddoppler/0 machxo2 project/ultrasounddopplertop.v(24[20:28])
    OB TP_pad_5 (.I(TP_c_5), .O(TP[5]));   // d:/workspace/ultrasounddoppler/0 machxo2 project/ultrasounddopplertop.v(25[22:24])
    OB TP_pad_4 (.I(TP_c), .O(TP[4]));   // d:/workspace/ultrasounddoppler/0 machxo2 project/ultrasounddopplertop.v(25[22:24])
    OB TP_pad_3 (.I(n2239), .O(TP[3]));   // d:/workspace/ultrasounddoppler/0 machxo2 project/ultrasounddopplertop.v(25[22:24])
    OB TP_pad_2 (.I(TP_c_2), .O(TP[2]));   // d:/workspace/ultrasounddoppler/0 machxo2 project/ultrasounddopplertop.v(25[22:24])
    OB TP_pad_1 (.I(n6686), .O(TP[1]));   // d:/workspace/ultrasounddoppler/0 machxo2 project/ultrasounddopplertop.v(25[22:24])
    OB TP_pad_0 (.I(n2242_c), .O(TP[0]));   // d:/workspace/ultrasounddoppler/0 machxo2 project/ultrasounddopplertop.v(25[22:24])
    IB CLK_EXT_pad (.I(CLK_EXT), .O(CLK_EXT_c));   // d:/workspace/ultrasounddoppler/0 machxo2 project/ultrasounddopplertop.v(4[15:22])
    IB n2242_pad (.I(ENABLE), .O(n2242_c));   // d:/workspace/ultrasounddoppler/0 machxo2 project/ultrasounddopplertop.v(5[15:21])
    IB spi_clk_pad (.I(spi_clk), .O(spi_clk_c));   // d:/workspace/ultrasounddoppler/0 machxo2 project/ultrasounddopplertop.v(7[19:26])
    IB spi_mosi_pad (.I(spi_mosi), .O(spi_mosi_c));   // d:/workspace/ultrasounddoppler/0 machxo2 project/ultrasounddopplertop.v(9[19:27])
    IB spi_csn_pad (.I(spi_csn), .O(spi_csn_c));   // d:/workspace/ultrasounddoppler/0 machxo2 project/ultrasounddopplertop.v(10[19:26])
    IB ADCData_pad_1 (.I(RX[13]), .O(ADCData_c_1));   // d:/workspace/ultrasounddoppler/0 machxo2 project/ultrasounddopplertop.v(17[21:23])
    IB RX_pad_12 (.I(RX[12]), .O(RX_c_12));   // d:/workspace/ultrasounddoppler/0 machxo2 project/ultrasounddopplertop.v(17[21:23])
    IB RX_pad_11 (.I(RX[11]), .O(RX_c_11));   // d:/workspace/ultrasounddoppler/0 machxo2 project/ultrasounddopplertop.v(17[21:23])
    IB RX_pad_10 (.I(RX[10]), .O(RX_c_10));   // d:/workspace/ultrasounddoppler/0 machxo2 project/ultrasounddopplertop.v(17[21:23])
    IB RX_pad_9 (.I(RX[9]), .O(RX_c_9));   // d:/workspace/ultrasounddoppler/0 machxo2 project/ultrasounddopplertop.v(17[21:23])
    IB RX_pad_8 (.I(RX[8]), .O(RX_c_8));   // d:/workspace/ultrasounddoppler/0 machxo2 project/ultrasounddopplertop.v(17[21:23])
    IB RX_pad_7 (.I(RX[7]), .O(RX_c_7));   // d:/workspace/ultrasounddoppler/0 machxo2 project/ultrasounddopplertop.v(17[21:23])
    IB RX_pad_6 (.I(RX[6]), .O(RX_c_6));   // d:/workspace/ultrasounddoppler/0 machxo2 project/ultrasounddopplertop.v(17[21:23])
    IB RX_pad_5 (.I(RX[5]), .O(RX_c_5));   // d:/workspace/ultrasounddoppler/0 machxo2 project/ultrasounddopplertop.v(17[21:23])
    IB RX_pad_4 (.I(RX[4]), .O(RX_c_4));   // d:/workspace/ultrasounddoppler/0 machxo2 project/ultrasounddopplertop.v(17[21:23])
    IB RX_pad_3 (.I(RX[3]), .O(RX_c_3));   // d:/workspace/ultrasounddoppler/0 machxo2 project/ultrasounddopplertop.v(17[21:23])
    IB RX_pad_2 (.I(RX[2]), .O(RX_c_2));   // d:/workspace/ultrasounddoppler/0 machxo2 project/ultrasounddopplertop.v(17[21:23])
    IB RX_pad_1 (.I(RX[1]), .O(RX_c_1));   // d:/workspace/ultrasounddoppler/0 machxo2 project/ultrasounddopplertop.v(17[21:23])
    IB RX_pad_0 (.I(RX[0]), .O(RX_c_0));   // d:/workspace/ultrasounddoppler/0 machxo2 project/ultrasounddopplertop.v(17[21:23])
    parallelInterface DATA_OUT_7__I_0 (.GND_net(GND_net), .DATA_CLK_c(DATA_CLK_c), 
            .\divider[0] (divider[0]), .TP_2__N_4(TP_2__N_4), .TP_c_2(TP_c_2), 
            .n6894(n6894), .MEM_DATA_RD_CLK(MEM_DATA_RD_CLK), .n6701(n6701)) /* synthesis syn_module_defined=1 */ ;   // d:/workspace/ultrasounddoppler/0 machxo2 project/ultrasounddopplertop.v(142[19] 155[2])
    LUT4 TP_2__I_0_1_lut (.A(TP_c_2), .Z(TP_2__N_4)) /* synthesis lut_function=(!(A)) */ ;   // d:/workspace/ultrasounddoppler/0 machxo2 project/ultrasounddopplertop.v(145[9:12])
    defparam TP_2__I_0_1_lut.init = 16'h5555;
    CCU2D divider_849_873_add_4_1 (.A0(GND_net), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(divider[0]), .B1(GND_net), .C1(GND_net), 
          .D1(GND_net), .S1(n10));   // d:/workspace/ultrasounddoppler/0 machxo2 project/ultrasounddopplertop.v(114[14:28])
    defparam divider_849_873_add_4_1.INIT0 = 16'hF000;
    defparam divider_849_873_add_4_1.INIT1 = 16'h0555;
    defparam divider_849_873_add_4_1.INJECT1_0 = "NO";
    defparam divider_849_873_add_4_1.INJECT1_1 = "NO";
    LUT4 ENABLE_I_0_1_lut (.A(n2242_c), .Z(ENABLE_N_2)) /* synthesis lut_function=(!(A)) */ ;   // d:/workspace/ultrasounddoppler/0 machxo2 project/ultrasounddopplertop.v(45[11:18])
    defparam ENABLE_I_0_1_lut.init = 16'h5555;
    CoreLayer TX_CLK_1__I_0 (.GND_net(GND_net), .CLK_EXT_c(CLK_EXT_c), .n410(n410), 
            .n407(n407), .n404(n404), .n401(n401), .n341(n341), .n305(n305), 
            .n6686(n6686), .n530(n530), .n527(n527), .n524(n524), .n521(n521), 
            .TP_c_5(TP_c_5), .n422(n422), .n419(n419), .n416(n416), 
            .n413(n413), .n434(n434), .n431(n431), .n428(n428), .n425(n425), 
            .n440(n440), .n437(n437), .n446(n446), .n443(n443), .n458(n458), 
            .n455(n455), .n452(n452), .n449(n449), .n470(n470), .n467(n467), 
            .n464(n464), .n461(n461), .n482(n482), .n479(n479), .n476(n476), 
            .n473(n473), .n350(n350), .n347(n347), .n488(n488), .n485(n485), 
            .n362(n362), .n359(n359), .n356(n356), .n353(n353), .n374(n374), 
            .n371(n371), .n368(n368), .n365(n365), .n386(n386), .n383(n383), 
            .n380(n380), .n377(n377), .n392(n392), .n389(n389), .n344(n344), 
            .n2239(n2239), .n494(n494), .n491(n491), .n506(n506), .n503(n503), 
            .n500(n500), .n497(n497), .TX_CLK_c_1(TX_CLK_c_1), .TP_c(TP_c), 
            .n398(n398), .n395(n395), .n518(n518), .n515(n515), .n512(n512), 
            .n509(n509), .n536(n536), .n533(n533)) /* synthesis syn_module_defined=1 */ ;   // d:/workspace/ultrasounddoppler/0 machxo2 project/ultrasounddopplertop.v(94[11] 107[3])
    CommunicationLayer com (.mem_clk(mem_clk), .CLK_EXT_c(CLK_EXT_c), .ENABLE_N_2(ENABLE_N_2), 
            .MEM_CLK_N_130(MEM_CLK_N_130), .mem_wdata({mem_wdata}), .mem_addr({Open_0, 
            Open_1, Open_2, Open_3, Open_4, mem_addr[2:0]}), .\spi_cmd[3] (spi_cmd[3]), 
            .mem_rdata({mem_rdata}), .n2242_c(n2242_c), .spi_csn_c(spi_csn_c), 
            .n1619(n1619), .TP_c_2(TP_c_2), .n616(n616), .n6692(n6692), 
            .GND_net(GND_net), .n6681(n6681), .n6894(n6894), .n6(n6), 
            .MEM_CLK_N_127(MEM_CLK_N_127), .n6701(n6701), .clock_N_160(clock_N_160), 
            .spi_miso_c(spi_miso_c), .spi_clk_c(spi_clk_c), .spi_mosi_c(spi_mosi_c)) /* synthesis syn_module_defined=1 */ ;   // d:/workspace/ultrasounddoppler/0 machxo2 project/ultrasounddopplertop.v(43[22] 58[4])
    TSALL TSALL_INST (.TSALL(GND_net));
    GSR GSR_INST (.GSR(n2242_c));
    Storeage MEM_DATA_OUT_7__I_0 (.n2239(n2239), .n2242_c(n2242_c), .readyToWrite(readyToWrite), 
            .ADCData_c_1(ADCData_c_1), .RX_c_12(RX_c_12), .RX_c_11(RX_c_11), 
            .RX_c_10(RX_c_10), .RX_c_5(RX_c_5), .RX_c_4(RX_c_4), .RX_c_3(RX_c_3), 
            .RX_c_2(RX_c_2), .MEM_DATA_OUT_7__N_13(MEM_DATA_OUT_7__N_13), 
            .MEM_DATA_RD_CLK(MEM_DATA_RD_CLK), .ENABLE_N_2(ENABLE_N_2), 
            .DATA_OUT_c_7(DATA_OUT_c_7), .DATA_OUT_c_6(DATA_OUT_c_6), .DATA_OUT_c_5(DATA_OUT_c_5), 
            .DATA_OUT_c_4(DATA_OUT_c_4), .VCC_net(VCC_net), .GND_net(GND_net), 
            .RX_c_9(RX_c_9), .RX_c_8(RX_c_8), .RX_c_7(RX_c_7), .RX_c_6(RX_c_6), 
            .RX_c_1(RX_c_1), .RX_c_0(RX_c_0), .DATA_OUT_c_3(DATA_OUT_c_3), 
            .DATA_OUT_c_2(DATA_OUT_c_2), .DATA_OUT_c_1(DATA_OUT_c_1), .DATA_OUT_c_0(DATA_OUT_c_0)) /* synthesis syn_module_defined=1 */ ;   // d:/workspace/ultrasounddoppler/0 machxo2 project/ultrasounddopplertop.v(128[10] 140[2])
    
endmodule
//
// Verilog Description of module PUR
// module not written out since it is a black-box. 
//

//
// Verilog Description of module MemoryMap
//

module MemoryMap (n416, CLK_EXT_c, mem_wdata, n365, n419, n368, 
            n371, \mem_addr[2] , mem_rdata, n512, n464, \mem_addr[0] , 
            n374, n377, n380, \mem_addr[1] , n401, n383, n386, 
            n389, n392, n407, MEM_CLK_N_127, n536, n533, n530, 
            n527, n524, n521, n518, n515, n509, n506, n503, 
            n500, n497, n494, n491, n488, n485, n482, n479, 
            n476, n473, n470, n467, n461, n458, n455, n452, 
            n449, n446, n443, n440, n437, n434, n431, n428, 
            n425, n422, TX_PWDN_c, n404, n305, n395, n341, n344, 
            n347, n350, n353, n356, n359, n398, n413, n410, 
            n362, RX_PWDN_c, n2242_c, mem_clk, n616, n6681, MEM_CLK_N_130) /* synthesis syn_module_defined=1 */ ;
    output n416;
    input CLK_EXT_c;
    input [15:0]mem_wdata;
    output n365;
    output n419;
    output n368;
    output n371;
    input \mem_addr[2] ;
    output [15:0]mem_rdata;
    output n512;
    output n464;
    input \mem_addr[0] ;
    output n374;
    output n377;
    output n380;
    input \mem_addr[1] ;
    output n401;
    output n383;
    output n386;
    output n389;
    output n392;
    output n407;
    input MEM_CLK_N_127;
    output n536;
    output n533;
    output n530;
    output n527;
    output n524;
    output n521;
    output n518;
    output n515;
    output n509;
    output n506;
    output n503;
    output n500;
    output n497;
    output n494;
    output n491;
    output n488;
    output n485;
    output n482;
    output n479;
    output n476;
    output n473;
    output n470;
    output n467;
    output n461;
    output n458;
    output n455;
    output n452;
    output n449;
    output n446;
    output n443;
    output n440;
    output n437;
    output n434;
    output n431;
    output n428;
    output n425;
    output n422;
    output TX_PWDN_c;
    output n404;
    output n305;
    output n395;
    output n341;
    output n344;
    output n347;
    output n350;
    output n353;
    output n356;
    output n359;
    output n398;
    output n413;
    output n410;
    output n362;
    output RX_PWDN_c;
    input n2242_c;
    input mem_clk;
    input n616;
    input n6681;
    input MEM_CLK_N_130;
    
    wire CLK_EXT_c /* synthesis SET_AS_NETWORK=CLK_EXT_c, is_clock=1 */ ;   // d:/workspace/ultrasounddoppler/0 machxo2 project/ultrasounddopplertop.v(4[15:22])
    
    wire CLK_EXT_c_enable_89, CLK_EXT_c_enable_92, n6365, n323, n4, 
        n6360, n6361, n6357, n6358, n6359, n6362, n320, n317, 
        n6363, n6364, n6366, n6367, n6368, n6356, n314, CLK_EXT_c_enable_76, 
        n6239, n5196, n6224, CLK_EXT_c_enable_36, CLK_EXT_c_enable_52, 
        n302, n308, n311, n326, n329, n332, n335, n338, n6369, 
        n6370, n6371, n6372, n6373, n6374, n6375, n6376, n6377, 
        n6378, n6379, n6380, n6381, n6382, n6383, n6353, n6350, 
        n6384, n6385, n6386, n6347, n6392, n6387, n6388, n6389, 
        n6345, n6348, n6349, n6351, n6352, n6354, n6355, n6346, 
        n6390, n6391;
    
    FD1P3AX MEM_4__i40 (.D(mem_wdata[7]), .SP(CLK_EXT_c_enable_89), .CK(CLK_EXT_c), 
            .Q(n416));   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/memorymap.v(27[8] 37[4])
    defparam MEM_4__i40.GSR = "DISABLED";
    FD1P3AX MEM_4__i23 (.D(mem_wdata[6]), .SP(CLK_EXT_c_enable_92), .CK(CLK_EXT_c), 
            .Q(n365));   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/memorymap.v(27[8] 37[4])
    defparam MEM_4__i23.GSR = "DISABLED";
    FD1P3AX MEM_4__i41 (.D(mem_wdata[8]), .SP(CLK_EXT_c_enable_89), .CK(CLK_EXT_c), 
            .Q(n419));   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/memorymap.v(27[8] 37[4])
    defparam MEM_4__i41.GSR = "DISABLED";
    FD1P3AX MEM_4__i24 (.D(mem_wdata[7]), .SP(CLK_EXT_c_enable_92), .CK(CLK_EXT_c), 
            .Q(n368));   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/memorymap.v(27[8] 37[4])
    defparam MEM_4__i24.GSR = "DISABLED";
    FD1P3AX MEM_4__i25 (.D(mem_wdata[8]), .SP(CLK_EXT_c_enable_92), .CK(CLK_EXT_c), 
            .Q(n371));   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/memorymap.v(27[8] 37[4])
    defparam MEM_4__i25.GSR = "DISABLED";
    LUT4 MEM_ADDR_2__I_0_10_Mux_8_i7_4_lut (.A(n6365), .B(n323), .C(\mem_addr[2] ), 
         .D(n4), .Z(mem_rdata[8])) /* synthesis lut_function=(!(A (B (C (D))+!B (C))+!A (((D)+!C)+!B))) */ ;   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/memorymap.v(25[24:53])
    defparam MEM_ADDR_2__I_0_10_Mux_8_i7_4_lut.init = 16'h0aca;
    LUT4 i5149_3_lut (.A(n512), .B(n464), .C(\mem_addr[0] ), .Z(n6360)) /* synthesis lut_function=(A (B+!(C))+!A (B (C))) */ ;
    defparam i5149_3_lut.init = 16'hcaca;
    FD1P3AX MEM_4__i26 (.D(mem_wdata[9]), .SP(CLK_EXT_c_enable_92), .CK(CLK_EXT_c), 
            .Q(n374));   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/memorymap.v(27[8] 37[4])
    defparam MEM_4__i26.GSR = "DISABLED";
    FD1P3AX MEM_4__i27 (.D(mem_wdata[10]), .SP(CLK_EXT_c_enable_92), .CK(CLK_EXT_c), 
            .Q(n377));   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/memorymap.v(27[8] 37[4])
    defparam MEM_4__i27.GSR = "DISABLED";
    FD1P3AX MEM_4__i28 (.D(mem_wdata[11]), .SP(CLK_EXT_c_enable_92), .CK(CLK_EXT_c), 
            .Q(n380));   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/memorymap.v(27[8] 37[4])
    defparam MEM_4__i28.GSR = "DISABLED";
    LUT4 i5150_3_lut (.A(n416), .B(n368), .C(\mem_addr[0] ), .Z(n6361)) /* synthesis lut_function=(A (B+!(C))+!A (B (C))) */ ;
    defparam i5150_3_lut.init = 16'hcaca;
    PFUMX i5148 (.BLUT(n6357), .ALUT(n6358), .C0(\mem_addr[1] ), .Z(n6359));
    LUT4 MEM_ADDR_2__I_0_10_Mux_7_i7_4_lut (.A(n6362), .B(n320), .C(\mem_addr[2] ), 
         .D(n4), .Z(mem_rdata[7])) /* synthesis lut_function=(!(A (B (C (D))+!B (C))+!A (((D)+!C)+!B))) */ ;   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/memorymap.v(25[24:53])
    defparam MEM_ADDR_2__I_0_10_Mux_7_i7_4_lut.init = 16'h0aca;
    FD1P3AX MEM_4__i35 (.D(mem_wdata[2]), .SP(CLK_EXT_c_enable_89), .CK(CLK_EXT_c), 
            .Q(n401));   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/memorymap.v(27[8] 37[4])
    defparam MEM_4__i35.GSR = "DISABLED";
    PFUMX i5151 (.BLUT(n6360), .ALUT(n6361), .C0(\mem_addr[1] ), .Z(n6362));
    LUT4 MEM_ADDR_2__I_0_10_Mux_6_i7_4_lut (.A(n6359), .B(n317), .C(\mem_addr[2] ), 
         .D(n4), .Z(mem_rdata[6])) /* synthesis lut_function=(!(A (B (C (D))+!B (C))+!A (((D)+!C)+!B))) */ ;   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/memorymap.v(25[24:53])
    defparam MEM_ADDR_2__I_0_10_Mux_6_i7_4_lut.init = 16'h0aca;
    PFUMX i5154 (.BLUT(n6363), .ALUT(n6364), .C0(\mem_addr[1] ), .Z(n6365));
    PFUMX i5157 (.BLUT(n6366), .ALUT(n6367), .C0(\mem_addr[1] ), .Z(n6368));
    FD1P3AX MEM_4__i29 (.D(mem_wdata[12]), .SP(CLK_EXT_c_enable_92), .CK(CLK_EXT_c), 
            .Q(n383));   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/memorymap.v(27[8] 37[4])
    defparam MEM_4__i29.GSR = "DISABLED";
    FD1P3AX MEM_4__i30 (.D(mem_wdata[13]), .SP(CLK_EXT_c_enable_92), .CK(CLK_EXT_c), 
            .Q(n386));   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/memorymap.v(27[8] 37[4])
    defparam MEM_4__i30.GSR = "DISABLED";
    FD1P3AX MEM_4__i31 (.D(mem_wdata[14]), .SP(CLK_EXT_c_enable_92), .CK(CLK_EXT_c), 
            .Q(n389));   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/memorymap.v(27[8] 37[4])
    defparam MEM_4__i31.GSR = "DISABLED";
    FD1P3AX MEM_4__i32 (.D(mem_wdata[15]), .SP(CLK_EXT_c_enable_92), .CK(CLK_EXT_c), 
            .Q(n392));   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/memorymap.v(27[8] 37[4])
    defparam MEM_4__i32.GSR = "DISABLED";
    LUT4 MEM_ADDR_2__I_0_10_Mux_5_i7_4_lut (.A(n6356), .B(n314), .C(\mem_addr[2] ), 
         .D(n4), .Z(mem_rdata[5])) /* synthesis lut_function=(!(A (B (C (D))+!B (C))+!A (((D)+!C)+!B))) */ ;   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/memorymap.v(25[24:53])
    defparam MEM_ADDR_2__I_0_10_Mux_5_i7_4_lut.init = 16'h0aca;
    FD1P3AX MEM_4__i37 (.D(mem_wdata[4]), .SP(CLK_EXT_c_enable_89), .CK(CLK_EXT_c), 
            .Q(n407));   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/memorymap.v(27[8] 37[4])
    defparam MEM_4__i37.GSR = "DISABLED";
    FD1P3AX MEM_4__i7 (.D(mem_wdata[6]), .SP(CLK_EXT_c_enable_76), .CK(CLK_EXT_c), 
            .Q(n317));   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/memorymap.v(27[8] 37[4])
    defparam MEM_4__i7.GSR = "DISABLED";
    LUT4 i2_3_lut_4_lut (.A(\mem_addr[0] ), .B(n6239), .C(\mem_addr[2] ), 
         .D(\mem_addr[1] ), .Z(CLK_EXT_c_enable_76)) /* synthesis lut_function=(!(A+(((D)+!C)+!B))) */ ;
    defparam i2_3_lut_4_lut.init = 16'h0040;
    LUT4 i1_2_lut_4_lut (.A(n6239), .B(\mem_addr[0] ), .C(\mem_addr[2] ), 
         .D(\mem_addr[1] ), .Z(CLK_EXT_c_enable_92)) /* synthesis lut_function=(!(((C+!(D))+!B)+!A)) */ ;   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/memorymap.v(27[8] 37[4])
    defparam i1_2_lut_4_lut.init = 16'h0800;
    LUT4 i1287_4_lut (.A(\mem_addr[1] ), .B(MEM_CLK_N_127), .C(n5196), 
         .D(n6224), .Z(CLK_EXT_c_enable_36)) /* synthesis lut_function=(!(A+((C+!(D))+!B))) */ ;   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/memorymap.v(27[8] 37[4])
    defparam i1287_4_lut.init = 16'h0400;
    LUT4 i4004_2_lut (.A(\mem_addr[2] ), .B(\mem_addr[0] ), .Z(n5196)) /* synthesis lut_function=(A+(B)) */ ;
    defparam i4004_2_lut.init = 16'heeee;
    FD1P3AX MEM_4__i80 (.D(mem_wdata[15]), .SP(CLK_EXT_c_enable_36), .CK(CLK_EXT_c), 
            .Q(n536));   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/memorymap.v(27[8] 37[4])
    defparam MEM_4__i80.GSR = "DISABLED";
    FD1P3AX MEM_4__i79 (.D(mem_wdata[14]), .SP(CLK_EXT_c_enable_36), .CK(CLK_EXT_c), 
            .Q(n533));   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/memorymap.v(27[8] 37[4])
    defparam MEM_4__i79.GSR = "DISABLED";
    FD1P3AX MEM_4__i78 (.D(mem_wdata[13]), .SP(CLK_EXT_c_enable_36), .CK(CLK_EXT_c), 
            .Q(n530));   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/memorymap.v(27[8] 37[4])
    defparam MEM_4__i78.GSR = "DISABLED";
    FD1P3AX MEM_4__i77 (.D(mem_wdata[12]), .SP(CLK_EXT_c_enable_36), .CK(CLK_EXT_c), 
            .Q(n527));   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/memorymap.v(27[8] 37[4])
    defparam MEM_4__i77.GSR = "DISABLED";
    FD1P3AX MEM_4__i76 (.D(mem_wdata[11]), .SP(CLK_EXT_c_enable_36), .CK(CLK_EXT_c), 
            .Q(n524));   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/memorymap.v(27[8] 37[4])
    defparam MEM_4__i76.GSR = "DISABLED";
    FD1P3AX MEM_4__i75 (.D(mem_wdata[10]), .SP(CLK_EXT_c_enable_36), .CK(CLK_EXT_c), 
            .Q(n521));   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/memorymap.v(27[8] 37[4])
    defparam MEM_4__i75.GSR = "DISABLED";
    FD1P3AX MEM_4__i74 (.D(mem_wdata[9]), .SP(CLK_EXT_c_enable_36), .CK(CLK_EXT_c), 
            .Q(n518));   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/memorymap.v(27[8] 37[4])
    defparam MEM_4__i74.GSR = "DISABLED";
    FD1P3AX MEM_4__i73 (.D(mem_wdata[8]), .SP(CLK_EXT_c_enable_36), .CK(CLK_EXT_c), 
            .Q(n515));   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/memorymap.v(27[8] 37[4])
    defparam MEM_4__i73.GSR = "DISABLED";
    FD1P3AX MEM_4__i72 (.D(mem_wdata[7]), .SP(CLK_EXT_c_enable_36), .CK(CLK_EXT_c), 
            .Q(n512));   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/memorymap.v(27[8] 37[4])
    defparam MEM_4__i72.GSR = "DISABLED";
    FD1P3AX MEM_4__i71 (.D(mem_wdata[6]), .SP(CLK_EXT_c_enable_36), .CK(CLK_EXT_c), 
            .Q(n509));   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/memorymap.v(27[8] 37[4])
    defparam MEM_4__i71.GSR = "DISABLED";
    FD1P3AX MEM_4__i70 (.D(mem_wdata[5]), .SP(CLK_EXT_c_enable_36), .CK(CLK_EXT_c), 
            .Q(n506));   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/memorymap.v(27[8] 37[4])
    defparam MEM_4__i70.GSR = "DISABLED";
    FD1P3AX MEM_4__i69 (.D(mem_wdata[4]), .SP(CLK_EXT_c_enable_36), .CK(CLK_EXT_c), 
            .Q(n503));   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/memorymap.v(27[8] 37[4])
    defparam MEM_4__i69.GSR = "DISABLED";
    FD1P3AX MEM_4__i68 (.D(mem_wdata[3]), .SP(CLK_EXT_c_enable_36), .CK(CLK_EXT_c), 
            .Q(n500));   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/memorymap.v(27[8] 37[4])
    defparam MEM_4__i68.GSR = "DISABLED";
    FD1P3AX MEM_4__i67 (.D(mem_wdata[2]), .SP(CLK_EXT_c_enable_36), .CK(CLK_EXT_c), 
            .Q(n497));   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/memorymap.v(27[8] 37[4])
    defparam MEM_4__i67.GSR = "DISABLED";
    FD1P3AX MEM_4__i66 (.D(mem_wdata[1]), .SP(CLK_EXT_c_enable_36), .CK(CLK_EXT_c), 
            .Q(n494));   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/memorymap.v(27[8] 37[4])
    defparam MEM_4__i66.GSR = "DISABLED";
    FD1P3AX MEM_4__i65 (.D(mem_wdata[0]), .SP(CLK_EXT_c_enable_36), .CK(CLK_EXT_c), 
            .Q(n491));   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/memorymap.v(27[8] 37[4])
    defparam MEM_4__i65.GSR = "DISABLED";
    FD1P3AX MEM_4__i64 (.D(mem_wdata[15]), .SP(CLK_EXT_c_enable_52), .CK(CLK_EXT_c), 
            .Q(n488));   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/memorymap.v(27[8] 37[4])
    defparam MEM_4__i64.GSR = "DISABLED";
    FD1P3AX MEM_4__i63 (.D(mem_wdata[14]), .SP(CLK_EXT_c_enable_52), .CK(CLK_EXT_c), 
            .Q(n485));   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/memorymap.v(27[8] 37[4])
    defparam MEM_4__i63.GSR = "DISABLED";
    FD1P3AX MEM_4__i62 (.D(mem_wdata[13]), .SP(CLK_EXT_c_enable_52), .CK(CLK_EXT_c), 
            .Q(n482));   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/memorymap.v(27[8] 37[4])
    defparam MEM_4__i62.GSR = "DISABLED";
    FD1P3AX MEM_4__i61 (.D(mem_wdata[12]), .SP(CLK_EXT_c_enable_52), .CK(CLK_EXT_c), 
            .Q(n479));   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/memorymap.v(27[8] 37[4])
    defparam MEM_4__i61.GSR = "DISABLED";
    FD1P3AX MEM_4__i60 (.D(mem_wdata[11]), .SP(CLK_EXT_c_enable_52), .CK(CLK_EXT_c), 
            .Q(n476));   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/memorymap.v(27[8] 37[4])
    defparam MEM_4__i60.GSR = "DISABLED";
    FD1P3AX MEM_4__i59 (.D(mem_wdata[10]), .SP(CLK_EXT_c_enable_52), .CK(CLK_EXT_c), 
            .Q(n473));   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/memorymap.v(27[8] 37[4])
    defparam MEM_4__i59.GSR = "DISABLED";
    FD1P3AX MEM_4__i58 (.D(mem_wdata[9]), .SP(CLK_EXT_c_enable_52), .CK(CLK_EXT_c), 
            .Q(n470));   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/memorymap.v(27[8] 37[4])
    defparam MEM_4__i58.GSR = "DISABLED";
    FD1P3AX MEM_4__i57 (.D(mem_wdata[8]), .SP(CLK_EXT_c_enable_52), .CK(CLK_EXT_c), 
            .Q(n467));   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/memorymap.v(27[8] 37[4])
    defparam MEM_4__i57.GSR = "DISABLED";
    FD1P3AX MEM_4__i56 (.D(mem_wdata[7]), .SP(CLK_EXT_c_enable_52), .CK(CLK_EXT_c), 
            .Q(n464));   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/memorymap.v(27[8] 37[4])
    defparam MEM_4__i56.GSR = "DISABLED";
    FD1P3AX MEM_4__i55 (.D(mem_wdata[6]), .SP(CLK_EXT_c_enable_52), .CK(CLK_EXT_c), 
            .Q(n461));   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/memorymap.v(27[8] 37[4])
    defparam MEM_4__i55.GSR = "DISABLED";
    FD1P3AX MEM_4__i54 (.D(mem_wdata[5]), .SP(CLK_EXT_c_enable_52), .CK(CLK_EXT_c), 
            .Q(n458));   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/memorymap.v(27[8] 37[4])
    defparam MEM_4__i54.GSR = "DISABLED";
    FD1P3AX MEM_4__i53 (.D(mem_wdata[4]), .SP(CLK_EXT_c_enable_52), .CK(CLK_EXT_c), 
            .Q(n455));   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/memorymap.v(27[8] 37[4])
    defparam MEM_4__i53.GSR = "DISABLED";
    FD1P3AX MEM_4__i52 (.D(mem_wdata[3]), .SP(CLK_EXT_c_enable_52), .CK(CLK_EXT_c), 
            .Q(n452));   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/memorymap.v(27[8] 37[4])
    defparam MEM_4__i52.GSR = "DISABLED";
    FD1P3AX MEM_4__i51 (.D(mem_wdata[2]), .SP(CLK_EXT_c_enable_52), .CK(CLK_EXT_c), 
            .Q(n449));   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/memorymap.v(27[8] 37[4])
    defparam MEM_4__i51.GSR = "DISABLED";
    FD1P3AX MEM_4__i50 (.D(mem_wdata[1]), .SP(CLK_EXT_c_enable_52), .CK(CLK_EXT_c), 
            .Q(n446));   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/memorymap.v(27[8] 37[4])
    defparam MEM_4__i50.GSR = "DISABLED";
    FD1P3AX MEM_4__i49 (.D(mem_wdata[0]), .SP(CLK_EXT_c_enable_52), .CK(CLK_EXT_c), 
            .Q(n443));   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/memorymap.v(27[8] 37[4])
    defparam MEM_4__i49.GSR = "DISABLED";
    FD1P3AX MEM_4__i48 (.D(mem_wdata[15]), .SP(CLK_EXT_c_enable_89), .CK(CLK_EXT_c), 
            .Q(n440));   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/memorymap.v(27[8] 37[4])
    defparam MEM_4__i48.GSR = "DISABLED";
    FD1P3AX MEM_4__i47 (.D(mem_wdata[14]), .SP(CLK_EXT_c_enable_89), .CK(CLK_EXT_c), 
            .Q(n437));   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/memorymap.v(27[8] 37[4])
    defparam MEM_4__i47.GSR = "DISABLED";
    FD1P3AX MEM_4__i46 (.D(mem_wdata[13]), .SP(CLK_EXT_c_enable_89), .CK(CLK_EXT_c), 
            .Q(n434));   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/memorymap.v(27[8] 37[4])
    defparam MEM_4__i46.GSR = "DISABLED";
    FD1P3AX MEM_4__i45 (.D(mem_wdata[12]), .SP(CLK_EXT_c_enable_89), .CK(CLK_EXT_c), 
            .Q(n431));   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/memorymap.v(27[8] 37[4])
    defparam MEM_4__i45.GSR = "DISABLED";
    FD1P3AX MEM_4__i44 (.D(mem_wdata[11]), .SP(CLK_EXT_c_enable_89), .CK(CLK_EXT_c), 
            .Q(n428));   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/memorymap.v(27[8] 37[4])
    defparam MEM_4__i44.GSR = "DISABLED";
    FD1P3AX MEM_4__i43 (.D(mem_wdata[10]), .SP(CLK_EXT_c_enable_89), .CK(CLK_EXT_c), 
            .Q(n425));   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/memorymap.v(27[8] 37[4])
    defparam MEM_4__i43.GSR = "DISABLED";
    FD1P3AX MEM_4__i42 (.D(mem_wdata[9]), .SP(CLK_EXT_c_enable_89), .CK(CLK_EXT_c), 
            .Q(n422));   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/memorymap.v(27[8] 37[4])
    defparam MEM_4__i42.GSR = "DISABLED";
    FD1P3AX MEM_4__i1 (.D(mem_wdata[0]), .SP(CLK_EXT_c_enable_76), .CK(CLK_EXT_c), 
            .Q(TX_PWDN_c));   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/memorymap.v(27[8] 37[4])
    defparam MEM_4__i1.GSR = "DISABLED";
    FD1P3AX MEM_4__i2 (.D(mem_wdata[1]), .SP(CLK_EXT_c_enable_76), .CK(CLK_EXT_c), 
            .Q(n302));   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/memorymap.v(27[8] 37[4])
    defparam MEM_4__i2.GSR = "DISABLED";
    FD1P3AX MEM_4__i36 (.D(mem_wdata[3]), .SP(CLK_EXT_c_enable_89), .CK(CLK_EXT_c), 
            .Q(n404));   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/memorymap.v(27[8] 37[4])
    defparam MEM_4__i36.GSR = "DISABLED";
    FD1P3AX MEM_4__i3 (.D(mem_wdata[2]), .SP(CLK_EXT_c_enable_76), .CK(CLK_EXT_c), 
            .Q(n305));   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/memorymap.v(27[8] 37[4])
    defparam MEM_4__i3.GSR = "DISABLED";
    FD1P3AX MEM_4__i4 (.D(mem_wdata[3]), .SP(CLK_EXT_c_enable_76), .CK(CLK_EXT_c), 
            .Q(n308));   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/memorymap.v(27[8] 37[4])
    defparam MEM_4__i4.GSR = "DISABLED";
    FD1P3AX MEM_4__i5 (.D(mem_wdata[4]), .SP(CLK_EXT_c_enable_76), .CK(CLK_EXT_c), 
            .Q(n311));   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/memorymap.v(27[8] 37[4])
    defparam MEM_4__i5.GSR = "DISABLED";
    FD1P3AX MEM_4__i6 (.D(mem_wdata[5]), .SP(CLK_EXT_c_enable_76), .CK(CLK_EXT_c), 
            .Q(n314));   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/memorymap.v(27[8] 37[4])
    defparam MEM_4__i6.GSR = "DISABLED";
    FD1P3AX MEM_4__i8 (.D(mem_wdata[7]), .SP(CLK_EXT_c_enable_76), .CK(CLK_EXT_c), 
            .Q(n320));   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/memorymap.v(27[8] 37[4])
    defparam MEM_4__i8.GSR = "DISABLED";
    FD1P3AX MEM_4__i9 (.D(mem_wdata[8]), .SP(CLK_EXT_c_enable_76), .CK(CLK_EXT_c), 
            .Q(n323));   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/memorymap.v(27[8] 37[4])
    defparam MEM_4__i9.GSR = "DISABLED";
    FD1P3AX MEM_4__i10 (.D(mem_wdata[9]), .SP(CLK_EXT_c_enable_76), .CK(CLK_EXT_c), 
            .Q(n326));   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/memorymap.v(27[8] 37[4])
    defparam MEM_4__i10.GSR = "DISABLED";
    FD1P3AX MEM_4__i11 (.D(mem_wdata[10]), .SP(CLK_EXT_c_enable_76), .CK(CLK_EXT_c), 
            .Q(n329));   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/memorymap.v(27[8] 37[4])
    defparam MEM_4__i11.GSR = "DISABLED";
    LUT4 i5152_3_lut (.A(n515), .B(n467), .C(\mem_addr[0] ), .Z(n6363)) /* synthesis lut_function=(A (B+!(C))+!A (B (C))) */ ;
    defparam i5152_3_lut.init = 16'hcaca;
    LUT4 i1_2_lut_4_lut_adj_27 (.A(n6239), .B(\mem_addr[0] ), .C(\mem_addr[2] ), 
         .D(\mem_addr[1] ), .Z(CLK_EXT_c_enable_52)) /* synthesis lut_function=(!(((C+(D))+!B)+!A)) */ ;   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/memorymap.v(27[8] 37[4])
    defparam i1_2_lut_4_lut_adj_27.init = 16'h0008;
    FD1P3AX MEM_4__i12 (.D(mem_wdata[11]), .SP(CLK_EXT_c_enable_76), .CK(CLK_EXT_c), 
            .Q(n332));   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/memorymap.v(27[8] 37[4])
    defparam MEM_4__i12.GSR = "DISABLED";
    FD1P3AX MEM_4__i13 (.D(mem_wdata[12]), .SP(CLK_EXT_c_enable_76), .CK(CLK_EXT_c), 
            .Q(n335));   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/memorymap.v(27[8] 37[4])
    defparam MEM_4__i13.GSR = "DISABLED";
    FD1P3AX MEM_4__i33 (.D(mem_wdata[0]), .SP(CLK_EXT_c_enable_89), .CK(CLK_EXT_c), 
            .Q(n395));   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/memorymap.v(27[8] 37[4])
    defparam MEM_4__i33.GSR = "DISABLED";
    FD1P3AX MEM_4__i14 (.D(mem_wdata[13]), .SP(CLK_EXT_c_enable_76), .CK(CLK_EXT_c), 
            .Q(n338));   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/memorymap.v(27[8] 37[4])
    defparam MEM_4__i14.GSR = "DISABLED";
    FD1P3AX MEM_4__i15 (.D(mem_wdata[14]), .SP(CLK_EXT_c_enable_76), .CK(CLK_EXT_c), 
            .Q(n341));   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/memorymap.v(27[8] 37[4])
    defparam MEM_4__i15.GSR = "DISABLED";
    FD1P3AX MEM_4__i16 (.D(mem_wdata[15]), .SP(CLK_EXT_c_enable_76), .CK(CLK_EXT_c), 
            .Q(n344));   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/memorymap.v(27[8] 37[4])
    defparam MEM_4__i16.GSR = "DISABLED";
    FD1P3AX MEM_4__i17 (.D(mem_wdata[0]), .SP(CLK_EXT_c_enable_92), .CK(CLK_EXT_c), 
            .Q(n347));   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/memorymap.v(27[8] 37[4])
    defparam MEM_4__i17.GSR = "DISABLED";
    FD1P3AX MEM_4__i18 (.D(mem_wdata[1]), .SP(CLK_EXT_c_enable_92), .CK(CLK_EXT_c), 
            .Q(n350));   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/memorymap.v(27[8] 37[4])
    defparam MEM_4__i18.GSR = "DISABLED";
    LUT4 i5153_3_lut (.A(n419), .B(n371), .C(\mem_addr[0] ), .Z(n6364)) /* synthesis lut_function=(A (B+!(C))+!A (B (C))) */ ;
    defparam i5153_3_lut.init = 16'hcaca;
    FD1P3AX MEM_4__i19 (.D(mem_wdata[2]), .SP(CLK_EXT_c_enable_92), .CK(CLK_EXT_c), 
            .Q(n353));   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/memorymap.v(27[8] 37[4])
    defparam MEM_4__i19.GSR = "DISABLED";
    FD1P3AX MEM_4__i20 (.D(mem_wdata[3]), .SP(CLK_EXT_c_enable_92), .CK(CLK_EXT_c), 
            .Q(n356));   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/memorymap.v(27[8] 37[4])
    defparam MEM_4__i20.GSR = "DISABLED";
    PFUMX i5160 (.BLUT(n6369), .ALUT(n6370), .C0(\mem_addr[1] ), .Z(n6371));
    FD1P3AX MEM_4__i21 (.D(mem_wdata[4]), .SP(CLK_EXT_c_enable_92), .CK(CLK_EXT_c), 
            .Q(n359));   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/memorymap.v(27[8] 37[4])
    defparam MEM_4__i21.GSR = "DISABLED";
    FD1P3AX MEM_4__i34 (.D(mem_wdata[1]), .SP(CLK_EXT_c_enable_89), .CK(CLK_EXT_c), 
            .Q(n398));   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/memorymap.v(27[8] 37[4])
    defparam MEM_4__i34.GSR = "DISABLED";
    FD1P3AX MEM_4__i39 (.D(mem_wdata[6]), .SP(CLK_EXT_c_enable_89), .CK(CLK_EXT_c), 
            .Q(n413));   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/memorymap.v(27[8] 37[4])
    defparam MEM_4__i39.GSR = "DISABLED";
    PFUMX i5163 (.BLUT(n6372), .ALUT(n6373), .C0(\mem_addr[1] ), .Z(n6374));
    FD1P3AX MEM_4__i38 (.D(mem_wdata[5]), .SP(CLK_EXT_c_enable_89), .CK(CLK_EXT_c), 
            .Q(n410));   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/memorymap.v(27[8] 37[4])
    defparam MEM_4__i38.GSR = "DISABLED";
    FD1P3AX MEM_4__i22 (.D(mem_wdata[5]), .SP(CLK_EXT_c_enable_92), .CK(CLK_EXT_c), 
            .Q(n362));   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/memorymap.v(27[8] 37[4])
    defparam MEM_4__i22.GSR = "DISABLED";
    LUT4 i5155_3_lut (.A(n518), .B(n470), .C(\mem_addr[0] ), .Z(n6366)) /* synthesis lut_function=(A (B+!(C))+!A (B (C))) */ ;
    defparam i5155_3_lut.init = 16'hcaca;
    PFUMX i5166 (.BLUT(n6375), .ALUT(n6376), .C0(\mem_addr[1] ), .Z(n6377));
    LUT4 i5156_3_lut (.A(n422), .B(n374), .C(\mem_addr[0] ), .Z(n6367)) /* synthesis lut_function=(A (B+!(C))+!A (B (C))) */ ;
    defparam i5156_3_lut.init = 16'hcaca;
    PFUMX i5169 (.BLUT(n6378), .ALUT(n6379), .C0(\mem_addr[1] ), .Z(n6380));
    PFUMX i5172 (.BLUT(n6381), .ALUT(n6382), .C0(\mem_addr[1] ), .Z(n6383));
    LUT4 i5158_3_lut (.A(n521), .B(n473), .C(\mem_addr[0] ), .Z(n6369)) /* synthesis lut_function=(A (B+!(C))+!A (B (C))) */ ;
    defparam i5158_3_lut.init = 16'hcaca;
    LUT4 i5159_3_lut (.A(n425), .B(n377), .C(\mem_addr[0] ), .Z(n6370)) /* synthesis lut_function=(A (B+!(C))+!A (B (C))) */ ;
    defparam i5159_3_lut.init = 16'hcaca;
    LUT4 i5161_3_lut (.A(n524), .B(n476), .C(\mem_addr[0] ), .Z(n6372)) /* synthesis lut_function=(A (B+!(C))+!A (B (C))) */ ;
    defparam i5161_3_lut.init = 16'hcaca;
    LUT4 MEM_ADDR_2__I_0_10_Mux_4_i7_4_lut (.A(n6353), .B(n311), .C(\mem_addr[2] ), 
         .D(n4), .Z(mem_rdata[4])) /* synthesis lut_function=(!(A (B (C (D))+!B (C))+!A (((D)+!C)+!B))) */ ;   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/memorymap.v(25[24:53])
    defparam MEM_ADDR_2__I_0_10_Mux_4_i7_4_lut.init = 16'h0aca;
    LUT4 i5162_3_lut (.A(n428), .B(n380), .C(\mem_addr[0] ), .Z(n6373)) /* synthesis lut_function=(A (B+!(C))+!A (B (C))) */ ;
    defparam i5162_3_lut.init = 16'hcaca;
    LUT4 MEM_ADDR_2__I_0_10_Mux_3_i7_4_lut (.A(n6350), .B(n308), .C(\mem_addr[2] ), 
         .D(n4), .Z(mem_rdata[3])) /* synthesis lut_function=(!(A (B (C (D))+!B (C))+!A (((D)+!C)+!B))) */ ;   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/memorymap.v(25[24:53])
    defparam MEM_ADDR_2__I_0_10_Mux_3_i7_4_lut.init = 16'h0aca;
    PFUMX i5175 (.BLUT(n6384), .ALUT(n6385), .C0(\mem_addr[1] ), .Z(n6386));
    LUT4 i5164_3_lut (.A(n527), .B(n479), .C(\mem_addr[0] ), .Z(n6375)) /* synthesis lut_function=(A (B+!(C))+!A (B (C))) */ ;
    defparam i5164_3_lut.init = 16'hcaca;
    LUT4 MEM_4__1__I_0_1_lut (.A(n302), .Z(RX_PWDN_c)) /* synthesis lut_function=(!(A)) */ ;   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/memorymap.v(50[17:29])
    defparam MEM_4__1__I_0_1_lut.init = 16'h5555;
    LUT4 i5165_3_lut (.A(n431), .B(n383), .C(\mem_addr[0] ), .Z(n6376)) /* synthesis lut_function=(A (B+!(C))+!A (B (C))) */ ;
    defparam i5165_3_lut.init = 16'hcaca;
    LUT4 i5167_3_lut (.A(n530), .B(n482), .C(\mem_addr[0] ), .Z(n6378)) /* synthesis lut_function=(A (B+!(C))+!A (B (C))) */ ;
    defparam i5167_3_lut.init = 16'hcaca;
    LUT4 i5168_3_lut (.A(n434), .B(n386), .C(\mem_addr[0] ), .Z(n6379)) /* synthesis lut_function=(A (B+!(C))+!A (B (C))) */ ;
    defparam i5168_3_lut.init = 16'hcaca;
    LUT4 MEM_ADDR_2__I_0_10_Mux_2_i7_4_lut (.A(n6347), .B(n305), .C(\mem_addr[2] ), 
         .D(n4), .Z(mem_rdata[2])) /* synthesis lut_function=(!(A (B (C (D))+!B (C))+!A (((D)+!C)+!B))) */ ;   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/memorymap.v(25[24:53])
    defparam MEM_ADDR_2__I_0_10_Mux_2_i7_4_lut.init = 16'h0aca;
    LUT4 i5170_3_lut (.A(n533), .B(n485), .C(\mem_addr[0] ), .Z(n6381)) /* synthesis lut_function=(A (B+!(C))+!A (B (C))) */ ;
    defparam i5170_3_lut.init = 16'hcaca;
    LUT4 i5171_3_lut (.A(n437), .B(n389), .C(\mem_addr[0] ), .Z(n6382)) /* synthesis lut_function=(A (B+!(C))+!A (B (C))) */ ;
    defparam i5171_3_lut.init = 16'hcaca;
    LUT4 i5173_3_lut (.A(n536), .B(n488), .C(\mem_addr[0] ), .Z(n6384)) /* synthesis lut_function=(A (B+!(C))+!A (B (C))) */ ;
    defparam i5173_3_lut.init = 16'hcaca;
    LUT4 i5174_3_lut (.A(n440), .B(n392), .C(\mem_addr[0] ), .Z(n6385)) /* synthesis lut_function=(A (B+!(C))+!A (B (C))) */ ;
    defparam i5174_3_lut.init = 16'hcaca;
    LUT4 MEM_ADDR_2__I_0_10_Mux_1_i7_4_lut (.A(n6392), .B(n302), .C(\mem_addr[2] ), 
         .D(n4), .Z(mem_rdata[1])) /* synthesis lut_function=(!(A (B (C (D))+!B (C))+!A (((D)+!C)+!B))) */ ;   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/memorymap.v(25[24:53])
    defparam MEM_ADDR_2__I_0_10_Mux_1_i7_4_lut.init = 16'h0aca;
    LUT4 MEM_ADDR_2__I_0_10_Mux_15_i7_4_lut (.A(n6386), .B(n344), .C(\mem_addr[2] ), 
         .D(n4), .Z(mem_rdata[15])) /* synthesis lut_function=(!(A (B (C (D))+!B (C))+!A (((D)+!C)+!B))) */ ;   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/memorymap.v(25[24:53])
    defparam MEM_ADDR_2__I_0_10_Mux_15_i7_4_lut.init = 16'h0aca;
    LUT4 i2_3_lut_4_lut_adj_28 (.A(\mem_addr[0] ), .B(n6239), .C(\mem_addr[2] ), 
         .D(\mem_addr[1] ), .Z(CLK_EXT_c_enable_89)) /* synthesis lut_function=(!(A+((C+!(D))+!B))) */ ;
    defparam i2_3_lut_4_lut_adj_28.init = 16'h0400;
    PFUMX i5178 (.BLUT(n6387), .ALUT(n6388), .C0(\mem_addr[1] ), .Z(n6389));
    LUT4 i1_2_lut (.A(n2242_c), .B(mem_clk), .Z(n6224)) /* synthesis lut_function=(!((B)+!A)) */ ;   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/memorymap.v(27[8] 37[4])
    defparam i1_2_lut.init = 16'h2222;
    LUT4 i5134_3_lut (.A(n497), .B(n449), .C(\mem_addr[0] ), .Z(n6345)) /* synthesis lut_function=(A (B+!(C))+!A (B (C))) */ ;
    defparam i5134_3_lut.init = 16'hcaca;
    LUT4 i5137_3_lut (.A(n500), .B(n452), .C(\mem_addr[0] ), .Z(n6348)) /* synthesis lut_function=(A (B+!(C))+!A (B (C))) */ ;
    defparam i5137_3_lut.init = 16'hcaca;
    LUT4 i5138_3_lut (.A(n404), .B(n356), .C(\mem_addr[0] ), .Z(n6349)) /* synthesis lut_function=(A (B+!(C))+!A (B (C))) */ ;
    defparam i5138_3_lut.init = 16'hcaca;
    LUT4 i5140_3_lut (.A(n503), .B(n455), .C(\mem_addr[0] ), .Z(n6351)) /* synthesis lut_function=(A (B+!(C))+!A (B (C))) */ ;
    defparam i5140_3_lut.init = 16'hcaca;
    LUT4 i5146_3_lut (.A(n509), .B(n461), .C(\mem_addr[0] ), .Z(n6357)) /* synthesis lut_function=(A (B+!(C))+!A (B (C))) */ ;
    defparam i5146_3_lut.init = 16'hcaca;
    LUT4 i5147_3_lut (.A(n413), .B(n365), .C(\mem_addr[0] ), .Z(n6358)) /* synthesis lut_function=(A (B+!(C))+!A (B (C))) */ ;
    defparam i5147_3_lut.init = 16'hcaca;
    LUT4 MEM_ADDR_2__I_0_10_Mux_14_i7_4_lut (.A(n6383), .B(n341), .C(\mem_addr[2] ), 
         .D(n4), .Z(mem_rdata[14])) /* synthesis lut_function=(!(A (B (C (D))+!B (C))+!A (((D)+!C)+!B))) */ ;   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/memorymap.v(25[24:53])
    defparam MEM_ADDR_2__I_0_10_Mux_14_i7_4_lut.init = 16'h0aca;
    LUT4 i5141_3_lut (.A(n407), .B(n359), .C(\mem_addr[0] ), .Z(n6352)) /* synthesis lut_function=(A (B+!(C))+!A (B (C))) */ ;
    defparam i5141_3_lut.init = 16'hcaca;
    LUT4 i5143_3_lut (.A(n506), .B(n458), .C(\mem_addr[0] ), .Z(n6354)) /* synthesis lut_function=(A (B+!(C))+!A (B (C))) */ ;
    defparam i5143_3_lut.init = 16'hcaca;
    LUT4 MEM_ADDR_2__I_0_10_Mux_0_i7_4_lut (.A(n6389), .B(TX_PWDN_c), .C(\mem_addr[2] ), 
         .D(n4), .Z(mem_rdata[0])) /* synthesis lut_function=(!(A (B (C (D))+!B (C))+!A (((D)+!C)+!B))) */ ;   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/memorymap.v(25[24:53])
    defparam MEM_ADDR_2__I_0_10_Mux_0_i7_4_lut.init = 16'h0aca;
    LUT4 i1_2_lut_adj_29 (.A(\mem_addr[1] ), .B(\mem_addr[0] ), .Z(n4)) /* synthesis lut_function=(A+(B)) */ ;
    defparam i1_2_lut_adj_29.init = 16'heeee;
    LUT4 MEM_ADDR_2__I_0_10_Mux_13_i7_4_lut (.A(n6380), .B(n338), .C(\mem_addr[2] ), 
         .D(n4), .Z(mem_rdata[13])) /* synthesis lut_function=(!(A (B (C (D))+!B (C))+!A (((D)+!C)+!B))) */ ;   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/memorymap.v(25[24:53])
    defparam MEM_ADDR_2__I_0_10_Mux_13_i7_4_lut.init = 16'h0aca;
    LUT4 i3_4_lut (.A(n616), .B(n6681), .C(MEM_CLK_N_130), .D(n6224), 
         .Z(n6239)) /* synthesis lut_function=(A (B (C (D)))) */ ;
    defparam i3_4_lut.init = 16'h8000;
    LUT4 MEM_ADDR_2__I_0_10_Mux_12_i7_4_lut (.A(n6377), .B(n335), .C(\mem_addr[2] ), 
         .D(n4), .Z(mem_rdata[12])) /* synthesis lut_function=(!(A (B (C (D))+!B (C))+!A (((D)+!C)+!B))) */ ;   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/memorymap.v(25[24:53])
    defparam MEM_ADDR_2__I_0_10_Mux_12_i7_4_lut.init = 16'h0aca;
    LUT4 i5176_3_lut (.A(n491), .B(n443), .C(\mem_addr[0] ), .Z(n6387)) /* synthesis lut_function=(A (B+!(C))+!A (B (C))) */ ;
    defparam i5176_3_lut.init = 16'hcaca;
    LUT4 i5177_3_lut (.A(n395), .B(n347), .C(\mem_addr[0] ), .Z(n6388)) /* synthesis lut_function=(A (B+!(C))+!A (B (C))) */ ;
    defparam i5177_3_lut.init = 16'hcaca;
    LUT4 MEM_ADDR_2__I_0_10_Mux_11_i7_4_lut (.A(n6374), .B(n332), .C(\mem_addr[2] ), 
         .D(n4), .Z(mem_rdata[11])) /* synthesis lut_function=(!(A (B (C (D))+!B (C))+!A (((D)+!C)+!B))) */ ;   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/memorymap.v(25[24:53])
    defparam MEM_ADDR_2__I_0_10_Mux_11_i7_4_lut.init = 16'h0aca;
    LUT4 i5144_3_lut (.A(n410), .B(n362), .C(\mem_addr[0] ), .Z(n6355)) /* synthesis lut_function=(A (B+!(C))+!A (B (C))) */ ;
    defparam i5144_3_lut.init = 16'hcaca;
    LUT4 MEM_ADDR_2__I_0_10_Mux_10_i7_4_lut (.A(n6371), .B(n329), .C(\mem_addr[2] ), 
         .D(n4), .Z(mem_rdata[10])) /* synthesis lut_function=(!(A (B (C (D))+!B (C))+!A (((D)+!C)+!B))) */ ;   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/memorymap.v(25[24:53])
    defparam MEM_ADDR_2__I_0_10_Mux_10_i7_4_lut.init = 16'h0aca;
    PFUMX i5136 (.BLUT(n6345), .ALUT(n6346), .C0(\mem_addr[1] ), .Z(n6347));
    LUT4 i5179_3_lut (.A(n494), .B(n446), .C(\mem_addr[0] ), .Z(n6390)) /* synthesis lut_function=(A (B+!(C))+!A (B (C))) */ ;
    defparam i5179_3_lut.init = 16'hcaca;
    PFUMX i5139 (.BLUT(n6348), .ALUT(n6349), .C0(\mem_addr[1] ), .Z(n6350));
    PFUMX i5142 (.BLUT(n6351), .ALUT(n6352), .C0(\mem_addr[1] ), .Z(n6353));
    PFUMX i5145 (.BLUT(n6354), .ALUT(n6355), .C0(\mem_addr[1] ), .Z(n6356));
    LUT4 MEM_ADDR_2__I_0_10_Mux_9_i7_4_lut (.A(n6368), .B(n326), .C(\mem_addr[2] ), 
         .D(n4), .Z(mem_rdata[9])) /* synthesis lut_function=(!(A (B (C (D))+!B (C))+!A (((D)+!C)+!B))) */ ;   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/memorymap.v(25[24:53])
    defparam MEM_ADDR_2__I_0_10_Mux_9_i7_4_lut.init = 16'h0aca;
    LUT4 i5180_3_lut (.A(n398), .B(n350), .C(\mem_addr[0] ), .Z(n6391)) /* synthesis lut_function=(A (B+!(C))+!A (B (C))) */ ;
    defparam i5180_3_lut.init = 16'hcaca;
    LUT4 i5135_3_lut (.A(n401), .B(n353), .C(\mem_addr[0] ), .Z(n6346)) /* synthesis lut_function=(A (B+!(C))+!A (B (C))) */ ;
    defparam i5135_3_lut.init = 16'hcaca;
    PFUMX i5181 (.BLUT(n6390), .ALUT(n6391), .C0(\mem_addr[1] ), .Z(n6392));
    
endmodule
//
// Verilog Description of module parallelInterface
//

module parallelInterface (GND_net, DATA_CLK_c, \divider[0] , TP_2__N_4, 
            TP_c_2, n6894, MEM_DATA_RD_CLK, n6701) /* synthesis syn_module_defined=1 */ ;
    input GND_net;
    output DATA_CLK_c;
    input \divider[0] ;
    input TP_2__N_4;
    input TP_c_2;
    output n6894;
    output MEM_DATA_RD_CLK;
    output n6701;
    
    wire \divider[0]  /* synthesis is_clock=1, SET_AS_NETWORK=divider[0] */ ;   // d:/workspace/ultrasounddoppler/0 machxo2 project/ultrasounddopplertop.v(64[13:20])
    
    wire n5932;
    wire [15:0]frameCounter;   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/parallelinterface.v(17[27:39])
    wire [16:0]frameCounter_15__N_439;
    
    wire n5933, n5931, n5930, n5929, DATA_OUT_CLK_N_519, n27, n32, 
        n28, n5928, n5934, n5935, n29, n26;
    
    CCU2D sub_33_add_2_11 (.A0(frameCounter[9]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(frameCounter[10]), .B1(GND_net), .C1(GND_net), 
          .D1(GND_net), .CIN(n5932), .COUT(n5933), .S0(frameCounter_15__N_439[9]), 
          .S1(frameCounter_15__N_439[10]));   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/parallelinterface.v(28[21:37])
    defparam sub_33_add_2_11.INIT0 = 16'h5555;
    defparam sub_33_add_2_11.INIT1 = 16'h5555;
    defparam sub_33_add_2_11.INJECT1_0 = "NO";
    defparam sub_33_add_2_11.INJECT1_1 = "NO";
    CCU2D sub_33_add_2_9 (.A0(frameCounter[7]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(frameCounter[8]), .B1(GND_net), .C1(GND_net), 
          .D1(GND_net), .CIN(n5931), .COUT(n5932), .S0(frameCounter_15__N_439[7]), 
          .S1(frameCounter_15__N_439[8]));   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/parallelinterface.v(28[21:37])
    defparam sub_33_add_2_9.INIT0 = 16'h5555;
    defparam sub_33_add_2_9.INIT1 = 16'h5555;
    defparam sub_33_add_2_9.INJECT1_0 = "NO";
    defparam sub_33_add_2_9.INJECT1_1 = "NO";
    CCU2D sub_33_add_2_7 (.A0(frameCounter[5]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(frameCounter[6]), .B1(GND_net), .C1(GND_net), 
          .D1(GND_net), .CIN(n5930), .COUT(n5931), .S0(frameCounter_15__N_439[5]), 
          .S1(frameCounter_15__N_439[6]));   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/parallelinterface.v(28[21:37])
    defparam sub_33_add_2_7.INIT0 = 16'h5555;
    defparam sub_33_add_2_7.INIT1 = 16'h5555;
    defparam sub_33_add_2_7.INJECT1_0 = "NO";
    defparam sub_33_add_2_7.INJECT1_1 = "NO";
    CCU2D sub_33_add_2_5 (.A0(frameCounter[3]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(frameCounter[4]), .B1(GND_net), .C1(GND_net), 
          .D1(GND_net), .CIN(n5929), .COUT(n5930), .S0(frameCounter_15__N_439[3]), 
          .S1(frameCounter_15__N_439[4]));   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/parallelinterface.v(28[21:37])
    defparam sub_33_add_2_5.INIT0 = 16'h5555;
    defparam sub_33_add_2_5.INIT1 = 16'h5555;
    defparam sub_33_add_2_5.INJECT1_0 = "NO";
    defparam sub_33_add_2_5.INJECT1_1 = "NO";
    FD1S3DX DATA_OUT_CLK_66 (.D(DATA_OUT_CLK_N_519), .CK(\divider[0] ), 
            .CD(TP_2__N_4), .Q(DATA_CLK_c)) /* synthesis LSE_LINE_FILE_ID=3, LSE_LCOL=19, LSE_RCOL=2, LSE_LLINE=142, LSE_RLINE=155 */ ;   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/parallelinterface.v(27[7] 32[5])
    defparam DATA_OUT_CLK_66.GSR = "DISABLED";
    FD1S3DX frameCounter_i0 (.D(frameCounter_15__N_439[0]), .CK(\divider[0] ), 
            .CD(TP_2__N_4), .Q(frameCounter[0])) /* synthesis LSE_LINE_FILE_ID=3, LSE_LCOL=19, LSE_RCOL=2, LSE_LLINE=142, LSE_RLINE=155 */ ;   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/parallelinterface.v(27[7] 32[5])
    defparam frameCounter_i0.GSR = "DISABLED";
    LUT4 i4049_4_lut_rep_84 (.A(n27), .B(TP_c_2), .C(n32), .D(n28), 
         .Z(n6894)) /* synthesis lut_function=(A (B)+!A (B (C+(D)))) */ ;
    defparam i4049_4_lut_rep_84.init = 16'hccc8;
    LUT4 DATA_OUT_CLK_I_0_1_lut (.A(DATA_CLK_c), .Z(MEM_DATA_RD_CLK)) /* synthesis lut_function=(!(A)) */ ;   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/parallelinterface.v(36[27:40])
    defparam DATA_OUT_CLK_I_0_1_lut.init = 16'h5555;
    LUT4 i5218_4_lut_then_1_lut_4_lut (.A(n27), .B(TP_c_2), .C(n32), .D(n28), 
         .Z(n6701)) /* synthesis lut_function=(!(A (B)+!A (B (C+(D))))) */ ;
    defparam i5218_4_lut_then_1_lut_4_lut.init = 16'h3337;
    CCU2D sub_33_add_2_3 (.A0(frameCounter[1]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(frameCounter[2]), .B1(GND_net), .C1(GND_net), 
          .D1(GND_net), .CIN(n5928), .COUT(n5929), .S0(frameCounter_15__N_439[1]), 
          .S1(frameCounter_15__N_439[2]));   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/parallelinterface.v(28[21:37])
    defparam sub_33_add_2_3.INIT0 = 16'h5555;
    defparam sub_33_add_2_3.INIT1 = 16'h5555;
    defparam sub_33_add_2_3.INJECT1_0 = "NO";
    defparam sub_33_add_2_3.INJECT1_1 = "NO";
    FD1S3DX frameCounter_i1 (.D(frameCounter_15__N_439[1]), .CK(\divider[0] ), 
            .CD(TP_2__N_4), .Q(frameCounter[1])) /* synthesis LSE_LINE_FILE_ID=3, LSE_LCOL=19, LSE_RCOL=2, LSE_LLINE=142, LSE_RLINE=155 */ ;   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/parallelinterface.v(27[7] 32[5])
    defparam frameCounter_i1.GSR = "DISABLED";
    FD1S3DX frameCounter_i2 (.D(frameCounter_15__N_439[2]), .CK(\divider[0] ), 
            .CD(TP_2__N_4), .Q(frameCounter[2])) /* synthesis LSE_LINE_FILE_ID=3, LSE_LCOL=19, LSE_RCOL=2, LSE_LLINE=142, LSE_RLINE=155 */ ;   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/parallelinterface.v(27[7] 32[5])
    defparam frameCounter_i2.GSR = "DISABLED";
    FD1S3DX frameCounter_i3 (.D(frameCounter_15__N_439[3]), .CK(\divider[0] ), 
            .CD(TP_2__N_4), .Q(frameCounter[3])) /* synthesis LSE_LINE_FILE_ID=3, LSE_LCOL=19, LSE_RCOL=2, LSE_LLINE=142, LSE_RLINE=155 */ ;   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/parallelinterface.v(27[7] 32[5])
    defparam frameCounter_i3.GSR = "DISABLED";
    FD1S3DX frameCounter_i4 (.D(frameCounter_15__N_439[4]), .CK(\divider[0] ), 
            .CD(TP_2__N_4), .Q(frameCounter[4])) /* synthesis LSE_LINE_FILE_ID=3, LSE_LCOL=19, LSE_RCOL=2, LSE_LLINE=142, LSE_RLINE=155 */ ;   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/parallelinterface.v(27[7] 32[5])
    defparam frameCounter_i4.GSR = "DISABLED";
    FD1S3DX frameCounter_i5 (.D(frameCounter_15__N_439[5]), .CK(\divider[0] ), 
            .CD(TP_2__N_4), .Q(frameCounter[5])) /* synthesis LSE_LINE_FILE_ID=3, LSE_LCOL=19, LSE_RCOL=2, LSE_LLINE=142, LSE_RLINE=155 */ ;   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/parallelinterface.v(27[7] 32[5])
    defparam frameCounter_i5.GSR = "DISABLED";
    FD1S3DX frameCounter_i6 (.D(frameCounter_15__N_439[6]), .CK(\divider[0] ), 
            .CD(TP_2__N_4), .Q(frameCounter[6])) /* synthesis LSE_LINE_FILE_ID=3, LSE_LCOL=19, LSE_RCOL=2, LSE_LLINE=142, LSE_RLINE=155 */ ;   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/parallelinterface.v(27[7] 32[5])
    defparam frameCounter_i6.GSR = "DISABLED";
    FD1S3DX frameCounter_i7 (.D(frameCounter_15__N_439[7]), .CK(\divider[0] ), 
            .CD(TP_2__N_4), .Q(frameCounter[7])) /* synthesis LSE_LINE_FILE_ID=3, LSE_LCOL=19, LSE_RCOL=2, LSE_LLINE=142, LSE_RLINE=155 */ ;   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/parallelinterface.v(27[7] 32[5])
    defparam frameCounter_i7.GSR = "DISABLED";
    FD1S3DX frameCounter_i8 (.D(frameCounter_15__N_439[8]), .CK(\divider[0] ), 
            .CD(TP_2__N_4), .Q(frameCounter[8])) /* synthesis LSE_LINE_FILE_ID=3, LSE_LCOL=19, LSE_RCOL=2, LSE_LLINE=142, LSE_RLINE=155 */ ;   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/parallelinterface.v(27[7] 32[5])
    defparam frameCounter_i8.GSR = "DISABLED";
    FD1S3DX frameCounter_i9 (.D(frameCounter_15__N_439[9]), .CK(\divider[0] ), 
            .CD(TP_2__N_4), .Q(frameCounter[9])) /* synthesis LSE_LINE_FILE_ID=3, LSE_LCOL=19, LSE_RCOL=2, LSE_LLINE=142, LSE_RLINE=155 */ ;   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/parallelinterface.v(27[7] 32[5])
    defparam frameCounter_i9.GSR = "DISABLED";
    FD1S3DX frameCounter_i10 (.D(frameCounter_15__N_439[10]), .CK(\divider[0] ), 
            .CD(TP_2__N_4), .Q(frameCounter[10])) /* synthesis LSE_LINE_FILE_ID=3, LSE_LCOL=19, LSE_RCOL=2, LSE_LLINE=142, LSE_RLINE=155 */ ;   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/parallelinterface.v(27[7] 32[5])
    defparam frameCounter_i10.GSR = "DISABLED";
    FD1S3DX frameCounter_i11 (.D(frameCounter_15__N_439[11]), .CK(\divider[0] ), 
            .CD(TP_2__N_4), .Q(frameCounter[11])) /* synthesis LSE_LINE_FILE_ID=3, LSE_LCOL=19, LSE_RCOL=2, LSE_LLINE=142, LSE_RLINE=155 */ ;   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/parallelinterface.v(27[7] 32[5])
    defparam frameCounter_i11.GSR = "DISABLED";
    FD1S3BX frameCounter_i12 (.D(frameCounter_15__N_439[12]), .CK(\divider[0] ), 
            .PD(TP_2__N_4), .Q(frameCounter[12])) /* synthesis LSE_LINE_FILE_ID=3, LSE_LCOL=19, LSE_RCOL=2, LSE_LLINE=142, LSE_RLINE=155 */ ;   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/parallelinterface.v(27[7] 32[5])
    defparam frameCounter_i12.GSR = "DISABLED";
    FD1S3DX frameCounter_i13 (.D(frameCounter_15__N_439[13]), .CK(\divider[0] ), 
            .CD(TP_2__N_4), .Q(frameCounter[13])) /* synthesis LSE_LINE_FILE_ID=3, LSE_LCOL=19, LSE_RCOL=2, LSE_LLINE=142, LSE_RLINE=155 */ ;   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/parallelinterface.v(27[7] 32[5])
    defparam frameCounter_i13.GSR = "DISABLED";
    FD1S3DX frameCounter_i14 (.D(frameCounter_15__N_439[14]), .CK(\divider[0] ), 
            .CD(TP_2__N_4), .Q(frameCounter[14])) /* synthesis LSE_LINE_FILE_ID=3, LSE_LCOL=19, LSE_RCOL=2, LSE_LLINE=142, LSE_RLINE=155 */ ;   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/parallelinterface.v(27[7] 32[5])
    defparam frameCounter_i14.GSR = "DISABLED";
    FD1S3DX frameCounter_i15 (.D(frameCounter_15__N_439[15]), .CK(\divider[0] ), 
            .CD(TP_2__N_4), .Q(frameCounter[15])) /* synthesis LSE_LINE_FILE_ID=3, LSE_LCOL=19, LSE_RCOL=2, LSE_LLINE=142, LSE_RLINE=155 */ ;   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/parallelinterface.v(27[7] 32[5])
    defparam frameCounter_i15.GSR = "DISABLED";
    CCU2D sub_33_add_2_15 (.A0(frameCounter[13]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(frameCounter[14]), .B1(GND_net), .C1(GND_net), 
          .D1(GND_net), .CIN(n5934), .COUT(n5935), .S0(frameCounter_15__N_439[13]), 
          .S1(frameCounter_15__N_439[14]));   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/parallelinterface.v(28[21:37])
    defparam sub_33_add_2_15.INIT0 = 16'h5555;
    defparam sub_33_add_2_15.INIT1 = 16'h5555;
    defparam sub_33_add_2_15.INJECT1_0 = "NO";
    defparam sub_33_add_2_15.INJECT1_1 = "NO";
    LUT4 i1_2_lut (.A(DATA_CLK_c), .B(n6894), .Z(DATA_OUT_CLK_N_519)) /* synthesis lut_function=(!(A (B)+!A !(B))) */ ;
    defparam i1_2_lut.init = 16'h6666;
    LUT4 i11_4_lut (.A(frameCounter[13]), .B(frameCounter[5]), .C(frameCounter[3]), 
         .D(frameCounter[10]), .Z(n28)) /* synthesis lut_function=(A+(B+(C+(D)))) */ ;
    defparam i11_4_lut.init = 16'hfffe;
    CCU2D sub_33_add_2_17 (.A0(frameCounter[15]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(GND_net), .B1(GND_net), .C1(GND_net), .D1(GND_net), 
          .CIN(n5935), .S0(frameCounter_15__N_439[15]));   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/parallelinterface.v(28[21:37])
    defparam sub_33_add_2_17.INIT0 = 16'h5555;
    defparam sub_33_add_2_17.INIT1 = 16'h0000;
    defparam sub_33_add_2_17.INJECT1_0 = "NO";
    defparam sub_33_add_2_17.INJECT1_1 = "NO";
    CCU2D sub_33_add_2_1 (.A0(GND_net), .B0(GND_net), .C0(GND_net), .D0(GND_net), 
          .A1(frameCounter[0]), .B1(GND_net), .C1(GND_net), .D1(GND_net), 
          .COUT(n5928), .S1(frameCounter_15__N_439[0]));   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/parallelinterface.v(28[21:37])
    defparam sub_33_add_2_1.INIT0 = 16'hF000;
    defparam sub_33_add_2_1.INIT1 = 16'h5555;
    defparam sub_33_add_2_1.INJECT1_0 = "NO";
    defparam sub_33_add_2_1.INJECT1_1 = "NO";
    LUT4 i12_4_lut (.A(frameCounter[12]), .B(frameCounter[7]), .C(frameCounter[2]), 
         .D(frameCounter[11]), .Z(n29)) /* synthesis lut_function=(A+(B+(C+(D)))) */ ;
    defparam i12_4_lut.init = 16'hfffe;
    LUT4 i9_3_lut (.A(frameCounter[15]), .B(DATA_CLK_c), .C(frameCounter[0]), 
         .Z(n26)) /* synthesis lut_function=(A+(B+(C))) */ ;
    defparam i9_3_lut.init = 16'hfefe;
    LUT4 i10_4_lut (.A(frameCounter[6]), .B(frameCounter[4]), .C(frameCounter[1]), 
         .D(frameCounter[8]), .Z(n27)) /* synthesis lut_function=(A+(B+(C+(D)))) */ ;
    defparam i10_4_lut.init = 16'hfffe;
    LUT4 i15_4_lut (.A(n29), .B(frameCounter[14]), .C(n26), .D(frameCounter[9]), 
         .Z(n32)) /* synthesis lut_function=(A+(B+(C+(D)))) */ ;
    defparam i15_4_lut.init = 16'hfffe;
    CCU2D sub_33_add_2_13 (.A0(frameCounter[11]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(frameCounter[12]), .B1(GND_net), .C1(GND_net), 
          .D1(GND_net), .CIN(n5933), .COUT(n5934), .S0(frameCounter_15__N_439[11]), 
          .S1(frameCounter_15__N_439[12]));   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/parallelinterface.v(28[21:37])
    defparam sub_33_add_2_13.INIT0 = 16'h5555;
    defparam sub_33_add_2_13.INIT1 = 16'h5555;
    defparam sub_33_add_2_13.INJECT1_0 = "NO";
    defparam sub_33_add_2_13.INJECT1_1 = "NO";
    
endmodule
//
// Verilog Description of module CoreLayer
//

module CoreLayer (GND_net, CLK_EXT_c, n410, n407, n404, n401, n341, 
            n305, n6686, n530, n527, n524, n521, TP_c_5, n422, 
            n419, n416, n413, n434, n431, n428, n425, n440, 
            n437, n446, n443, n458, n455, n452, n449, n470, 
            n467, n464, n461, n482, n479, n476, n473, n350, 
            n347, n488, n485, n362, n359, n356, n353, n374, 
            n371, n368, n365, n386, n383, n380, n377, n392, 
            n389, n344, n2239, n494, n491, n506, n503, n500, 
            n497, TX_CLK_c_1, TP_c, n398, n395, n518, n515, n512, 
            n509, n536, n533) /* synthesis syn_module_defined=1 */ ;
    input GND_net;
    input CLK_EXT_c;
    input n410;
    input n407;
    input n404;
    input n401;
    input n341;
    input n305;
    output n6686;
    input n530;
    input n527;
    input n524;
    input n521;
    output TP_c_5;
    input n422;
    input n419;
    input n416;
    input n413;
    input n434;
    input n431;
    input n428;
    input n425;
    input n440;
    input n437;
    input n446;
    input n443;
    input n458;
    input n455;
    input n452;
    input n449;
    input n470;
    input n467;
    input n464;
    input n461;
    input n482;
    input n479;
    input n476;
    input n473;
    input n350;
    input n347;
    input n488;
    input n485;
    input n362;
    input n359;
    input n356;
    input n353;
    input n374;
    input n371;
    input n368;
    input n365;
    input n386;
    input n383;
    input n380;
    input n377;
    input n392;
    input n389;
    input n344;
    output n2239;
    input n494;
    input n491;
    input n506;
    input n503;
    input n500;
    input n497;
    output TX_CLK_c_1;
    output TP_c;
    input n398;
    input n395;
    input n518;
    input n515;
    input n512;
    input n509;
    input n536;
    input n533;
    
    wire CLK_EXT_c /* synthesis SET_AS_NETWORK=CLK_EXT_c, is_clock=1 */ ;   // d:/workspace/ultrasounddoppler/0 machxo2 project/ultrasounddopplertop.v(4[15:22])
    wire n2239 /* synthesis is_clock=1, SET_AS_NETWORK=n2239 */ ;   // d:/workspace/ultrasounddoppler/0 machxo2 project/ultrasounddopplertop.v(18[15:21])
    
    wire n5947;
    wire [15:0]Count;   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/corelayer.v(21[11:16])
    wire [15:0]n69;
    
    wire n5948;
    wire [2:0]currentState;   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/corelayer.v(20[10:22])
    
    wire CLK_EXT_c_enable_20;
    wire [2:0]nextState;   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/corelayer.v(20[24:33])
    
    wire n6068, n5946, CLK_EXT_c_enable_83, n5215, n5916, n5917, 
        n20, n16;
    wire [2:0]nextState_2__N_371;
    
    wire nextState_2__N_425;
    wire [2:0]nextState_2__N_365;
    
    wire n7, n5945, Count_15__N_422, n6687, n5906, n5907, n5944, 
        nextState_2__N_427, n6315, n5915, n5914, n5913, n5912, n5911, 
        n5910, n5921, n5920, n5919, n5918, n7_adj_525, n5909, 
        n5908, n6234, n5951, n5950, n19, n5949;
    
    CCU2D Count_851_add_4_9 (.A0(Count[7]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(Count[8]), .B1(GND_net), .C1(GND_net), .D1(GND_net), 
          .CIN(n5947), .COUT(n5948), .S0(n69[7]), .S1(n69[8]));   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/corelayer.v(42[66:78])
    defparam Count_851_add_4_9.INIT0 = 16'hfaaa;
    defparam Count_851_add_4_9.INIT1 = 16'hfaaa;
    defparam Count_851_add_4_9.INJECT1_0 = "NO";
    defparam Count_851_add_4_9.INJECT1_1 = "NO";
    FD1P3AX currentState_i2 (.D(nextState[2]), .SP(CLK_EXT_c_enable_20), 
            .CK(CLK_EXT_c), .Q(currentState[2])) /* synthesis LSE_LINE_FILE_ID=3, LSE_LCOL=11, LSE_RCOL=3, LSE_LLINE=94, LSE_RLINE=107 */ ;   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/corelayer.v(41[7] 44[5])
    defparam currentState_i2.GSR = "ENABLED";
    FD1S3AX currentState_i1 (.D(n6068), .CK(CLK_EXT_c), .Q(currentState[1])) /* synthesis LSE_LINE_FILE_ID=3, LSE_LCOL=11, LSE_RCOL=3, LSE_LLINE=94, LSE_RLINE=107 */ ;   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/corelayer.v(41[7] 44[5])
    defparam currentState_i1.GSR = "ENABLED";
    CCU2D Count_851_add_4_7 (.A0(Count[5]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(Count[6]), .B1(GND_net), .C1(GND_net), .D1(GND_net), 
          .CIN(n5946), .COUT(n5947), .S0(n69[5]), .S1(n69[6]));   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/corelayer.v(42[66:78])
    defparam Count_851_add_4_7.INIT0 = 16'hfaaa;
    defparam Count_851_add_4_7.INIT1 = 16'hfaaa;
    defparam Count_851_add_4_7.INJECT1_0 = "NO";
    defparam Count_851_add_4_7.INJECT1_1 = "NO";
    FD1P3AX currentState_i0 (.D(n5215), .SP(CLK_EXT_c_enable_83), .CK(CLK_EXT_c), 
            .Q(currentState[0])) /* synthesis LSE_LINE_FILE_ID=3, LSE_LCOL=11, LSE_RCOL=3, LSE_LLINE=94, LSE_RLINE=107 */ ;   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/corelayer.v(41[7] 44[5])
    defparam currentState_i0.GSR = "ENABLED";
    CCU2D Count_15__I_0_47_15 (.A0(n410), .B0(Count[5]), .C0(n407), .D0(Count[4]), 
          .A1(n404), .B1(Count[3]), .C1(n401), .D1(Count[2]), .CIN(n5916), 
          .COUT(n5917));
    defparam Count_15__I_0_47_15.INIT0 = 16'h9009;
    defparam Count_15__I_0_47_15.INIT1 = 16'h9009;
    defparam Count_15__I_0_47_15.INJECT1_0 = "YES";
    defparam Count_15__I_0_47_15.INJECT1_1 = "YES";
    LUT4 i1_4_lut (.A(currentState[2]), .B(n20), .C(n16), .D(currentState[1]), 
         .Z(CLK_EXT_c_enable_83)) /* synthesis lut_function=(!(A+!(B (C+!(D))+!B (C (D))))) */ ;
    defparam i1_4_lut.init = 16'h5044;
    LUT4 i39_3_lut (.A(nextState_2__N_371[0]), .B(nextState_2__N_425), .C(currentState[0]), 
         .Z(n20)) /* synthesis lut_function=(A (B+!(C))+!A (B (C))) */ ;
    defparam i39_3_lut.init = 16'hcaca;
    LUT4 i4022_4_lut (.A(currentState[0]), .B(nextState_2__N_371[0]), .C(nextState_2__N_365[0]), 
         .D(currentState[1]), .Z(n5215)) /* synthesis lut_function=(!(A+!(B (C+!(D))+!B (C (D))))) */ ;   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/corelayer.v(49[2] 55[9])
    defparam i4022_4_lut.init = 16'h5044;
    LUT4 i21_3_lut (.A(Count[3]), .B(Count[2]), .C(n341), .Z(n7)) /* synthesis lut_function=(A (B+!(C))+!A (B (C))) */ ;   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/corelayer.v(61[12:86])
    defparam i21_3_lut.init = 16'hcaca;
    CCU2D Count_851_add_4_5 (.A0(Count[3]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(Count[4]), .B1(GND_net), .C1(GND_net), .D1(GND_net), 
          .CIN(n5945), .COUT(n5946), .S0(n69[3]), .S1(n69[4]));   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/corelayer.v(42[66:78])
    defparam Count_851_add_4_5.INIT0 = 16'hfaaa;
    defparam Count_851_add_4_5.INIT1 = 16'hfaaa;
    defparam Count_851_add_4_5.INJECT1_0 = "NO";
    defparam Count_851_add_4_5.INJECT1_1 = "NO";
    LUT4 i5245_2_lut_3_lut_4_lut (.A(currentState[0]), .B(currentState[1]), 
         .C(n305), .D(currentState[2]), .Z(Count_15__N_422)) /* synthesis lut_function=(!(A (C)+!A (B (C)+!B !((D)+!C)))) */ ;   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/corelayer.v(34[21:54])
    defparam i5245_2_lut_3_lut_4_lut.init = 16'h1f0f;
    LUT4 i5230_2_lut_rep_70_3_lut (.A(currentState[0]), .B(currentState[1]), 
         .C(currentState[2]), .Z(n6686)) /* synthesis lut_function=(!(A+(B+!(C)))) */ ;   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/corelayer.v(34[21:54])
    defparam i5230_2_lut_rep_70_3_lut.init = 16'h1010;
    LUT4 i1_2_lut_rep_71_3_lut (.A(currentState[0]), .B(currentState[1]), 
         .C(currentState[2]), .Z(n6687)) /* synthesis lut_function=(A+(B+(C))) */ ;   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/corelayer.v(34[21:54])
    defparam i1_2_lut_rep_71_3_lut.init = 16'hfefe;
    CCU2D Count_15__I_0_43_11 (.A0(n530), .B0(Count[13]), .C0(n527), .D0(Count[12]), 
          .A1(n524), .B1(Count[11]), .C1(n521), .D1(Count[10]), .CIN(n5906), 
          .COUT(n5907));
    defparam Count_15__I_0_43_11.INIT0 = 16'h9009;
    defparam Count_15__I_0_43_11.INIT1 = 16'h9009;
    defparam Count_15__I_0_43_11.INJECT1_0 = "YES";
    defparam Count_15__I_0_43_11.INJECT1_1 = "YES";
    LUT4 i5233_3_lut (.A(currentState[2]), .B(currentState[1]), .C(currentState[0]), 
         .Z(TP_c_5)) /* synthesis lut_function=(!(A+((C)+!B))) */ ;   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/corelayer.v(31[19:47])
    defparam i5233_3_lut.init = 16'h0404;
    CCU2D Count_851_add_4_3 (.A0(Count[1]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(Count[2]), .B1(GND_net), .C1(GND_net), .D1(GND_net), 
          .CIN(n5944), .COUT(n5945), .S0(n69[1]), .S1(n69[2]));   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/corelayer.v(42[66:78])
    defparam Count_851_add_4_3.INIT0 = 16'hfaaa;
    defparam Count_851_add_4_3.INIT1 = 16'hfaaa;
    defparam Count_851_add_4_3.INJECT1_0 = "NO";
    defparam Count_851_add_4_3.INJECT1_1 = "NO";
    CCU2D Count_851_add_4_1 (.A0(GND_net), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(Count[0]), .B1(GND_net), .C1(GND_net), .D1(GND_net), 
          .COUT(n5944), .S1(n69[0]));   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/corelayer.v(42[66:78])
    defparam Count_851_add_4_1.INIT0 = 16'hF000;
    defparam Count_851_add_4_1.INIT1 = 16'h0555;
    defparam Count_851_add_4_1.INJECT1_0 = "NO";
    defparam Count_851_add_4_1.INJECT1_1 = "NO";
    FD1S3IX Count_851__i1 (.D(n69[1]), .CK(CLK_EXT_c), .CD(Count_15__N_422), 
            .Q(Count[1])) /* synthesis syn_use_carry_chain=1 */ ;   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/corelayer.v(42[66:78])
    defparam Count_851__i1.GSR = "ENABLED";
    LUT4 i5238_3_lut (.A(currentState[0]), .B(currentState[2]), .C(nextState_2__N_427), 
         .Z(n6315)) /* synthesis lut_function=((B+!(C))+!A) */ ;
    defparam i5238_3_lut.init = 16'hdfdf;
    CCU2D Count_15__I_0_47_13 (.A0(n422), .B0(Count[9]), .C0(n419), .D0(Count[8]), 
          .A1(n416), .B1(Count[7]), .C1(n413), .D1(Count[6]), .CIN(n5915), 
          .COUT(n5916));
    defparam Count_15__I_0_47_13.INIT0 = 16'h9009;
    defparam Count_15__I_0_47_13.INIT1 = 16'h9009;
    defparam Count_15__I_0_47_13.INJECT1_0 = "YES";
    defparam Count_15__I_0_47_13.INJECT1_1 = "YES";
    FD1S3IX Count_851__i2 (.D(n69[2]), .CK(CLK_EXT_c), .CD(Count_15__N_422), 
            .Q(Count[2])) /* synthesis syn_use_carry_chain=1 */ ;   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/corelayer.v(42[66:78])
    defparam Count_851__i2.GSR = "ENABLED";
    FD1S3IX Count_851__i3 (.D(n69[3]), .CK(CLK_EXT_c), .CD(Count_15__N_422), 
            .Q(Count[3])) /* synthesis syn_use_carry_chain=1 */ ;   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/corelayer.v(42[66:78])
    defparam Count_851__i3.GSR = "ENABLED";
    FD1S3IX Count_851__i4 (.D(n69[4]), .CK(CLK_EXT_c), .CD(Count_15__N_422), 
            .Q(Count[4])) /* synthesis syn_use_carry_chain=1 */ ;   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/corelayer.v(42[66:78])
    defparam Count_851__i4.GSR = "ENABLED";
    FD1S3IX Count_851__i5 (.D(n69[5]), .CK(CLK_EXT_c), .CD(Count_15__N_422), 
            .Q(Count[5])) /* synthesis syn_use_carry_chain=1 */ ;   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/corelayer.v(42[66:78])
    defparam Count_851__i5.GSR = "ENABLED";
    FD1S3IX Count_851__i6 (.D(n69[6]), .CK(CLK_EXT_c), .CD(Count_15__N_422), 
            .Q(Count[6])) /* synthesis syn_use_carry_chain=1 */ ;   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/corelayer.v(42[66:78])
    defparam Count_851__i6.GSR = "ENABLED";
    FD1S3IX Count_851__i7 (.D(n69[7]), .CK(CLK_EXT_c), .CD(Count_15__N_422), 
            .Q(Count[7])) /* synthesis syn_use_carry_chain=1 */ ;   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/corelayer.v(42[66:78])
    defparam Count_851__i7.GSR = "ENABLED";
    FD1S3IX Count_851__i8 (.D(n69[8]), .CK(CLK_EXT_c), .CD(Count_15__N_422), 
            .Q(Count[8])) /* synthesis syn_use_carry_chain=1 */ ;   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/corelayer.v(42[66:78])
    defparam Count_851__i8.GSR = "ENABLED";
    FD1S3IX Count_851__i9 (.D(n69[9]), .CK(CLK_EXT_c), .CD(Count_15__N_422), 
            .Q(Count[9])) /* synthesis syn_use_carry_chain=1 */ ;   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/corelayer.v(42[66:78])
    defparam Count_851__i9.GSR = "ENABLED";
    FD1S3IX Count_851__i10 (.D(n69[10]), .CK(CLK_EXT_c), .CD(Count_15__N_422), 
            .Q(Count[10])) /* synthesis syn_use_carry_chain=1 */ ;   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/corelayer.v(42[66:78])
    defparam Count_851__i10.GSR = "ENABLED";
    FD1S3IX Count_851__i11 (.D(n69[11]), .CK(CLK_EXT_c), .CD(Count_15__N_422), 
            .Q(Count[11])) /* synthesis syn_use_carry_chain=1 */ ;   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/corelayer.v(42[66:78])
    defparam Count_851__i11.GSR = "ENABLED";
    FD1S3IX Count_851__i12 (.D(n69[12]), .CK(CLK_EXT_c), .CD(Count_15__N_422), 
            .Q(Count[12])) /* synthesis syn_use_carry_chain=1 */ ;   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/corelayer.v(42[66:78])
    defparam Count_851__i12.GSR = "ENABLED";
    FD1S3IX Count_851__i13 (.D(n69[13]), .CK(CLK_EXT_c), .CD(Count_15__N_422), 
            .Q(Count[13])) /* synthesis syn_use_carry_chain=1 */ ;   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/corelayer.v(42[66:78])
    defparam Count_851__i13.GSR = "ENABLED";
    FD1S3IX Count_851__i14 (.D(n69[14]), .CK(CLK_EXT_c), .CD(Count_15__N_422), 
            .Q(Count[14])) /* synthesis syn_use_carry_chain=1 */ ;   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/corelayer.v(42[66:78])
    defparam Count_851__i14.GSR = "ENABLED";
    FD1S3IX Count_851__i15 (.D(n69[15]), .CK(CLK_EXT_c), .CD(Count_15__N_422), 
            .Q(Count[15])) /* synthesis syn_use_carry_chain=1 */ ;   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/corelayer.v(42[66:78])
    defparam Count_851__i15.GSR = "ENABLED";
    CCU2D Count_15__I_0_47_11 (.A0(n434), .B0(Count[13]), .C0(n431), .D0(Count[12]), 
          .A1(n428), .B1(Count[11]), .C1(n425), .D1(Count[10]), .CIN(n5914), 
          .COUT(n5915));
    defparam Count_15__I_0_47_11.INIT0 = 16'h9009;
    defparam Count_15__I_0_47_11.INIT1 = 16'h9009;
    defparam Count_15__I_0_47_11.INJECT1_0 = "YES";
    defparam Count_15__I_0_47_11.INJECT1_1 = "YES";
    CCU2D Count_15__I_0_47_0 (.A0(GND_net), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(n440), .B1(Count[15]), .C1(n437), .D1(Count[14]), 
          .COUT(n5914));   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/corelayer.v(52[19:39])
    defparam Count_15__I_0_47_0.INIT0 = 16'hF000;
    defparam Count_15__I_0_47_0.INIT1 = 16'h9009;
    defparam Count_15__I_0_47_0.INJECT1_0 = "NO";
    defparam Count_15__I_0_47_0.INJECT1_1 = "YES";
    CCU2D Count_15__I_0_45_16 (.A0(n446), .B0(Count[1]), .C0(n443), .D0(Count[0]), 
          .A1(GND_net), .B1(GND_net), .C1(GND_net), .D1(GND_net), .CIN(n5913), 
          .S1(nextState_2__N_425));
    defparam Count_15__I_0_45_16.INIT0 = 16'h9009;
    defparam Count_15__I_0_45_16.INIT1 = 16'hFFFF;
    defparam Count_15__I_0_45_16.INJECT1_0 = "YES";
    defparam Count_15__I_0_45_16.INJECT1_1 = "NO";
    CCU2D Count_15__I_0_45_15 (.A0(n458), .B0(Count[5]), .C0(n455), .D0(Count[4]), 
          .A1(n452), .B1(Count[3]), .C1(n449), .D1(Count[2]), .CIN(n5912), 
          .COUT(n5913));
    defparam Count_15__I_0_45_15.INIT0 = 16'h9009;
    defparam Count_15__I_0_45_15.INIT1 = 16'h9009;
    defparam Count_15__I_0_45_15.INJECT1_0 = "YES";
    defparam Count_15__I_0_45_15.INJECT1_1 = "YES";
    CCU2D Count_15__I_0_45_13 (.A0(n470), .B0(Count[9]), .C0(n467), .D0(Count[8]), 
          .A1(n464), .B1(Count[7]), .C1(n461), .D1(Count[6]), .CIN(n5911), 
          .COUT(n5912));
    defparam Count_15__I_0_45_13.INIT0 = 16'h9009;
    defparam Count_15__I_0_45_13.INIT1 = 16'h9009;
    defparam Count_15__I_0_45_13.INJECT1_0 = "YES";
    defparam Count_15__I_0_45_13.INJECT1_1 = "YES";
    CCU2D Count_15__I_0_45_11 (.A0(n482), .B0(Count[13]), .C0(n479), .D0(Count[12]), 
          .A1(n476), .B1(Count[11]), .C1(n473), .D1(Count[10]), .CIN(n5910), 
          .COUT(n5911));
    defparam Count_15__I_0_45_11.INIT0 = 16'h9009;
    defparam Count_15__I_0_45_11.INIT1 = 16'h9009;
    defparam Count_15__I_0_45_11.INJECT1_0 = "YES";
    defparam Count_15__I_0_45_11.INJECT1_1 = "YES";
    CCU2D Count_15__I_0_16 (.A0(n350), .B0(Count[1]), .C0(n347), .D0(Count[0]), 
          .A1(GND_net), .B1(GND_net), .C1(GND_net), .D1(GND_net), .CIN(n5921), 
          .S1(nextState_2__N_427));
    defparam Count_15__I_0_16.INIT0 = 16'h9009;
    defparam Count_15__I_0_16.INIT1 = 16'hFFFF;
    defparam Count_15__I_0_16.INJECT1_0 = "YES";
    defparam Count_15__I_0_16.INJECT1_1 = "NO";
    CCU2D Count_15__I_0_45_0 (.A0(GND_net), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(n488), .B1(Count[15]), .C1(n485), .D1(Count[14]), 
          .COUT(n5910));   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/corelayer.v(51[20:40])
    defparam Count_15__I_0_45_0.INIT0 = 16'hF000;
    defparam Count_15__I_0_45_0.INIT1 = 16'h9009;
    defparam Count_15__I_0_45_0.INJECT1_0 = "NO";
    defparam Count_15__I_0_45_0.INJECT1_1 = "YES";
    CCU2D Count_15__I_0_15 (.A0(n362), .B0(Count[5]), .C0(n359), .D0(Count[4]), 
          .A1(n356), .B1(Count[3]), .C1(n353), .D1(Count[2]), .CIN(n5920), 
          .COUT(n5921));
    defparam Count_15__I_0_15.INIT0 = 16'h9009;
    defparam Count_15__I_0_15.INIT1 = 16'h9009;
    defparam Count_15__I_0_15.INJECT1_0 = "YES";
    defparam Count_15__I_0_15.INJECT1_1 = "YES";
    CCU2D Count_15__I_0_13 (.A0(n374), .B0(Count[9]), .C0(n371), .D0(Count[8]), 
          .A1(n368), .B1(Count[7]), .C1(n365), .D1(Count[6]), .CIN(n5919), 
          .COUT(n5920));
    defparam Count_15__I_0_13.INIT0 = 16'h9009;
    defparam Count_15__I_0_13.INIT1 = 16'h9009;
    defparam Count_15__I_0_13.INJECT1_0 = "YES";
    defparam Count_15__I_0_13.INJECT1_1 = "YES";
    CCU2D Count_15__I_0_11 (.A0(n386), .B0(Count[13]), .C0(n383), .D0(Count[12]), 
          .A1(n380), .B1(Count[11]), .C1(n377), .D1(Count[10]), .CIN(n5918), 
          .COUT(n5919));
    defparam Count_15__I_0_11.INIT0 = 16'h9009;
    defparam Count_15__I_0_11.INIT1 = 16'h9009;
    defparam Count_15__I_0_11.INJECT1_0 = "YES";
    defparam Count_15__I_0_11.INJECT1_1 = "YES";
    CCU2D Count_15__I_0_0 (.A0(GND_net), .B0(GND_net), .C0(GND_net), .D0(GND_net), 
          .A1(n392), .B1(Count[15]), .C1(n389), .D1(Count[14]), .COUT(n5918));   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/corelayer.v(53[20:40])
    defparam Count_15__I_0_0.INIT0 = 16'hF000;
    defparam Count_15__I_0_0.INIT1 = 16'h9009;
    defparam Count_15__I_0_0.INJECT1_0 = "NO";
    defparam Count_15__I_0_0.INJECT1_1 = "YES";
    LUT4 i20_3_lut (.A(Count[1]), .B(n7_adj_525), .C(n344), .Z(n2239)) /* synthesis lut_function=(A (B+!(C))+!A (B (C))) */ ;   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/corelayer.v(68[12:87])
    defparam i20_3_lut.init = 16'hcaca;
    CCU2D Count_15__I_0_43_16 (.A0(n494), .B0(Count[1]), .C0(n491), .D0(Count[0]), 
          .A1(GND_net), .B1(GND_net), .C1(GND_net), .D1(GND_net), .CIN(n5909), 
          .S1(nextState_2__N_371[0]));
    defparam Count_15__I_0_43_16.INIT0 = 16'h9009;
    defparam Count_15__I_0_43_16.INIT1 = 16'hFFFF;
    defparam Count_15__I_0_43_16.INJECT1_0 = "YES";
    defparam Count_15__I_0_43_16.INJECT1_1 = "NO";
    LUT4 i21_3_lut_adj_25 (.A(Count[0]), .B(CLK_EXT_c), .C(n341), .Z(n7_adj_525)) /* synthesis lut_function=(A (B+!(C))+!A (B (C))) */ ;   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/corelayer.v(68[12:87])
    defparam i21_3_lut_adj_25.init = 16'hcaca;
    CCU2D Count_15__I_0_43_15 (.A0(n506), .B0(Count[5]), .C0(n503), .D0(Count[4]), 
          .A1(n500), .B1(Count[3]), .C1(n497), .D1(Count[2]), .CIN(n5908), 
          .COUT(n5909));
    defparam Count_15__I_0_43_15.INIT0 = 16'h9009;
    defparam Count_15__I_0_43_15.INIT1 = 16'h9009;
    defparam Count_15__I_0_43_15.INJECT1_0 = "YES";
    defparam Count_15__I_0_43_15.INJECT1_1 = "YES";
    LUT4 i5224_2_lut_2_lut_4_lut (.A(Count[4]), .B(n7), .C(n344), .D(n6687), 
         .Z(TX_CLK_c_1)) /* synthesis lut_function=(!(A (B+((D)+!C))+!A (B (C+(D))+!B (D)))) */ ;   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/corelayer.v(61[12:86])
    defparam i5224_2_lut_2_lut_4_lut.init = 16'h0035;
    FD1S3IX Count_851__i0 (.D(n69[0]), .CK(CLK_EXT_c), .CD(Count_15__N_422), 
            .Q(Count[0])) /* synthesis syn_use_carry_chain=1 */ ;   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/corelayer.v(42[66:78])
    defparam Count_851__i0.GSR = "ENABLED";
    PFUMX i21 (.BLUT(n6234), .ALUT(n6315), .C0(currentState[1]), .Z(n6068));
    LUT4 i3908_2_lut_4_lut (.A(Count[4]), .B(n7), .C(n344), .D(n6687), 
         .Z(TP_c)) /* synthesis lut_function=(!(A (B (D)+!B (C+(D)))+!A (((D)+!C)+!B))) */ ;   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/corelayer.v(61[12:86])
    defparam i3908_2_lut_4_lut.init = 16'h00ca;
    CCU2D Count_15__I_0_47_16 (.A0(n398), .B0(Count[1]), .C0(n395), .D0(Count[0]), 
          .A1(GND_net), .B1(GND_net), .C1(GND_net), .D1(GND_net), .CIN(n5917), 
          .S1(nextState_2__N_365[0]));
    defparam Count_15__I_0_47_16.INIT0 = 16'h9009;
    defparam Count_15__I_0_47_16.INIT1 = 16'hFFFF;
    defparam Count_15__I_0_47_16.INJECT1_0 = "YES";
    defparam Count_15__I_0_47_16.INJECT1_1 = "NO";
    LUT4 i1_2_lut_3_lut (.A(currentState[0]), .B(currentState[2]), .C(currentState[1]), 
         .Z(nextState[2])) /* synthesis lut_function=(!((B+!(C))+!A)) */ ;   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/corelayer.v(41[7] 44[5])
    defparam i1_2_lut_3_lut.init = 16'h2020;
    LUT4 i1_2_lut_3_lut_adj_26 (.A(currentState[0]), .B(currentState[2]), 
         .C(nextState_2__N_425), .Z(n6234)) /* synthesis lut_function=(!((B+!(C))+!A)) */ ;   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/corelayer.v(41[7] 44[5])
    defparam i1_2_lut_3_lut_adj_26.init = 16'h2020;
    CCU2D Count_851_add_4_17 (.A0(Count[15]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(GND_net), .B1(GND_net), .C1(GND_net), .D1(GND_net), 
          .CIN(n5951), .S0(n69[15]));   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/corelayer.v(42[66:78])
    defparam Count_851_add_4_17.INIT0 = 16'hfaaa;
    defparam Count_851_add_4_17.INIT1 = 16'h0000;
    defparam Count_851_add_4_17.INJECT1_0 = "NO";
    defparam Count_851_add_4_17.INJECT1_1 = "NO";
    CCU2D Count_851_add_4_15 (.A0(Count[13]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(Count[14]), .B1(GND_net), .C1(GND_net), 
          .D1(GND_net), .CIN(n5950), .COUT(n5951), .S0(n69[13]), .S1(n69[14]));   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/corelayer.v(42[66:78])
    defparam Count_851_add_4_15.INIT0 = 16'hfaaa;
    defparam Count_851_add_4_15.INIT1 = 16'hfaaa;
    defparam Count_851_add_4_15.INJECT1_0 = "NO";
    defparam Count_851_add_4_15.INJECT1_1 = "NO";
    LUT4 i36_4_lut (.A(n19), .B(currentState[2]), .C(currentState[1]), 
         .D(n16), .Z(CLK_EXT_c_enable_20)) /* synthesis lut_function=(!(A (B (C)+!B !((D)+!C))+!A (B+!(C (D))))) */ ;
    defparam i36_4_lut.init = 16'h3a0a;
    CCU2D Count_15__I_0_43_13 (.A0(n518), .B0(Count[9]), .C0(n515), .D0(Count[8]), 
          .A1(n512), .B1(Count[7]), .C1(n509), .D1(Count[6]), .CIN(n5907), 
          .COUT(n5908));
    defparam Count_15__I_0_43_13.INIT0 = 16'h9009;
    defparam Count_15__I_0_43_13.INIT1 = 16'h9009;
    defparam Count_15__I_0_43_13.INJECT1_0 = "YES";
    defparam Count_15__I_0_43_13.INJECT1_1 = "YES";
    LUT4 i37_4_lut (.A(nextState_2__N_371[0]), .B(nextState_2__N_425), .C(currentState[0]), 
         .D(currentState[2]), .Z(n19)) /* synthesis lut_function=(!(A (B (C (D))+!B (C))+!A (B (C (D)+!C !(D))+!B (C+!(D))))) */ ;
    defparam i37_4_lut.init = 16'h0fca;
    CCU2D Count_851_add_4_13 (.A0(Count[11]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(Count[12]), .B1(GND_net), .C1(GND_net), 
          .D1(GND_net), .CIN(n5949), .COUT(n5950), .S0(n69[11]), .S1(n69[12]));   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/corelayer.v(42[66:78])
    defparam Count_851_add_4_13.INIT0 = 16'hfaaa;
    defparam Count_851_add_4_13.INIT1 = 16'hfaaa;
    defparam Count_851_add_4_13.INJECT1_0 = "NO";
    defparam Count_851_add_4_13.INJECT1_1 = "NO";
    LUT4 i38_3_lut (.A(nextState_2__N_365[0]), .B(nextState_2__N_427), .C(currentState[0]), 
         .Z(n16)) /* synthesis lut_function=(A (B+!(C))+!A (B (C))) */ ;
    defparam i38_3_lut.init = 16'hcaca;
    CCU2D Count_851_add_4_11 (.A0(Count[9]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(Count[10]), .B1(GND_net), .C1(GND_net), 
          .D1(GND_net), .CIN(n5948), .COUT(n5949), .S0(n69[9]), .S1(n69[10]));   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/corelayer.v(42[66:78])
    defparam Count_851_add_4_11.INIT0 = 16'hfaaa;
    defparam Count_851_add_4_11.INIT1 = 16'hfaaa;
    defparam Count_851_add_4_11.INJECT1_0 = "NO";
    defparam Count_851_add_4_11.INJECT1_1 = "NO";
    CCU2D Count_15__I_0_43_0 (.A0(GND_net), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(n536), .B1(Count[15]), .C1(n533), .D1(Count[14]), 
          .COUT(n5906));   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/corelayer.v(50[20:40])
    defparam Count_15__I_0_43_0.INIT0 = 16'hF000;
    defparam Count_15__I_0_43_0.INIT1 = 16'h9009;
    defparam Count_15__I_0_43_0.INJECT1_0 = "NO";
    defparam Count_15__I_0_43_0.INJECT1_1 = "YES";
    
endmodule
//
// Verilog Description of module CommunicationLayer
//

module CommunicationLayer (mem_clk, CLK_EXT_c, ENABLE_N_2, MEM_CLK_N_130, 
            mem_wdata, mem_addr, \spi_cmd[3] , mem_rdata, n2242_c, 
            spi_csn_c, n1619, TP_c_2, n616, n6692, GND_net, n6681, 
            n6894, n6, MEM_CLK_N_127, n6701, clock_N_160, spi_miso_c, 
            spi_clk_c, spi_mosi_c) /* synthesis syn_module_defined=1 */ ;
    output mem_clk;
    input CLK_EXT_c;
    input ENABLE_N_2;
    output MEM_CLK_N_130;
    output [15:0]mem_wdata;
    output [7:0]mem_addr;
    output \spi_cmd[3] ;
    input [15:0]mem_rdata;
    input n2242_c;
    input spi_csn_c;
    input n1619;
    output TP_c_2;
    output n616;
    output n6692;
    input GND_net;
    output n6681;
    input n6894;
    output n6;
    output MEM_CLK_N_127;
    input n6701;
    input clock_N_160;
    output spi_miso_c;
    input spi_clk_c;
    input spi_mosi_c;
    
    wire CLK_EXT_c /* synthesis SET_AS_NETWORK=CLK_EXT_c, is_clock=1 */ ;   // d:/workspace/ultrasounddoppler/0 machxo2 project/ultrasounddopplertop.v(4[15:22])
    wire clock_N_160 /* synthesis is_inv_clock=1 */ ;   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/spi_slave.v(33[18:24])
    wire spi_clk_c /* synthesis is_clock=1 */ ;   // d:/workspace/ultrasounddoppler/0 machxo2 project/ultrasounddopplertop.v(7[19:26])
    wire [15:0]n610;
    
    wire n786;
    wire [7:0]mem_burst_cnt;   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/communicationlayer.v(25[14:27])
    
    wire CLK_EXT_c_enable_90, n6223;
    wire [7:0]n810;
    
    wire n6222, n4299, MEM_CLK_N_126;
    wire [15:0]dataOut;   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/communicationlayer.v(24[27:34])
    wire [15:0]dataOut_15__N_94;
    wire [3:0]spi_cmd;   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/communicationlayer.v(32[12:19])
    
    wire n6076, n6094, n6221, n2776, CLK_EXT_c_enable_99;
    wire [7:0]n1620;
    
    wire n9, n4360, n4361;
    wire [15:0]rd_data;   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/communicationlayer.v(22[27:34])
    
    wire n6043;
    wire [15:0]counter_15__N_193;
    
    wire n3015, n6696, n4336, n4337, n2734, n5095, n4350, n4351, 
        n17, n16, n4033, n6685;
    wire [7:0]n800;
    
    wire n1607, n6697, n2672, n2703, CLK_EXT_c_enable_84, ENABLE_N_135, 
        n4064, n6682, n6297, n6533, n6694, n6206, n6337, n6257, 
        CLK_EXT_c_enable_91, n2782, n6232, n6698, n6693, n6287, 
        n5203, n43, n5967, n3990, n6699, n6683, n5180, n6254, 
        n6003, n2494, n2492, n658, n4418, n4422, n4420, n4424, 
        n4387, n4385, n4383, n4381, n4379, n4377, n4375, n4373, 
        n4371, n4367, n4365, n4363, n6689, n12, n8, n4419, n6216;
    wire [7:0]mem_addr_c;   // d:/workspace/ultrasounddoppler/0 machxo2 project/ultrasounddopplertop.v(38[32:40])
    
    wire n6246, n6323, n8_adj_524, n6248, n4386, n7, n6309, n5943, 
        n5942, n4, n6896, n5941, n6690, n6700, n4384, n4408, 
        n6695, n4382, n4380, n5940, n5939, n6684, MEM_CLK_N_128, 
        n4378, n5938, n5966, n63, n6275, n4376, n6335, n4374, 
        n6895, n6317, n6319, n4372, n5937, n5936, n6688, n41, 
        n22, n4298, n4362, n4421, n6897, n24, n6247, n4370, 
        n66, n4366, n4364;
    
    LUT4 i3922_2_lut_3_lut (.A(n610[0]), .B(n610[11]), .C(mem_clk), .Z(n786)) /* synthesis lut_function=(!(A+(B+!(C)))) */ ;   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/communicationlayer.v(50[3] 148[10])
    defparam i3922_2_lut_3_lut.init = 16'h1010;
    FD1P3IX mem_burst_cnt__i0 (.D(n6223), .SP(CLK_EXT_c_enable_90), .CD(ENABLE_N_2), 
            .CK(CLK_EXT_c), .Q(mem_burst_cnt[0])) /* synthesis LSE_LINE_FILE_ID=3, LSE_LCOL=22, LSE_RCOL=4, LSE_LLINE=43, LSE_RLINE=58 */ ;   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/communicationlayer.v(35[7] 150[4])
    defparam mem_burst_cnt__i0.GSR = "DISABLED";
    LUT4 i1_2_lut_3_lut_4_lut (.A(n610[0]), .B(n610[11]), .C(n810[7]), 
         .D(MEM_CLK_N_130), .Z(n6222)) /* synthesis lut_function=(A (C (D))+!A (B (C (D)))) */ ;   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/communicationlayer.v(50[3] 148[10])
    defparam i1_2_lut_3_lut_4_lut.init = 16'he000;
    FD1S3AX MEM_WDATA_i0 (.D(n4299), .CK(CLK_EXT_c), .Q(mem_wdata[0])) /* synthesis LSE_LINE_FILE_ID=3, LSE_LCOL=22, LSE_RCOL=4, LSE_LLINE=43, LSE_RLINE=58 */ ;   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/communicationlayer.v(35[7] 150[4])
    defparam MEM_WDATA_i0.GSR = "DISABLED";
    FD1S3AX MEM_CLK_110 (.D(MEM_CLK_N_126), .CK(CLK_EXT_c), .Q(mem_clk)) /* synthesis LSE_LINE_FILE_ID=3, LSE_LCOL=22, LSE_RCOL=4, LSE_LLINE=43, LSE_RLINE=58 */ ;   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/communicationlayer.v(35[7] 150[4])
    defparam MEM_CLK_110.GSR = "DISABLED";
    FD1S3IX dataOut_i0 (.D(dataOut_15__N_94[0]), .CK(CLK_EXT_c), .CD(ENABLE_N_2), 
            .Q(dataOut[0])) /* synthesis LSE_LINE_FILE_ID=3, LSE_LCOL=22, LSE_RCOL=4, LSE_LLINE=43, LSE_RLINE=58 */ ;   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/communicationlayer.v(35[7] 150[4])
    defparam dataOut_i0.GSR = "DISABLED";
    FD1S3JX spi_cmd_i0 (.D(n6076), .CK(CLK_EXT_c), .PD(ENABLE_N_2), .Q(spi_cmd[0])) /* synthesis LSE_LINE_FILE_ID=3, LSE_LCOL=22, LSE_RCOL=4, LSE_LLINE=43, LSE_RLINE=58 */ ;   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/communicationlayer.v(35[7] 150[4])
    defparam spi_cmd_i0.GSR = "DISABLED";
    FD1S3JX main_sm_FSM_i1 (.D(n6094), .CK(CLK_EXT_c), .PD(ENABLE_N_2), 
            .Q(n610[0]));   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/communicationlayer.v(50[3] 148[10])
    defparam main_sm_FSM_i1.GSR = "DISABLED";
    LUT4 i1_2_lut_3_lut_4_lut_adj_4 (.A(n610[0]), .B(n610[11]), .C(n810[6]), 
         .D(MEM_CLK_N_130), .Z(n6221)) /* synthesis lut_function=(A (C (D))+!A (B (C (D)))) */ ;   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/communicationlayer.v(50[3] 148[10])
    defparam i1_2_lut_3_lut_4_lut_adj_4.init = 16'he000;
    FD1P3IX mem_burst_cnt__i7 (.D(n6222), .SP(CLK_EXT_c_enable_90), .CD(ENABLE_N_2), 
            .CK(CLK_EXT_c), .Q(mem_burst_cnt[7])) /* synthesis LSE_LINE_FILE_ID=3, LSE_LCOL=22, LSE_RCOL=4, LSE_LLINE=43, LSE_RLINE=58 */ ;   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/communicationlayer.v(35[7] 150[4])
    defparam mem_burst_cnt__i7.GSR = "DISABLED";
    FD1P3IX mem_burst_cnt__i6 (.D(n6221), .SP(CLK_EXT_c_enable_90), .CD(ENABLE_N_2), 
            .CK(CLK_EXT_c), .Q(mem_burst_cnt[6])) /* synthesis LSE_LINE_FILE_ID=3, LSE_LCOL=22, LSE_RCOL=4, LSE_LLINE=43, LSE_RLINE=58 */ ;   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/communicationlayer.v(35[7] 150[4])
    defparam mem_burst_cnt__i6.GSR = "DISABLED";
    LUT4 i1_2_lut_3_lut_4_lut_adj_5 (.A(n610[0]), .B(n610[11]), .C(n810[2]), 
         .D(MEM_CLK_N_130), .Z(n2776)) /* synthesis lut_function=(A (C (D))+!A (B (C (D)))) */ ;   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/communicationlayer.v(50[3] 148[10])
    defparam i1_2_lut_3_lut_4_lut_adj_5.init = 16'he000;
    FD1P3AX MEM_ADDR_i0_i0 (.D(n1620[0]), .SP(CLK_EXT_c_enable_99), .CK(CLK_EXT_c), 
            .Q(mem_addr[0])) /* synthesis LSE_LINE_FILE_ID=3, LSE_LCOL=22, LSE_RCOL=4, LSE_LLINE=43, LSE_RLINE=58 */ ;   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/communicationlayer.v(35[7] 150[4])
    defparam MEM_ADDR_i0_i0.GSR = "DISABLED";
    LUT4 i24_4_lut_4_lut (.A(\spi_cmd[3] ), .B(spi_cmd[0]), .C(spi_cmd[1]), 
         .D(spi_cmd[2]), .Z(n9)) /* synthesis lut_function=(!(A (((D)+!C)+!B)+!A (B (C+!(D))+!B !(C (D))))) */ ;   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/communicationlayer.v(108[27] 118[34])
    defparam i24_4_lut_4_lut.init = 16'h1480;
    LUT4 i3166_3_lut (.A(mem_rdata[3]), .B(n4360), .C(n2242_c), .Z(n4361)) /* synthesis lut_function=(A (B+!(C))+!A (B (C))) */ ;   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/communicationlayer.v(35[7] 150[4])
    defparam i3166_3_lut.init = 16'hcaca;
    LUT4 i3165_3_lut (.A(mem_wdata[3]), .B(rd_data[3]), .C(n6043), .Z(n4360)) /* synthesis lut_function=(A (B+(C))+!A !((C)+!B)) */ ;   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/communicationlayer.v(35[7] 150[4])
    defparam i3165_3_lut.init = 16'hacac;
    LUT4 i1839_3_lut_4_lut (.A(spi_csn_c), .B(counter_15__N_193[15]), .C(n610[0]), 
         .D(n610[3]), .Z(n3015)) /* synthesis lut_function=(!(A+(B+!(C+(D))))) */ ;
    defparam i1839_3_lut_4_lut.init = 16'h1110;
    LUT4 i2_3_lut_rep_80 (.A(\spi_cmd[3] ), .B(spi_cmd[0]), .C(spi_cmd[1]), 
         .Z(n6696)) /* synthesis lut_function=(A (B (C))) */ ;
    defparam i2_3_lut_rep_80.init = 16'h8080;
    LUT4 i3142_3_lut (.A(mem_rdata[2]), .B(n4336), .C(n2242_c), .Z(n4337)) /* synthesis lut_function=(A (B+!(C))+!A (B (C))) */ ;   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/communicationlayer.v(35[7] 150[4])
    defparam i3142_3_lut.init = 16'hcaca;
    LUT4 i1_2_lut_3_lut_4_lut_adj_6 (.A(n610[0]), .B(n610[11]), .C(n810[3]), 
         .D(MEM_CLK_N_130), .Z(n2734)) /* synthesis lut_function=(A (C (D))+!A (B (C (D)))) */ ;   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/communicationlayer.v(50[3] 148[10])
    defparam i1_2_lut_3_lut_4_lut_adj_6.init = 16'he000;
    LUT4 i3903_4_lut_4_lut (.A(\spi_cmd[3] ), .B(spi_cmd[1]), .C(spi_cmd[0]), 
         .D(spi_cmd[2]), .Z(n5095)) /* synthesis lut_function=(A+(B (C+!(D))+!B !(C (D)))) */ ;
    defparam i3903_4_lut_4_lut.init = 16'hebff;
    LUT4 i3141_3_lut (.A(mem_wdata[2]), .B(rd_data[2]), .C(n6043), .Z(n4336)) /* synthesis lut_function=(A (B+(C))+!A !((C)+!B)) */ ;   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/communicationlayer.v(35[7] 150[4])
    defparam i3141_3_lut.init = 16'hacac;
    LUT4 i3156_3_lut (.A(mem_rdata[1]), .B(n4350), .C(n2242_c), .Z(n4351)) /* synthesis lut_function=(A (B+!(C))+!A (B (C))) */ ;   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/communicationlayer.v(35[7] 150[4])
    defparam i3156_3_lut.init = 16'hcaca;
    LUT4 i9_4_lut (.A(n17), .B(rd_data[8]), .C(n16), .D(rd_data[10]), 
         .Z(n4033)) /* synthesis lut_function=(A+(B+(C+(D)))) */ ;   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/communicationlayer.v(76[8:17])
    defparam i9_4_lut.init = 16'hfffe;
    LUT4 i1_2_lut_rep_69_4_lut (.A(\spi_cmd[3] ), .B(spi_cmd[0]), .C(spi_cmd[1]), 
         .D(spi_cmd[2]), .Z(n6685)) /* synthesis lut_function=(A (B (C (D)))) */ ;
    defparam i1_2_lut_rep_69_4_lut.init = 16'h8000;
    LUT4 i3155_3_lut (.A(mem_wdata[1]), .B(rd_data[1]), .C(n6043), .Z(n4350)) /* synthesis lut_function=(A (B+(C))+!A !((C)+!B)) */ ;   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/communicationlayer.v(35[7] 150[4])
    defparam i3155_3_lut.init = 16'hacac;
    LUT4 mux_698_i2_4_lut (.A(n800[1]), .B(rd_data[1]), .C(n1619), .D(n1607), 
         .Z(n1620[1])) /* synthesis lut_function=(A (B (C+(D))+!B !(C+!(D)))+!A (B (C))) */ ;   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/communicationlayer.v(46[7] 149[5])
    defparam mux_698_i2_4_lut.init = 16'hcac0;
    LUT4 i756_2_lut_rep_81 (.A(n610[9]), .B(spi_csn_c), .Z(n6697)) /* synthesis lut_function=(!((B)+!A)) */ ;   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/communicationlayer.v(46[7] 149[5])
    defparam i756_2_lut_rep_81.init = 16'h2222;
    FD1P3IX mem_burst_cnt__i5 (.D(n2672), .SP(CLK_EXT_c_enable_90), .CD(ENABLE_N_2), 
            .CK(CLK_EXT_c), .Q(mem_burst_cnt[5])) /* synthesis LSE_LINE_FILE_ID=3, LSE_LCOL=22, LSE_RCOL=4, LSE_LLINE=43, LSE_RLINE=58 */ ;   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/communicationlayer.v(35[7] 150[4])
    defparam mem_burst_cnt__i5.GSR = "DISABLED";
    FD1P3IX mem_burst_cnt__i4 (.D(n2703), .SP(CLK_EXT_c_enable_90), .CD(ENABLE_N_2), 
            .CK(CLK_EXT_c), .Q(mem_burst_cnt[4])) /* synthesis LSE_LINE_FILE_ID=3, LSE_LCOL=22, LSE_RCOL=4, LSE_LLINE=43, LSE_RLINE=58 */ ;   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/communicationlayer.v(35[7] 150[4])
    defparam mem_burst_cnt__i4.GSR = "DISABLED";
    FD1P3IX mem_burst_cnt__i3 (.D(n2734), .SP(CLK_EXT_c_enable_90), .CD(ENABLE_N_2), 
            .CK(CLK_EXT_c), .Q(mem_burst_cnt[3])) /* synthesis LSE_LINE_FILE_ID=3, LSE_LCOL=22, LSE_RCOL=4, LSE_LLINE=43, LSE_RLINE=58 */ ;   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/communicationlayer.v(35[7] 150[4])
    defparam mem_burst_cnt__i3.GSR = "DISABLED";
    FD1P3IX ENABLE_108 (.D(ENABLE_N_135), .SP(CLK_EXT_c_enable_84), .CD(ENABLE_N_2), 
            .CK(CLK_EXT_c), .Q(TP_c_2));   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/communicationlayer.v(35[7] 150[4])
    defparam ENABLE_108.GSR = "DISABLED";
    LUT4 i2878_3_lut_4_lut (.A(n610[9]), .B(spi_csn_c), .C(n616), .D(counter_15__N_193[15]), 
         .Z(n4064)) /* synthesis lut_function=(!(A (B ((D)+!C)+!B (D))+!A ((D)+!C))) */ ;   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/communicationlayer.v(46[7] 149[5])
    defparam i2878_3_lut_4_lut.init = 16'h00f2;
    LUT4 i5089_2_lut_3_lut (.A(rd_data[1]), .B(n6682), .C(rd_data[2]), 
         .Z(n6297)) /* synthesis lut_function=(A+(B+(C))) */ ;   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/communicationlayer.v(74[8:17])
    defparam i5089_2_lut_3_lut.init = 16'hfefe;
    LUT4 i5241_3_lut_4_lut (.A(n6533), .B(n6694), .C(rd_data[3]), .D(n6206), 
         .Z(n6337)) /* synthesis lut_function=(!(A (D)+!A (B (D)+!B (C (D))))) */ ;
    defparam i5241_3_lut_4_lut.init = 16'h01ff;
    FD1P3IX mem_burst_cnt__i2 (.D(n2776), .SP(CLK_EXT_c_enable_90), .CD(ENABLE_N_2), 
            .CK(CLK_EXT_c), .Q(mem_burst_cnt[2])) /* synthesis LSE_LINE_FILE_ID=3, LSE_LCOL=22, LSE_RCOL=4, LSE_LLINE=43, LSE_RLINE=58 */ ;   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/communicationlayer.v(35[7] 150[4])
    defparam mem_burst_cnt__i2.GSR = "DISABLED";
    LUT4 i1_3_lut_4_lut (.A(n610[9]), .B(spi_csn_c), .C(mem_clk), .D(n610[0]), 
         .Z(n6257)) /* synthesis lut_function=(!(A (B (C+!(D)))+!A (C+!(D)))) */ ;   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/communicationlayer.v(46[7] 149[5])
    defparam i1_3_lut_4_lut.init = 16'h2f22;
    FD1P3IX mem_burst_cnt__i1 (.D(n2782), .SP(CLK_EXT_c_enable_91), .CD(ENABLE_N_2), 
            .CK(CLK_EXT_c), .Q(mem_burst_cnt[1])) /* synthesis LSE_LINE_FILE_ID=3, LSE_LCOL=22, LSE_RCOL=4, LSE_LLINE=43, LSE_RLINE=58 */ ;   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/communicationlayer.v(35[7] 150[4])
    defparam mem_burst_cnt__i1.GSR = "DISABLED";
    FD1S3IX main_sm_FSM_i9 (.D(n6232), .CK(CLK_EXT_c), .CD(ENABLE_N_2), 
            .Q(n610[11]));   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/communicationlayer.v(50[3] 148[10])
    defparam main_sm_FSM_i9.GSR = "DISABLED";
    LUT4 i1_2_lut_rep_82 (.A(rd_data[2]), .B(rd_data[1]), .Z(n6698)) /* synthesis lut_function=(A+(B)) */ ;   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/communicationlayer.v(71[8] 78[15])
    defparam i1_2_lut_rep_82.init = 16'heeee;
    LUT4 i4_4_lut (.A(\spi_cmd[3] ), .B(n6693), .C(n610[5]), .D(n6287), 
         .Z(ENABLE_N_135)) /* synthesis lut_function=(!(A+(((D)+!C)+!B))) */ ;
    defparam i4_4_lut.init = 16'h0040;
    LUT4 i5079_2_lut (.A(spi_cmd[1]), .B(spi_cmd[0]), .Z(n6287)) /* synthesis lut_function=(A+(B)) */ ;
    defparam i5079_2_lut.init = 16'heeee;
    LUT4 i7_4_lut (.A(rd_data[5]), .B(rd_data[13]), .C(rd_data[15]), .D(rd_data[12]), 
         .Z(n17)) /* synthesis lut_function=(A+(B+(C+(D)))) */ ;   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/communicationlayer.v(76[8:17])
    defparam i7_4_lut.init = 16'hfffe;
    LUT4 i1_2_lut_3_lut_4_lut_adj_7 (.A(n610[0]), .B(n610[11]), .C(n810[4]), 
         .D(MEM_CLK_N_130), .Z(n2703)) /* synthesis lut_function=(A (C (D))+!A (B (C (D)))) */ ;   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/communicationlayer.v(50[3] 148[10])
    defparam i1_2_lut_3_lut_4_lut_adj_7.init = 16'he000;
    LUT4 i54_3_lut_4_lut (.A(rd_data[2]), .B(rd_data[1]), .C(rd_data[3]), 
         .D(n5203), .Z(n43)) /* synthesis lut_function=(!(A (C+(D))+!A (B (C+(D))+!B ((D)+!C)))) */ ;   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/communicationlayer.v(71[8] 78[15])
    defparam i54_3_lut_4_lut.init = 16'h001e;
    LUT4 i2_3_lut_4_lut (.A(rd_data[2]), .B(rd_data[1]), .C(rd_data[7]), 
         .D(n5203), .Z(n5967)) /* synthesis lut_function=(!(A (C+(D))+!A ((C+(D))+!B))) */ ;   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/communicationlayer.v(71[8] 78[15])
    defparam i2_3_lut_4_lut.init = 16'h000e;
    LUT4 i1_2_lut_3_lut_4_lut_adj_8 (.A(n610[0]), .B(n610[11]), .C(n810[5]), 
         .D(MEM_CLK_N_130), .Z(n2672)) /* synthesis lut_function=(A (C (D))+!A (B (C (D)))) */ ;   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/communicationlayer.v(50[3] 148[10])
    defparam i1_2_lut_3_lut_4_lut_adj_8.init = 16'he000;
    LUT4 i5251_3_lut (.A(n2242_c), .B(n3990), .C(n6257), .Z(CLK_EXT_c_enable_99)) /* synthesis lut_function=(!(A (B+(C)))) */ ;   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/communicationlayer.v(46[7] 149[5])
    defparam i5251_3_lut.init = 16'h5757;
    LUT4 i1_2_lut_rep_83 (.A(counter_15__N_193[15]), .B(spi_csn_c), .Z(n6699)) /* synthesis lut_function=(!((B)+!A)) */ ;   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/communicationlayer.v(50[3] 148[10])
    defparam i1_2_lut_rep_83.init = 16'h2222;
    LUT4 i3034_4_lut (.A(n6683), .B(n5180), .C(n610[8]), .D(n6254), 
         .Z(n3990)) /* synthesis lut_function=(A (B (C (D))+!B (C))+!A (((D)+!C)+!B)) */ ;
    defparam i3034_4_lut.init = 16'hf535;
    LUT4 i1_2_lut_3_lut_4_lut_adj_9 (.A(n610[0]), .B(n610[11]), .C(n810[0]), 
         .D(MEM_CLK_N_130), .Z(n6223)) /* synthesis lut_function=(A (C (D))+!A (B (C (D)))) */ ;   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/communicationlayer.v(50[3] 148[10])
    defparam i1_2_lut_3_lut_4_lut_adj_9.init = 16'he000;
    LUT4 i1_2_lut_3_lut (.A(counter_15__N_193[15]), .B(spi_csn_c), .C(n616), 
         .Z(n6232)) /* synthesis lut_function=(!((B+!(C))+!A)) */ ;   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/communicationlayer.v(50[3] 148[10])
    defparam i1_2_lut_3_lut.init = 16'h2020;
    LUT4 i30_2_lut_rep_76 (.A(spi_cmd[0]), .B(spi_cmd[1]), .Z(n6692)) /* synthesis lut_function=(!(A (B)+!A !(B))) */ ;   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/communicationlayer.v(108[27] 118[34])
    defparam i30_2_lut_rep_76.init = 16'h6666;
    FD1S3IX main_sm_FSM_i8 (.D(n4064), .CK(CLK_EXT_c), .CD(ENABLE_N_2), 
            .Q(n616));   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/communicationlayer.v(50[3] 148[10])
    defparam main_sm_FSM_i8.GSR = "DISABLED";
    FD1S3IX main_sm_FSM_i7 (.D(n6003), .CK(CLK_EXT_c), .CD(ENABLE_N_2), 
            .Q(n610[9]));   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/communicationlayer.v(50[3] 148[10])
    defparam main_sm_FSM_i7.GSR = "DISABLED";
    FD1S3IX main_sm_FSM_i6 (.D(n2494), .CK(CLK_EXT_c), .CD(ENABLE_N_2), 
            .Q(n610[8]));   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/communicationlayer.v(50[3] 148[10])
    defparam main_sm_FSM_i6.GSR = "DISABLED";
    FD1S3IX main_sm_FSM_i5 (.D(n2492), .CK(CLK_EXT_c), .CD(ENABLE_N_2), 
            .Q(n610[7]));   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/communicationlayer.v(50[3] 148[10])
    defparam main_sm_FSM_i5.GSR = "DISABLED";
    FD1S3IX main_sm_FSM_i4 (.D(n610[4]), .CK(CLK_EXT_c), .CD(ENABLE_N_2), 
            .Q(n610[5]));   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/communicationlayer.v(50[3] 148[10])
    defparam main_sm_FSM_i4.GSR = "DISABLED";
    FD1S3IX main_sm_FSM_i3 (.D(n658), .CK(CLK_EXT_c), .CD(ENABLE_N_2), 
            .Q(n610[4]));   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/communicationlayer.v(50[3] 148[10])
    defparam main_sm_FSM_i3.GSR = "DISABLED";
    FD1S3IX main_sm_FSM_i2 (.D(n3015), .CK(CLK_EXT_c), .CD(ENABLE_N_2), 
            .Q(n610[3]));   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/communicationlayer.v(50[3] 148[10])
    defparam main_sm_FSM_i2.GSR = "DISABLED";
    FD1S3JX spi_cmd_i3 (.D(n4418), .CK(CLK_EXT_c), .PD(ENABLE_N_2), .Q(\spi_cmd[3] )) /* synthesis LSE_LINE_FILE_ID=3, LSE_LCOL=22, LSE_RCOL=4, LSE_LLINE=43, LSE_RLINE=58 */ ;   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/communicationlayer.v(35[7] 150[4])
    defparam spi_cmd_i3.GSR = "DISABLED";
    FD1S3IX spi_cmd_i2 (.D(n4422), .CK(CLK_EXT_c), .CD(ENABLE_N_2), .Q(spi_cmd[2])) /* synthesis LSE_LINE_FILE_ID=3, LSE_LCOL=22, LSE_RCOL=4, LSE_LLINE=43, LSE_RLINE=58 */ ;   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/communicationlayer.v(35[7] 150[4])
    defparam spi_cmd_i2.GSR = "DISABLED";
    FD1S3JX spi_cmd_i1 (.D(n4420), .CK(CLK_EXT_c), .PD(ENABLE_N_2), .Q(spi_cmd[1])) /* synthesis LSE_LINE_FILE_ID=3, LSE_LCOL=22, LSE_RCOL=4, LSE_LLINE=43, LSE_RLINE=58 */ ;   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/communicationlayer.v(35[7] 150[4])
    defparam spi_cmd_i1.GSR = "DISABLED";
    FD1S3IX dataOut_i14 (.D(dataOut_15__N_94[14]), .CK(CLK_EXT_c), .CD(ENABLE_N_2), 
            .Q(dataOut[14])) /* synthesis LSE_LINE_FILE_ID=3, LSE_LCOL=22, LSE_RCOL=4, LSE_LLINE=43, LSE_RLINE=58 */ ;   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/communicationlayer.v(35[7] 150[4])
    defparam dataOut_i14.GSR = "DISABLED";
    FD1S3IX dataOut_i13 (.D(dataOut_15__N_94[13]), .CK(CLK_EXT_c), .CD(ENABLE_N_2), 
            .Q(dataOut[13])) /* synthesis LSE_LINE_FILE_ID=3, LSE_LCOL=22, LSE_RCOL=4, LSE_LLINE=43, LSE_RLINE=58 */ ;   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/communicationlayer.v(35[7] 150[4])
    defparam dataOut_i13.GSR = "DISABLED";
    FD1S3IX dataOut_i12 (.D(dataOut_15__N_94[12]), .CK(CLK_EXT_c), .CD(ENABLE_N_2), 
            .Q(dataOut[12])) /* synthesis LSE_LINE_FILE_ID=3, LSE_LCOL=22, LSE_RCOL=4, LSE_LLINE=43, LSE_RLINE=58 */ ;   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/communicationlayer.v(35[7] 150[4])
    defparam dataOut_i12.GSR = "DISABLED";
    FD1S3IX dataOut_i11 (.D(dataOut_15__N_94[11]), .CK(CLK_EXT_c), .CD(ENABLE_N_2), 
            .Q(dataOut[11])) /* synthesis LSE_LINE_FILE_ID=3, LSE_LCOL=22, LSE_RCOL=4, LSE_LLINE=43, LSE_RLINE=58 */ ;   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/communicationlayer.v(35[7] 150[4])
    defparam dataOut_i11.GSR = "DISABLED";
    FD1S3IX dataOut_i10 (.D(dataOut_15__N_94[10]), .CK(CLK_EXT_c), .CD(ENABLE_N_2), 
            .Q(dataOut[10])) /* synthesis LSE_LINE_FILE_ID=3, LSE_LCOL=22, LSE_RCOL=4, LSE_LLINE=43, LSE_RLINE=58 */ ;   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/communicationlayer.v(35[7] 150[4])
    defparam dataOut_i10.GSR = "DISABLED";
    FD1S3IX dataOut_i9 (.D(dataOut_15__N_94[9]), .CK(CLK_EXT_c), .CD(ENABLE_N_2), 
            .Q(dataOut[9])) /* synthesis LSE_LINE_FILE_ID=3, LSE_LCOL=22, LSE_RCOL=4, LSE_LLINE=43, LSE_RLINE=58 */ ;   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/communicationlayer.v(35[7] 150[4])
    defparam dataOut_i9.GSR = "DISABLED";
    LUT4 mux_698_i1_4_lut (.A(n800[0]), .B(rd_data[0]), .C(n1619), .D(n1607), 
         .Z(n1620[0])) /* synthesis lut_function=(A (B (C+(D))+!B !(C+!(D)))+!A (B (C))) */ ;   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/communicationlayer.v(46[7] 149[5])
    defparam mux_698_i1_4_lut.init = 16'hcac0;
    LUT4 mux_698_i3_4_lut (.A(n800[2]), .B(rd_data[2]), .C(n1619), .D(n1607), 
         .Z(n1620[2])) /* synthesis lut_function=(A (B (C+(D))+!B !(C+!(D)))+!A (B (C))) */ ;   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/communicationlayer.v(46[7] 149[5])
    defparam mux_698_i3_4_lut.init = 16'hcac0;
    FD1S3IX dataOut_i8 (.D(dataOut_15__N_94[8]), .CK(CLK_EXT_c), .CD(ENABLE_N_2), 
            .Q(dataOut[8])) /* synthesis LSE_LINE_FILE_ID=3, LSE_LCOL=22, LSE_RCOL=4, LSE_LLINE=43, LSE_RLINE=58 */ ;   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/communicationlayer.v(35[7] 150[4])
    defparam dataOut_i8.GSR = "DISABLED";
    FD1S3IX dataOut_i7 (.D(dataOut_15__N_94[7]), .CK(CLK_EXT_c), .CD(ENABLE_N_2), 
            .Q(dataOut[7])) /* synthesis LSE_LINE_FILE_ID=3, LSE_LCOL=22, LSE_RCOL=4, LSE_LLINE=43, LSE_RLINE=58 */ ;   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/communicationlayer.v(35[7] 150[4])
    defparam dataOut_i7.GSR = "DISABLED";
    FD1S3IX dataOut_i6 (.D(dataOut_15__N_94[6]), .CK(CLK_EXT_c), .CD(ENABLE_N_2), 
            .Q(dataOut[6])) /* synthesis LSE_LINE_FILE_ID=3, LSE_LCOL=22, LSE_RCOL=4, LSE_LLINE=43, LSE_RLINE=58 */ ;   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/communicationlayer.v(35[7] 150[4])
    defparam dataOut_i6.GSR = "DISABLED";
    FD1S3IX dataOut_i5 (.D(dataOut_15__N_94[5]), .CK(CLK_EXT_c), .CD(ENABLE_N_2), 
            .Q(dataOut[5])) /* synthesis LSE_LINE_FILE_ID=3, LSE_LCOL=22, LSE_RCOL=4, LSE_LLINE=43, LSE_RLINE=58 */ ;   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/communicationlayer.v(35[7] 150[4])
    defparam dataOut_i5.GSR = "DISABLED";
    FD1S3IX dataOut_i4 (.D(dataOut_15__N_94[4]), .CK(CLK_EXT_c), .CD(ENABLE_N_2), 
            .Q(dataOut[4])) /* synthesis LSE_LINE_FILE_ID=3, LSE_LCOL=22, LSE_RCOL=4, LSE_LLINE=43, LSE_RLINE=58 */ ;   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/communicationlayer.v(35[7] 150[4])
    defparam dataOut_i4.GSR = "DISABLED";
    FD1S3JX dataOut_i3 (.D(mem_rdata[3]), .CK(CLK_EXT_c), .PD(n4424), 
            .Q(dataOut[3])) /* synthesis LSE_LINE_FILE_ID=3, LSE_LCOL=22, LSE_RCOL=4, LSE_LLINE=43, LSE_RLINE=58 */ ;   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/communicationlayer.v(35[7] 150[4])
    defparam dataOut_i3.GSR = "DISABLED";
    FD1S3IX dataOut_i2 (.D(dataOut_15__N_94[2]), .CK(CLK_EXT_c), .CD(ENABLE_N_2), 
            .Q(dataOut[2])) /* synthesis LSE_LINE_FILE_ID=3, LSE_LCOL=22, LSE_RCOL=4, LSE_LLINE=43, LSE_RLINE=58 */ ;   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/communicationlayer.v(35[7] 150[4])
    defparam dataOut_i2.GSR = "DISABLED";
    FD1S3JX dataOut_i1 (.D(mem_rdata[1]), .CK(CLK_EXT_c), .PD(n4424), 
            .Q(dataOut[1])) /* synthesis LSE_LINE_FILE_ID=3, LSE_LCOL=22, LSE_RCOL=4, LSE_LLINE=43, LSE_RLINE=58 */ ;   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/communicationlayer.v(35[7] 150[4])
    defparam dataOut_i1.GSR = "DISABLED";
    FD1S3AX MEM_WDATA_i15 (.D(n4387), .CK(CLK_EXT_c), .Q(mem_wdata[15])) /* synthesis LSE_LINE_FILE_ID=3, LSE_LCOL=22, LSE_RCOL=4, LSE_LLINE=43, LSE_RLINE=58 */ ;   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/communicationlayer.v(35[7] 150[4])
    defparam MEM_WDATA_i15.GSR = "DISABLED";
    FD1S3AX MEM_WDATA_i14 (.D(n4385), .CK(CLK_EXT_c), .Q(mem_wdata[14])) /* synthesis LSE_LINE_FILE_ID=3, LSE_LCOL=22, LSE_RCOL=4, LSE_LLINE=43, LSE_RLINE=58 */ ;   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/communicationlayer.v(35[7] 150[4])
    defparam MEM_WDATA_i14.GSR = "DISABLED";
    FD1S3AX MEM_WDATA_i13 (.D(n4383), .CK(CLK_EXT_c), .Q(mem_wdata[13])) /* synthesis LSE_LINE_FILE_ID=3, LSE_LCOL=22, LSE_RCOL=4, LSE_LLINE=43, LSE_RLINE=58 */ ;   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/communicationlayer.v(35[7] 150[4])
    defparam MEM_WDATA_i13.GSR = "DISABLED";
    FD1S3AX MEM_WDATA_i12 (.D(n4381), .CK(CLK_EXT_c), .Q(mem_wdata[12])) /* synthesis LSE_LINE_FILE_ID=3, LSE_LCOL=22, LSE_RCOL=4, LSE_LLINE=43, LSE_RLINE=58 */ ;   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/communicationlayer.v(35[7] 150[4])
    defparam MEM_WDATA_i12.GSR = "DISABLED";
    FD1S3AX MEM_WDATA_i11 (.D(n4379), .CK(CLK_EXT_c), .Q(mem_wdata[11])) /* synthesis LSE_LINE_FILE_ID=3, LSE_LCOL=22, LSE_RCOL=4, LSE_LLINE=43, LSE_RLINE=58 */ ;   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/communicationlayer.v(35[7] 150[4])
    defparam MEM_WDATA_i11.GSR = "DISABLED";
    FD1S3AX MEM_WDATA_i10 (.D(n4377), .CK(CLK_EXT_c), .Q(mem_wdata[10])) /* synthesis LSE_LINE_FILE_ID=3, LSE_LCOL=22, LSE_RCOL=4, LSE_LLINE=43, LSE_RLINE=58 */ ;   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/communicationlayer.v(35[7] 150[4])
    defparam MEM_WDATA_i10.GSR = "DISABLED";
    FD1S3AX MEM_WDATA_i9 (.D(n4375), .CK(CLK_EXT_c), .Q(mem_wdata[9])) /* synthesis LSE_LINE_FILE_ID=3, LSE_LCOL=22, LSE_RCOL=4, LSE_LLINE=43, LSE_RLINE=58 */ ;   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/communicationlayer.v(35[7] 150[4])
    defparam MEM_WDATA_i9.GSR = "DISABLED";
    FD1S3AX MEM_WDATA_i8 (.D(n4373), .CK(CLK_EXT_c), .Q(mem_wdata[8])) /* synthesis LSE_LINE_FILE_ID=3, LSE_LCOL=22, LSE_RCOL=4, LSE_LLINE=43, LSE_RLINE=58 */ ;   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/communicationlayer.v(35[7] 150[4])
    defparam MEM_WDATA_i8.GSR = "DISABLED";
    FD1S3AX MEM_WDATA_i7 (.D(n4371), .CK(CLK_EXT_c), .Q(mem_wdata[7])) /* synthesis LSE_LINE_FILE_ID=3, LSE_LCOL=22, LSE_RCOL=4, LSE_LLINE=43, LSE_RLINE=58 */ ;   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/communicationlayer.v(35[7] 150[4])
    defparam MEM_WDATA_i7.GSR = "DISABLED";
    FD1S3AX MEM_WDATA_i6 (.D(n4367), .CK(CLK_EXT_c), .Q(mem_wdata[6])) /* synthesis LSE_LINE_FILE_ID=3, LSE_LCOL=22, LSE_RCOL=4, LSE_LLINE=43, LSE_RLINE=58 */ ;   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/communicationlayer.v(35[7] 150[4])
    defparam MEM_WDATA_i6.GSR = "DISABLED";
    FD1S3AX MEM_WDATA_i5 (.D(n4365), .CK(CLK_EXT_c), .Q(mem_wdata[5])) /* synthesis LSE_LINE_FILE_ID=3, LSE_LCOL=22, LSE_RCOL=4, LSE_LLINE=43, LSE_RLINE=58 */ ;   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/communicationlayer.v(35[7] 150[4])
    defparam MEM_WDATA_i5.GSR = "DISABLED";
    FD1S3AX MEM_WDATA_i4 (.D(n4363), .CK(CLK_EXT_c), .Q(mem_wdata[4])) /* synthesis LSE_LINE_FILE_ID=3, LSE_LCOL=22, LSE_RCOL=4, LSE_LLINE=43, LSE_RLINE=58 */ ;   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/communicationlayer.v(35[7] 150[4])
    defparam MEM_WDATA_i4.GSR = "DISABLED";
    FD1S3AX MEM_WDATA_i3 (.D(n4361), .CK(CLK_EXT_c), .Q(mem_wdata[3])) /* synthesis LSE_LINE_FILE_ID=3, LSE_LCOL=22, LSE_RCOL=4, LSE_LLINE=43, LSE_RLINE=58 */ ;   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/communicationlayer.v(35[7] 150[4])
    defparam MEM_WDATA_i3.GSR = "DISABLED";
    FD1S3AX MEM_WDATA_i2 (.D(n4337), .CK(CLK_EXT_c), .Q(mem_wdata[2])) /* synthesis LSE_LINE_FILE_ID=3, LSE_LCOL=22, LSE_RCOL=4, LSE_LLINE=43, LSE_RLINE=58 */ ;   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/communicationlayer.v(35[7] 150[4])
    defparam MEM_WDATA_i2.GSR = "DISABLED";
    FD1S3AX MEM_WDATA_i1 (.D(n4351), .CK(CLK_EXT_c), .Q(mem_wdata[1])) /* synthesis LSE_LINE_FILE_ID=3, LSE_LCOL=22, LSE_RCOL=4, LSE_LLINE=43, LSE_RLINE=58 */ ;   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/communicationlayer.v(35[7] 150[4])
    defparam MEM_WDATA_i1.GSR = "DISABLED";
    LUT4 i1_2_lut_3_lut_4_lut_adj_10 (.A(n610[0]), .B(n610[11]), .C(n810[1]), 
         .D(MEM_CLK_N_130), .Z(n2782)) /* synthesis lut_function=(A (C (D))+!A (B (C (D)))) */ ;   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/communicationlayer.v(50[3] 148[10])
    defparam i1_2_lut_3_lut_4_lut_adj_10.init = 16'he000;
    LUT4 i2_2_lut_rep_67_3_lut (.A(n610[0]), .B(n610[11]), .C(n610[9]), 
         .Z(n6683)) /* synthesis lut_function=(A+(B+(C))) */ ;   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/communicationlayer.v(50[3] 148[10])
    defparam i2_2_lut_rep_67_3_lut.init = 16'hfefe;
    FD1P3AX MEM_ADDR_i0_i1 (.D(n1620[1]), .SP(CLK_EXT_c_enable_99), .CK(CLK_EXT_c), 
            .Q(mem_addr[1])) /* synthesis LSE_LINE_FILE_ID=3, LSE_LCOL=22, LSE_RCOL=4, LSE_LLINE=43, LSE_RLINE=58 */ ;   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/communicationlayer.v(35[7] 150[4])
    defparam MEM_ADDR_i0_i1.GSR = "DISABLED";
    LUT4 mux_698_i4_4_lut (.A(n800[3]), .B(rd_data[3]), .C(n1619), .D(n1607), 
         .Z(n1620[3])) /* synthesis lut_function=(A (B (C+(D))+!B !(C+!(D)))+!A (B (C))) */ ;   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/communicationlayer.v(46[7] 149[5])
    defparam mux_698_i4_4_lut.init = 16'hcac0;
    LUT4 i842_2_lut_rep_73 (.A(spi_cmd[2]), .B(spi_cmd[0]), .Z(n6689)) /* synthesis lut_function=(A (B)) */ ;   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/communicationlayer.v(81[8] 102[15])
    defparam i842_2_lut_rep_73.init = 16'h8888;
    LUT4 i6_4_lut (.A(rd_data[9]), .B(rd_data[14]), .C(rd_data[11]), .D(rd_data[6]), 
         .Z(n16)) /* synthesis lut_function=(A+(B+(C+(D)))) */ ;   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/communicationlayer.v(76[8:17])
    defparam i6_4_lut.init = 16'hfffe;
    LUT4 i6_4_lut_adj_11 (.A(mem_burst_cnt[2]), .B(n12), .C(n8), .D(mem_burst_cnt[0]), 
         .Z(MEM_CLK_N_130)) /* synthesis lut_function=((B+(C+!(D)))+!A) */ ;   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/communicationlayer.v(35[7] 150[4])
    defparam i6_4_lut_adj_11.init = 16'hfdff;
    LUT4 i4009_2_lut (.A(spi_cmd[1]), .B(n610[0]), .Z(n4419)) /* synthesis lut_function=(A+(B)) */ ;   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/communicationlayer.v(35[7] 150[4])
    defparam i4009_2_lut.init = 16'heeee;
    LUT4 i5_4_lut (.A(mem_burst_cnt[5]), .B(mem_burst_cnt[3]), .C(mem_burst_cnt[4]), 
         .D(mem_burst_cnt[1]), .Z(n12)) /* synthesis lut_function=(A+(B+(C+(D)))) */ ;   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/communicationlayer.v(35[7] 150[4])
    defparam i5_4_lut.init = 16'hfffe;
    LUT4 i3_4_lut (.A(n2242_c), .B(spi_csn_c), .C(mem_addr[2]), .D(n6216), 
         .Z(n1607)) /* synthesis lut_function=(!((B+(C+!(D)))+!A)) */ ;
    defparam i3_4_lut.init = 16'h0200;
    LUT4 mux_698_i5_4_lut (.A(n800[4]), .B(rd_data[4]), .C(n1619), .D(n1607), 
         .Z(n1620[4])) /* synthesis lut_function=(A (B (C+(D))+!B !(C+!(D)))+!A (B (C))) */ ;   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/communicationlayer.v(46[7] 149[5])
    defparam mux_698_i5_4_lut.init = 16'hcac0;
    LUT4 mux_698_i6_4_lut (.A(n800[5]), .B(rd_data[5]), .C(n1619), .D(n1607), 
         .Z(n1620[5])) /* synthesis lut_function=(A (B (C+(D))+!B !(C+!(D)))+!A (B (C))) */ ;   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/communicationlayer.v(46[7] 149[5])
    defparam mux_698_i6_4_lut.init = 16'hcac0;
    LUT4 mux_698_i7_4_lut (.A(n800[6]), .B(rd_data[6]), .C(n1619), .D(n1607), 
         .Z(n1620[6])) /* synthesis lut_function=(A (B (C+(D))+!B !(C+!(D)))+!A (B (C))) */ ;   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/communicationlayer.v(46[7] 149[5])
    defparam mux_698_i7_4_lut.init = 16'hcac0;
    LUT4 mux_698_i8_4_lut (.A(n800[7]), .B(rd_data[7]), .C(n1619), .D(n1607), 
         .Z(n1620[7])) /* synthesis lut_function=(A (B (C+(D))+!B !(C+!(D)))+!A (B (C))) */ ;   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/communicationlayer.v(46[7] 149[5])
    defparam mux_698_i8_4_lut.init = 16'hcac0;
    FD1P3AX MEM_ADDR_i0_i2 (.D(n1620[2]), .SP(CLK_EXT_c_enable_99), .CK(CLK_EXT_c), 
            .Q(mem_addr[2])) /* synthesis LSE_LINE_FILE_ID=3, LSE_LCOL=22, LSE_RCOL=4, LSE_LLINE=43, LSE_RLINE=58 */ ;   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/communicationlayer.v(35[7] 150[4])
    defparam MEM_ADDR_i0_i2.GSR = "DISABLED";
    FD1P3AX MEM_ADDR_i0_i3 (.D(n1620[3]), .SP(CLK_EXT_c_enable_99), .CK(CLK_EXT_c), 
            .Q(mem_addr_c[3])) /* synthesis LSE_LINE_FILE_ID=3, LSE_LCOL=22, LSE_RCOL=4, LSE_LLINE=43, LSE_RLINE=58 */ ;   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/communicationlayer.v(35[7] 150[4])
    defparam MEM_ADDR_i0_i3.GSR = "DISABLED";
    FD1P3AX MEM_ADDR_i0_i4 (.D(n1620[4]), .SP(CLK_EXT_c_enable_99), .CK(CLK_EXT_c), 
            .Q(mem_addr_c[4])) /* synthesis LSE_LINE_FILE_ID=3, LSE_LCOL=22, LSE_RCOL=4, LSE_LLINE=43, LSE_RLINE=58 */ ;   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/communicationlayer.v(35[7] 150[4])
    defparam MEM_ADDR_i0_i4.GSR = "DISABLED";
    FD1P3AX MEM_ADDR_i0_i5 (.D(n1620[5]), .SP(CLK_EXT_c_enable_99), .CK(CLK_EXT_c), 
            .Q(mem_addr_c[5])) /* synthesis LSE_LINE_FILE_ID=3, LSE_LCOL=22, LSE_RCOL=4, LSE_LLINE=43, LSE_RLINE=58 */ ;   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/communicationlayer.v(35[7] 150[4])
    defparam MEM_ADDR_i0_i5.GSR = "DISABLED";
    FD1P3AX MEM_ADDR_i0_i6 (.D(n1620[6]), .SP(CLK_EXT_c_enable_99), .CK(CLK_EXT_c), 
            .Q(mem_addr_c[6])) /* synthesis LSE_LINE_FILE_ID=3, LSE_LCOL=22, LSE_RCOL=4, LSE_LLINE=43, LSE_RLINE=58 */ ;   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/communicationlayer.v(35[7] 150[4])
    defparam MEM_ADDR_i0_i6.GSR = "DISABLED";
    FD1P3AX MEM_ADDR_i0_i7 (.D(n1620[7]), .SP(CLK_EXT_c_enable_99), .CK(CLK_EXT_c), 
            .Q(mem_addr_c[7])) /* synthesis LSE_LINE_FILE_ID=3, LSE_LCOL=22, LSE_RCOL=4, LSE_LLINE=43, LSE_RLINE=58 */ ;   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/communicationlayer.v(35[7] 150[4])
    defparam MEM_ADDR_i0_i7.GSR = "DISABLED";
    LUT4 i1_4_lut (.A(rd_data[4]), .B(n6246), .C(n6323), .D(n8_adj_524), 
         .Z(n6248)) /* synthesis lut_function=(A (B+!((D)+!C))+!A (B)) */ ;
    defparam i1_4_lut.init = 16'hccec;
    LUT4 i5115_4_lut (.A(rd_data[0]), .B(rd_data[1]), .C(rd_data[3]), 
         .D(rd_data[7]), .Z(n6323)) /* synthesis lut_function=(A (B (C (D)))) */ ;
    defparam i5115_4_lut.init = 16'h8000;
    LUT4 i1_2_lut (.A(n4033), .B(rd_data[2]), .Z(n8_adj_524)) /* synthesis lut_function=(A+!(B)) */ ;
    defparam i1_2_lut.init = 16'hbbbb;
    LUT4 i3192_3_lut (.A(mem_rdata[15]), .B(n4386), .C(n2242_c), .Z(n4387)) /* synthesis lut_function=(A (B+!(C))+!A (B (C))) */ ;   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/communicationlayer.v(35[7] 150[4])
    defparam i3192_3_lut.init = 16'hcaca;
    LUT4 i5_4_lut_adj_12 (.A(mem_addr_c[3]), .B(n7), .C(mem_addr_c[5]), 
         .D(n6309), .Z(n6216)) /* synthesis lut_function=(!(A+((C+(D))+!B))) */ ;
    defparam i5_4_lut_adj_12.init = 16'h0004;
    CCU2D add_130_9 (.A0(mem_addr_c[7]), .B0(GND_net), .C0(GND_net), .D0(GND_net), 
          .A1(GND_net), .B1(GND_net), .C1(GND_net), .D1(GND_net), .CIN(n5943), 
          .S0(n800[7]));   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/communicationlayer.v(143[71:83])
    defparam add_130_9.INIT0 = 16'h5aaa;
    defparam add_130_9.INIT1 = 16'h0000;
    defparam add_130_9.INJECT1_0 = "NO";
    defparam add_130_9.INJECT1_1 = "NO";
    LUT4 i1_4_lut_adj_13 (.A(mem_addr_c[4]), .B(n610[0]), .C(n610[11]), 
         .D(mem_clk), .Z(n7)) /* synthesis lut_function=(!(A+!(B (C+(D))+!B (C)))) */ ;
    defparam i1_4_lut_adj_13.init = 16'h5450;
    CCU2D add_130_7 (.A0(mem_addr_c[5]), .B0(GND_net), .C0(GND_net), .D0(GND_net), 
          .A1(mem_addr_c[6]), .B1(GND_net), .C1(GND_net), .D1(GND_net), 
          .CIN(n5942), .COUT(n5943), .S0(n800[5]), .S1(n800[6]));   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/communicationlayer.v(143[71:83])
    defparam add_130_7.INIT0 = 16'h5aaa;
    defparam add_130_7.INIT1 = 16'h5aaa;
    defparam add_130_7.INJECT1_0 = "NO";
    defparam add_130_7.INJECT1_1 = "NO";
    LUT4 i2_3_lut (.A(spi_csn_c), .B(n4), .C(n610[11]), .Z(n6003)) /* synthesis lut_function=(A (B)+!A (B+(C))) */ ;   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/communicationlayer.v(50[3] 148[10])
    defparam i2_3_lut.init = 16'hdcdc;
    LUT4 i1_4_lut_then_4_lut (.A(n610[5]), .B(spi_cmd[0]), .C(spi_cmd[2]), 
         .D(\spi_cmd[3] ), .Z(n6896)) /* synthesis lut_function=(A (B+((D)+!C))) */ ;   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/communicationlayer.v(50[3] 148[10])
    defparam i1_4_lut_then_4_lut.init = 16'haa8a;
    LUT4 i3191_3_lut (.A(mem_wdata[15]), .B(rd_data[15]), .C(n6043), .Z(n4386)) /* synthesis lut_function=(A (B+(C))+!A !((C)+!B)) */ ;   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/communicationlayer.v(35[7] 150[4])
    defparam i3191_3_lut.init = 16'hacac;
    LUT4 i1328_4_lut (.A(n610[8]), .B(counter_15__N_193[15]), .C(n9), 
         .D(n610[7]), .Z(n2494)) /* synthesis lut_function=(!(A (B (C))+!A (B+!(D)))) */ ;   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/communicationlayer.v(50[3] 148[10])
    defparam i1328_4_lut.init = 16'h3b2a;
    LUT4 i5101_2_lut (.A(mem_addr_c[6]), .B(mem_addr_c[7]), .Z(n6309)) /* synthesis lut_function=(A+(B)) */ ;
    defparam i5101_2_lut.init = 16'heeee;
    CCU2D add_130_5 (.A0(mem_addr_c[3]), .B0(GND_net), .C0(GND_net), .D0(GND_net), 
          .A1(mem_addr_c[4]), .B1(GND_net), .C1(GND_net), .D1(GND_net), 
          .CIN(n5941), .COUT(n5942), .S0(n800[3]), .S1(n800[4]));   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/communicationlayer.v(143[71:83])
    defparam add_130_5.INIT0 = 16'h5aaa;
    defparam add_130_5.INIT1 = 16'h5aaa;
    defparam add_130_5.INJECT1_0 = "NO";
    defparam add_130_5.INJECT1_1 = "NO";
    LUT4 i1145_2_lut_rep_65_3_lut_4_lut (.A(spi_cmd[2]), .B(spi_cmd[0]), 
         .C(counter_15__N_193[15]), .D(n6690), .Z(n6681)) /* synthesis lut_function=(!((((D)+!C)+!B)+!A)) */ ;   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/communicationlayer.v(81[8] 102[15])
    defparam i1145_2_lut_rep_65_3_lut_4_lut.init = 16'h0080;
    LUT4 i5235_2_lut_4_lut (.A(n610[5]), .B(n6257), .C(n6683), .D(n2242_c), 
         .Z(CLK_EXT_c_enable_91)) /* synthesis lut_function=(!(A (B (D))+!A (B (D)+!B !(C+!(D))))) */ ;
    defparam i5235_2_lut_4_lut.init = 16'h32ff;
    LUT4 i5218_4_lut_else_1_lut (.A(n6894), .B(n610[5]), .C(spi_cmd[1]), 
         .D(\spi_cmd[3] ), .Z(n6700)) /* synthesis lut_function=(!(A ((C+(D))+!B))) */ ;
    defparam i5218_4_lut_else_1_lut.init = 16'h555d;
    LUT4 i3190_3_lut (.A(mem_rdata[14]), .B(n4384), .C(n2242_c), .Z(n4385)) /* synthesis lut_function=(A (B+!(C))+!A (B (C))) */ ;   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/communicationlayer.v(35[7] 150[4])
    defparam i3190_3_lut.init = 16'hcaca;
    LUT4 i3961_2_lut (.A(spi_cmd[0]), .B(n610[0]), .Z(n4408)) /* synthesis lut_function=(A+(B)) */ ;   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/communicationlayer.v(35[7] 150[4])
    defparam i3961_2_lut.init = 16'heeee;
    LUT4 i1_2_lut_adj_14 (.A(spi_cmd[2]), .B(\spi_cmd[3] ), .Z(n6254)) /* synthesis lut_function=((B)+!A) */ ;
    defparam i1_2_lut_adj_14.init = 16'hdddd;
    LUT4 i3189_3_lut (.A(mem_wdata[14]), .B(rd_data[14]), .C(n6043), .Z(n4384)) /* synthesis lut_function=(A (B+(C))+!A !((C)+!B)) */ ;   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/communicationlayer.v(35[7] 150[4])
    defparam i3189_3_lut.init = 16'hacac;
    LUT4 i1326_4_lut (.A(n610[7]), .B(n5095), .C(n6699), .D(n610[5]), 
         .Z(n2492)) /* synthesis lut_function=(A (B (C)+!B (C+(D)))+!A !(B+!(D))) */ ;   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/communicationlayer.v(50[3] 148[10])
    defparam i1326_4_lut.init = 16'hb3a0;
    LUT4 i3965_2_lut_3_lut_4_lut (.A(n6695), .B(n610[0]), .C(mem_rdata[4]), 
         .D(n6685), .Z(dataOut_15__N_94[4])) /* synthesis lut_function=(A (C+(D))+!A (B+(C+(D)))) */ ;   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/communicationlayer.v(50[3] 148[10])
    defparam i3965_2_lut_3_lut_4_lut.init = 16'hfff4;
    LUT4 i3188_3_lut (.A(mem_rdata[13]), .B(n4382), .C(n2242_c), .Z(n4383)) /* synthesis lut_function=(A (B+!(C))+!A (B (C))) */ ;   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/communicationlayer.v(35[7] 150[4])
    defparam i3188_3_lut.init = 16'hcaca;
    LUT4 i447_2_lut (.A(counter_15__N_193[15]), .B(n610[3]), .Z(n658)) /* synthesis lut_function=(A (B)) */ ;   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/communicationlayer.v(50[3] 148[10])
    defparam i447_2_lut.init = 16'h8888;
    LUT4 i3187_3_lut (.A(mem_wdata[13]), .B(rd_data[13]), .C(n6043), .Z(n4382)) /* synthesis lut_function=(A (B+(C))+!A !((C)+!B)) */ ;   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/communicationlayer.v(35[7] 150[4])
    defparam i3187_3_lut.init = 16'hacac;
    LUT4 i3186_3_lut (.A(mem_rdata[12]), .B(n4380), .C(n2242_c), .Z(n4381)) /* synthesis lut_function=(A (B+!(C))+!A (B (C))) */ ;   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/communicationlayer.v(35[7] 150[4])
    defparam i3186_3_lut.init = 16'hcaca;
    LUT4 i3185_3_lut (.A(mem_wdata[12]), .B(rd_data[12]), .C(n6043), .Z(n4380)) /* synthesis lut_function=(A (B+(C))+!A !((C)+!B)) */ ;   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/communicationlayer.v(35[7] 150[4])
    defparam i3185_3_lut.init = 16'hacac;
    CCU2D add_130_3 (.A0(mem_addr[1]), .B0(GND_net), .C0(GND_net), .D0(GND_net), 
          .A1(mem_addr[2]), .B1(GND_net), .C1(GND_net), .D1(GND_net), 
          .CIN(n5940), .COUT(n5941), .S0(n800[1]), .S1(n800[2]));   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/communicationlayer.v(143[71:83])
    defparam add_130_3.INIT0 = 16'h5aaa;
    defparam add_130_3.INIT1 = 16'h5aaa;
    defparam add_130_3.INJECT1_0 = "NO";
    defparam add_130_3.INJECT1_1 = "NO";
    CCU2D add_130_1 (.A0(GND_net), .B0(GND_net), .C0(GND_net), .D0(GND_net), 
          .A1(mem_addr[0]), .B1(GND_net), .C1(GND_net), .D1(GND_net), 
          .COUT(n5940), .S1(n800[0]));   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/communicationlayer.v(143[71:83])
    defparam add_130_1.INIT0 = 16'hF000;
    defparam add_130_1.INIT1 = 16'h5555;
    defparam add_130_1.INJECT1_0 = "NO";
    defparam add_130_1.INJECT1_1 = "NO";
    LUT4 i1_2_lut_rep_74 (.A(\spi_cmd[3] ), .B(spi_cmd[1]), .Z(n6690)) /* synthesis lut_function=(A+(B)) */ ;   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/communicationlayer.v(82[8:15])
    defparam i1_2_lut_rep_74.init = 16'heeee;
    CCU2D add_131_9 (.A0(mem_burst_cnt[7]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(GND_net), .B1(GND_net), .C1(GND_net), .D1(GND_net), 
          .CIN(n5939), .S0(n810[7]));   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/communicationlayer.v(144[66:83])
    defparam add_131_9.INIT0 = 16'h5aaa;
    defparam add_131_9.INIT1 = 16'h0000;
    defparam add_131_9.INJECT1_0 = "NO";
    defparam add_131_9.INJECT1_1 = "NO";
    LUT4 i3223_4_lut (.A(\spi_cmd[3] ), .B(n6206), .C(n610[4]), .D(n610[0]), 
         .Z(n4418)) /* synthesis lut_function=(!(A (B (C))+!A (B (C+!(D))+!B !(C+(D))))) */ ;   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/communicationlayer.v(35[7] 150[4])
    defparam i3223_4_lut.init = 16'h3f3a;
    LUT4 i2_2_lut_rep_68_3_lut_4_lut (.A(\spi_cmd[3] ), .B(spi_cmd[1]), 
         .C(spi_cmd[0]), .D(spi_cmd[2]), .Z(n6684)) /* synthesis lut_function=(A+(B+!(C (D)))) */ ;   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/communicationlayer.v(82[8:15])
    defparam i2_2_lut_rep_68_3_lut_4_lut.init = 16'hefff;
    LUT4 i1_2_lut_adj_15 (.A(mem_burst_cnt[6]), .B(mem_burst_cnt[7]), .Z(n8)) /* synthesis lut_function=(A+(B)) */ ;   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/communicationlayer.v(35[7] 150[4])
    defparam i1_2_lut_adj_15.init = 16'heeee;
    LUT4 i1146_3_lut_4_lut (.A(n6684), .B(counter_15__N_193[15]), .C(MEM_CLK_N_130), 
         .D(mem_clk), .Z(MEM_CLK_N_128)) /* synthesis lut_function=(A (D)+!A (B (C)+!B (D))) */ ;   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/communicationlayer.v(128[17] 141[10])
    defparam i1146_3_lut_4_lut.init = 16'hfb40;
    LUT4 i3184_3_lut (.A(mem_rdata[11]), .B(n4378), .C(n2242_c), .Z(n4379)) /* synthesis lut_function=(A (B+!(C))+!A (B (C))) */ ;   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/communicationlayer.v(35[7] 150[4])
    defparam i3184_3_lut.init = 16'hcaca;
    LUT4 i3183_3_lut (.A(mem_wdata[11]), .B(rd_data[11]), .C(n6043), .Z(n4378)) /* synthesis lut_function=(A (B+(C))+!A !((C)+!B)) */ ;   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/communicationlayer.v(35[7] 150[4])
    defparam i3183_3_lut.init = 16'hacac;
    CCU2D add_131_7 (.A0(mem_burst_cnt[5]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(mem_burst_cnt[6]), .B1(GND_net), .C1(GND_net), 
          .D1(GND_net), .CIN(n5938), .COUT(n5939), .S0(n810[5]), .S1(n810[6]));   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/communicationlayer.v(144[66:83])
    defparam add_131_7.INIT0 = 16'h5aaa;
    defparam add_131_7.INIT1 = 16'h5aaa;
    defparam add_131_7.INJECT1_0 = "NO";
    defparam add_131_7.INJECT1_1 = "NO";
    LUT4 i79_4_lut (.A(n5203), .B(n5966), .C(rd_data[7]), .D(n6698), 
         .Z(n63)) /* synthesis lut_function=(A (B (C))+!A (B (C+!(D))+!B !(C+(D)))) */ ;   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/communicationlayer.v(71[8] 78[15])
    defparam i79_4_lut.init = 16'hc0c5;
    LUT4 i3_4_lut_adj_16 (.A(rd_data[4]), .B(rd_data[1]), .C(rd_data[2]), 
         .D(rd_data[0]), .Z(n5966)) /* synthesis lut_function=(A (B (C (D)))) */ ;   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/communicationlayer.v(71[8] 78[15])
    defparam i3_4_lut_adj_16.init = 16'h8000;
    LUT4 n6289_bdd_4_lut (.A(rd_data[2]), .B(n4033), .C(rd_data[1]), .D(rd_data[0]), 
         .Z(n6533)) /* synthesis lut_function=(A (B+(C+(D)))+!A (B+((D)+!C))) */ ;
    defparam n6289_bdd_4_lut.init = 16'hffed;
    LUT4 i5067_2_lut_4_lut (.A(n6694), .B(rd_data[0]), .C(n4033), .D(rd_data[3]), 
         .Z(n6275)) /* synthesis lut_function=(A+(B+(C+(D)))) */ ;
    defparam i5067_2_lut_4_lut.init = 16'hfffe;
    LUT4 i3182_3_lut (.A(mem_rdata[10]), .B(n4376), .C(n2242_c), .Z(n4377)) /* synthesis lut_function=(A (B+!(C))+!A (B (C))) */ ;   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/communicationlayer.v(35[7] 150[4])
    defparam i3182_3_lut.init = 16'hcaca;
    LUT4 i2_3_lut_adj_17 (.A(rd_data[7]), .B(n43), .C(n6335), .Z(n6206)) /* synthesis lut_function=(!(A+((C)+!B))) */ ;
    defparam i2_3_lut_adj_17.init = 16'h0404;
    LUT4 i3180_3_lut (.A(mem_rdata[9]), .B(n4374), .C(n2242_c), .Z(n4375)) /* synthesis lut_function=(A (B+!(C))+!A (B (C))) */ ;   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/communicationlayer.v(35[7] 150[4])
    defparam i3180_3_lut.init = 16'hcaca;
    LUT4 i1_4_lut_else_4_lut (.A(n610[5]), .B(spi_cmd[0]), .C(spi_cmd[2]), 
         .D(\spi_cmd[3] ), .Z(n6895)) /* synthesis lut_function=(A (((D)+!C)+!B)) */ ;   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/communicationlayer.v(50[3] 148[10])
    defparam i1_4_lut_else_4_lut.init = 16'haa2a;
    LUT4 i4011_2_lut (.A(rd_data[0]), .B(rd_data[4]), .Z(n5203)) /* synthesis lut_function=(A+(B)) */ ;
    defparam i4011_2_lut.init = 16'heeee;
    LUT4 i3179_3_lut (.A(mem_wdata[9]), .B(rd_data[9]), .C(n6043), .Z(n4374)) /* synthesis lut_function=(A (B+(C))+!A !((C)+!B)) */ ;   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/communicationlayer.v(35[7] 150[4])
    defparam i3179_3_lut.init = 16'hacac;
    LUT4 i5126_4_lut (.A(n6317), .B(rd_data[8]), .C(n6319), .D(rd_data[15]), 
         .Z(n6335)) /* synthesis lut_function=(A+(B+(C+(D)))) */ ;
    defparam i5126_4_lut.init = 16'hfffe;
    LUT4 i3966_2_lut_3_lut_4_lut (.A(n6695), .B(n610[0]), .C(mem_rdata[2]), 
         .D(n6685), .Z(dataOut_15__N_94[2])) /* synthesis lut_function=(A (C+(D))+!A (B+(C+(D)))) */ ;   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/communicationlayer.v(50[3] 148[10])
    defparam i3966_2_lut_3_lut_4_lut.init = 16'hfff4;
    LUT4 i5109_4_lut (.A(rd_data[12]), .B(rd_data[14]), .C(rd_data[11]), 
         .D(rd_data[13]), .Z(n6317)) /* synthesis lut_function=(A+(B+(C+(D)))) */ ;
    defparam i5109_4_lut.init = 16'hfffe;
    LUT4 i3988_2_lut_3_lut (.A(spi_cmd[0]), .B(spi_cmd[1]), .C(counter_15__N_193[15]), 
         .Z(n5180)) /* synthesis lut_function=(!(A (B+!(C))+!A !(B (C)))) */ ;   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/communicationlayer.v(108[27] 118[34])
    defparam i3988_2_lut_3_lut.init = 16'h6060;
    LUT4 i3178_3_lut (.A(mem_rdata[8]), .B(n4372), .C(n2242_c), .Z(n4373)) /* synthesis lut_function=(A (B+!(C))+!A (B (C))) */ ;   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/communicationlayer.v(35[7] 150[4])
    defparam i3178_3_lut.init = 16'hcaca;
    LUT4 i1_4_lut_4_lut (.A(counter_15__N_193[15]), .B(n610[8]), .C(n6697), 
         .D(n5095), .Z(n4)) /* synthesis lut_function=(A (B (C+!(D))+!B (C))) */ ;   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/communicationlayer.v(50[3] 148[10])
    defparam i1_4_lut_4_lut.init = 16'ha0a8;
    LUT4 i5111_4_lut (.A(rd_data[5]), .B(rd_data[6]), .C(rd_data[10]), 
         .D(rd_data[9]), .Z(n6319)) /* synthesis lut_function=(A+(B+(C+(D)))) */ ;
    defparam i5111_4_lut.init = 16'hfffe;
    CCU2D add_131_5 (.A0(mem_burst_cnt[3]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(mem_burst_cnt[4]), .B1(GND_net), .C1(GND_net), 
          .D1(GND_net), .CIN(n5937), .COUT(n5938), .S0(n810[3]), .S1(n810[4]));   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/communicationlayer.v(144[66:83])
    defparam add_131_5.INIT0 = 16'h5aaa;
    defparam add_131_5.INIT1 = 16'h5aaa;
    defparam add_131_5.INJECT1_0 = "NO";
    defparam add_131_5.INJECT1_1 = "NO";
    CCU2D add_131_3 (.A0(mem_burst_cnt[1]), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(mem_burst_cnt[2]), .B1(GND_net), .C1(GND_net), 
          .D1(GND_net), .CIN(n5936), .COUT(n5937), .S0(n810[1]), .S1(n810[2]));   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/communicationlayer.v(144[66:83])
    defparam add_131_3.INIT0 = 16'h5aaa;
    defparam add_131_3.INIT1 = 16'h5aaa;
    defparam add_131_3.INJECT1_0 = "NO";
    defparam add_131_3.INJECT1_1 = "NO";
    LUT4 i3933_3_lut_4_lut (.A(n6695), .B(n610[0]), .C(mem_rdata[10]), 
         .D(n6685), .Z(dataOut_15__N_94[10])) /* synthesis lut_function=(!(A ((D)+!C)+!A !(B+!((D)+!C)))) */ ;   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/communicationlayer.v(50[3] 148[10])
    defparam i3933_3_lut_4_lut.init = 16'h44f4;
    LUT4 i3177_3_lut (.A(mem_wdata[8]), .B(rd_data[8]), .C(n6043), .Z(n4372)) /* synthesis lut_function=(A (B+(C))+!A !((C)+!B)) */ ;   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/communicationlayer.v(35[7] 150[4])
    defparam i3177_3_lut.init = 16'hacac;
    LUT4 i5221_3_lut_rep_64_4_lut (.A(n610[9]), .B(n6688), .C(n6257), 
         .D(n610[5]), .Z(CLK_EXT_c_enable_90)) /* synthesis lut_function=(!(A (C)+!A (B (C)+!B (C+!(D))))) */ ;   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/communicationlayer.v(50[3] 148[10])
    defparam i5221_3_lut_rep_64_4_lut.init = 16'h0f0e;
    LUT4 i1_3_lut_4_lut_adj_18 (.A(n610[9]), .B(n6688), .C(n41), .D(spi_csn_c), 
         .Z(n22)) /* synthesis lut_function=(A (D)+!A (B (D)+!B (C (D)))) */ ;   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/communicationlayer.v(50[3] 148[10])
    defparam i1_3_lut_4_lut_adj_18.init = 16'hfe00;
    LUT4 i1_2_lut_3_lut_adj_19 (.A(counter_15__N_193[15]), .B(n610[8]), 
         .C(spi_cmd[2]), .Z(n6)) /* synthesis lut_function=(A (B (C))) */ ;   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/communicationlayer.v(50[3] 148[10])
    defparam i1_2_lut_3_lut_adj_19.init = 16'h8080;
    LUT4 i3929_3_lut_4_lut (.A(n6695), .B(n610[0]), .C(mem_rdata[14]), 
         .D(n6685), .Z(dataOut_15__N_94[14])) /* synthesis lut_function=(!(A ((D)+!C)+!A !(B+!((D)+!C)))) */ ;   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/communicationlayer.v(50[3] 148[10])
    defparam i3929_3_lut_4_lut.init = 16'h44f4;
    LUT4 i2_3_lut_4_lut_adj_20 (.A(n6690), .B(n6689), .C(counter_15__N_193[15]), 
         .D(n616), .Z(n6043)) /* synthesis lut_function=(A+!(B (C (D)))) */ ;   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/communicationlayer.v(35[7] 150[4])
    defparam i2_3_lut_4_lut_adj_20.init = 16'hbfff;
    LUT4 i3104_3_lut (.A(mem_rdata[0]), .B(n4298), .C(n2242_c), .Z(n4299)) /* synthesis lut_function=(A (B+!(C))+!A (B (C))) */ ;   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/communicationlayer.v(35[7] 150[4])
    defparam i3104_3_lut.init = 16'hcaca;
    LUT4 i3103_3_lut (.A(mem_wdata[0]), .B(rd_data[0]), .C(n6043), .Z(n4298)) /* synthesis lut_function=(A (B+(C))+!A !((C)+!B)) */ ;   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/communicationlayer.v(35[7] 150[4])
    defparam i3103_3_lut.init = 16'hacac;
    LUT4 i3167_3_lut (.A(mem_wdata[4]), .B(rd_data[4]), .C(n6043), .Z(n4362)) /* synthesis lut_function=(A (B+(C))+!A !((C)+!B)) */ ;   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/communicationlayer.v(35[7] 150[4])
    defparam i3167_3_lut.init = 16'hacac;
    LUT4 i1_3_lut_4_lut_adj_21 (.A(n6695), .B(n610[0]), .C(mem_rdata[6]), 
         .D(n6685), .Z(dataOut_15__N_94[6])) /* synthesis lut_function=(!(A ((D)+!C)+!A !(B+!((D)+!C)))) */ ;   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/communicationlayer.v(50[3] 148[10])
    defparam i1_3_lut_4_lut_adj_21.init = 16'h44f4;
    LUT4 i3934_3_lut_4_lut (.A(n6695), .B(n610[0]), .C(mem_rdata[9]), 
         .D(n6685), .Z(dataOut_15__N_94[9])) /* synthesis lut_function=(!(A ((D)+!C)+!A !(B+!((D)+!C)))) */ ;   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/communicationlayer.v(50[3] 148[10])
    defparam i3934_3_lut_4_lut.init = 16'h44f4;
    LUT4 i3883_2_lut (.A(MEM_CLK_N_127), .B(n2242_c), .Z(MEM_CLK_N_126)) /* synthesis lut_function=(A (B)) */ ;   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/communicationlayer.v(46[7] 149[5])
    defparam i3883_2_lut.init = 16'h8888;
    LUT4 i3930_3_lut_4_lut (.A(n6695), .B(n610[0]), .C(mem_rdata[13]), 
         .D(n6685), .Z(dataOut_15__N_94[13])) /* synthesis lut_function=(!(A ((D)+!C)+!A !(B+!((D)+!C)))) */ ;   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/communicationlayer.v(50[3] 148[10])
    defparam i3930_3_lut_4_lut.init = 16'h44f4;
    LUT4 i3931_3_lut_4_lut (.A(n6695), .B(n610[0]), .C(mem_rdata[12]), 
         .D(n6685), .Z(dataOut_15__N_94[12])) /* synthesis lut_function=(!(A ((D)+!C)+!A !(B+!((D)+!C)))) */ ;   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/communicationlayer.v(50[3] 148[10])
    defparam i3931_3_lut_4_lut.init = 16'h44f4;
    LUT4 i4008_2_lut (.A(spi_cmd[2]), .B(n610[0]), .Z(n4421)) /* synthesis lut_function=(A+(B)) */ ;   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/communicationlayer.v(35[7] 150[4])
    defparam i4008_2_lut.init = 16'heeee;
    LUT4 i3181_3_lut (.A(mem_wdata[10]), .B(rd_data[10]), .C(n6043), .Z(n4376)) /* synthesis lut_function=(A (B+(C))+!A !((C)+!B)) */ ;   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/communicationlayer.v(35[7] 150[4])
    defparam i3181_3_lut.init = 16'hacac;
    LUT4 i2_4_lut (.A(n6897), .B(n22), .C(counter_15__N_193[15]), .D(n24), 
         .Z(n6094)) /* synthesis lut_function=(A+(B+(C (D)))) */ ;   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/communicationlayer.v(50[3] 148[10])
    defparam i2_4_lut.init = 16'hfeee;
    LUT4 i3948_2_lut_3_lut_4_lut (.A(n6695), .B(n610[0]), .C(mem_rdata[0]), 
         .D(n6685), .Z(dataOut_15__N_94[0])) /* synthesis lut_function=(A (C+(D))+!A (B+(C+(D)))) */ ;   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/communicationlayer.v(50[3] 148[10])
    defparam i3948_2_lut_3_lut_4_lut.init = 16'hfff4;
    PFUMX i3227 (.BLUT(n4421), .ALUT(n6247), .C0(n610[4]), .Z(n4422));
    LUT4 i3964_2_lut_3_lut_4_lut (.A(n6695), .B(n610[0]), .C(mem_rdata[7]), 
         .D(n6685), .Z(dataOut_15__N_94[7])) /* synthesis lut_function=(A (C+(D))+!A (B+(C+(D)))) */ ;   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/communicationlayer.v(50[3] 148[10])
    defparam i3964_2_lut_3_lut_4_lut.init = 16'hfff4;
    LUT4 i1_4_lut_adj_22 (.A(rd_data[2]), .B(n6246), .C(n6275), .D(rd_data[1]), 
         .Z(n6247)) /* synthesis lut_function=(A (B)+!A (B+!(C+!(D)))) */ ;
    defparam i1_4_lut_adj_22.init = 16'hcdcc;
    LUT4 i1_4_lut_adj_23 (.A(n610[0]), .B(spi_cmd[2]), .C(n610[8]), .D(n6696), 
         .Z(n24)) /* synthesis lut_function=(A+!(B+!(C (D)))) */ ;   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/communicationlayer.v(50[3] 148[10])
    defparam i1_4_lut_adj_23.init = 16'hbaaa;
    LUT4 i5243_2_lut_3_lut_4_lut (.A(n6695), .B(n610[0]), .C(n2242_c), 
         .D(n6685), .Z(n4424)) /* synthesis lut_function=(A ((D)+!C)+!A (B+((D)+!C))) */ ;   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/communicationlayer.v(50[3] 148[10])
    defparam i5243_2_lut_3_lut_4_lut.init = 16'hff4f;
    PFUMX i3225 (.BLUT(n4419), .ALUT(n6248), .C0(n610[4]), .Z(n4420));
    LUT4 i3176_3_lut (.A(mem_rdata[7]), .B(n4370), .C(n2242_c), .Z(n4371)) /* synthesis lut_function=(A (B+!(C))+!A (B (C))) */ ;   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/communicationlayer.v(35[7] 150[4])
    defparam i3176_3_lut.init = 16'hcaca;
    LUT4 i45_4_lut (.A(n610[3]), .B(n610[7]), .C(counter_15__N_193[15]), 
         .D(n616), .Z(n41)) /* synthesis lut_function=(A (B+((D)+!C))+!A (B (C)+!B (C (D)))) */ ;   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/communicationlayer.v(50[3] 148[10])
    defparam i45_4_lut.init = 16'hfaca;
    PFUMX i33 (.BLUT(n4408), .ALUT(n6337), .C0(n610[4]), .Z(n6076));
    LUT4 i3175_3_lut (.A(mem_wdata[7]), .B(rd_data[7]), .C(n6043), .Z(n4370)) /* synthesis lut_function=(A (B+(C))+!A !((C)+!B)) */ ;   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/communicationlayer.v(35[7] 150[4])
    defparam i3175_3_lut.init = 16'hacac;
    PFUMX i482 (.BLUT(n786), .ALUT(MEM_CLK_N_128), .C0(n616), .Z(MEM_CLK_N_127));
    LUT4 i3932_3_lut_4_lut (.A(n6695), .B(n610[0]), .C(mem_rdata[11]), 
         .D(n6685), .Z(dataOut_15__N_94[11])) /* synthesis lut_function=(!(A ((D)+!C)+!A !(B+!((D)+!C)))) */ ;   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/communicationlayer.v(50[3] 148[10])
    defparam i3932_3_lut_4_lut.init = 16'h44f4;
    LUT4 i1_4_lut_adj_24 (.A(n66), .B(rd_data[3]), .C(n6335), .D(n6297), 
         .Z(n6246)) /* synthesis lut_function=((B (C+!(D))+!B (C))+!A) */ ;
    defparam i1_4_lut_adj_24.init = 16'hf5fd;
    PFUMX i80 (.BLUT(n5967), .ALUT(n63), .C0(rd_data[3]), .Z(n66));
    CCU2D add_131_1 (.A0(GND_net), .B0(GND_net), .C0(GND_net), .D0(GND_net), 
          .A1(mem_burst_cnt[0]), .B1(GND_net), .C1(GND_net), .D1(GND_net), 
          .COUT(n5936), .S1(n810[0]));   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/communicationlayer.v(144[66:83])
    defparam add_131_1.INIT0 = 16'hF000;
    defparam add_131_1.INIT1 = 16'h5555;
    defparam add_131_1.INJECT1_0 = "NO";
    defparam add_131_1.INJECT1_1 = "NO";
    LUT4 select_488_Select_1_i17_2_lut_rep_72 (.A(n610[0]), .B(n610[11]), 
         .Z(n6688)) /* synthesis lut_function=(A+(B)) */ ;   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/communicationlayer.v(50[3] 148[10])
    defparam select_488_Select_1_i17_2_lut_rep_72.init = 16'heeee;
    LUT4 i3935_3_lut_4_lut (.A(n6695), .B(n610[0]), .C(mem_rdata[8]), 
         .D(n6685), .Z(dataOut_15__N_94[8])) /* synthesis lut_function=(!(A ((D)+!C)+!A !(B+!((D)+!C)))) */ ;   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/communicationlayer.v(50[3] 148[10])
    defparam i3935_3_lut_4_lut.init = 16'h44f4;
    LUT4 i3172_3_lut (.A(mem_rdata[6]), .B(n4366), .C(n2242_c), .Z(n4367)) /* synthesis lut_function=(A (B+!(C))+!A (B (C))) */ ;   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/communicationlayer.v(35[7] 150[4])
    defparam i3172_3_lut.init = 16'hcaca;
    LUT4 i10_4_lut_3_lut_rep_77 (.A(spi_cmd[2]), .B(spi_cmd[0]), .C(spi_cmd[1]), 
         .Z(n6693)) /* synthesis lut_function=(!(A (B (C)+!B !(C))+!A (C))) */ ;
    defparam i10_4_lut_3_lut_rep_77.init = 16'h2d2d;
    LUT4 i5081_2_lut_rep_78 (.A(rd_data[4]), .B(rd_data[7]), .Z(n6694)) /* synthesis lut_function=(A+(B)) */ ;
    defparam i5081_2_lut_rep_78.init = 16'heeee;
    FD1S3IX dataOut_i15 (.D(mem_rdata[15]), .CK(CLK_EXT_c), .CD(n4424), 
            .Q(dataOut[15])) /* synthesis LSE_LINE_FILE_ID=3, LSE_LCOL=22, LSE_RCOL=4, LSE_LLINE=43, LSE_RLINE=58 */ ;   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/communicationlayer.v(35[7] 150[4])
    defparam dataOut_i15.GSR = "DISABLED";
    LUT4 i3171_3_lut (.A(mem_wdata[6]), .B(rd_data[6]), .C(n6043), .Z(n4366)) /* synthesis lut_function=(A (B+(C))+!A !((C)+!B)) */ ;   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/communicationlayer.v(35[7] 150[4])
    defparam i3171_3_lut.init = 16'hacac;
    LUT4 i3170_3_lut (.A(mem_rdata[5]), .B(n4364), .C(n2242_c), .Z(n4365)) /* synthesis lut_function=(A (B+!(C))+!A (B (C))) */ ;   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/communicationlayer.v(35[7] 150[4])
    defparam i3170_3_lut.init = 16'hcaca;
    LUT4 i3169_3_lut (.A(mem_wdata[5]), .B(rd_data[5]), .C(n6043), .Z(n4364)) /* synthesis lut_function=(A (B+(C))+!A !((C)+!B)) */ ;   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/communicationlayer.v(35[7] 150[4])
    defparam i3169_3_lut.init = 16'hacac;
    LUT4 i3168_3_lut (.A(mem_rdata[4]), .B(n4362), .C(n2242_c), .Z(n4363)) /* synthesis lut_function=(A (B+!(C))+!A (B (C))) */ ;   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/communicationlayer.v(35[7] 150[4])
    defparam i3168_3_lut.init = 16'hcaca;
    LUT4 i3_3_lut_rep_66_4_lut (.A(rd_data[4]), .B(rd_data[7]), .C(n4033), 
         .D(rd_data[0]), .Z(n6682)) /* synthesis lut_function=(A+(B+(C+(D)))) */ ;
    defparam i3_3_lut_rep_66_4_lut.init = 16'hfffe;
    LUT4 i3936_3_lut_4_lut (.A(n6695), .B(n610[0]), .C(mem_rdata[5]), 
         .D(n6685), .Z(dataOut_15__N_94[5])) /* synthesis lut_function=(!(A ((D)+!C)+!A !(B+!((D)+!C)))) */ ;   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/communicationlayer.v(50[3] 148[10])
    defparam i3936_3_lut_4_lut.init = 16'h44f4;
    LUT4 i3879_2_lut_rep_79 (.A(spi_csn_c), .B(counter_15__N_193[15]), .Z(n6695)) /* synthesis lut_function=(A+(B)) */ ;
    defparam i3879_2_lut_rep_79.init = 16'heeee;
    PFUMX i5398 (.BLUT(n6895), .ALUT(n6896), .C0(spi_cmd[1]), .Z(n6897));
    PFUMX i5328 (.BLUT(n6700), .ALUT(n6701), .C0(spi_cmd[2]), .Z(CLK_EXT_c_enable_84));
    parallelIN_serialOUT mode3out (.clock_N_160(clock_N_160), .\counter_15__N_193[15] (counter_15__N_193[15]), 
            .dataOut({dataOut}), .spi_miso_c(spi_miso_c)) /* synthesis syn_module_defined=1 */ ;   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/communicationlayer.v(27[40:125])
    serialIN_parallelOUT mode3in (.rd_data({rd_data}), .spi_clk_c(spi_clk_c), 
            .spi_mosi_c(spi_mosi_c), .\counter_15__N_193[15] (counter_15__N_193[15]), 
            .spi_csn_c(spi_csn_c)) /* synthesis syn_module_defined=1 */ ;   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/communicationlayer.v(28[40:135])
    
endmodule
//
// Verilog Description of module parallelIN_serialOUT
//

module parallelIN_serialOUT (clock_N_160, \counter_15__N_193[15] , dataOut, 
            spi_miso_c) /* synthesis syn_module_defined=1 */ ;
    input clock_N_160;
    input \counter_15__N_193[15] ;
    input [15:0]dataOut;
    output spi_miso_c;
    
    wire clock_N_160 /* synthesis is_inv_clock=1 */ ;   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/spi_slave.v(33[18:24])
    wire [15:0]counter;   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/spi_slave.v(34[18:25])
    
    wire clock_N_160_enable_15;
    wire [15:0]outreg;   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/spi_slave.v(33[18:24])
    
    wire n4290, n17, n30, n26, n18, n28, n22, n4348, n4349, 
        n4347, n4345, n4343, n4341, n4339, n4335, n4333, n4331, 
        n4329, n4327, n4325, n4323, n4321, n4359, n4346, n4344, 
        n4342, n4340, n4338, n4334, n4332, n4330, n4328, n4326, 
        n4324, n4322, n4320, n4358;
    
    FD1P3JX counter_i0_i14 (.D(counter[15]), .SP(clock_N_160_enable_15), 
            .PD(\counter_15__N_193[15] ), .CK(clock_N_160), .Q(counter[14])) /* synthesis LSE_LINE_FILE_ID=5, LSE_LCOL=40, LSE_RCOL=125, LSE_LLINE=27, LSE_RLINE=27 */ ;   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/spi_slave.v(41[8] 54[6])
    defparam counter_i0_i14.GSR = "ENABLED";
    FD1P3JX counter_i0_i13 (.D(counter[14]), .SP(clock_N_160_enable_15), 
            .PD(\counter_15__N_193[15] ), .CK(clock_N_160), .Q(counter[13])) /* synthesis LSE_LINE_FILE_ID=5, LSE_LCOL=40, LSE_RCOL=125, LSE_LLINE=27, LSE_RLINE=27 */ ;   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/spi_slave.v(41[8] 54[6])
    defparam counter_i0_i13.GSR = "ENABLED";
    FD1P3JX counter_i0_i12 (.D(counter[13]), .SP(clock_N_160_enable_15), 
            .PD(\counter_15__N_193[15] ), .CK(clock_N_160), .Q(counter[12])) /* synthesis LSE_LINE_FILE_ID=5, LSE_LCOL=40, LSE_RCOL=125, LSE_LLINE=27, LSE_RLINE=27 */ ;   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/spi_slave.v(41[8] 54[6])
    defparam counter_i0_i12.GSR = "ENABLED";
    FD1P3JX counter_i0_i11 (.D(counter[12]), .SP(clock_N_160_enable_15), 
            .PD(\counter_15__N_193[15] ), .CK(clock_N_160), .Q(counter[11])) /* synthesis LSE_LINE_FILE_ID=5, LSE_LCOL=40, LSE_RCOL=125, LSE_LLINE=27, LSE_RLINE=27 */ ;   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/spi_slave.v(41[8] 54[6])
    defparam counter_i0_i11.GSR = "ENABLED";
    FD1P3JX counter_i0_i10 (.D(counter[11]), .SP(clock_N_160_enable_15), 
            .PD(\counter_15__N_193[15] ), .CK(clock_N_160), .Q(counter[10])) /* synthesis LSE_LINE_FILE_ID=5, LSE_LCOL=40, LSE_RCOL=125, LSE_LLINE=27, LSE_RLINE=27 */ ;   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/spi_slave.v(41[8] 54[6])
    defparam counter_i0_i10.GSR = "ENABLED";
    FD1P3JX counter_i0_i9 (.D(counter[10]), .SP(clock_N_160_enable_15), 
            .PD(\counter_15__N_193[15] ), .CK(clock_N_160), .Q(counter[9])) /* synthesis LSE_LINE_FILE_ID=5, LSE_LCOL=40, LSE_RCOL=125, LSE_LLINE=27, LSE_RLINE=27 */ ;   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/spi_slave.v(41[8] 54[6])
    defparam counter_i0_i9.GSR = "ENABLED";
    FD1P3JX counter_i0_i8 (.D(counter[9]), .SP(clock_N_160_enable_15), .PD(\counter_15__N_193[15] ), 
            .CK(clock_N_160), .Q(counter[8])) /* synthesis LSE_LINE_FILE_ID=5, LSE_LCOL=40, LSE_RCOL=125, LSE_LLINE=27, LSE_RLINE=27 */ ;   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/spi_slave.v(41[8] 54[6])
    defparam counter_i0_i8.GSR = "ENABLED";
    FD1P3JX counter_i0_i7 (.D(counter[8]), .SP(clock_N_160_enable_15), .PD(\counter_15__N_193[15] ), 
            .CK(clock_N_160), .Q(counter[7])) /* synthesis LSE_LINE_FILE_ID=5, LSE_LCOL=40, LSE_RCOL=125, LSE_LLINE=27, LSE_RLINE=27 */ ;   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/spi_slave.v(41[8] 54[6])
    defparam counter_i0_i7.GSR = "ENABLED";
    FD1P3JX counter_i0_i6 (.D(counter[7]), .SP(clock_N_160_enable_15), .PD(\counter_15__N_193[15] ), 
            .CK(clock_N_160), .Q(counter[6])) /* synthesis LSE_LINE_FILE_ID=5, LSE_LCOL=40, LSE_RCOL=125, LSE_LLINE=27, LSE_RLINE=27 */ ;   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/spi_slave.v(41[8] 54[6])
    defparam counter_i0_i6.GSR = "ENABLED";
    FD1P3JX counter_i0_i5 (.D(counter[6]), .SP(clock_N_160_enable_15), .PD(\counter_15__N_193[15] ), 
            .CK(clock_N_160), .Q(counter[5])) /* synthesis LSE_LINE_FILE_ID=5, LSE_LCOL=40, LSE_RCOL=125, LSE_LLINE=27, LSE_RLINE=27 */ ;   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/spi_slave.v(41[8] 54[6])
    defparam counter_i0_i5.GSR = "ENABLED";
    FD1P3JX counter_i0_i4 (.D(counter[5]), .SP(clock_N_160_enable_15), .PD(\counter_15__N_193[15] ), 
            .CK(clock_N_160), .Q(counter[4])) /* synthesis LSE_LINE_FILE_ID=5, LSE_LCOL=40, LSE_RCOL=125, LSE_LLINE=27, LSE_RLINE=27 */ ;   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/spi_slave.v(41[8] 54[6])
    defparam counter_i0_i4.GSR = "ENABLED";
    FD1P3JX counter_i0_i3 (.D(counter[4]), .SP(clock_N_160_enable_15), .PD(\counter_15__N_193[15] ), 
            .CK(clock_N_160), .Q(counter[3])) /* synthesis LSE_LINE_FILE_ID=5, LSE_LCOL=40, LSE_RCOL=125, LSE_LLINE=27, LSE_RLINE=27 */ ;   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/spi_slave.v(41[8] 54[6])
    defparam counter_i0_i3.GSR = "ENABLED";
    FD1P3JX counter_i0_i2 (.D(counter[3]), .SP(clock_N_160_enable_15), .PD(\counter_15__N_193[15] ), 
            .CK(clock_N_160), .Q(counter[2])) /* synthesis LSE_LINE_FILE_ID=5, LSE_LCOL=40, LSE_RCOL=125, LSE_LLINE=27, LSE_RLINE=27 */ ;   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/spi_slave.v(41[8] 54[6])
    defparam counter_i0_i2.GSR = "ENABLED";
    FD1P3JX counter_i0_i1 (.D(counter[2]), .SP(clock_N_160_enable_15), .PD(\counter_15__N_193[15] ), 
            .CK(clock_N_160), .Q(counter[1])) /* synthesis LSE_LINE_FILE_ID=5, LSE_LCOL=40, LSE_RCOL=125, LSE_LLINE=27, LSE_RLINE=27 */ ;   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/spi_slave.v(41[8] 54[6])
    defparam counter_i0_i1.GSR = "ENABLED";
    FD1P3JX counter_i0_i0 (.D(counter[1]), .SP(clock_N_160_enable_15), .PD(\counter_15__N_193[15] ), 
            .CK(clock_N_160), .Q(counter[0])) /* synthesis LSE_LINE_FILE_ID=5, LSE_LCOL=40, LSE_RCOL=125, LSE_LLINE=27, LSE_RLINE=27 */ ;   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/spi_slave.v(41[8] 54[6])
    defparam counter_i0_i0.GSR = "ENABLED";
    FD1S3AX outreg_i0 (.D(n4290), .CK(clock_N_160), .Q(outreg[0])) /* synthesis LSE_LINE_FILE_ID=5, LSE_LCOL=40, LSE_RCOL=125, LSE_LLINE=27, LSE_RLINE=27 */ ;   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/spi_slave.v(41[8] 54[6])
    defparam outreg_i0.GSR = "ENABLED";
    LUT4 i15_4_lut (.A(n17), .B(n30), .C(n26), .D(n18), .Z(clock_N_160_enable_15)) /* synthesis lut_function=(A+(B+(C+(D)))) */ ;   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/spi_slave.v(42[7:19])
    defparam i15_4_lut.init = 16'hfffe;
    LUT4 i1_2_lut (.A(counter[0]), .B(counter[6]), .Z(n17)) /* synthesis lut_function=(A+(B)) */ ;   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/spi_slave.v(42[7:19])
    defparam i1_2_lut.init = 16'heeee;
    LUT4 i14_4_lut (.A(counter[10]), .B(n28), .C(n22), .D(counter[12]), 
         .Z(n30)) /* synthesis lut_function=(A+(B+(C+(D)))) */ ;   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/spi_slave.v(42[7:19])
    defparam i14_4_lut.init = 16'hfffe;
    LUT4 i10_4_lut (.A(counter[8]), .B(counter[3]), .C(counter[13]), .D(counter[5]), 
         .Z(n26)) /* synthesis lut_function=(A+(B+(C+(D)))) */ ;   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/spi_slave.v(42[7:19])
    defparam i10_4_lut.init = 16'hfffe;
    LUT4 i2_2_lut (.A(counter[1]), .B(counter[4]), .Z(n18)) /* synthesis lut_function=(A+(B)) */ ;   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/spi_slave.v(42[7:19])
    defparam i2_2_lut.init = 16'heeee;
    LUT4 i3154_3_lut (.A(n4348), .B(dataOut[1]), .C(\counter_15__N_193[15] ), 
         .Z(n4349)) /* synthesis lut_function=(A (B+!(C))+!A (B (C))) */ ;   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/spi_slave.v(41[8] 54[6])
    defparam i3154_3_lut.init = 16'hcaca;
    FD1S3AX outreg_i1 (.D(n4349), .CK(clock_N_160), .Q(outreg[1])) /* synthesis LSE_LINE_FILE_ID=5, LSE_LCOL=40, LSE_RCOL=125, LSE_LLINE=27, LSE_RLINE=27 */ ;   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/spi_slave.v(41[8] 54[6])
    defparam outreg_i1.GSR = "ENABLED";
    FD1S3AX outreg_i2 (.D(n4347), .CK(clock_N_160), .Q(outreg[2])) /* synthesis LSE_LINE_FILE_ID=5, LSE_LCOL=40, LSE_RCOL=125, LSE_LLINE=27, LSE_RLINE=27 */ ;   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/spi_slave.v(41[8] 54[6])
    defparam outreg_i2.GSR = "ENABLED";
    FD1S3AX outreg_i3 (.D(n4345), .CK(clock_N_160), .Q(outreg[3])) /* synthesis LSE_LINE_FILE_ID=5, LSE_LCOL=40, LSE_RCOL=125, LSE_LLINE=27, LSE_RLINE=27 */ ;   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/spi_slave.v(41[8] 54[6])
    defparam outreg_i3.GSR = "ENABLED";
    FD1S3AX outreg_i4 (.D(n4343), .CK(clock_N_160), .Q(outreg[4])) /* synthesis LSE_LINE_FILE_ID=5, LSE_LCOL=40, LSE_RCOL=125, LSE_LLINE=27, LSE_RLINE=27 */ ;   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/spi_slave.v(41[8] 54[6])
    defparam outreg_i4.GSR = "ENABLED";
    FD1S3AX outreg_i5 (.D(n4341), .CK(clock_N_160), .Q(outreg[5])) /* synthesis LSE_LINE_FILE_ID=5, LSE_LCOL=40, LSE_RCOL=125, LSE_LLINE=27, LSE_RLINE=27 */ ;   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/spi_slave.v(41[8] 54[6])
    defparam outreg_i5.GSR = "ENABLED";
    FD1S3AX outreg_i6 (.D(n4339), .CK(clock_N_160), .Q(outreg[6])) /* synthesis LSE_LINE_FILE_ID=5, LSE_LCOL=40, LSE_RCOL=125, LSE_LLINE=27, LSE_RLINE=27 */ ;   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/spi_slave.v(41[8] 54[6])
    defparam outreg_i6.GSR = "ENABLED";
    FD1S3AX outreg_i7 (.D(n4335), .CK(clock_N_160), .Q(outreg[7])) /* synthesis LSE_LINE_FILE_ID=5, LSE_LCOL=40, LSE_RCOL=125, LSE_LLINE=27, LSE_RLINE=27 */ ;   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/spi_slave.v(41[8] 54[6])
    defparam outreg_i7.GSR = "ENABLED";
    FD1S3AX outreg_i8 (.D(n4333), .CK(clock_N_160), .Q(outreg[8])) /* synthesis LSE_LINE_FILE_ID=5, LSE_LCOL=40, LSE_RCOL=125, LSE_LLINE=27, LSE_RLINE=27 */ ;   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/spi_slave.v(41[8] 54[6])
    defparam outreg_i8.GSR = "ENABLED";
    FD1S3AX outreg_i9 (.D(n4331), .CK(clock_N_160), .Q(outreg[9])) /* synthesis LSE_LINE_FILE_ID=5, LSE_LCOL=40, LSE_RCOL=125, LSE_LLINE=27, LSE_RLINE=27 */ ;   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/spi_slave.v(41[8] 54[6])
    defparam outreg_i9.GSR = "ENABLED";
    FD1S3AX outreg_i10 (.D(n4329), .CK(clock_N_160), .Q(outreg[10])) /* synthesis LSE_LINE_FILE_ID=5, LSE_LCOL=40, LSE_RCOL=125, LSE_LLINE=27, LSE_RLINE=27 */ ;   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/spi_slave.v(41[8] 54[6])
    defparam outreg_i10.GSR = "ENABLED";
    FD1S3AX outreg_i11 (.D(n4327), .CK(clock_N_160), .Q(outreg[11])) /* synthesis LSE_LINE_FILE_ID=5, LSE_LCOL=40, LSE_RCOL=125, LSE_LLINE=27, LSE_RLINE=27 */ ;   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/spi_slave.v(41[8] 54[6])
    defparam outreg_i11.GSR = "ENABLED";
    FD1S3AX outreg_i12 (.D(n4325), .CK(clock_N_160), .Q(outreg[12])) /* synthesis LSE_LINE_FILE_ID=5, LSE_LCOL=40, LSE_RCOL=125, LSE_LLINE=27, LSE_RLINE=27 */ ;   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/spi_slave.v(41[8] 54[6])
    defparam outreg_i12.GSR = "ENABLED";
    FD1S3AX outreg_i13 (.D(n4323), .CK(clock_N_160), .Q(outreg[13])) /* synthesis LSE_LINE_FILE_ID=5, LSE_LCOL=40, LSE_RCOL=125, LSE_LLINE=27, LSE_RLINE=27 */ ;   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/spi_slave.v(41[8] 54[6])
    defparam outreg_i13.GSR = "ENABLED";
    FD1S3AX outreg_i14 (.D(n4321), .CK(clock_N_160), .Q(outreg[14])) /* synthesis LSE_LINE_FILE_ID=5, LSE_LCOL=40, LSE_RCOL=125, LSE_LLINE=27, LSE_RLINE=27 */ ;   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/spi_slave.v(41[8] 54[6])
    defparam outreg_i14.GSR = "ENABLED";
    FD1S3AX outreg_i15 (.D(n4359), .CK(clock_N_160), .Q(spi_miso_c)) /* synthesis LSE_LINE_FILE_ID=5, LSE_LCOL=40, LSE_RCOL=125, LSE_LLINE=27, LSE_RLINE=27 */ ;   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/spi_slave.v(41[8] 54[6])
    defparam outreg_i15.GSR = "ENABLED";
    LUT4 i12_4_lut (.A(counter[11]), .B(counter[9]), .C(counter[14]), 
         .D(counter[15]), .Z(n28)) /* synthesis lut_function=(A+(B+(C+(D)))) */ ;   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/spi_slave.v(42[7:19])
    defparam i12_4_lut.init = 16'hfffe;
    LUT4 i3153_3_lut (.A(outreg[1]), .B(outreg[0]), .C(clock_N_160_enable_15), 
         .Z(n4348)) /* synthesis lut_function=(A (B+!(C))+!A (B (C))) */ ;   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/spi_slave.v(41[8] 54[6])
    defparam i3153_3_lut.init = 16'hcaca;
    LUT4 i3152_3_lut (.A(n4346), .B(dataOut[2]), .C(\counter_15__N_193[15] ), 
         .Z(n4347)) /* synthesis lut_function=(A (B+!(C))+!A (B (C))) */ ;   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/spi_slave.v(41[8] 54[6])
    defparam i3152_3_lut.init = 16'hcaca;
    LUT4 i3151_3_lut (.A(outreg[2]), .B(outreg[1]), .C(clock_N_160_enable_15), 
         .Z(n4346)) /* synthesis lut_function=(A (B+!(C))+!A (B (C))) */ ;   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/spi_slave.v(41[8] 54[6])
    defparam i3151_3_lut.init = 16'hcaca;
    LUT4 i3150_3_lut (.A(n4344), .B(dataOut[3]), .C(\counter_15__N_193[15] ), 
         .Z(n4345)) /* synthesis lut_function=(A (B+!(C))+!A (B (C))) */ ;   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/spi_slave.v(41[8] 54[6])
    defparam i3150_3_lut.init = 16'hcaca;
    LUT4 i3095_4_lut (.A(outreg[0]), .B(dataOut[0]), .C(\counter_15__N_193[15] ), 
         .D(clock_N_160_enable_15), .Z(n4290)) /* synthesis lut_function=(A (B+!(C))+!A (B (C+(D))+!B !(C+!(D)))) */ ;   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/spi_slave.v(41[8] 54[6])
    defparam i3095_4_lut.init = 16'hcfca;
    LUT4 i3149_3_lut (.A(outreg[3]), .B(outreg[2]), .C(clock_N_160_enable_15), 
         .Z(n4344)) /* synthesis lut_function=(A (B+!(C))+!A (B (C))) */ ;   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/spi_slave.v(41[8] 54[6])
    defparam i3149_3_lut.init = 16'hcaca;
    LUT4 i3148_3_lut (.A(n4342), .B(dataOut[4]), .C(\counter_15__N_193[15] ), 
         .Z(n4343)) /* synthesis lut_function=(A (B+!(C))+!A (B (C))) */ ;   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/spi_slave.v(41[8] 54[6])
    defparam i3148_3_lut.init = 16'hcaca;
    LUT4 i3147_3_lut (.A(outreg[4]), .B(outreg[3]), .C(clock_N_160_enable_15), 
         .Z(n4342)) /* synthesis lut_function=(A (B+!(C))+!A (B (C))) */ ;   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/spi_slave.v(41[8] 54[6])
    defparam i3147_3_lut.init = 16'hcaca;
    LUT4 i3146_3_lut (.A(n4340), .B(dataOut[5]), .C(\counter_15__N_193[15] ), 
         .Z(n4341)) /* synthesis lut_function=(A (B+!(C))+!A (B (C))) */ ;   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/spi_slave.v(41[8] 54[6])
    defparam i3146_3_lut.init = 16'hcaca;
    LUT4 i3145_3_lut (.A(outreg[5]), .B(outreg[4]), .C(clock_N_160_enable_15), 
         .Z(n4340)) /* synthesis lut_function=(A (B+!(C))+!A (B (C))) */ ;   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/spi_slave.v(41[8] 54[6])
    defparam i3145_3_lut.init = 16'hcaca;
    LUT4 i3144_3_lut (.A(n4338), .B(dataOut[6]), .C(\counter_15__N_193[15] ), 
         .Z(n4339)) /* synthesis lut_function=(A (B+!(C))+!A (B (C))) */ ;   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/spi_slave.v(41[8] 54[6])
    defparam i3144_3_lut.init = 16'hcaca;
    LUT4 i3143_3_lut (.A(outreg[6]), .B(outreg[5]), .C(clock_N_160_enable_15), 
         .Z(n4338)) /* synthesis lut_function=(A (B+!(C))+!A (B (C))) */ ;   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/spi_slave.v(41[8] 54[6])
    defparam i3143_3_lut.init = 16'hcaca;
    LUT4 i3140_3_lut (.A(n4334), .B(dataOut[7]), .C(\counter_15__N_193[15] ), 
         .Z(n4335)) /* synthesis lut_function=(A (B+!(C))+!A (B (C))) */ ;   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/spi_slave.v(41[8] 54[6])
    defparam i3140_3_lut.init = 16'hcaca;
    LUT4 i3139_3_lut (.A(outreg[7]), .B(outreg[6]), .C(clock_N_160_enable_15), 
         .Z(n4334)) /* synthesis lut_function=(A (B+!(C))+!A (B (C))) */ ;   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/spi_slave.v(41[8] 54[6])
    defparam i3139_3_lut.init = 16'hcaca;
    LUT4 i3138_3_lut (.A(n4332), .B(dataOut[8]), .C(\counter_15__N_193[15] ), 
         .Z(n4333)) /* synthesis lut_function=(A (B+!(C))+!A (B (C))) */ ;   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/spi_slave.v(41[8] 54[6])
    defparam i3138_3_lut.init = 16'hcaca;
    LUT4 i3137_3_lut (.A(outreg[8]), .B(outreg[7]), .C(clock_N_160_enable_15), 
         .Z(n4332)) /* synthesis lut_function=(A (B+!(C))+!A (B (C))) */ ;   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/spi_slave.v(41[8] 54[6])
    defparam i3137_3_lut.init = 16'hcaca;
    LUT4 i3136_3_lut (.A(n4330), .B(dataOut[9]), .C(\counter_15__N_193[15] ), 
         .Z(n4331)) /* synthesis lut_function=(A (B+!(C))+!A (B (C))) */ ;   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/spi_slave.v(41[8] 54[6])
    defparam i3136_3_lut.init = 16'hcaca;
    LUT4 i3135_3_lut (.A(outreg[9]), .B(outreg[8]), .C(clock_N_160_enable_15), 
         .Z(n4330)) /* synthesis lut_function=(A (B+!(C))+!A (B (C))) */ ;   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/spi_slave.v(41[8] 54[6])
    defparam i3135_3_lut.init = 16'hcaca;
    LUT4 i3134_3_lut (.A(n4328), .B(dataOut[10]), .C(\counter_15__N_193[15] ), 
         .Z(n4329)) /* synthesis lut_function=(A (B+!(C))+!A (B (C))) */ ;   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/spi_slave.v(41[8] 54[6])
    defparam i3134_3_lut.init = 16'hcaca;
    LUT4 i3133_3_lut (.A(outreg[10]), .B(outreg[9]), .C(clock_N_160_enable_15), 
         .Z(n4328)) /* synthesis lut_function=(A (B+!(C))+!A (B (C))) */ ;   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/spi_slave.v(41[8] 54[6])
    defparam i3133_3_lut.init = 16'hcaca;
    LUT4 i3132_3_lut (.A(n4326), .B(dataOut[11]), .C(\counter_15__N_193[15] ), 
         .Z(n4327)) /* synthesis lut_function=(A (B+!(C))+!A (B (C))) */ ;   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/spi_slave.v(41[8] 54[6])
    defparam i3132_3_lut.init = 16'hcaca;
    LUT4 i3131_3_lut (.A(outreg[11]), .B(outreg[10]), .C(clock_N_160_enable_15), 
         .Z(n4326)) /* synthesis lut_function=(A (B+!(C))+!A (B (C))) */ ;   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/spi_slave.v(41[8] 54[6])
    defparam i3131_3_lut.init = 16'hcaca;
    LUT4 i3130_3_lut (.A(n4324), .B(dataOut[12]), .C(\counter_15__N_193[15] ), 
         .Z(n4325)) /* synthesis lut_function=(A (B+!(C))+!A (B (C))) */ ;   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/spi_slave.v(41[8] 54[6])
    defparam i3130_3_lut.init = 16'hcaca;
    LUT4 i3129_3_lut (.A(outreg[12]), .B(outreg[11]), .C(clock_N_160_enable_15), 
         .Z(n4324)) /* synthesis lut_function=(A (B+!(C))+!A (B (C))) */ ;   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/spi_slave.v(41[8] 54[6])
    defparam i3129_3_lut.init = 16'hcaca;
    LUT4 i3128_3_lut (.A(n4322), .B(dataOut[13]), .C(\counter_15__N_193[15] ), 
         .Z(n4323)) /* synthesis lut_function=(A (B+!(C))+!A (B (C))) */ ;   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/spi_slave.v(41[8] 54[6])
    defparam i3128_3_lut.init = 16'hcaca;
    LUT4 i3127_3_lut (.A(outreg[13]), .B(outreg[12]), .C(clock_N_160_enable_15), 
         .Z(n4322)) /* synthesis lut_function=(A (B+!(C))+!A (B (C))) */ ;   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/spi_slave.v(41[8] 54[6])
    defparam i3127_3_lut.init = 16'hcaca;
    LUT4 i6_2_lut (.A(counter[2]), .B(counter[7]), .Z(n22)) /* synthesis lut_function=(A+(B)) */ ;   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/spi_slave.v(42[7:19])
    defparam i6_2_lut.init = 16'heeee;
    LUT4 i3126_3_lut (.A(n4320), .B(dataOut[14]), .C(\counter_15__N_193[15] ), 
         .Z(n4321)) /* synthesis lut_function=(A (B+!(C))+!A (B (C))) */ ;   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/spi_slave.v(41[8] 54[6])
    defparam i3126_3_lut.init = 16'hcaca;
    LUT4 i3125_3_lut (.A(outreg[14]), .B(outreg[13]), .C(clock_N_160_enable_15), 
         .Z(n4320)) /* synthesis lut_function=(A (B+!(C))+!A (B (C))) */ ;   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/spi_slave.v(41[8] 54[6])
    defparam i3125_3_lut.init = 16'hcaca;
    LUT4 i3164_3_lut (.A(n4358), .B(dataOut[15]), .C(\counter_15__N_193[15] ), 
         .Z(n4359)) /* synthesis lut_function=(A (B+!(C))+!A (B (C))) */ ;   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/spi_slave.v(41[8] 54[6])
    defparam i3164_3_lut.init = 16'hcaca;
    LUT4 i3163_3_lut (.A(spi_miso_c), .B(outreg[14]), .C(clock_N_160_enable_15), 
         .Z(n4358)) /* synthesis lut_function=(A (B+!(C))+!A (B (C))) */ ;   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/spi_slave.v(41[8] 54[6])
    defparam i3163_3_lut.init = 16'hcaca;
    FD1S3AY counter_i0_i15 (.D(\counter_15__N_193[15] ), .CK(clock_N_160), 
            .Q(counter[15])) /* synthesis LSE_LINE_FILE_ID=5, LSE_LCOL=40, LSE_RCOL=125, LSE_LLINE=27, LSE_RLINE=27 */ ;   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/spi_slave.v(41[8] 54[6])
    defparam counter_i0_i15.GSR = "ENABLED";
    
endmodule
//
// Verilog Description of module serialIN_parallelOUT
//

module serialIN_parallelOUT (rd_data, spi_clk_c, spi_mosi_c, \counter_15__N_193[15] , 
            spi_csn_c) /* synthesis syn_module_defined=1 */ ;
    output [15:0]rd_data;
    input spi_clk_c;
    input spi_mosi_c;
    output \counter_15__N_193[15] ;
    input spi_csn_c;
    
    wire spi_clk_c /* synthesis is_clock=1 */ ;   // d:/workspace/ultrasounddoppler/0 machxo2 project/ultrasounddopplertop.v(7[19:26])
    
    wire dataIn_15__N_240;
    wire [15:0]inreg;   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/spi_slave.v(72[27:32])
    wire [15:0]counter;   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/spi_slave.v(72[18:25])
    
    wire n25, n6421, n26, n28, n22;
    
    FD1P3AX dataIn_i0_i0 (.D(spi_mosi_c), .SP(dataIn_15__N_240), .CK(spi_clk_c), 
            .Q(rd_data[0])) /* synthesis LSE_LINE_FILE_ID=5, LSE_LCOL=40, LSE_RCOL=135, LSE_LLINE=28, LSE_RLINE=28 */ ;   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/spi_slave.v(81[8] 94[6])
    defparam dataIn_i0_i0.GSR = "ENABLED";
    FD1S3AX inreg_i1 (.D(spi_mosi_c), .CK(spi_clk_c), .Q(inreg[0])) /* synthesis LSE_LINE_FILE_ID=5, LSE_LCOL=40, LSE_RCOL=135, LSE_LLINE=28, LSE_RLINE=28 */ ;   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/spi_slave.v(81[8] 94[6])
    defparam inreg_i1.GSR = "ENABLED";
    FD1S3AX done_15 (.D(dataIn_15__N_240), .CK(spi_clk_c), .Q(\counter_15__N_193[15] )) /* synthesis LSE_LINE_FILE_ID=5, LSE_LCOL=40, LSE_RCOL=135, LSE_LLINE=28, LSE_RLINE=28 */ ;   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/spi_slave.v(81[8] 94[6])
    defparam done_15.GSR = "ENABLED";
    FD1S3JX counter_i1 (.D(counter[2]), .CK(spi_clk_c), .PD(dataIn_15__N_240), 
            .Q(counter[1])) /* synthesis LSE_LINE_FILE_ID=5, LSE_LCOL=40, LSE_RCOL=135, LSE_LLINE=28, LSE_RLINE=28 */ ;   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/spi_slave.v(81[8] 94[6])
    defparam counter_i1.GSR = "ENABLED";
    FD1P3AX dataIn_i0_i1 (.D(inreg[0]), .SP(dataIn_15__N_240), .CK(spi_clk_c), 
            .Q(rd_data[1])) /* synthesis LSE_LINE_FILE_ID=5, LSE_LCOL=40, LSE_RCOL=135, LSE_LLINE=28, LSE_RLINE=28 */ ;   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/spi_slave.v(81[8] 94[6])
    defparam dataIn_i0_i1.GSR = "ENABLED";
    FD1P3AX dataIn_i0_i2 (.D(inreg[1]), .SP(dataIn_15__N_240), .CK(spi_clk_c), 
            .Q(rd_data[2])) /* synthesis LSE_LINE_FILE_ID=5, LSE_LCOL=40, LSE_RCOL=135, LSE_LLINE=28, LSE_RLINE=28 */ ;   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/spi_slave.v(81[8] 94[6])
    defparam dataIn_i0_i2.GSR = "ENABLED";
    FD1P3AX dataIn_i0_i3 (.D(inreg[2]), .SP(dataIn_15__N_240), .CK(spi_clk_c), 
            .Q(rd_data[3])) /* synthesis LSE_LINE_FILE_ID=5, LSE_LCOL=40, LSE_RCOL=135, LSE_LLINE=28, LSE_RLINE=28 */ ;   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/spi_slave.v(81[8] 94[6])
    defparam dataIn_i0_i3.GSR = "ENABLED";
    FD1P3AX dataIn_i0_i4 (.D(inreg[3]), .SP(dataIn_15__N_240), .CK(spi_clk_c), 
            .Q(rd_data[4])) /* synthesis LSE_LINE_FILE_ID=5, LSE_LCOL=40, LSE_RCOL=135, LSE_LLINE=28, LSE_RLINE=28 */ ;   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/spi_slave.v(81[8] 94[6])
    defparam dataIn_i0_i4.GSR = "ENABLED";
    FD1P3AX dataIn_i0_i5 (.D(inreg[4]), .SP(dataIn_15__N_240), .CK(spi_clk_c), 
            .Q(rd_data[5])) /* synthesis LSE_LINE_FILE_ID=5, LSE_LCOL=40, LSE_RCOL=135, LSE_LLINE=28, LSE_RLINE=28 */ ;   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/spi_slave.v(81[8] 94[6])
    defparam dataIn_i0_i5.GSR = "ENABLED";
    FD1P3AX dataIn_i0_i6 (.D(inreg[5]), .SP(dataIn_15__N_240), .CK(spi_clk_c), 
            .Q(rd_data[6])) /* synthesis LSE_LINE_FILE_ID=5, LSE_LCOL=40, LSE_RCOL=135, LSE_LLINE=28, LSE_RLINE=28 */ ;   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/spi_slave.v(81[8] 94[6])
    defparam dataIn_i0_i6.GSR = "ENABLED";
    FD1P3AX dataIn_i0_i7 (.D(inreg[6]), .SP(dataIn_15__N_240), .CK(spi_clk_c), 
            .Q(rd_data[7])) /* synthesis LSE_LINE_FILE_ID=5, LSE_LCOL=40, LSE_RCOL=135, LSE_LLINE=28, LSE_RLINE=28 */ ;   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/spi_slave.v(81[8] 94[6])
    defparam dataIn_i0_i7.GSR = "ENABLED";
    FD1P3AX dataIn_i0_i8 (.D(inreg[7]), .SP(dataIn_15__N_240), .CK(spi_clk_c), 
            .Q(rd_data[8])) /* synthesis LSE_LINE_FILE_ID=5, LSE_LCOL=40, LSE_RCOL=135, LSE_LLINE=28, LSE_RLINE=28 */ ;   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/spi_slave.v(81[8] 94[6])
    defparam dataIn_i0_i8.GSR = "ENABLED";
    FD1P3AX dataIn_i0_i9 (.D(inreg[8]), .SP(dataIn_15__N_240), .CK(spi_clk_c), 
            .Q(rd_data[9])) /* synthesis LSE_LINE_FILE_ID=5, LSE_LCOL=40, LSE_RCOL=135, LSE_LLINE=28, LSE_RLINE=28 */ ;   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/spi_slave.v(81[8] 94[6])
    defparam dataIn_i0_i9.GSR = "ENABLED";
    FD1P3AX dataIn_i0_i10 (.D(inreg[9]), .SP(dataIn_15__N_240), .CK(spi_clk_c), 
            .Q(rd_data[10])) /* synthesis LSE_LINE_FILE_ID=5, LSE_LCOL=40, LSE_RCOL=135, LSE_LLINE=28, LSE_RLINE=28 */ ;   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/spi_slave.v(81[8] 94[6])
    defparam dataIn_i0_i10.GSR = "ENABLED";
    FD1P3AX dataIn_i0_i11 (.D(inreg[10]), .SP(dataIn_15__N_240), .CK(spi_clk_c), 
            .Q(rd_data[11])) /* synthesis LSE_LINE_FILE_ID=5, LSE_LCOL=40, LSE_RCOL=135, LSE_LLINE=28, LSE_RLINE=28 */ ;   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/spi_slave.v(81[8] 94[6])
    defparam dataIn_i0_i11.GSR = "ENABLED";
    FD1P3AX dataIn_i0_i12 (.D(inreg[11]), .SP(dataIn_15__N_240), .CK(spi_clk_c), 
            .Q(rd_data[12])) /* synthesis LSE_LINE_FILE_ID=5, LSE_LCOL=40, LSE_RCOL=135, LSE_LLINE=28, LSE_RLINE=28 */ ;   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/spi_slave.v(81[8] 94[6])
    defparam dataIn_i0_i12.GSR = "ENABLED";
    FD1P3AX dataIn_i0_i13 (.D(inreg[12]), .SP(dataIn_15__N_240), .CK(spi_clk_c), 
            .Q(rd_data[13])) /* synthesis LSE_LINE_FILE_ID=5, LSE_LCOL=40, LSE_RCOL=135, LSE_LLINE=28, LSE_RLINE=28 */ ;   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/spi_slave.v(81[8] 94[6])
    defparam dataIn_i0_i13.GSR = "ENABLED";
    FD1P3AX dataIn_i0_i14 (.D(inreg[13]), .SP(dataIn_15__N_240), .CK(spi_clk_c), 
            .Q(rd_data[14])) /* synthesis LSE_LINE_FILE_ID=5, LSE_LCOL=40, LSE_RCOL=135, LSE_LLINE=28, LSE_RLINE=28 */ ;   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/spi_slave.v(81[8] 94[6])
    defparam dataIn_i0_i14.GSR = "ENABLED";
    FD1P3AX dataIn_i0_i15 (.D(inreg[14]), .SP(dataIn_15__N_240), .CK(spi_clk_c), 
            .Q(rd_data[15])) /* synthesis LSE_LINE_FILE_ID=5, LSE_LCOL=40, LSE_RCOL=135, LSE_LLINE=28, LSE_RLINE=28 */ ;   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/spi_slave.v(81[8] 94[6])
    defparam dataIn_i0_i15.GSR = "ENABLED";
    FD1S3AX inreg_i2 (.D(inreg[0]), .CK(spi_clk_c), .Q(inreg[1])) /* synthesis LSE_LINE_FILE_ID=5, LSE_LCOL=40, LSE_RCOL=135, LSE_LLINE=28, LSE_RLINE=28 */ ;   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/spi_slave.v(81[8] 94[6])
    defparam inreg_i2.GSR = "ENABLED";
    FD1S3AX inreg_i3 (.D(inreg[1]), .CK(spi_clk_c), .Q(inreg[2])) /* synthesis LSE_LINE_FILE_ID=5, LSE_LCOL=40, LSE_RCOL=135, LSE_LLINE=28, LSE_RLINE=28 */ ;   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/spi_slave.v(81[8] 94[6])
    defparam inreg_i3.GSR = "ENABLED";
    FD1S3AX inreg_i4 (.D(inreg[2]), .CK(spi_clk_c), .Q(inreg[3])) /* synthesis LSE_LINE_FILE_ID=5, LSE_LCOL=40, LSE_RCOL=135, LSE_LLINE=28, LSE_RLINE=28 */ ;   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/spi_slave.v(81[8] 94[6])
    defparam inreg_i4.GSR = "ENABLED";
    FD1S3AX inreg_i5 (.D(inreg[3]), .CK(spi_clk_c), .Q(inreg[4])) /* synthesis LSE_LINE_FILE_ID=5, LSE_LCOL=40, LSE_RCOL=135, LSE_LLINE=28, LSE_RLINE=28 */ ;   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/spi_slave.v(81[8] 94[6])
    defparam inreg_i5.GSR = "ENABLED";
    FD1S3AX inreg_i6 (.D(inreg[4]), .CK(spi_clk_c), .Q(inreg[5])) /* synthesis LSE_LINE_FILE_ID=5, LSE_LCOL=40, LSE_RCOL=135, LSE_LLINE=28, LSE_RLINE=28 */ ;   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/spi_slave.v(81[8] 94[6])
    defparam inreg_i6.GSR = "ENABLED";
    FD1S3AX inreg_i7 (.D(inreg[5]), .CK(spi_clk_c), .Q(inreg[6])) /* synthesis LSE_LINE_FILE_ID=5, LSE_LCOL=40, LSE_RCOL=135, LSE_LLINE=28, LSE_RLINE=28 */ ;   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/spi_slave.v(81[8] 94[6])
    defparam inreg_i7.GSR = "ENABLED";
    FD1S3AX inreg_i8 (.D(inreg[6]), .CK(spi_clk_c), .Q(inreg[7])) /* synthesis LSE_LINE_FILE_ID=5, LSE_LCOL=40, LSE_RCOL=135, LSE_LLINE=28, LSE_RLINE=28 */ ;   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/spi_slave.v(81[8] 94[6])
    defparam inreg_i8.GSR = "ENABLED";
    FD1S3AX inreg_i9 (.D(inreg[7]), .CK(spi_clk_c), .Q(inreg[8])) /* synthesis LSE_LINE_FILE_ID=5, LSE_LCOL=40, LSE_RCOL=135, LSE_LLINE=28, LSE_RLINE=28 */ ;   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/spi_slave.v(81[8] 94[6])
    defparam inreg_i9.GSR = "ENABLED";
    FD1S3AX inreg_i10 (.D(inreg[8]), .CK(spi_clk_c), .Q(inreg[9])) /* synthesis LSE_LINE_FILE_ID=5, LSE_LCOL=40, LSE_RCOL=135, LSE_LLINE=28, LSE_RLINE=28 */ ;   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/spi_slave.v(81[8] 94[6])
    defparam inreg_i10.GSR = "ENABLED";
    FD1S3AX inreg_i11 (.D(inreg[9]), .CK(spi_clk_c), .Q(inreg[10])) /* synthesis LSE_LINE_FILE_ID=5, LSE_LCOL=40, LSE_RCOL=135, LSE_LLINE=28, LSE_RLINE=28 */ ;   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/spi_slave.v(81[8] 94[6])
    defparam inreg_i11.GSR = "ENABLED";
    FD1S3AX inreg_i12 (.D(inreg[10]), .CK(spi_clk_c), .Q(inreg[11])) /* synthesis LSE_LINE_FILE_ID=5, LSE_LCOL=40, LSE_RCOL=135, LSE_LLINE=28, LSE_RLINE=28 */ ;   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/spi_slave.v(81[8] 94[6])
    defparam inreg_i12.GSR = "ENABLED";
    FD1S3AX inreg_i13 (.D(inreg[11]), .CK(spi_clk_c), .Q(inreg[12])) /* synthesis LSE_LINE_FILE_ID=5, LSE_LCOL=40, LSE_RCOL=135, LSE_LLINE=28, LSE_RLINE=28 */ ;   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/spi_slave.v(81[8] 94[6])
    defparam inreg_i13.GSR = "ENABLED";
    FD1S3AX inreg_i14 (.D(inreg[12]), .CK(spi_clk_c), .Q(inreg[13])) /* synthesis LSE_LINE_FILE_ID=5, LSE_LCOL=40, LSE_RCOL=135, LSE_LLINE=28, LSE_RLINE=28 */ ;   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/spi_slave.v(81[8] 94[6])
    defparam inreg_i14.GSR = "ENABLED";
    FD1S3AX inreg_i15 (.D(inreg[13]), .CK(spi_clk_c), .Q(inreg[14])) /* synthesis LSE_LINE_FILE_ID=5, LSE_LCOL=40, LSE_RCOL=135, LSE_LLINE=28, LSE_RLINE=28 */ ;   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/spi_slave.v(81[8] 94[6])
    defparam inreg_i15.GSR = "ENABLED";
    FD1S3JX counter_i2 (.D(counter[3]), .CK(spi_clk_c), .PD(dataIn_15__N_240), 
            .Q(counter[2])) /* synthesis LSE_LINE_FILE_ID=5, LSE_LCOL=40, LSE_RCOL=135, LSE_LLINE=28, LSE_RLINE=28 */ ;   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/spi_slave.v(81[8] 94[6])
    defparam counter_i2.GSR = "ENABLED";
    FD1S3JX counter_i3 (.D(counter[4]), .CK(spi_clk_c), .PD(dataIn_15__N_240), 
            .Q(counter[3])) /* synthesis LSE_LINE_FILE_ID=5, LSE_LCOL=40, LSE_RCOL=135, LSE_LLINE=28, LSE_RLINE=28 */ ;   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/spi_slave.v(81[8] 94[6])
    defparam counter_i3.GSR = "ENABLED";
    FD1S3JX counter_i4 (.D(counter[5]), .CK(spi_clk_c), .PD(dataIn_15__N_240), 
            .Q(counter[4])) /* synthesis LSE_LINE_FILE_ID=5, LSE_LCOL=40, LSE_RCOL=135, LSE_LLINE=28, LSE_RLINE=28 */ ;   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/spi_slave.v(81[8] 94[6])
    defparam counter_i4.GSR = "ENABLED";
    FD1S3JX counter_i5 (.D(counter[6]), .CK(spi_clk_c), .PD(dataIn_15__N_240), 
            .Q(counter[5])) /* synthesis LSE_LINE_FILE_ID=5, LSE_LCOL=40, LSE_RCOL=135, LSE_LLINE=28, LSE_RLINE=28 */ ;   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/spi_slave.v(81[8] 94[6])
    defparam counter_i5.GSR = "ENABLED";
    FD1S3JX counter_i6 (.D(counter[7]), .CK(spi_clk_c), .PD(dataIn_15__N_240), 
            .Q(counter[6])) /* synthesis LSE_LINE_FILE_ID=5, LSE_LCOL=40, LSE_RCOL=135, LSE_LLINE=28, LSE_RLINE=28 */ ;   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/spi_slave.v(81[8] 94[6])
    defparam counter_i6.GSR = "ENABLED";
    FD1S3JX counter_i7 (.D(counter[8]), .CK(spi_clk_c), .PD(dataIn_15__N_240), 
            .Q(counter[7])) /* synthesis LSE_LINE_FILE_ID=5, LSE_LCOL=40, LSE_RCOL=135, LSE_LLINE=28, LSE_RLINE=28 */ ;   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/spi_slave.v(81[8] 94[6])
    defparam counter_i7.GSR = "ENABLED";
    FD1S3JX counter_i8 (.D(counter[9]), .CK(spi_clk_c), .PD(dataIn_15__N_240), 
            .Q(counter[8])) /* synthesis LSE_LINE_FILE_ID=5, LSE_LCOL=40, LSE_RCOL=135, LSE_LLINE=28, LSE_RLINE=28 */ ;   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/spi_slave.v(81[8] 94[6])
    defparam counter_i8.GSR = "ENABLED";
    FD1S3JX counter_i9 (.D(counter[10]), .CK(spi_clk_c), .PD(dataIn_15__N_240), 
            .Q(counter[9])) /* synthesis LSE_LINE_FILE_ID=5, LSE_LCOL=40, LSE_RCOL=135, LSE_LLINE=28, LSE_RLINE=28 */ ;   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/spi_slave.v(81[8] 94[6])
    defparam counter_i9.GSR = "ENABLED";
    FD1S3JX counter_i10 (.D(counter[11]), .CK(spi_clk_c), .PD(dataIn_15__N_240), 
            .Q(counter[10])) /* synthesis LSE_LINE_FILE_ID=5, LSE_LCOL=40, LSE_RCOL=135, LSE_LLINE=28, LSE_RLINE=28 */ ;   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/spi_slave.v(81[8] 94[6])
    defparam counter_i10.GSR = "ENABLED";
    FD1S3JX counter_i11 (.D(counter[12]), .CK(spi_clk_c), .PD(dataIn_15__N_240), 
            .Q(counter[11])) /* synthesis LSE_LINE_FILE_ID=5, LSE_LCOL=40, LSE_RCOL=135, LSE_LLINE=28, LSE_RLINE=28 */ ;   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/spi_slave.v(81[8] 94[6])
    defparam counter_i11.GSR = "ENABLED";
    FD1S3JX counter_i12 (.D(counter[13]), .CK(spi_clk_c), .PD(dataIn_15__N_240), 
            .Q(counter[12])) /* synthesis LSE_LINE_FILE_ID=5, LSE_LCOL=40, LSE_RCOL=135, LSE_LLINE=28, LSE_RLINE=28 */ ;   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/spi_slave.v(81[8] 94[6])
    defparam counter_i12.GSR = "ENABLED";
    FD1S3JX counter_i13 (.D(counter[14]), .CK(spi_clk_c), .PD(dataIn_15__N_240), 
            .Q(counter[13])) /* synthesis LSE_LINE_FILE_ID=5, LSE_LCOL=40, LSE_RCOL=135, LSE_LLINE=28, LSE_RLINE=28 */ ;   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/spi_slave.v(81[8] 94[6])
    defparam counter_i13.GSR = "ENABLED";
    FD1S3JX counter_i14 (.D(counter[15]), .CK(spi_clk_c), .PD(dataIn_15__N_240), 
            .Q(counter[14])) /* synthesis LSE_LINE_FILE_ID=5, LSE_LCOL=40, LSE_RCOL=135, LSE_LLINE=28, LSE_RLINE=28 */ ;   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/spi_slave.v(81[8] 94[6])
    defparam counter_i14.GSR = "ENABLED";
    FD1S3AY counter_i15 (.D(dataIn_15__N_240), .CK(spi_clk_c), .Q(counter[15])) /* synthesis LSE_LINE_FILE_ID=5, LSE_LCOL=40, LSE_RCOL=135, LSE_LLINE=28, LSE_RLINE=28 */ ;   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/spi_slave.v(81[8] 94[6])
    defparam counter_i15.GSR = "ENABLED";
    LUT4 i5227_3_lut (.A(n25), .B(n6421), .C(n26), .Z(dataIn_15__N_240)) /* synthesis lut_function=(!(A+((C)+!B))) */ ;   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/spi_slave.v(89[7] 93[5])
    defparam i5227_3_lut.init = 16'h0404;
    LUT4 i9_4_lut (.A(counter[1]), .B(counter[2]), .C(counter[6]), .D(counter[8]), 
         .Z(n25)) /* synthesis lut_function=(A+(B+(C+(D)))) */ ;   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/spi_slave.v(88[5:24])
    defparam i9_4_lut.init = 16'hfffe;
    LUT4 i5226_4_lut (.A(counter[10]), .B(n28), .C(n22), .D(counter[12]), 
         .Z(n6421)) /* synthesis lut_function=(!(A+(B+(C+(D))))) */ ;   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/spi_slave.v(89[7] 93[5])
    defparam i5226_4_lut.init = 16'h0001;
    LUT4 i10_4_lut (.A(spi_csn_c), .B(counter[3]), .C(counter[13]), .D(counter[5]), 
         .Z(n26)) /* synthesis lut_function=(A+(B+(C+(D)))) */ ;   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/spi_slave.v(88[5:24])
    defparam i10_4_lut.init = 16'hfffe;
    LUT4 i12_4_lut (.A(counter[11]), .B(counter[9]), .C(counter[14]), 
         .D(counter[15]), .Z(n28)) /* synthesis lut_function=(A+(B+(C+(D)))) */ ;   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/spi_slave.v(88[5:24])
    defparam i12_4_lut.init = 16'hfffe;
    LUT4 i6_2_lut (.A(counter[4]), .B(counter[7]), .Z(n22)) /* synthesis lut_function=(A+(B)) */ ;   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/spi_slave.v(88[5:24])
    defparam i6_2_lut.init = 16'heeee;
    
endmodule
//
// Verilog Description of module TSALL
// module not written out since it is a black-box. 
//

//
// Verilog Description of module Storeage
//

module Storeage (n2239, n2242_c, readyToWrite, ADCData_c_1, RX_c_12, 
            RX_c_11, RX_c_10, RX_c_5, RX_c_4, RX_c_3, RX_c_2, MEM_DATA_OUT_7__N_13, 
            MEM_DATA_RD_CLK, ENABLE_N_2, DATA_OUT_c_7, DATA_OUT_c_6, 
            DATA_OUT_c_5, DATA_OUT_c_4, VCC_net, GND_net, RX_c_9, 
            RX_c_8, RX_c_7, RX_c_6, RX_c_1, RX_c_0, DATA_OUT_c_3, 
            DATA_OUT_c_2, DATA_OUT_c_1, DATA_OUT_c_0) /* synthesis syn_module_defined=1 */ ;
    input n2239;
    input n2242_c;
    output readyToWrite;
    input ADCData_c_1;
    input RX_c_12;
    input RX_c_11;
    input RX_c_10;
    input RX_c_5;
    input RX_c_4;
    input RX_c_3;
    input RX_c_2;
    input MEM_DATA_OUT_7__N_13;
    input MEM_DATA_RD_CLK;
    input ENABLE_N_2;
    output DATA_OUT_c_7;
    output DATA_OUT_c_6;
    output DATA_OUT_c_5;
    output DATA_OUT_c_4;
    input VCC_net;
    input GND_net;
    input RX_c_9;
    input RX_c_8;
    input RX_c_7;
    input RX_c_6;
    input RX_c_1;
    input RX_c_0;
    output DATA_OUT_c_3;
    output DATA_OUT_c_2;
    output DATA_OUT_c_1;
    output DATA_OUT_c_0;
    
    wire n2239 /* synthesis is_clock=1, SET_AS_NETWORK=n2239 */ ;   // d:/workspace/ultrasounddoppler/0 machxo2 project/ultrasounddopplertop.v(18[15:21])
    wire MEM_DATA_OUT_7__N_13 /* synthesis is_clock=1 */ ;   // d:/workspace/ultrasounddoppler/0 machxo2 project/ultrasounddopplertop.v(117[13:25])
    wire [1:0]canReadAE;   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/storagelayer.v(38[11:20])
    
    wire FlagAE_OSZI;
    wire [1:0]canReadAF;   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/storagelayer.v(37[11:20])
    
    wire FlagAF_OSZI, n2239_enable_1, n6691;
    
    FD1P3AX canReadAE_i0_i0 (.D(FlagAE_OSZI), .SP(n2242_c), .CK(n2239), 
            .Q(canReadAE[0])) /* synthesis LSE_LINE_FILE_ID=3, LSE_LCOL=10, LSE_RCOL=2, LSE_LLINE=128, LSE_RLINE=140 */ ;   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/storagelayer.v(44[7] 49[5])
    defparam canReadAE_i0_i0.GSR = "DISABLED";
    FD1P3AX canReadAF_i0_i1 (.D(canReadAF[0]), .SP(n2242_c), .CK(n2239), 
            .Q(canReadAF[1])) /* synthesis LSE_LINE_FILE_ID=3, LSE_LCOL=10, LSE_RCOL=2, LSE_LLINE=128, LSE_RLINE=140 */ ;   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/storagelayer.v(44[7] 49[5])
    defparam canReadAF_i0_i1.GSR = "DISABLED";
    FD1P3AX canReadAE_i0_i1 (.D(canReadAE[0]), .SP(n2242_c), .CK(n2239), 
            .Q(canReadAE[1])) /* synthesis LSE_LINE_FILE_ID=3, LSE_LCOL=10, LSE_RCOL=2, LSE_LLINE=128, LSE_RLINE=140 */ ;   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/storagelayer.v(44[7] 49[5])
    defparam canReadAE_i0_i1.GSR = "DISABLED";
    FD1P3AX canReadAF_i0_i0 (.D(FlagAF_OSZI), .SP(n2242_c), .CK(n2239), 
            .Q(canReadAF[0])) /* synthesis LSE_LINE_FILE_ID=3, LSE_LCOL=10, LSE_RCOL=2, LSE_LLINE=128, LSE_RLINE=140 */ ;   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/storagelayer.v(44[7] 49[5])
    defparam canReadAF_i0_i0.GSR = "DISABLED";
    FD1P3AY READY2WRITE_30 (.D(n6691), .SP(n2239_enable_1), .CK(n2239), 
            .Q(readyToWrite)) /* synthesis LSE_LINE_FILE_ID=3, LSE_LCOL=10, LSE_RCOL=2, LSE_LLINE=128, LSE_RLINE=140 */ ;   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/storagelayer.v(44[7] 49[5])
    defparam READY2WRITE_30.GSR = "ENABLED";
    LUT4 equal_30_i3_2_lut_rep_75 (.A(canReadAF[0]), .B(canReadAF[1]), .Z(n6691)) /* synthesis lut_function=((B)+!A) */ ;   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/storagelayer.v(48[18:38])
    defparam equal_30_i3_2_lut_rep_75.init = 16'hdddd;
    LUT4 i5248_3_lut_4_lut (.A(canReadAF[0]), .B(canReadAF[1]), .C(canReadAE[1]), 
         .D(canReadAE[0]), .Z(n2239_enable_1)) /* synthesis lut_function=(!(A (B (C+!(D)))+!A (C+!(D)))) */ ;   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/storagelayer.v(48[18:38])
    defparam i5248_3_lut_4_lut.init = 16'h2f22;
    FIFO_OUT Data_OSZI_7__I_0 (.ADCData_c_1(ADCData_c_1), .RX_c_12(RX_c_12), 
            .RX_c_11(RX_c_11), .RX_c_10(RX_c_10), .RX_c_5(RX_c_5), .RX_c_4(RX_c_4), 
            .RX_c_3(RX_c_3), .RX_c_2(RX_c_2), .MEM_DATA_OUT_7__N_13(MEM_DATA_OUT_7__N_13), 
            .MEM_DATA_RD_CLK(MEM_DATA_RD_CLK), .n2242_c(n2242_c), .ENABLE_N_2(ENABLE_N_2), 
            .DATA_OUT_c_7(DATA_OUT_c_7), .DATA_OUT_c_6(DATA_OUT_c_6), .DATA_OUT_c_5(DATA_OUT_c_5), 
            .DATA_OUT_c_4(DATA_OUT_c_4), .VCC_net(VCC_net), .GND_net(GND_net), 
            .RX_c_9(RX_c_9), .RX_c_8(RX_c_8), .RX_c_7(RX_c_7), .RX_c_6(RX_c_6), 
            .RX_c_1(RX_c_1), .RX_c_0(RX_c_0), .DATA_OUT_c_3(DATA_OUT_c_3), 
            .DATA_OUT_c_2(DATA_OUT_c_2), .DATA_OUT_c_1(DATA_OUT_c_1), .DATA_OUT_c_0(DATA_OUT_c_0), 
            .FlagAE_OSZI(FlagAE_OSZI), .FlagAF_OSZI(FlagAF_OSZI)) /* synthesis NGD_DRC_MASK=1, syn_module_defined=1 */ ;   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/storagelayer.v(52[10] 53[118])
    
endmodule
//
// Verilog Description of module FIFO_OUT
//

module FIFO_OUT (ADCData_c_1, RX_c_12, RX_c_11, RX_c_10, RX_c_5, RX_c_4, 
            RX_c_3, RX_c_2, MEM_DATA_OUT_7__N_13, MEM_DATA_RD_CLK, n2242_c, 
            ENABLE_N_2, DATA_OUT_c_7, DATA_OUT_c_6, DATA_OUT_c_5, DATA_OUT_c_4, 
            VCC_net, GND_net, RX_c_9, RX_c_8, RX_c_7, RX_c_6, RX_c_1, 
            RX_c_0, DATA_OUT_c_3, DATA_OUT_c_2, DATA_OUT_c_1, DATA_OUT_c_0, 
            FlagAE_OSZI, FlagAF_OSZI) /* synthesis NGD_DRC_MASK=1, syn_module_defined=1 */ ;
    input ADCData_c_1;
    input RX_c_12;
    input RX_c_11;
    input RX_c_10;
    input RX_c_5;
    input RX_c_4;
    input RX_c_3;
    input RX_c_2;
    input MEM_DATA_OUT_7__N_13;
    input MEM_DATA_RD_CLK;
    input n2242_c;
    input ENABLE_N_2;
    output DATA_OUT_c_7;
    output DATA_OUT_c_6;
    output DATA_OUT_c_5;
    output DATA_OUT_c_4;
    input VCC_net;
    input GND_net;
    input RX_c_9;
    input RX_c_8;
    input RX_c_7;
    input RX_c_6;
    input RX_c_1;
    input RX_c_0;
    output DATA_OUT_c_3;
    output DATA_OUT_c_2;
    output DATA_OUT_c_1;
    output DATA_OUT_c_0;
    output FlagAE_OSZI;
    output FlagAF_OSZI;
    
    wire MEM_DATA_OUT_7__N_13 /* synthesis is_clock=1 */ ;   // d:/workspace/ultrasounddoppler/0 machxo2 project/ultrasounddopplertop.v(117[13:25])
    
    wire Empty, Full;
    
    FIFO8KB FIFO_OUT_1_0 (.DI0(RX_c_2), .DI1(RX_c_3), .DI2(RX_c_4), .DI3(RX_c_5), 
            .DI4(RX_c_10), .DI5(RX_c_11), .DI6(RX_c_12), .DI7(ADCData_c_1), 
            .DI8(GND_net), .DI9(GND_net), .DI10(GND_net), .DI11(GND_net), 
            .DI12(GND_net), .DI13(GND_net), .DI14(GND_net), .DI15(GND_net), 
            .DI16(GND_net), .DI17(GND_net), .FULLI(Full), .EMPTYI(Empty), 
            .CSW1(VCC_net), .CSW0(VCC_net), .CSR1(VCC_net), .CSR0(n2242_c), 
            .WE(n2242_c), .RE(VCC_net), .ORE(VCC_net), .CLKW(MEM_DATA_OUT_7__N_13), 
            .CLKR(MEM_DATA_RD_CLK), .RST(ENABLE_N_2), .RPRST(ENABLE_N_2), 
            .DO0(DATA_OUT_c_4), .DO1(DATA_OUT_c_5), .DO2(DATA_OUT_c_6), 
            .DO3(DATA_OUT_c_7)) /* synthesis syn_instantiated=1, LSE_LINE_FILE_ID=12, LSE_LCOL=10, LSE_RCOL=118, LSE_LLINE=52, LSE_RLINE=53 */ ;   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/storagelayer.v(52[10] 53[118])
    defparam FIFO_OUT_1_0.DATA_WIDTH_W = 9;
    defparam FIFO_OUT_1_0.DATA_WIDTH_R = 4;
    defparam FIFO_OUT_1_0.REGMODE = "OUTREG";
    defparam FIFO_OUT_1_0.RESETMODE = "ASYNC";
    defparam FIFO_OUT_1_0.ASYNC_RESET_RELEASE = "ASYNC";
    defparam FIFO_OUT_1_0.CSDECODE_W = "0b11";
    defparam FIFO_OUT_1_0.CSDECODE_R = "0b11";
    defparam FIFO_OUT_1_0.AEPOINTER = "0b11111111111100";
    defparam FIFO_OUT_1_0.AEPOINTER1 = "0b00000000000000";
    defparam FIFO_OUT_1_0.AFPOINTER = "0b11111111111100";
    defparam FIFO_OUT_1_0.AFPOINTER1 = "0b00000000000000";
    defparam FIFO_OUT_1_0.FULLPOINTER = "0b11111111111100";
    defparam FIFO_OUT_1_0.FULLPOINTER1 = "0b00000000000000";
    defparam FIFO_OUT_1_0.GSR = "DISABLED";
    FIFO8KB FIFO_OUT_0_1 (.DI0(ADCData_c_1), .DI1(ADCData_c_1), .DI2(RX_c_0), 
            .DI3(RX_c_1), .DI4(RX_c_6), .DI5(RX_c_7), .DI6(RX_c_8), 
            .DI7(RX_c_9), .DI8(GND_net), .DI9(GND_net), .DI10(GND_net), 
            .DI11(GND_net), .DI12(GND_net), .DI13(GND_net), .DI14(GND_net), 
            .DI15(GND_net), .DI16(GND_net), .DI17(GND_net), .FULLI(Full), 
            .EMPTYI(Empty), .CSW1(VCC_net), .CSW0(VCC_net), .CSR1(VCC_net), 
            .CSR0(n2242_c), .WE(n2242_c), .RE(VCC_net), .ORE(VCC_net), 
            .CLKW(MEM_DATA_OUT_7__N_13), .CLKR(MEM_DATA_RD_CLK), .RST(ENABLE_N_2), 
            .RPRST(ENABLE_N_2), .DO0(DATA_OUT_c_0), .DO1(DATA_OUT_c_1), 
            .DO2(DATA_OUT_c_2), .DO3(DATA_OUT_c_3), .EF(Empty), .AEF(FlagAE_OSZI), 
            .AFF(FlagAF_OSZI), .FF(Full)) /* synthesis syn_instantiated=1, LSE_LINE_FILE_ID=12, LSE_LCOL=10, LSE_RCOL=118, LSE_LLINE=52, LSE_RLINE=53 */ ;   // d:/workspace/ultrasounddoppler/0 machxo2 project/modules/storagelayer.v(52[10] 53[118])
    defparam FIFO_OUT_0_1.DATA_WIDTH_W = 9;
    defparam FIFO_OUT_0_1.DATA_WIDTH_R = 4;
    defparam FIFO_OUT_0_1.REGMODE = "OUTREG";
    defparam FIFO_OUT_0_1.RESETMODE = "ASYNC";
    defparam FIFO_OUT_0_1.ASYNC_RESET_RELEASE = "ASYNC";
    defparam FIFO_OUT_0_1.CSDECODE_W = "0b11";
    defparam FIFO_OUT_0_1.CSDECODE_R = "0b11";
    defparam FIFO_OUT_0_1.AEPOINTER = "0b00010000000000";
    defparam FIFO_OUT_0_1.AEPOINTER1 = "0b00010000000100";
    defparam FIFO_OUT_0_1.AFPOINTER = "0b01111000000000";
    defparam FIFO_OUT_0_1.AFPOINTER1 = "0b01110111111000";
    defparam FIFO_OUT_0_1.FULLPOINTER = "0b10000000000000";
    defparam FIFO_OUT_0_1.FULLPOINTER1 = "0b01111111111000";
    defparam FIFO_OUT_0_1.GSR = "DISABLED";
    
endmodule
