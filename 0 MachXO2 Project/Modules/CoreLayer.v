`include "Defines.v"

module CoreLayer(
	input wire coreClock,
	input wire RESET, ENABLE,
	input wire[1:0] freq,
	input wire[15:0] State0Value, State1Value, State2Value, StateRValue,
	output wire RX_CLK, DEMOD_ON, RETRANSMIT,
	output wire [1:0] TX_CLK);
	
localparam 
BurstState = 3'd0,
Delay1State = 3'd1,
DemodState = 3'd2,
Delay2State = 3'd3,
RetransmitState = 3'd4;

/* --- Register Initialvalues ---*/	

reg[2:0] currentState, nextState;
reg[15:0] Count;

/* --- TX logic --- */
assign TX_CLK[0] = (currentState == BurstState) ? TxClock(freq, Count[4:0]) : 0;
assign TX_CLK[1] = (currentState == BurstState) ? ~TX_CLK[0] : 0;

/* --- RX logic --- */
assign RX_CLK = RxClock(coreClock, freq, Count[1:0]);

/* --- Demodulation logic --- */
assign DEMOD_ON = (currentState == DemodState);

/* --- RETRANSMIT --- */
assign RETRANSMIT = (currentState == RetransmitState);

always@(posedge coreClock, posedge RESET) begin : FSM
	if(RESET) begin : RESET
		Count <= #`DELAY 0;
		currentState <= BurstState;
	end
	else begin : RUN
		Count <= #`DELAY (ENABLE && currentState != RetransmitState) ? Count + 1'b1 : 0;
		currentState <= nextState;
	end
end

always@(*) begin : NextStateLogic
	nextState = currentState;
	case (currentState)
	BurstState 		: if(Count == State0Value)	nextState = Delay1State;
	Delay1State 	: if(Count == State1Value)	nextState = DemodState;
	DemodState		: if(Count == State2Value)	nextState = Delay2State;
	Delay2State		: if(Count == StateRValue)	nextState = RetransmitState;
	RetransmitState	: nextState = BurstState;
	endcase
end

function TxClock;
input [1:0] Frequency;
input [4:0] Count;
	TxClock = (freq == `freq8MHz) ? Count[2] : (freq == `freq4MHz) ? Count[3] : Count[4];
endfunction

function RxClock;
input Clock;
input [1:0] Frequency;
input [1:0] Count;
	RxClock = (freq == `freq8MHz) ? coreClock : (freq == `freq4MHz) ? Count[0] : Count[1];
endfunction

endmodule