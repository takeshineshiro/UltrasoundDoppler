setenv SIM_WORKING_FOLDER .
set newDesign 0
if {![file exists "C:/Users/Andreas/Desktop/usd/beamScanner/test/test.adf"]} { 
	design create test "C:/Users/Andreas/Desktop/usd/beamScanner"
  set newDesign 1
}
design open "C:/Users/Andreas/Desktop/usd/beamScanner/test"
cd "C:/Users/Andreas/Desktop/usd/beamScanner"
designverincludedir -clear
designverlibrarysim -PL -clear
designverlibrarysim -L -clear
designverlibrarysim -PL pmi_work
designverlibrarysim ovi_machxo
designverdefinemacro -clear
if {$newDesign == 0} { 
  removefile -Y -D *
}
addfile "C:/Users/Andreas/Desktop/usd/beamScanner/spi_slave.v"
addfile "C:/Users/Andreas/Desktop/usd/beamScanner/tb_spi_slave.v"
vlib "C:/Users/Andreas/Desktop/usd/beamScanner/test/work"
set worklib work
adel -all
vlog -dbg -work work "C:/Users/Andreas/Desktop/usd/beamScanner/spi_slave.v"
vlog -dbg -work work "C:/Users/Andreas/Desktop/usd/beamScanner/tb_spi_slave.v"
module tbslave
vsim +access +r tbslave   -PL pmi_work -L ovi_machxo
add wave *
run 1000ns
