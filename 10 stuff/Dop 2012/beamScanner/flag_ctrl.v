// File            : flag_ctrl.v
// Author          : Erhart
// Date            : 23/03/2012
// Version         : 1.0
// Abstract        : 	Modul zum Empang der Flags aus dem FIFO. 
//						Daraus wird ein Signal generiert, das der PIC verwerten kann.
//						Dabei soll auf die Flanken von AF und AE reagiert werden.
// Modification History:
// Date        By       Version    Change Description
//
// ===========================================================
//23/03/2012    	      1.0        Original
// 
// ===========================================================
module flag_ctrl(AE, AF, CLK, Reset, read); //AE_state, AF_state);
		
	
//ports:
input AE;
input AF;
input CLK;
input Reset;

output read;
reg read;

reg oldAF;
reg oldAE;


always @(posedge CLK)
	begin
		if((!oldAE && AE) || Reset) read <= 0;
		else if(!oldAF && AF) read<= 1;
			
		oldAE <= AE;
		oldAF <= AF;
	end
	
endmodule
	