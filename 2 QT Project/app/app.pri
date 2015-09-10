PROJECT = Ultrasonic Doppler
HEADERS += $$PWD/usdmodel.h \
           $$PWD/Menu.h \
           $$PWD/mmode.h \
           $$PWD/spectrogram.h \
           $$PWD/stringextentions.h

SOURCES += $$PWD/Menu.cpp \
           $$PWD/usdmodel.cpp \
           $$PWD/mmode.cpp \
           $$PWD/spectrogram.cpp \
           $$PWD/stringextentions.cpp

message(Project files are in $$PWD)
#include($$PWD/libs/usbDevicelib/usb.pri)
#include($$PWD/libs/QCPlib/QCP.pri)
#include($$PWD/libs/kiss_fft/fft.pri)

INCLUDEPATH += $$PWD/libs/QCPlib \
               $$PWD/libs/kiss_fft \
               $$PWD/libs/usbDevicelib
LIBS += $$PWD/libs/QCPlib/libQCP.a \
        $$PWD/libs/kiss_fft/libfft.a \
        $$PWD/libs/usbDevicelib/libusb.a
