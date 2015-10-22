//
// File            : dataMUX.v
// Author          : stemplew
// Date            : 07/27/2012
// Version         : 1.2
// Abstract        : MUX: four channels 32bit-width to one channel 8bit-width, generating every scnd Clock a Write-Signal-output
//
// Modification History:
// Date        By       Version    Change Description
//
// ===========================================================
// 00/00/00    xxx      x.x        Original
// 
// ===========================================================

module dataMUX(
	input wire [31:0] A, B, C, D, 
	input wire CLK, nClkEn, EN,Reset, 
	output reg[7:0] Q, 
	output reg WR);

integer count;

always @(posedge CLK or posedge Reset)
	begin
		if (Reset)
			begin
				Q[7:0] <= 0;
				WR <= 0;
				count <= 35;
			end
					
		else if (nClkEn) count <= 0;
		
		else if (count < 35)
			begin
				
				case (count)
					0:	begin WR <= 0; count <= 1; Q <= 8'hAA; end		// start Data sync Byte hex AA	
					1:	begin WR <= 1; count <= 2; end								
					2:	begin WR <= 0; count <= 3; Q <= A[7:0]; end		// LSB Input A						
					3:	begin WR <= 1; count <= 4; end						
					4:	begin WR <= 0; count <= 5; Q <= A[15:8]; end											
					5:	begin WR <= 1; count <= 6; end										
					6:	begin WR <= 0; count <= 7; Q <= A[23:16]; end											
					7:	begin WR <= 1; count <= 8; end										
					8:	begin WR <= 0; count <= 9;  Q <= A[31:24]; end	// MSB Input A					
					9:	begin WR <= 1; count <= 10; end										
					10:	begin WR <= 0; count <= 11; Q <= B[7:0]; end	// LSB Input B					
					11:	begin WR <= 1; count <= 12; end										
					12:	begin WR <= 0; count <= 13; Q <= B[15:8]; end					
					13:	begin WR <= 1; count <= 14; end										
					14:	begin WR <= 0; count <= 15; Q <= B[23:16]; end						
					15:	begin WR <= 1; count <= 16; end										
					16:	begin WR <= 0; count <= 17; Q <= B[31:24]; end	// MSB Input B						
					17: begin WR <= 1; count <= 18; end										
					18:	begin WR <= 0; count <= 19; Q <= C[7:0]; end	// LSB Input C								
					19:	begin WR <= 1; count <= 20; end								
					20:	begin WR <= 0; count <= 21; Q <= C[15:8]; end						
					21:	begin WR <= 1; count <= 22; end						
					22:	begin WR <= 0; count <= 23; Q <= C[23:16]; end					
					23:	begin WR <= 1; count <= 24; end					
					24:	begin WR <= 0; count <= 25; Q <= C[31:24]; end			// MSB Input C					
					25:	begin WR <= 1; count <= 26; end					
					26:	begin WR <= 0; count <= 27; Q <= D[7:0]; end		// LSB Input D					
					27:	begin WR <= 1; count <= 28; end					
					28:	begin WR <= 0; count <= 29; Q <= D[15:8]; end					
					29:	begin WR <= 1; count <= 30; end					
					30:	begin WR <= 0; count <= 31; Q <= D[23:16]; end					
					31:	begin WR <= 1; count <= 32; end					
					32:	begin WR <= 0; count <= 33; Q <= D[31:24]; end			// MSB Input D						
					33:	begin WR <= 1; count <= 34; end					
					34: begin WR <= 0; count <= 35; Q <= 0; end					
				endcase
			end
	end

endmodule
