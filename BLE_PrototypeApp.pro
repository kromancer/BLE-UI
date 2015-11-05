TEMPLATE = app




QT += qml quick bluetooth multimedia

CONFIG += c++11

HEADERS += \
    VAQ.h \
    deviceinfo.h \
    camera.h

SOURCES += main.cpp \
    VAQ.cpp \
    deviceinfo.cpp \
    camera.cpp

RESOURCES += qml.qrc


LIBS += -lvlc-qt -lvlc-qt-widgets


# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =

# Default rules for deployment.
include(deployment.pri)

DISTFILES +=

