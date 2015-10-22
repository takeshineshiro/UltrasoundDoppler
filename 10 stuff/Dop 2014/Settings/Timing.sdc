# Synopsys, Inc. constraint file
# D:\workspace\USD\USD3.0\Settings\Timing.sdc
# Written on Tue Aug 25 11:16:02 2015
# by Synplify Pro, J-2015.03L Scope Editor

#
# Collections
#

#
# Clocks
#
define_clock   {CLK_EXT} -name {CoreClock}  -freq 64 -clockgroup system_clkgroup
define_clock   {n:dataOut.MEM_READ} -name {MemoryReadClock}  -freq 16 -clockgroup default_clkgroup_0
define_clock   {spi_clk}  -freq 2 -clockgroup default_clkgroup_1
define_clock   {n:com.MEM_CLK} -name {n:com.MEM_CLK}  -freq 64 -clockgroup system_clkgroup

#
# Clock to Clock
#

#
# Inputs/Outputs
#

#
# Registers
#

#
# Delay Paths
#

#
# Attributes
#

#
# I/O Standards
#

#
# Compile Points
#

#
# Other
#
