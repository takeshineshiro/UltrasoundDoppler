
module USD_TopLevel(
	input wire CLK_64MHz, SPP_DATA_0, SPP_DATA_1, SPP_DATA_2, SPP_DATA_3, SPP_DATA_4
	input wire[13:0] ADC,
	output wire ADC_CLK, ADC_PWDN, PDWN_0, PDWN_1, pos_burst, neg_burst
	);
	
	wire PullData;
	wire[7:0] RegBus;
	wire[15:0] RegValueBus;
	
CommunicationLayer comm(
	.mosi(SRDATA), .ss(nSRSYNC), .sck(SRCLK), .reset(nRESET), .SendDataMode(PullData),
	.DataOut(),
	.Reg(RegBus), 
	.RegValue(RegValueBus),
	.Transfered(), .miso()
	);
	
USDCoreLayer #(16) core(.cmd(RegBus), .value(RegValueBus),
	.write(), .clock(CLK_64MHz), .enable(~nENABLE),
	.Trigger(), .TX_pos(pos_burst), .TX_neg(neg_burst), .TX_pwdn0(PDWN_0), .TX_pwdn1(PDWN_1), .RX_clock(ADC_CLK), .RX_pwdn(ADC_PWDN), .RX_read(),
	.PullData(PullData));
	
endmodule