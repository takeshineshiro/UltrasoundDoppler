

// DATE:     20.01.2014 11:35:20 
// TITLE:    
// MODULE:   cnt16bit
// DESIGN:   cnt16bit
// FILENAME: cnt16bit.v
// PROJECT:  BeamScanner
// VERSION:  1.0
//
// simple 8bit counter to create dummy data 


`timescale 1 ns / 1 ns

module cnt16bit(CLK, nCLR, nEN, Q);
// Inputs
	input CLK;
	input nCLR;
	input nEN;

// Outputs
	output [15:0] Q;

// Inputs Data Types
	wire CLK, nCLR, nEN;

// Outputs Data Types 
	reg [15:0] Q;

// Internal Variables

// ### Code Start ###

always@(posedge CLK or negedge nCLR)

	if (nCLR == 0)
		Q <= 0;
	else if (nEN == 1)
		Q <= Q;
	else
		Q <= Q + 1;


endmodule // cnt16bit