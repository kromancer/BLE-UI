#include <QtQuick>
//QGuiApplication contains the main event loop, where all events from the window system and other sources are processed and dispatched.
#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include "VAQ.h"
#include "camera.h"


int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    qmlRegisterType<PG_Camera>("mymodule", 1, 0, "PGCamera");

    VAQ vaq;

    QQmlApplicationEngine view(QUrl("qrc:/main.qml"));

    view.rootContext()->setContextProperty("VAQ", &vaq);

    return app.exec();
}

