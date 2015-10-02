setenv SIM_WORKING_FOLDER .
set newDesign 0
if {![file exists "D:/workspace/UltrasoundDoppler/0 MachXO2 Project/Testbench/TopLevel/TopLevel.adf"]} { 
	design create TopLevel "D:/workspace/UltrasoundDoppler/0 MachXO2 Project/Testbench"
  set newDesign 1
}
design open "D:/workspace/UltrasoundDoppler/0 MachXO2 Project/Testbench/TopLevel"
cd "D:/workspace/UltrasoundDoppler/0 MachXO2 Project/Testbench"
designverincludedir -clear
designverlibrarysim -PL -clear
designverlibrarysim -L -clear
designverlibrarysim -PL pmi_work
designverlibrarysim ovi_machxo2
designverdefinemacro -clear
if {$newDesign == 0} { 
  removefile -Y -D *
}
addfile "D:/workspace/UltrasoundDoppler/0 MachXO2 Project/Testbench/tb_TopLevel.v"
vlib "D:/workspace/UltrasoundDoppler/0 MachXO2 Project/Testbench/TopLevel/work"
set worklib work
adel -all
vlog -dbg -work work "D:/workspace/UltrasoundDoppler/0 MachXO2 Project/Testbench/tb_TopLevel.v"
module tb_TopLevel
vsim  +access +r tb_TopLevel   -PL pmi_work -L ovi_machxo2
add wave *
run 1000ns
