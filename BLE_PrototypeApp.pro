
# This is a hacky way to copy this damned .glade file (an xml file describing the ui of the camera settings
# to the build directory
copydata.commands = $(COPY) $$PWD/FlyCapture2GUI_GTK.glade $$OUT_PWD
first.depends = $(first) copydata
export(first.depends)
export(copydata.commands)


QMAKE_EXTRA_TARGETS += first copydata

TEMPLATE = app

QT += qml quick bluetooth testlib multimedia widgets

CONFIG += c++11

HEADERS += \
    camera.h \
    bluetooth.h

SOURCES += main.cpp \
    camera.cpp \
    bluetooth.cpp

RESOURCES += \
    qml.qrc

INCLUDEPATH += /usr/include/flycapture/

LIBS += -lflycapture -lflycapturegui

DISTFILES += \
    FlyCapture2GUI_GTK.glade



