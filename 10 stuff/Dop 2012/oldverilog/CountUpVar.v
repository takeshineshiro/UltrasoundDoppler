module CountUpVar #(
	parameter Width = 3, 
	parameter startCount = 3)
   (input wire clk,
	input wire enable,
	input wire reset,
	output reg [Width-1:0] Q);

always@(posedge clk) begin
	if(reset) Q <= 0;
	if(enable) Q <= Q + 1;
	end

endmodule