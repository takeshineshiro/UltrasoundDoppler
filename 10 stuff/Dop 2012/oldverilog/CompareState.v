module CompareState #(
	parameter width = 16)
   (input wire mainclk, reset,
    input wire [width-1:0] dataB,
	output wire Equal, StateError);
	
	reg[width-1:0] Count;
	
always@(posedge mainclk) begin
		Count <= (~reset) ? Count + 1 : 0;
	end

assign Equal 			= ~reset && (Count == dataB);
assign StateError 		= (Count > dataB + 1);
endmodule
