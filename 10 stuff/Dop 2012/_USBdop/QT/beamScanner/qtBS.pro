#-------------------------------------------------
#
# Project created by QtCreator 2012-01-31T09:08:10
#
#-------------------------------------------------

QT       += core gui
greaterThan(QT_MAJOR_VERSION, 4): QT += widgets printsupport

TARGET = QTdop
TEMPLATE = app

QMAKE_CXXFLAGS += -std=gnu++11


SOURCES += main.cpp\
    qtBSmain.cpp \
    beamScanner_hw.cpp \
    libs/QCustomPlot/qcustomplot.cpp \
    usd.cpp \
    usb_api.cpp

HEADERS  += qtBSmain.h \
    beamScanner_hw.h \
    libs/QCustomPlot/qcustomplot.h \
    libs/libusbx/libusb.h \
    usd.h \
    usb_api.h

FORMS    += qtBSmain.ui

LIBS    += -L$$PWD/libs/libusbx/ -lusb-1.0
