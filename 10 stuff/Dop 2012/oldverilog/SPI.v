module SPI_api
   (input wire spi_type, mainclk, enable, MM_start,
	input wire [1:0] spi_mode,
	inout wire sclk, select, mosi, miso,
	input wire [7:0] dataToTransmit,
	output wire [7:0] receivedData,
	output wire finish);

parameter Master_Mode = 1, Slave_Mode = 0;
parameter Mode0 = 2'b00, Mode1 = 2'b01, Mode2 = 2'b10, Mode3 = 2'b11;

reg[2:0] sclkDiv = 0;
reg[7:0] tempIn;
wire[7:0] tempOut;
reg[2:0] edgeUpCnt, edgeDownCnt;
reg mosiregNeg, mosiregPos, misoregNeg, misoregPos, selectreg;

wire synplifyEdge;
wire masterSelect;

assign select 		= (spi_type == Master_Mode) ? (selectreg && ~finish) : 0;
assign sclk			= (spi_type != Master_Mode) ? 0 :(spi_mode == Mode0 || spi_mode == Mode1) ? (sclkDiv[2] && enable) : ~(sclkDiv[2] && enable);
assign miso 		= (spi_type != Master_Mode) ? (misoregNeg | misoregPos) : 0;
assign mosi 		= (spi_type == Master_Mode) ? (mosiregNeg | mosiregPos) : 0;
assign receivedData = tempIn;
assign tempOut = dataToTransmit;
assign finish 		= (edgeDownCnt == 7) ? 1 : 0;

assign synplifyEdge = sclk && ~select;
assign masterSelect = (spi_type == Master_Mode) ? select : 0;

//Divide SystemClock for SPI
always@(posedge mainclk) sclkDiv <= sclkDiv + 1;
always@(posedge MM_start) selectreg <= 1;

task ShiftIn;
	input data;
	begin
		tempIn[7:1] <= tempIn[6:0];
		tempIn[0]		 <= data;
	end
endtask


always@(posedge synplifyEdge) begin
	case (spi_mode)
	Mode0:
		case (spi_type)
			Master_Mode: ShiftIn(miso);
			Slave_Mode: ShiftIn(mosi);
		endcase
	Mode1:
		case (spi_type)
			Master_Mode: misoregPos <= (edgeUpCnt != 0) ? tempOut[edgeUpCnt-1] : tempOut[edgeUpCnt];
			Slave_Mode: mosiregPos <= (edgeUpCnt != 0) ? tempOut[edgeUpCnt-1] : tempOut[edgeUpCnt];
		endcase
	Mode2: begin
		case (spi_type)
			Master_Mode: misoregPos <= (edgeUpCnt != 0) ? tempOut[edgeUpCnt-1] : tempOut[edgeUpCnt];
			Slave_Mode: mosiregPos <= (edgeUpCnt != 0) ? tempOut[edgeUpCnt-1] : tempOut[edgeUpCnt];
		endcase
		end
	Mode3: begin
			case (spi_type)
			Master_Mode: if(edgeDownCnt >= 1) ShiftIn(miso);
			Slave_Mode:  if(edgeDownCnt >= 1) ShiftIn(mosi);
		endcase
		end
	endcase
	edgeUpCnt <= (edgeUpCnt < 7 && enable) ? edgeUpCnt +1 : 0;
	
end

always@(negedge synplifyEdge) begin
	case (spi_mode)
	Mode0: begin
		case (spi_type)
			Master_Mode: mosiregNeg <= (edgeDownCnt != 0) ? tempOut[edgeDownCnt-1] : tempOut[edgeDownCnt];
			Slave_Mode: misoregNeg <= (edgeDownCnt != 0) ? tempOut[edgeDownCnt-1] : tempOut[edgeDownCnt];
		endcase
		end
	/*Mode1: begin
		case (spi_type)
			Master_Mode: if(edgeUpCnt >= 1) ShiftIn(miso);
			Slave_Mode:  if(edgeUpCnt >= 1) ShiftIn(mosi);
		endcase
		
		end
	Mode2:
		case (spi_type)
			Master_Mode: if(edgeUpCnt >= 1) ShiftIn(miso);
			Slave_Mode: if(edgeUpCnt >= 1)ShiftIn(mosi);
		endcase*/
	Mode3:
		case (spi_type)
			Master_Mode: mosiregNeg <= (edgeDownCnt != 0) ? tempOut[edgeDownCnt-1] : tempOut[edgeDownCnt];
			Slave_Mode: misoregNeg <= (edgeDownCnt != 0) ? tempOut[edgeDownCnt-1] : tempOut[edgeDownCnt];
		endcase
	endcase
	
	edgeDownCnt <= (edgeDownCnt < 7 && enable) ? edgeDownCnt +1 : 0;
	end
endmodule