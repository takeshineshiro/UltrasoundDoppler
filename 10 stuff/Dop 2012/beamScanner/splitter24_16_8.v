// DATE:     25-NOV-2013 13:11:00 
// TITLE:    
// MODULE:   splitter24_16_8
// DESIGN:   splitter24_16_8
// FILENAME: splitter24_16_8.v
// PROJECT:  
// VERSION:  1.0

`timescale 1 ns / 1 ns

module splitter24_16_8(D,Ctrl, Cnt);
// Inputs
	input [23:0] D;
// Outputs	
	output [15:0] Cnt;
	output [7:0] Ctrl;


// Inputs Data Types
	wire [23:0] D;
// Outputs Data Types 
	wire [15:0] Cnt;
	wire [7:0] Ctrl;

// ### Code Start ###
 
assign
	Ctrl[7:0] = D[23:16];

assign
	Cnt[15:0] = D[15:0];

endmodule // splitter24_16_8