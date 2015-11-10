@echo off
set COMPILER="D:\workspace\UltrasoundDoppler\3 QT Project\upx.exe"
set INPUT="D:\workspace\UltrasoundDoppler\3 QT Project\build\release\USD2014s.exe"
set OUTPUT="D:\workspace\UltrasoundDoppler\3 QT Project\USD2014_packed.exe"

%COMPILER% -9 -o %OUTPUT% %INPUT%