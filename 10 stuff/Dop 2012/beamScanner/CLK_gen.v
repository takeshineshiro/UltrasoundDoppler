
`timescale 1 ns / 1 ns

module CLK_gen( CLK64, RES_n, F8, F4, F2, WR_Freq, BURST_EN, ADC_EN, SMPL_EN, CLK_4MHz, BURST_P, BURST_N, CLK_ADC, CLK_SMPL);

  input CLK64;
  input RES_n;
  input F8, F4, F2;
  input WR_Freq;
  input BURST_EN;
  input ADC_EN;
  input SMPL_EN;
  output CLK_4MHz;
  output BURST_P;
  output BURST_N;
  output CLK_ADC;
  output CLK_SMPL;
	
  reg Freq2 = 0;
  reg Freq4 = 0;
  reg Freq8 = 0;
  reg [3:0] PICcnt = 0;
  reg [4:0] SYNCcnt = 0;
	wire BURSTclk;
	
assign CLK_4MHz = PICcnt[3];
assign CLK_ADC  = ADC_EN && CLK64;
assign CLK_SMPL = SMPL_EN && CLK64;
//                  Freq8 && ADC_EN && CLK64
//               || Freq4 && ADC_EN && SYNCcnt[0]
//               || Freq2 && ADC_EN && SYNCcnt[1];


assign BURSTclk = Freq8 && SYNCcnt[2] && RES_n
               || Freq4 && SYNCcnt[3] && RES_n
               || Freq2 && SYNCcnt[4] && RES_n;
assign BURST_P = BURST_EN && ~BURSTclk;
assign BURST_N = BURST_EN && BURSTclk;


always @(posedge WR_Freq)
	begin 
		Freq8 <= F8;
		Freq4 <= F4;
		Freq2 <= F2;
	end


always @(posedge CLK64)
	begin
		PICcnt <= PICcnt + 1;
		if(BURST_EN || ADC_EN)
				SYNCcnt <= SYNCcnt +1;
		else
				SYNCcnt <= 0;	
	end		
  
 endmodule
 	