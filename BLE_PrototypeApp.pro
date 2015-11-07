TEMPLATE = app




QT += qml quick bluetooth multimedia

CONFIG += c++11

HEADERS += \
    VAQ.h \
    deviceinfo.h \
    fangxian.h \
    kostis.h

SOURCES += main.cpp \
    VAQ.cpp \
    deviceinfo.cpp \
    fangxian.cpp \
    kostis.cpp


RESOURCES += qml.qrc


INCLUDEPATH += /usr/include/opencv

INCLUDEPATH += /usr/include/flycapture/
LIBS += -L"usr/lib/libflycapture.so" -lflycapture

LIBS += /usr/lib/x86_64-linux-gnu/libopencv_calib3d.so /usr/lib/x86_64-linux-gnu/libopencv_contrib.so /usr/lib/x86_64-linux-gnu/libopencv_core.so /usr/lib/x86_64-linux-gnu/libopencv_features2d.so /usr/lib/x86_64-linux-gnu/libopencv_flann.so /usr/lib/x86_64-linux-gnu/libopencv_gpu.so /usr/lib/x86_64-linux-gnu/libopencv_highgui.so /usr/lib/x86_64-linux-gnu/libopencv_imgproc.so /usr/lib/x86_64-linux-gnu/libopencv_legacy.so /usr/lib/x86_64-linux-gnu/libopencv_ml.so /usr/lib/x86_64-linux-gnu/libopencv_objdetect.so /usr/lib/x86_64-linux-gnu/libopencv_ocl.so /usr/lib/x86_64-linux-gnu/libopencv_photo.so /usr/lib/x86_64-linux-gnu/libopencv_stitching.so /usr/lib/x86_64-linux-gnu/libopencv_superres.so /usr/lib/x86_64-linux-gnu/libopencv_ts.so /usr/lib/x86_64-linux-gnu/libopencv_video.so /usr/lib/x86_64-linux-gnu/libopencv_videostab.so -lopencv_calib3d -lopencv_contrib -lopencv_core -lopencv_features2d -lopencv_flann -lopencv_gpu -lopencv_highgui -lopencv_imgproc -lopencv_legacy -lopencv_ml -lopencv_objdetect -lopencv_ocl -lopencv_photo -lopencv_stitching -lopencv_superres -lopencv_ts -lopencv_video -lopencv_videostab

#LIBS += -lvlc-qt -lvlc-qt-widgets

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =

# Default rules for deployment.
include(deployment.pri)

DISTFILES +=

