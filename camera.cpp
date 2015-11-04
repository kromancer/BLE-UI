#include "camera.h"


Camera::Camera():stream(0), QQuickImageProvider(QQuickImageProvider::Image)
{
    if(!stream.isOpened())  // check if we succeeded
        qWarning("Problem opening camera within opencv");
}


QImage Camera::captureFrame()
{
    cv::Mat frame, temp_frame;
    stream >> frame;
    cvtColor(frame, temp_frame,CV_BGR2RGB); // cvtColor Makes a copt, that what i need
    QImage dest((const uchar *) temp_frame.data, temp_frame.cols, temp_frame.rows, temp_frame.step, QImage::Format_RGB888);
    dest.bits();
    return dest;
}



QImage Camera::requestImage(const QString &id, QSize *size, const QSize &requestedSize)
{
    QImage image = captureFrame();
    QImage result;
    if (requestedSize.isValid()) {
        result = image.scaled(requestedSize, Qt::KeepAspectRatio);
    } else {
        result = image;
    }
    *size = result.size();
    return result;
}






