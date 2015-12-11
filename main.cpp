#include <QtQuick>
//QGuiApplication contains the main event loop, where all events from the window system and other sources are processed and dispatched.
#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include "bluetooth.h"
#include "camera.h"


int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    qmlRegisterType<PG_Camera>("mymodule", 1, 0, "PGCamera");

    Bluetooth ble;

    QQmlApplicationEngine view;

    // We can call this guys methods from QML

    view.addImportPath("/home/kostis/rQtKnobs/imports");

    view.rootContext()->setContextProperty("BLE", &ble);

    view.load(QUrl("qrc:/main.qml"));

    return app.exec();
}

