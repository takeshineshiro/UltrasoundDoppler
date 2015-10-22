module DataBuffer #(
	parameter width = 64, deep = 6)
   (input wire[width-1:0] dataIn,
	input wire readNext, reset, prfFinish, clk,
	input wire[1:0] samplingTrigger,
	output wire[width-1:0] dataOut,
	output wire dataReady);

//internals
reg[width-1:0] InBuffer;
reg[1:0] CntFlag = 0, lastTrigger;

always@(prfFinish) begin
	CntFlag <= CntFlag + 1;
	end

assign dataReady = (CntFlag == 3);

always@(samplingTrigger) begin
	InBuffer <= dataIn;
	end

always@(posedge clk) begin
	if(lastTrigger != samplingTrigger) begin
		lastTrigger <= samplingTrigger;
		
		end
	end


FIFOVar #(.width(width), .deep(deep)) fifo(.dataIn(dataIn), .readEnable(1'b1), .reset(reset), 
												.readNext(readNext), .writeNext(bufferNxt), .goToReg0(reset), .Q(dataOut));
endmodule
