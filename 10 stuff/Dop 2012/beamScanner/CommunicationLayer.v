`define RegStatics		8'h07

module CommunicationLayer(
	input wire mosi, ss, sck, reset, SendDataMode,
	input wire[7:0] DataOut,
	output wire[7:0] Reg, 
	output wire[15:0] RegValue,
	output wire Transfered, miso
	);

	wire segmentDone;
	wire[7:0] Rdata;
	reg[24:0] Register;
	reg[2:0] Cnt = 0;
	wire[7:0] DataToTransfer = (SendDataMode) ? DataOut : 0;

	SPI_slave	mode3(.rstb(~reset), .ten(1'b1), .tdata(DataToTransfer), .mlb(1'b1), .ss(ss), .sck(sck),
						.sdin(mosi), .sdout(miso), .done(SegmentDone), .rdata(Rdata));

always@(posedge SegmentDone or posedge Transfered) begin
	Cnt <= Cnt + 1;
	if(Cnt[1]) Cnt <= 0; //Cnt[3]
	if(Cnt[0] == 1 && (`RegStatics & Rdata)) begin
			Register[23:16] <= Rdata;
			Cnt[1] <= 1;
		end
	else Register <= {Register[15:0],Rdata};
	if(reset || Transfered) begin
			Cnt <= 0;
			Register = 0;
		end
	end

assign Transfered = SendDataMode ? segmentDone : (SegmentDone && Cnt[1]); //Cnt[3]
assign Reg = Register[23:16];
assign RegValue = Register[15:0];

endmodule