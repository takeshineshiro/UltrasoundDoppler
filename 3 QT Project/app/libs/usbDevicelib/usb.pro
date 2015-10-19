HEADERS +=     $$PWD/libusb/libusb.h \
               $$PWD/usbdevice.h \
               $$PWD/usbtransfer.h \
               $$PWD/usbwatcher.h
SOURCES     += $$PWD/usbdevice.cpp \
               $$PWD/usbwatcher.cpp
DEPENDPATH  += $$PWD
INCLUDEPATH += $$PWD

message(Project files are in $$PWD)

CONFIG += c++11
QMAKE_CXXFLAGS += -std=c++11

TEMPLATE = lib
CONFIG += staticlib

release: DESTDIR = build/release
debug:   DESTDIR = build/debug

OBJECTS_DIR = $$DESTDIR/.obj
MOC_DIR = $$DESTDIR/.moc
RCC_DIR = $$DESTDIR/.qrc
UI_DIR = $$DESTDIR/.ui

QMAKE_RESOURCE_FLAGS += -threshold 0 -compress 9
QT       += widgets
greaterThan(QT_MAJOR_VERSION, 4): QT += widgets printsupport
