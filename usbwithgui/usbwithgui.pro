#-------------------------------------------------
#
# Project created by QtCreator 2013-01-05T20:09:55
#
#-------------------------------------------------

QT       += core gui

TARGET = usbwithgui
TEMPLATE = app


SOURCES += main.cpp\
        mainwindow.cpp

HEADERS  += mainwindow.h \
    usb.h

FORMS    += mainwindow.ui
LIBS=.\libusb.a
