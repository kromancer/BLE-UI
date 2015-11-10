#include <QtQuick>
//QGuiApplication contains the main event loop, where all events from the window system and other sources are processed and dispatched.
#include <QGuiApplication>
#include "VAQ.h"
#include "frame_provider.h"
#include "fangxian.h"
#include "cam_settings.h"

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    QQuickView view;

    FrameProvider kos;

    CamSettings cam_settings(&kos.fan.our_cam);




    view.setSource(QUrl("qrc:/main.qml"));



    view.rootContext()->setContextProperty("cam_settings", &cam_settings);
    view.engine()->addImageProvider(QLatin1String("camera"), &kos);





    view.setMinimumWidth(700);
    view.setMinimumHeight(700);
    view.show();
    return app.exec();
}

