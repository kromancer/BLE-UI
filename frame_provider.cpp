#include "frame_provider.h"


FrameProvider::FrameProvider():QQuickImageProvider(QQuickImageProvider::Image), fan()
{

}


QImage FrameProvider::requestImage(const QString &id, QSize *size, const QSize &requestedSize)
{
    FlyCapture2::Image rawImage, rgbImage;
    FlyCapture2::Error error = fan.our_cam.RetrieveBuffer( &rawImage );

    rawImage.Convert(FlyCapture2::PIXEL_FORMAT_RGB8, &rgbImage);

    QImage dest((const uchar *) rgbImage.GetData(), rgbImage.GetCols(), rgbImage.GetRows(), QImage::Format_RGB888);

    dest.bits();

    return dest;
}

