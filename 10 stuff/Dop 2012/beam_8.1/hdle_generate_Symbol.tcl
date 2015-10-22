lappend auto_path "C:/lscc/diamond/3.1_x64/data/script"
package require symbol_generation

set ::bali::Para(MODNAME) fifo24bit
set ::bali::Para(PACKAGE) {"C:/lscc/diamond/3.1_x64/cae_library/vhdl_packages/vdbs"}
set ::bali::Para(PRIMITIVEFILE) {"C:/lscc/diamond/3.1_x64/cae_library/synthesis/verilog/machxo.v"}
set ::bali::Para(FILELIST) {"C:/Users/Andreas/Desktop/usd/beam_8.1/CLK_gen.v=work" "C:/Users/Andreas/Desktop/usd/beam_8.1/cmp16bit.v=work" "C:/Users/Andreas/Desktop/usd/beam_8.1/cnt16bit.v=work" "C:/Users/Andreas/Desktop/usd/beam_8.1/DataFIFO.v=work" "C:/Users/Andreas/Desktop/usd/beam_8.1/fifo24bit.v=work" "C:/Users/Andreas/Desktop/usd/beam_8.1/flag_ctrl.v=work" "C:/Users/Andreas/Desktop/usd/beam_8.1/splitter24_16_8.v=work" "C:/Users/Andreas/Desktop/usd/beam_8.1/sr24bit.v=work" }
set ::bali::Para(INCLUDEPATH) {}
puts "set parameters done"
::bali::GenerateSymbol
