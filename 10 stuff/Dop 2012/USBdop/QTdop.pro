#-------------------------------------------------
#
# Project created by QtCreator 2012-01-31T09:08:10
#
#-------------------------------------------------

QT       += core gui

TARGET = QTdop
TEMPLATE = app


SOURCES += main.cpp\
    qtdopmain.cpp \
    digidophw.cpp

HEADERS  += qtdopmain.h \
    digidophw.h

FORMS    += qtdopmain.ui

win32:CONFIG(release, debug|release): LIBS += \
    O:/libusb-win32-bin-1.2.6.0/lib/gcc/libusb.a \
#    D:/eda/QtSDK/INSTALL/Qwt-6.0.1/lib/libqwt.a
    C:/QtSDK/INSTALL/Qwt-6.0.1/lib/libqwt.a

else:win32:CONFIG(debug, debug|release): LIBS += \
    O:/libusb-win32-bin-1.2.6.0/lib/gcc/libusb.a \
#    D:/eda/QtSDK/INSTALL/Qwt-6.0.1/lib/libqwtd.a
    C:/QtSDK/INSTALL/Qwt-6.0.1/lib/libqwtd.a

INCLUDEPATH += O:/libusb-win32-bin-1.2.6.0/include \
#    D:/eda/QtSDK/INSTALL/Qwt-6.0.1/include
    C:/QtSDK/INSTALL/Qwt-6.0.1/include

DEPENDPATH += O:/libusb-win32-bin-1.2.6.0/include
#\
#    D:/eda/QtSDK/INSTALL/Qwt-6.0.1/include

#win32:QMAKE_POST_LINK = copy /Y C:/qwt-6.0.0-rc4/lib/qwtd. $(DESTDIR)

CONFIG += qwt
