#ifndef FRAME_PROVIDER_H
#define FRAME_PROVIDER_H
#include "fangxian.h"
#include <QQuickImageProvider>






//using namespace FlyCapture2;
using namespace std;



class FrameProvider: public QQuickImageProvider
{
public:
    FrameProvider();
    QImage requestImage(const QString& id, QSize* size, const QSize& requestedSize);
    Fangxian fan;
};




#endif // CAMERA_H

