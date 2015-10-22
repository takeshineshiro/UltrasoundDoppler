module StateMaschine #(
	parameter width = 32, deep = 22, cntstartbit = 16)
   (input wire dataIn, sclk, sync, mainclk, enable, 
	output wire[1:0] frequency, sampling, outputInterface,
	output wire transmitterOn, measureType, triggerOn);
// enable == Feedback
//internals
	wire Retransmit;
	reg NextState;
	reg [4:0] ReadPtr, WritePtr;
	wire [width-11:0] CounterValue;
	reg [width-1:0] data, MEM[deep-1:0];
	reg [width-11:0] CurrentCntValue;
	
/*	
always@(posedge sclk && ~sync) begin	//shift in
	data[width-1:1] <= data[width-2:0];
	data[0]			<= dataIn;
    end

always@(posedge sync && ~enable) begin	//writeNext 
	MEM[WritePtr] <= data;
	end	
*/
//Counter + Compare
always@(posedge mainclk) begin
	if(sclk && ~sync) begin
		data[width-1:1] <= data[width-2:0];
		data[0]			<= dataIn;
	end
	if(sync && ~enable) begin
		MEM[WritePtr] <= data;	
	end
	if(~sync) WritePtr <= (enable) ? 0 : WritePtr +1;
	CurrentCntValue <= (~Retransmit && enable) ? CurrentCntValue + 1 : 0;
	NextState		<= (CounterValue == CurrentCntValue) ? 1 : 0;
	ReadPtr 		<= (Retransmit || enable) ? 0 : (NextState) ? ReadPtr + 1 : ReadPtr;
	end
//FIFO ReadPointer
/*always@(posedge (Retransmit || enable)) ReadPtr <= 0;
always@(posedge NextState) ReadPtr <= ReadPtr + 1;*/
//FIFO WritePointer
//always@(negedge sync) WritePtr <= (enable) ? 0 : WritePtr +1;
//Signals from FIFO at ReadPointer
assign frequency 	 	= (enable) ? MEM[ReadPtr][1:0] : 2'b0;
assign transmitterOn 	= (enable) ? MEM[ReadPtr][2] : 0;
assign sampling  	 	= (enable) ? MEM[ReadPtr][4:3] : 2'b0;
assign Retransmit 		= (enable) ? MEM[ReadPtr][5] : 0;
assign outputInterface	= (enable) ? MEM[ReadPtr][7:6] : 2'b0;
assign measureType 		= (enable) ? MEM[ReadPtr][8] : 0;
assign triggerOn 		= (enable) ? MEM[ReadPtr][9] : 0;
assign CounterValue		= (enable) ? MEM[ReadPtr][width-1:cntstartbit] : 0;

endmodule