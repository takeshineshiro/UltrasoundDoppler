`define ADCbitCount 14
//`define Delay 7
`define AlwaysOn 1

module ADC_Inbetriebnahme
   (input wire [`ADCbitCount-1:0] pins,
    input wire enable, frequency,
	output wire adcClock,
	output wire [`ADCbitCount-1:0] sampledata);

assign adcClock = enable && frequency;
assign sampledata = (`AlwaysOn == 1) ? pins : {`ADCbitCount{1'b0}};

endmodule