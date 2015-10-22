module FIFOVar #(
	parameter width = 32, deep = 4)
   (input wire [width-1:0] dataIn,
	input wire readEnable, reset, readNext, writeNext, goToReg0,
	output wire [width-1:0] Q);

//internals
	reg [width-1:0] MEM[((1<<deep)-1):0];
	reg [deep-1:0] 	ReadPtr  = 0;
	reg [deep-1:0]	WritePtr = 0;
	
//logic
assign Q = (readEnable && ~reset) ? MEM[ReadPtr] : {width{1'b0}};

//assign Overrun = (ReadPtr == WritePtr);

always@(posedge readNext or posedge goToReg0 or posedge reset) begin
	ReadPtr <= (reset || goToReg0 || ReadPtr + 1 == WritePtr) ? 0 : ReadPtr + 1;
	end

always@(posedge writeNext) begin
	WritePtr <= (reset || readEnable || (WritePtr == width-1)) ? 0 : WritePtr + 1;
	MEM[WritePtr] <= dataIn;
	end	

endmodule