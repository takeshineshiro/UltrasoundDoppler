#############################################################
# vsimsa environment configuration
set dsn $curdir
log $dsn/log/vsimsa.log
@echo
@echo #################### Starting C Code Debug Session ######################
cd $dsn/src
amap work $dsn/work/work.lib
set worklib work
# simulation
asim -callbacks -L ovi_machxo2 -PL pmi_work +accb +accr +access +r tb_TopLevel
run -all
#############################################################