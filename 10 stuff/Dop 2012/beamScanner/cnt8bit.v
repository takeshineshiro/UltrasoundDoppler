

// DATE:     04.09.20138 11:35:20 
// TITLE:    
// MODULE:   cnt8bit
// DESIGN:   cnt8bit
// FILENAME: cnt8bit.v
// PROJECT:  BeamScanner
// VERSION:  1.0
//
// simple 8bit counter to create dummy data 


`timescale 1 ns / 1 ns

module cnt8bit(CLK, nCLR, nEN, Q);
// Inputs
	input CLK;
	input nCLR;
	input nEN;

// Outputs
	output [7:0] Q;

// Inputs Data Types
	wire CLK, nCLR, nEN;

// Outputs Data Types 
	reg [7:0] Q;

// Internal Variables

// ### Code Start ###

always@(posedge CLK or negedge nCLR)

	if (nCLR == 0)
		Q <= 0;
	else if (nEN == 1)
		Q <= Q;
	else
		Q <= Q + 1;


endmodule // cnt8bit