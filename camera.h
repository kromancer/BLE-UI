#ifndef CAMERA_H
#define CAMERA_H
#include <QQuickImageProvider>
#include <opencv2/opencv.hpp>

class Camera: public QQuickImageProvider
{
public:
    Camera();
    QImage requestImage(const QString& id, QSize* size, const QSize& requestedSize);
public slots:
    QImage captureFrame();
private:
    cv::VideoCapture stream;
};


#endif // CAMERA_H

