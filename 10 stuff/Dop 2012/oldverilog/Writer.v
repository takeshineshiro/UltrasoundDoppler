module Writer #(
	parameter TestMode = 1'b0)
   (input wire clk, enable, reset,
    input wire [1:0] samplingActions,
	input wire [63:0] calculatedValues,
	output wire write,
	output wire [63:0] dataToWrite);
	
reg bufferNext;
reg [1:0] LastSamplingMode;
reg[31:0] Cnt1, Cnt2;

always@(posedge clk) begin
	if(~enable) LastSamplingMode <= 2'b11; 
	if(reset || Cnt1 == 180) begin
		Cnt1 <= 3;
		Cnt2 <= 180;
		end
	if(LastSamplingMode != samplingActions) begin
		LastSamplingMode <= samplingActions;
		if(samplingActions == 2'b01 || samplingActions == 2'b10) begin
			Cnt1 <= Cnt1 + 1;
			Cnt2 <= Cnt2 - 1;
			end
		if(samplingActions != 2'b00) bufferNext <= 1;
		end
	else begin bufferNext <= 0; end
	end

assign write = bufferNext;
assign dataToWrite = (TestMode == 1'b1) ? calculatedValues : (Cnt1) | (Cnt2 << 32);


endmodule //Writer
