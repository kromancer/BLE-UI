#ifndef CAMERA_H
#define CAMERA_H
#include "fangxian.h"
#include <QQuickImageProvider>
#include <opencv2/opencv.hpp>





//using namespace FlyCapture2;
using namespace std;



class Kostis: public QQuickImageProvider
{
public:
    Kostis();
    QImage requestImage(const QString& id, QSize* size, const QSize& requestedSize);

private:
    Fangxian fan;
};




#endif // CAMERA_H

