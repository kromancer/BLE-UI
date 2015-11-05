#include <QtQuick>
//QGuiApplication contains the main event loop, where all events from the window system and other sources are processed and dispatched.
#include <QGuiApplication>
#include "VAQ.h"


int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    QQuickView view;

    VAQ vaq;


    //The Qt resource system is a platform-independent mechanism for storing binary files in the application's executable.
    view.setSource(QUrl("qrc:/main.qml"));

    view.rootContext()->setContextProperty("VAQ", &vaq);

    view.setMinimumWidth(700);
    view.setMinimumHeight(700);



    //view.setResizeMode(QQuickView::SizeViewToRootObject);
    view.show();
    return app.exec();
}

