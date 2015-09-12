[ActiveSupport MAP]
Device = LCMXO2-7000HC;
Package = TQFP144;
Performance = 4;
LUTS_avail = 6864;
LUTS_used = 310;
FF_avail = 6979;
FF_used = 255;
INPUT_LVCMOS25 = 19;
OUTPUT_LVCMOS25 = 25;
IO_avail = 115;
IO_used = 44;
EBR_avail = 26;
EBR_used = 2;
; Begin EBR Section
Instance_Name = fifo/ebr1/FIFO_OUT_0_1;
Type = FIFO8KB;
Width = 4;
REGMODE = OUTREG;
RESETMODE = ASYNC;
ASYNC_RESET_RELEASE = ASYNC;
GSR = DISABLED;
Instance_Name = fifo/ebr1/FIFO_OUT_1_0;
Type = FIFO8KB;
Width = 4;
REGMODE = OUTREG;
RESETMODE = ASYNC;
ASYNC_RESET_RELEASE = ASYNC;
GSR = DISABLED;
; End EBR Section
