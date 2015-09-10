VERSION = 0.0.0.2

QMAKE_RESOURCE_FLAGS += -threshold 0 -compress 9

QT       += core gui widgets

greaterThan(QT_MAJOR_VERSION, 4): QT += widgets printsupport

TARGET = USD2014
TEMPLATE = app
DEPENDPATH += $$PWD
INCLUDEPATH += $$PWD

CONFIG += c++11
QMAKE_CXXFLAGS += -std=c++11


include(app/app.pri)

SOURCES += main.cpp\
        uimainwindow.cpp \

HEADERS  += uimainwindow.h \

RESOURCES += \
    icons.qrc

OTHER_FILES += \
    pro.rc

RC_FILE = pro.rc

message(Project files are in $$PWD)

    win32:CONFIG(release, debug|release): LIBS += -L$$PWD/app/libs/usbDevicelib/libusb/MinGW32/dll/ -lusb-1.0
    else:win32:CONFIG(debug, debug|release): LIBS += -L$$PWD/app/libs/usbDevicelib/libusb/MinGW32/dll/ -lusb-1.0
    INCLUDEPATH += $$PWD/app/libs/usbDevicelib/libusb/MinGW32/dll
    DEPENDPATH += $$PWD/app/libs/usbDevicelib/libusb/MinGW32/dll

static { # everything below takes effect with CONFIG += static
    CONFIG += static
    #CONFIG += staticlib # this is needed if you create a static library, not a static executable
    DEFINES += STATIC
    message("~~~ static build ~~~") # this is for information, that the static build is done
    mac: TARGET = $$join(TARGET,,,_static) #this adds an _static in the end, so you can seperate static build from non static build
    win32: TARGET = $$join(TARGET,,,s) #this adds an s in the end, so you can seperate static build from non static build
    win32:CONFIG(release, debug|release): LIBS += -L$$PWD/app/libs/usbDevicelib/libusb/MinGW32/static/ -lusb-1.0
    else:win32:CONFIG(debug, debug|release): LIBS += -L$$PWD/app/libs/usbDevicelib/libusb/MinGW32/static/ -lusb-1.0
    else:mac: LIBS += `/usr/local/bin/pkg-config libusb-1.0 --static --libs`
    else:unix:!symbian: LIBS += -L$$PWD/app/libs/usbDevicelib/libusb/Linux/ -lusb-1.0 -ludev

    INCLUDEPATH += $$PWD/app/usbDevicelib/libusb/MS32/static
    DEPENDPATH += $$PWD/app/usbDevicelib/libusb/MS32/static
}
