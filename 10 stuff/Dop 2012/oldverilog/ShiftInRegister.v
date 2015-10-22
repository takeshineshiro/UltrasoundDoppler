module shiftInRegister #(
	parameter width = 32)
   (input wire dataIn, sclk, cs,
	output reg [width-1:0] Q = 0);

always@(posedge sclk) begin
	if(~cs) begin
		Q[width-1:1] <= Q[width-2:0];
		Q[0]	<= dataIn;
	end
    end
endmodule
