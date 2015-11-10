
#ifndef SNAPSHOT_H
#define SNAPSHOT_H
#include <QObject>
#include <FlyCapture2.h>

using namespace FlyCapture2;
class CamSettings: public QObject{
Q_OBJECT
public:
    CamSettings(GigECamera *);
public slots:
    void setAutoExposure(float);
    void setShutter(unsigned int);
    void setGain(int);
    void setBrightness(float);
private:
    Property brightness, shutter, gain, auto_exposure;
    GigECamera *cam;
};

/*
 * auto_exposure = Allows the camera to automatically control exposure and/or gain
 * in order to achieve a specific average image intensity. Additionally users can specify
 * the range of allowed values used by the auto-exposure algorithm by setting the auto exposure range,
 * the auto shutter range and the auto gain range.
*/


#endif // SNAPSHOT_H


