// Within this class we have encapsulated all the functionality related to the camera
// The PG_Camera object is exposed and handled by the QML context
// In the main.cpp we just register this class to the QML Type System (qmlRegisterType)

#ifndef PG_CAMERA_H
#define PG_CAMERA_H
#include <QtQuick>
#include <QImage>
#include <FlyCapture2.h>
#include <sstream>
#include <iomanip>
#include <iostream>



using namespace std;
using namespace FlyCapture2;
class PG_Camera: public QQuickPaintedItem
{
Q_OBJECT
public:
    PG_Camera(QQuickItem *parent = 0);
    ~PG_Camera();

    // Displaying and saving frames methods
    void paint(QPainter*);
    Q_INVOKABLE void saveFrame(QString);

    // Camera info methods
    Q_INVOKABLE void printBuildInfo();
    Q_INVOKABLE void printCameraInfo(CameraInfo*);
    Q_INVOKABLE void printStreamChannelInfo(GigEStreamChannel*);
    Q_INVOKABLE void printCameraSettings();

    // Modifying camera settings methods
    Q_INVOKABLE void setAutoExposure(float);
    Q_INVOKABLE void setShutter(unsigned int);
    Q_INVOKABLE void setGain(float);
    Q_INVOKABLE void setBrightness(float);


private:
    GigECamera our_cam;
    CameraInfo cam_info;
    Error error;
    PGRGuid guid;
    BusManager busMgr;
    GigEStreamChannel our_chan;
    GigEImageSettingsInfo imageSettingsInfo;
    QImage getFrame();
    Property brightness, shutter, gain, auto_exposure;


    void printError(Error);
};

#endif // PG_CAMERA_H

