module FrequencyDivider(
	input wire mainclk,
	output wire half,
	output wire quarter,
	output wire eighth);
	
	reg[2:0] Count = 0;
	
always@(posedge mainclk) begin
		Count <= Count + 1;
	end
	
assign half 	= Count[0];
assign quarter 	= Count[1];
assign eighth	= Count[2];
endmodule