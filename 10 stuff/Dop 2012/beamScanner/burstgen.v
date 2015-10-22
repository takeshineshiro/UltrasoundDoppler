`timescale 1 ns / 1 ns

module burstgen(Burst_p, Burst_n, Sin_in, gate);

  input Sin_in;
  input gate;
  output Burst_p;
  output Burst_n;
  reg sync;
  wire neg_Sin;
  reg Sin = 0;
  reg [1:0] Count = 3;
	
always @(posedge Sin_in)
	begin
		if (Count == 3)
			begin
				Sin <= !Sin;
				Count <= 0;
			end
		else
			Count <= Count + 1;
	end


		assign neg_Sin = !Sin;
		assign Burst_p = (Sin && sync)? 1:0;
		assign Burst_n = (neg_Sin && sync)? 1:0;

always @(posedge Sin)
	begin
		if (gate ==1) sync <=1;
		else sync <= 0;
	end
 endmodule
