#include <QtQuick>
//QGuiApplication contains the main event loop, where all events from the window system and other sources are processed and dispatched.
#include <QGuiApplication>
#include "VAQ.h"
#include "kostis.h"
#include "fangxian.h"


int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    QQuickView view;

    Kostis kos;






    view.setSource(QUrl("qrc:/main.qml"));


    view.engine()->addImageProvider(QLatin1String("camera"), &kos);




    view.setMinimumWidth(700);
    view.setMinimumHeight(700);
    view.show();
    return app.exec();
}

