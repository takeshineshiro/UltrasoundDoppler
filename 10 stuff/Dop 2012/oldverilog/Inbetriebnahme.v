`define SPI			2'b00
`define SSP8		2'b01
`define SSP16		2'b10
`define Deep		5
`define Bufferlengh	120


module Inbetriebnahme(
	input wire CTR_CLOCK, CTR_SYNC, CTR_DATA, CTR_ENABLE, Xin, DATA_READ_THROUGH,
	input wire[13:0] ADC,
	output wire Burst_N, Burst_P, TRIGGER, PDWN_0, PDWN_1, ADC_CLK, ADC_PWDN, DATA_READY,
	inout wire[15:0] DATA);
	
//fields
reg[15:0] Data_adc = 0;
wire[13:0] adc_wire;
wire[1:0] Frequency, Sampling, OutputInterface, SegDone;
reg[7:0] Data_out;
	
	StateHandler 	handler(.mainclk(Xin), .dataIn(CTR_DATA), .ctr_clk(CTR_CLOCK), .ctr_cs(CTR_SYNC), .ctr_enable(CTR_ENABLE),
								.StateError(StateError), .TransmitterOn(TransmitterOn), .Retransmit(Retransmit), 
								.MeasureType(MeasureType), .TriggerOn(TRIGGER), .Frequency(Frequency), .Sampling(Sampling),
								.OutputInterface(OutputInterface)); //TRIGGER
	 
	ADC_Inbetriebnahme adc   (.pins(ADC), .enable(TRIGGER), .frequency(Xin), .adcClock(ADC_CLK), .sampledata(adc_wire));

DataFiFoInbetriebnahme (.Data(Data_adc), .WrClock(Sampling[1] | Sampling[0]), .RdClock(SegDone), .WrEn(CTR_ENABLE), .RdEn(CTR_ENABLE), .Reset(~CTR_ENABLE), 
    .RPReset(1'b0), .Q(Data_out), .Empty(), .Full(), .AlmostEmpty(), .AlmostFull())/* synthesis NGD_DRC_MASK=1 */;
    output wire Empty;
    output wire Full;
    output wire AlmostEmpty;
    output wire AlmostFull;
	
	DATA_READY

	SPI_slave #(1)	mode3(.rstb(~CTR_ENABLE), .ten(1), .tdata(Data_out), .ss(1'b0), .sck(DATA[0]),
						.mosi(DATA[2]), .miso(DATA[3]), .done(SegDone), .rdata(MOSI_Data));
	
endmodule
