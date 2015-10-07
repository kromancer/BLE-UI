//This is a convenience subclass of QQuickWindow which will automatically load and display a QML scene when given the URL of the main source file
#include <QQuickView>
//QGuiApplication contains the main event loop, where all events from the window system and other sources are processed and dispatched.
#include <QGuiApplication>


int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    QQuickView view;

    //The Qt resource system is a platform-independent mechanism for storing binary files in the application's executable.
    view.setSource(QUrl("qrc:/main.qml"));
    view.show();

    return app.exec();
}

