`include "Defines.v"

module BuildSampleVolumes(
	input wire clk, reset,
	input wire[31:0] re, im,
	input wire[7:0] sampleVolumeLength,
	output reg[31:0] SV_re, SV_im,
	output wire Write);

reg[7:0] Counter;

always@(posedge clk or posedge reset) begin
	if(reset || Write) Counter <= 0;
	else begin
		Counter <= Counter + 1;
	end
end

assign Write = (Counter == sampleVolumeLength);


always@(posedge clk or posedge reset) begin
	if(reset) begin
		SV_re <= 0;
		SV_im <= 0;
	end
	else if(Counter == 0) begin
		SV_re <= re;
		SV_im <= im;
	end
	else begin
		SV_re <= SV_re + re;
		SV_im <= SV_im + im;
	end
end

endmodule