`define SPI			2'b00
`define SSP8		2'b01
`define SSP16		2'b10
`define Deep		5
`define Bufferlengh	120

module OutputInterface #(
		parameter iWidth = 64)
	   (inout wire [15:0] pins, 
		input wire[iWidth-1:0] data,
		input wire[1:0] iOut,
		input wire reset, bufferNxt,
		output wire finish, DataReady);

//FIFO
wire [iWidth-1:0] Data2Send;
reg[6:0] CntValues = 0;
wire[7:0] SegData[7:0];
wire empty, full, almostEmpty, almostFull;

OutBuffer FIFO(.Data(data), .WrClock(bufferNxt), .RdClock(finish), .WrEn(~reset), .RdEn(~reset), .Reset(reset || full), .RPReset(1'b0), .Q(Data2Send), 
    .Empty(empty), .Full(full), .AlmostEmpty(almostEmpty), .AlmostFull(almostFull));

assign SegData[0] = Data2Send[7:0];
assign SegData[1] = Data2Send[15:8];
assign SegData[2] = Data2Send[23:16];
assign SegData[3] = Data2Send[31:24];
assign SegData[4] = Data2Send[39:32];
assign SegData[5] = Data2Send[47:40];
assign SegData[6] = Data2Send[55:48];
assign SegData[7] = Data2Send[63:56];

assign DataReady = almostFull; //almostFull; //(CntValues == 80);
assign pins[15] = almostFull;
assign pins[14] = almostEmpty;
assign pins[12] = full;
assign pins[10] = empty;

always@(posedge bufferNxt) begin
	CntValues <= CntValues +1;
	if(reset || bufferNxt == `Bufferlengh) CntValues <= 0;
	end

wire SegDone; //, spi_clk, spi_ss, spi_mosi;

wire[7:0] MOSI_Data;
reg[3:0] Cnt = 0;

//assign pins[3] = (iOut == `SPI) ? MISO : 1'bz;
//assign pins[2] = (iOut == `SPI) ? MOSI : 1'bz;
assign finish = (SegDone && Cnt[3]); // || (CntValues == 2 && bufferNxt)

always@(posedge SegDone or posedge finish) begin
	Cnt <= Cnt + 1;
	if(Cnt[3]) Cnt <= 0;
	if(reset || finish) Cnt <= 0;
	end

wire ss, mosi, miso, spiclk;
assign spiclk = (iOut == `SPI) ? pins[0] : 0;
assign ss = (iOut == `SPI) ? pins[1] : 0;
assign mosi = (iOut == `SPI) ? pins[2] : 0;
assign pins[3] = (iOut == `SPI) ?  miso : 0;

	
SPI_slave #(1)	mode3(.rstb(~reset), .ten(iOut == `SPI), .tdata(SegData[Cnt]), .ss(1'b0), .sck(spiclk),
						.mosi(mosi), .miso(miso), .done(SegDone), .rdata(MOSI_Data));

/*SPIMaster_Mode0 spi(.mainclk(clk && iOut == SPI), .transmit(transmit), .reset(reset),
											.sclk(pins[0]), .select(pins[1]), .mosi(pins[2]),
											.dataToTransmit(SegData[Cnt]), .finish(SegDone));
*/
endmodule
