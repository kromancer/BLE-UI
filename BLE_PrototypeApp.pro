TEMPLATE = app

QT += qml quick bluetooth testlib multimedia widgets
CONFIG += c++11

HEADERS += \
    VAQ.h \
    deviceinfo.h \
    fangxian.h \
    cam_settings.h \
    frame_provider.h

SOURCES += main.cpp \
    VAQ.cpp \
    deviceinfo.cpp \
    fangxian.cpp \
    cam_settings.cpp \
    frame_provider.cpp

RESOURCES += qml.qrc


INCLUDEPATH += /usr/include/flycapture/
LIBS += -L"usr/lib/libflycapture.so" -lflycapture



# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =

# Default rules for deployment.
include(deployment.pri)

DISTFILES +=

