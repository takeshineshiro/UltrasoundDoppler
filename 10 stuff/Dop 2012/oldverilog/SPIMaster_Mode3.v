module SPIMaster_Mode0
   (input wire mainclk, transmit, reset,
    output wire sclk, select, mosi, finish,
	input wire [7:0] dataToTransmit);

reg[3:0] bitcnt;

assign sclk 	= mainclk && transmit && ~finish;
assign select	= ~(transmit && ~finish);
assign mosi		= (finish) ? 0 : dataToTransmit[bitcnt];
assign finish	= (bitcnt == 8);


always@(negedge sclk or posedge reset) begin
	bitcnt <= (transmit && ~finish) ? bitcnt + 1 : 0;
	if(reset) bitcnt <= 0;
	end

endmodule