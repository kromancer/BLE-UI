#ifndef FANGXIAN_H
#define FANGXIAN_H
#include <QObject>
#include <opencv2/opencv.hpp>
#include <FlyCapture2.h>
#include <sstream>
#include <iomanip>

using namespace std;
class Fangxian: public QObject
{
Q_OBJECT
public:
    Fangxian();
    ~Fangxian();
    FlyCapture2::GigECamera our_cam;
public slots:
    void printBuildInfo();
    void printCameraInfo(FlyCapture2::CameraInfo*);
    void printStreamChannelInfo(FlyCapture2::GigEStreamChannel*);
    void printCameraSettings();
private:
    FlyCapture2::CameraInfo cam_info;
    FlyCapture2::Error error;
    FlyCapture2::PGRGuid guid;
    FlyCapture2::BusManager busMgr;
    FlyCapture2::GigEStreamChannel our_chan;
    FlyCapture2::GigEImageSettingsInfo imageSettingsInfo;


    void printError(FlyCapture2::Error);
};

#endif // FANGXIAN_H

