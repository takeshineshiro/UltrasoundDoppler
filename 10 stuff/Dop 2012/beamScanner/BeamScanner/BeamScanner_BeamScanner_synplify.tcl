#-- Lattice Semiconductor Corporation Ltd.
#-- Synplify OEM project file

#device options
set_option -technology MACHXO
set_option -part LCMXO2280C
set_option -package T100C
set_option -speed_grade -3

#compilation/mapping options
set_option -symbolic_fsm_compiler true
set_option -resource_sharing true

#use verilog 2001 standard option
set_option -vlog_std v2001

#map options
set_option -frequency auto
set_option -maxfan 1000
set_option -auto_constrain_io 0
set_option -disable_io_insertion false
set_option -retiming false; set_option -pipe true
set_option -force_gsr false
set_option -compiler_compatible 0
set_option -dup false
set_option -frequency 1
add_file -constraint {E:/backup download/usd/beamScanner/Timing.sdc}
set_option -default_enum_encoding default

#simulation options


#timing analysis options



#automatic place and route (vendor) options
set_option -write_apr_constraint 1

#synplifyPro options
set_option -fix_gated_and_generated_clocks 1
set_option -update_models_cp 0
set_option -resolve_multiple_driver 0


#-- add_file options
set_option -include_path {E:/backup download/usd/beamScanner}
add_file -verilog {E:/backup download/usd/beamScanner/cmp16bit.v}
add_file -verilog {E:/backup download/usd/beamScanner/cnt16bit.v}
add_file -verilog {E:/backup download/usd/beamScanner/BeamScanner/BeamScanner.v}
add_file -verilog {E:/backup download/usd/beamScanner/sr24bit.v}
add_file -verilog {E:/backup download/usd/beamScanner/fifo24bit.v}
add_file -verilog {E:/backup download/usd/beamScanner/splitter24_16_8.v}
add_file -verilog {E:/backup download/usd/beamScanner/CLK_gen.v}
add_file -verilog {E:/backup download/usd/beamScanner/DataFIFO.v}
add_file -verilog {E:/backup download/usd/beamScanner/flag_ctrl.v}

#-- top module name
set_option -top_module BeamScanner

#-- set result format/file last
project -result_file {E:/backup download/usd/beamScanner/BeamScanner/BeamScanner_BeamScanner.edi}

#-- error message log file
project -log_file {BeamScanner_BeamScanner.srf}

#-- set any command lines input by customer


#-- run Synplify with 'arrange HDL file'
project -run
