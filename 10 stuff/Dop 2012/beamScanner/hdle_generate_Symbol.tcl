lappend auto_path "C:/lscc/diamond/3.1_x64/data/script"
package require symbol_generation

set ::bali::Para(MODNAME) CommunicationLayer
set ::bali::Para(PACKAGE) {"C:/lscc/diamond/3.1_x64/cae_library/vhdl_packages/vdbs"}
set ::bali::Para(PRIMITIVEFILE) {"C:/lscc/diamond/3.1_x64/cae_library/synthesis/verilog/machxo.v"}
set ::bali::Para(FILELIST) {"C:/Users/Andreas/Desktop/usd/beamScanner/cmp16bit.v=work" "C:/Users/Andreas/Desktop/usd/beamScanner/cnt16bit.v=work" "C:/Users/Andreas/Desktop/usd/beamScanner/BeamScanner/BeamScanner.v=work" "C:/Users/Andreas/Desktop/usd/beamScanner/sr24bit.v=work" "C:/Users/Andreas/Desktop/usd/beamScanner/fifo24bit.v=work" "C:/Users/Andreas/Desktop/usd/beamScanner/splitter24_16_8.v=work" "C:/Users/Andreas/Desktop/usd/beamScanner/CLK_gen.v=work" "C:/Users/Andreas/Desktop/usd/beamScanner/DataFIFO.v=work" "C:/Users/Andreas/Desktop/usd/beamScanner/flag_ctrl.v=work" "C:/Users/Andreas/Desktop/usd/beamScanner/USDCoreLayer.v=work" "C:/Users/Andreas/Desktop/usd/beamScanner/BeamScanner/USD.v=work" "C:/Users/Andreas/Desktop/usd/beamScanner/spi_slave.v=work" "C:/Users/Andreas/Desktop/usd/beamScanner/CommunicationLayer.v=work" }
set ::bali::Para(INCLUDEPATH) {}
puts "set parameters done"
::bali::GenerateSymbol
