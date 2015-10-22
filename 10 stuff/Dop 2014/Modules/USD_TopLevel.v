`include "Defines.v"
module USD_TopLevel( 
	input wire CLK_64MHz, ENABLE,
	inout wire[13:0] ADC,
	inout wire[2:0] SPI,
	output wire[3:0] TX,
	output wire READY2READ, ADC_CLK, ADC_PWDN
	); ///* synthesis GSR=”ENABLED” */
	
//GSR GSR_INST (.GSR (~ENABLE));
	
	wire NextRead, WriteToFiFo, retransmit, run, ENdemod;
	wire[7:0] SampleVolumeLength;
	wire[1:0] freq;
	wire[2:0] RegBus, GateDivider;
	wire[15:0] RegValueBus;
	wire[15:0] State [0:3];
	wire[`RegBusWidth-1:0] DataBus;				
	
CommunicationLayer comm(
	.rstb(~ENABLE), .mosi(SPI[1]), .sck(SPI[0]),
	.Reg(RegBus), .RegValue(RegValueBus), .outdone(NextRead),
	.miso(SPI[2]), .DataOut(DataBus));

MemoryMap mem(
	.cmd(RegBus), .value(RegValueBus), .coreClock(CLK_64MHz), // future .SETFREQUENCY(freq),
	.RX_ON(ADC_PWDN), .TX_ON(TX[1:0]), 
	.RUN(run), .FREQUENCY(freq), .GATEdiv(GateDivider), .SVlength(SampleVolumeLength),
	.State0Value(State[0]), .State1Value(State[1]), .State2Value(State[2]), .StateRValue(State[3])
	);
CoreLayer core(
	.coreClock(CLK_64MHz), .ENABLE(run), .RESET(~ENABLE), .freq(freq),
	.State0Value(State[0]), .State1Value(State[1]), .State2Value(State[2]), .StateRValue(State[3]),
	.TX_POS(TX[2]), .TX_NEG(TX[3]),	.RX_CLK(ADC_CLK), .DEMOD_ON(ENdemod), .RETRANSMIT(retransmit)) ;

	wire[31:0] re, im;

Demodulate demod(
	//.CORECLK(CLK_64MHz), .FREQUENCY(freq),
	.DEMODCLK(ADC_CLK), .ENABLE(ENdemod), .RESET(~ENABLE || retransmit),
	.GATEdiv(GateDivider), .SVLength(SampleVolumeLength), .adcValue(ADC), 
	.IN(re), .QUAD(im), .WRITE(WriteToFiFo));

function [1:0] ADC14To16;
	input ADCbit;
	begin
		ADC14To16 = ADCbit ? 2'b11 : 2'b00;
	end
endfunction
wire[15:0] ADCData = {ADC, ADC14To16(ADC[13])} ;

/*
function [17:0] ADC14To32;
	input ADCbit;
	begin
		ADC14To32 = ADCbit ? {17{1'b1}} : {17{1'b0}};
	end
endfunction
wire[31:0] ADC32 = {ADC, ADC14To32(ADC[13])};
*/

Storeage ram(
.WRITE(WriteToFiFo), .READ(NextRead), .RE_IN(re), .IM_IN(im), .ENABLE(ENABLE), .RESET(~ENABLE),
.DOUT(DataBus), .READY2READ(READY2READ));
/*
Storeage ram(
.MODE(Mode), .WRITE((Mode == `OSZI_MODE) ? SampleClock : WriteToFiFo), .READ(NextRead), .DIN(ADCData), .RE_IN(re), .IM_IN(im), .ENABLE(ENABLE), .RESET(~ENABLE),
.DOUT(DataBus), .READY2READ(READY2READ));
*/

endmodule