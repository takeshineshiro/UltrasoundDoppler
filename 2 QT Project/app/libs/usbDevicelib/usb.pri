HEADERS +=     $$PWD/libusb/libusb.h \
               $$PWD/usbdevice.h \
               $$PWD/usbtransfer.h \
               $$PWD/usbwatcher.h
SOURCES     += $$PWD/usbdevice.cpp \
               $$PWD/usbwatcher.cpp
DEPENDPATH  += $$PWD
INCLUDEPATH += $$PWD

message(Project files are in $$PWD)
