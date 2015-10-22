
`timescale 1 ns / 1 ns

module CLK_gen( CLK64, RES_n, F8, F4, F2, WR_Freq, BURST_EN, ADC_EN, CLK_4MHz, BURST_P, BURST_N, CLK_ADC);

  input CLK64;
  input RES_n;
  input F8, F4, F2;
  input WR_Freq;
	input BURST_EN;
	input ADC_EN;
  output CLK_4MHz;
	output BURST_P;
	output BURST_N;
  output CLK_ADC;
  reg Freq2 = 0;
  reg Freq4 = 0;
  reg Freq8 = 0;
  reg [3:0] counter = 0;
  
assign CLK_4MHz = counter[3]; 

assign CLK_out = 	Freq8 && CLK64 && RES_n
					|| Freq4 && counter[0] && RES_n
					|| Freq2 && counter[1] && RES_n;


always @(posedge WR_Freq)
	begin 
		Freq8 <= F8;
		Freq4 <= F4;
		Freq2 <= F2;
	end

	
	
always @(posedge CLK64)
		begin
			counter <= counter + 1;
		end		


   
 endmodule
 