[ActiveSupport MAP]
Device = LCMXO2280C;
Package = TQFP100;
Performance = 3;
LUTS_avail = 2280;
LUTS_used = 503;
FF_avail = 2280;
FF_used = 717;
INPUT_LVCMOS33 = 22;
OUTPUT_LVCMOS33 = 16;
IO_avail = 73;
IO_used = 38;
PLL_avail = 2;
PLL_used = 0;
EBR_avail = 3;
EBR_used = 2;
; Begin EBR Section
Instance_Name = I213/DataFIFO_0_1;
Type = FIFO8KA;
Width = 4;
REGMODE = OUTREG;
RESETMODE = ASYNC;
GSR = DISABLED;
Instance_Name = I213/DataFIFO_1_0;
Type = FIFO8KA;
Width = 4;
REGMODE = OUTREG;
RESETMODE = ASYNC;
GSR = DISABLED;
; End EBR Section
