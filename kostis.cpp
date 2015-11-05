#include "kostis.h"


Kostis::Kostis():QQuickImageProvider(QQuickImageProvider::Image), fan()
{

}


QImage Kostis::requestImage(const QString &id, QSize *size, const QSize &requestedSize)
{
    FlyCapture2::Image rawImage, rgbImage;
    FlyCapture2::Error error = fan.our_cam.RetrieveBuffer( &rawImage );
    rawImage.Convert(FlyCapture2::PIXEL_FORMAT_RGB8,&rgbImage);

    unsigned int rowBytes = (double)rgbImage.GetReceivedDataSize()/(double)rgbImage.GetRows();
    cv::Mat temp_frame;
    cv::Mat image = cv::Mat(rgbImage.GetRows(), rgbImage.GetCols(), CV_8UC3, rgbImage.GetData(),rowBytes);

    cv::cvtColor(image, temp_frame, CV_BGR2RGB);
    QImage dest((const uchar *) temp_frame.data, temp_frame.cols, temp_frame.rows, temp_frame.step, QImage::Format_RGB888);
    dest.bits();

    return dest;
}

