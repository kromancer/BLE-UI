#include <QtQuick>
//QGuiApplication contains the main event loop, where all events from the window system and other sources are processed and dispatched.
#include <QGuiApplication>
#include "VAQ.h"
#include "camera.h"


int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);
    QQuickView view;
    qmlRegisterType<PG_Camera>("mymodule", 1, 0, "PG_Camera");

    VAQ vaq;





    view.setSource(QUrl("qrc:/main.qml"));


    view.rootContext()->setContextProperty("VAQ", &vaq);
    //view.rootContext()->setContextProperty("cam_settings", &cam_settings);
    //view.engine()->addImageProvider(QLatin1String("camera"), &kos);





    view.setMinimumWidth(1288);
    view.setMinimumHeight(964);
    view.setMaximumWidth(1288);
    view.setMaximumHeight(980);
    view.show();
    return app.exec();
}

