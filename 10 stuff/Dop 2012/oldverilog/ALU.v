`define Add   2'b00
`define Sub   2'b01
`define Multi 2'b10
`define Div	  2'b11

module ALU #(
	parameter Width = 32, WidthA = Width, WidthB = Width)
   (input wire clk,
    input wire[WidthA-1:0] a,
	input wire[WidthB-1:0] b,
	input wire[1:0] op,
	output reg[Width-1:0] result);

/*assign result = (op == Add) ? a + b :
				(op == Sub) ? b - a : 
				(op == Div) ? b / a :
				(op == Multi)?a * b : 0; */
always@(posedge clk) begin
	case(op)
		`Add: 	 result <= a + b;
		`Sub: 	 result <= b - a;
		`Div:  	 result <= b / a;
		`Multi:  result <= a * b;
		default: result <= {Width{1'bz}};
		endcase
	end
endmodule
