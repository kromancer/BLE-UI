// Within this class we have encapsulated all the functionality related to the camera
// The PG_Camera object is exposed and handled by the QML context
// In the main.cpp we just register this class to the QML Type System (qmlRegisterType)

#ifndef PG_CAMERA_H
#define PG_CAMERA_H
#include <QtQuick>
#include <QImage>
#include <FlyCapture2.h>
#include <FlyCapture2GUI.h>
#include <sstream>
#include <iomanip>
#include <iostream>



using namespace std;
using namespace FlyCapture2;
class PG_Camera: public QQuickPaintedItem
{
    Q_OBJECT
    // This property is responsible for setting the sad face in the GUI
    Q_PROPERTY(bool cameraConnected READ cameraConnected WRITE setCameraConnected NOTIFY cameraConnectedChanged)

public:
    PG_Camera(QQuickItem *parent = 0);
    ~PG_Camera();

    // Displaying and saving frames methods
    void paint(QPainter*);
    Q_INVOKABLE void saveFrame(QString);

    // Camera info methods
    void setCameraConnected(bool);
    bool cameraConnected();
    Q_INVOKABLE void printBuildInfo();
    Q_INVOKABLE void printCameraInfo(CameraInfo*);
    Q_INVOKABLE void printStreamChannelInfo(GigEStreamChannel*);

    // Show camera settings window
    Q_INVOKABLE void showSettings();

signals:
    // Not Utilized
    void cameraConnectedChanged();

private:
    bool m_cameraConnected;
    PGRGuid cam_uid;
    GigECamera our_cam;
    CameraInfo cam_info;
    QImage getFrame();
    Error error;
    void printError(Error);
};

#endif // PG_CAMERA_H

