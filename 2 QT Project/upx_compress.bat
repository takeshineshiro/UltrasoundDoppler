@echo off
set COMPILER="C:\upx391w\upx.exe"
set INPUT="D:\USD\Ultrasonic Doppler 2.0\build-USD2014-static-Release\release\USD2014s.exe"
set OUTPUT="D:\USD\Ultrasonic Doppler 2.0\USD2014_packed.exe"

%COMPILER% -9 -o %OUTPUT% %INPUT%