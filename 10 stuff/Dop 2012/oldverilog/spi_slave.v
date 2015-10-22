/* SPI MODE 3
		CHANGE DATA (miso) @ NEGEDGE SCK
		read data (mosi) @posedge SCK
*/
/* Params
	rstb 	-> active low asyn reset
	ten		-> active high MOSI enabled - else don't care /tri-state
	tdata	-> 114 bit data to transmit
	mlb		-> if high -> Bit15to0 else -> Bit0to15
	ss		-> active low - slave select
	sck		-> SPI Clock
	mosi	-> Master out Slave in
	miso	-> Master in Slave out
	done	-> active high -> low if 114 bit not transmitted else high
	rdata	-> 114 bit parallel MOSI data REGISTER!!!
*/
/*
	http://www.elecdude.com/2013/10/serial-communication-protocol-ic-vs-spi.html
	http://www.elecdude.com/2013/09/spi-master-slave-verilog-code-spi.html
	http://www.elecdude.com/2013/10/spi-verilog-code-master-slave-code-with.html
	http://www.fpga4fun.com/SPI2.html
*/
module SPI_slave #(
	parameter mlb = 1)
   (input rstb, ss, sck, mosi, ten,
	input [15:0] tdata,
	output wire miso,
	output reg done,
	output reg [15:0] rdata);
	
  reg [15:0] treg,rreg;
  reg [4:0] nb;
  
  assign sout = mlb ? treg[15] : treg[0];
  assign miso = ((!ss) && ten) ? sout:1'bz; //if 1=> send data  else TRI-STATE miso


//read from mosi
always @(posedge sck or negedge rstb)
  begin
    if (rstb==0)
		begin rreg = 16'h0000;  rdata = 16'h0000; done = 0; nb = 0; end   //
	else if (!ss) begin 
			if(mlb==0)  //LSB first, in@msb -> right shift
				begin rreg ={mosi,rreg[15:1]}; end
			else     //MSB first, in@lsb -> left shift
				begin rreg ={rreg[14:0],mosi}; end  
		//increment bit count
			nb = nb+1;
			if(nb!=16) done = 0;
			else  begin rdata = rreg; done = 1; nb = 0; end
		end	 //if(!ss)_END  if(nb==14)
  end

//send to miso
always @(negedge sck or negedge rstb)
  begin
	if (rstb==0)
		begin treg = 16'hFFFF; end
	else begin
		if(!ss) begin			
			if(nb==0) treg = tdata;
			else begin
			   if(mlb==0)  //LSB first, out=lsb -> right shift
					begin treg = {1'b1,treg[15:1]}; end
			   else     //MSB first, out=msb -> left shift
					begin treg = {treg[14:0],1'b1}; end			
			end
		end //!ss
	 end //rstb	
  end //always

endmodule
      
/*
			if(mlb==0)  //LSB first, out=lsb -> right shift
					begin treg = {treg[15],treg[15:1]}; end
			else     //MSB first, out=msb -> left shift
					begin treg = {treg[14:0],treg[0]}; end	
*/