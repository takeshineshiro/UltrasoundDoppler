//`define LSB

`define cmdPullData 		8'h00

//Operation

// The definitions for the state values of the main state machine
    `define S_IDLE      4'h0
    `define S_CMD_ST    4'h3
    `define S_CMD_LD    4'h4
    `define S_CMD_DEC   4'h5
    `define S_TXDR_WR1  4'h6
    `define S_ADDR_ST   4'h7
    `define S_ADDR_LD   4'h8
    `define S_DATA_ST   4'h9
    `define S_DATA_SET  4'hA
	`define S_DATA_UPDATE  4'hB
    `define S_RDATA_ST  4'hC
	`define S_ADDRESS_UP 4'hD
    
    // The definitions for the SPI command values of the reference design
    `define C_EN_SET     8'h06 
    `define C_EN_CLR     8'h04 
    `define C_MEM_WR     8'h02 
    `define C_MEM_RD     8'h08    
    `define C_REV_ID     8'h9F 
    
    // The definitions for the slim version of the SPI command values
    `define EN_SET     4'h0  
    `define EN_CLR     4'h1    
    `define MEM_WR     4'h5  
    `define MEM_RD     4'h6    
    `define REV_ID     4'hB  
    `define INVALID    4'hF  

//Addresses
`define DELAY1 		4'h01
`define DEMOD		4'h02
`define DELAY2		4'h03
`define RETRANSMIT	4'h04
`define SETTINGS	4'h05


`define freq8MHz 			2'b11
`define freq4MHz 			2'b10
`define freq2MHz 			2'b01
`define TransducerNC		2'b00

`define Init			16'hFFFF

`define MEM_ADDR_WIDTH	8
`define DATABusWidth	16
`define DELAY			0

`define DOPPLER_MODE	1'b1
`define OSZI_MODE		1'b0