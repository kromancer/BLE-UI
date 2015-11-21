#include "camera.h"

/******************************************************************************
 * METHODS FOR ACQUISITION, DISPLAY AND STORAGE OF IMAGE STREAM
 ******************************************************************************/

// Withing QML whenever we call the update method on a PG_Camera object, this method is invoked.
// The update is requested by the QML timer, located in CameraPanel.qml
void PG_Camera::paint(QPainter *painter)
{
    // I hope that this calls the move assignment operator
    QImage frame = getFrame();

    painter->drawImage(contentsBoundingRect(),frame);

    return;
}

// Super easy. The method is called from the FileDialog item, onAccepted.
void PG_Camera::saveFrame(QString path)
{
    // I hope that this calls the move assignment operator
    QImage frame = getFrame();

    frame.save(path);

    return;
}


QImage PG_Camera::getFrame()
{
    FlyCapture2::Image rawImage, rgbImage;

    error = our_cam.RetrieveBuffer( &rawImage );

    rawImage.Convert(FlyCapture2::PIXEL_FORMAT_RGB8, &rgbImage);

    QImage dest((const uchar *) rgbImage.GetData(), rgbImage.GetCols(), rgbImage.GetRows(), QImage::Format_RGB888);

    dest.bits();

    return dest;
}

/******************************************************************************
 * MAGIC METHOD FOR SHOWING CAMERA SETTINGS WINDOW
 ******************************************************************************/

void PG_Camera::showSettings()
{
    CameraControlDlg settingsWindow;

    settingsWindow.Connect(&our_cam);

    settingsWindow.Show();

    return;
}

/******************************************************************************
 * CONSTRUCTOR
 ******************************************************************************/
PG_Camera::PG_Camera(QQuickItem *parent): QQuickPaintedItem(parent)
{
    // Discover GigE cameras
    unsigned int numCamInfo;
    FlyCapture2::CameraInfo cam_disc[10];
    error = FlyCapture2::BusManager::DiscoverGigECameras( cam_disc , &numCamInfo );
    if (error != FlyCapture2::PGRERROR_OK)
    {
        printError( error );
    }

    // Get camera's id
    error = busMgr.GetCameraFromIndex(0, &guid);
    if (error != FlyCapture2::PGRERROR_OK)
    {
        printError( error );
    }

    // Connect to the camera
    error = our_cam.Connect(&guid);
    if (error != FlyCapture2::PGRERROR_OK)
    {
        printError( error );
    }


    // Print camera info
    error = our_cam.GetCameraInfo(&cam_info);
    if (error != FlyCapture2::PGRERROR_OK)
    {
        printError( error );
    }
    printCameraInfo(&cam_info);


    // Create channel of communication with the camera
    error = our_cam.GetGigEStreamChannelInfo( 0, &our_chan );
    if (error != FlyCapture2::PGRERROR_OK)
    {
        printError( error );
    }

    // We do not understand this:
    our_chan.destinationIpAddress.octets[0] = 224;
    our_chan.destinationIpAddress.octets[1] = 0;
    our_chan.destinationIpAddress.octets[2] = 0;
    our_chan.destinationIpAddress.octets[3] = 1;
    error = our_cam.SetGigEStreamChannelInfo( 0, &our_chan );
    if (error != FlyCapture2::PGRERROR_OK)
    {
        printError( error );
    }
    cout << "Printing stream channel information for channel " << 0 << endl;
    printStreamChannelInfo( &our_chan);


    // Set Camera Image settings
    error = our_cam.GetGigEImageSettingsInfo( &imageSettingsInfo );
    if (error != FlyCapture2::PGRERROR_OK)
    {
        printError( error );
    }
    FlyCapture2::GigEImageSettings imageSettings;
    imageSettings.offsetX = 0;
    imageSettings.offsetY = 0;
    imageSettings.height = imageSettingsInfo.maxHeight;
    imageSettings.width = imageSettingsInfo.maxWidth;
    imageSettings.pixelFormat = FlyCapture2::PIXEL_FORMAT_RGB8;
    error = our_cam.SetGigEImageSettings( &imageSettings );
    if (error != FlyCapture2::PGRERROR_OK)
    {
        printError( error );
    }


    // Start Capturing
    cout << "Starting image capture..." << endl;
    error = our_cam.StartCapture();
    if (error != FlyCapture2::PGRERROR_OK)
    {
        printError( error );
    }
}

PG_Camera::~PG_Camera()
{
    our_cam.StopCapture();
    our_cam.Disconnect();
}


/******************************************************************************
 * CAMERA STATUS METHODS, USED FOR DEBUGGING, CALLED IN THE CONSTRUCTOR
 ******************************************************************************/

void PG_Camera::printCameraSettings()
{
    cout << "Camera Settings" << endl;
    cout << "Max height: " << imageSettingsInfo.maxHeight << " Max width: " << imageSettingsInfo.maxWidth << endl;
}


void PG_Camera::printBuildInfo()
{
    FlyCapture2::FC2Version fc2Version;
    FlyCapture2::Utilities::GetLibraryVersion( &fc2Version );

    ostringstream version;
    version << "FlyCapture2 library version: " << fc2Version.major << "." << fc2Version.minor << "." << fc2Version.type << "." << fc2Version.build;
    cout << version.str() << endl;

    ostringstream timeStamp;
    timeStamp << "Application build date: " << __DATE__ << " " << __TIME__;
    cout << timeStamp.str() << endl << endl;

    qWarning("Button pressed\n");
}

void PG_Camera::printCameraInfo( FlyCapture2::CameraInfo* pCamInfo )
{
    ostringstream macAddress;
    macAddress << hex << setw(2) << setfill('0') << (unsigned int)pCamInfo->macAddress.octets[0] << ":" <<
                  hex << setw(2) << setfill('0') << (unsigned int)pCamInfo->macAddress.octets[1] << ":" <<
                  hex << setw(2) << setfill('0') << (unsigned int)pCamInfo->macAddress.octets[2] << ":" <<
                  hex << setw(2) << setfill('0') << (unsigned int)pCamInfo->macAddress.octets[3] << ":" <<
                  hex << setw(2) << setfill('0') << (unsigned int)pCamInfo->macAddress.octets[4] << ":" <<
                  hex << setw(2) << setfill('0') << (unsigned int)pCamInfo->macAddress.octets[5];


    ostringstream ipAddress;
    ipAddress << (unsigned int)pCamInfo->ipAddress.octets[0] << "." <<
                 (unsigned int)pCamInfo->ipAddress.octets[1] << "." <<
                 (unsigned int)pCamInfo->ipAddress.octets[2] << "." <<
                 (unsigned int)pCamInfo->ipAddress.octets[3];

    ostringstream subnetMask;
    subnetMask << (unsigned int)pCamInfo->subnetMask.octets[0] << "." <<
                  (unsigned int)pCamInfo->subnetMask.octets[1] << "." <<
                  (unsigned int)pCamInfo->subnetMask.octets[2] << "." <<
                  (unsigned int)pCamInfo->subnetMask.octets[3];

    ostringstream defaultGateway;
    defaultGateway << (unsigned int)pCamInfo->defaultGateway.octets[0] << "." <<
                      (unsigned int)pCamInfo->defaultGateway.octets[1] << "." <<
                      (unsigned int)pCamInfo->defaultGateway.octets[2] << "." <<
                      (unsigned int)pCamInfo->defaultGateway.octets[3];

    cout << endl;
    cout << "*** CAMERA INFORMATION ***" << endl;
    cout << "Serial number - " << pCamInfo->serialNumber << endl;
    cout << "Camera model - " << pCamInfo->modelName << endl;
    cout << "Camera vendor - " << pCamInfo->vendorName << endl;
    cout << "Sensor - " << pCamInfo->sensorInfo << endl;
    cout << "Resolution - " << pCamInfo->sensorResolution << endl;
    cout << "Firmware version - " << pCamInfo->firmwareVersion << endl;
    cout << "Firmware build time - " << pCamInfo->firmwareBuildTime << endl;
    cout << "GigE version - " << pCamInfo->gigEMajorVersion << "." << pCamInfo->gigEMinorVersion << endl;
    cout << "User defined name - " << pCamInfo->userDefinedName << endl;
    cout << "XML URL 1 - " << pCamInfo->xmlURL1 << endl;
    cout << "XML URL 2 - " << pCamInfo->xmlURL2 << endl;
    cout << "MAC address - " << macAddress.str() << endl;
    cout << "IP address - " << ipAddress.str() << endl;
    cout << "Subnet mask - " << subnetMask.str() << endl;
    cout << "Default gateway - " << defaultGateway.str() << endl << endl;
}

void PG_Camera::printStreamChannelInfo( FlyCapture2::GigEStreamChannel* pStreamChannel )
{
    ostringstream ipAddress;
    ipAddress << (unsigned int)pStreamChannel->destinationIpAddress.octets[0] << "." <<
                (unsigned int)pStreamChannel->destinationIpAddress.octets[1] << "." <<
                (unsigned int)pStreamChannel->destinationIpAddress.octets[2] << "." <<
                (unsigned int)pStreamChannel->destinationIpAddress.octets[3];

    cout << "Network interface: " << pStreamChannel->networkInterfaceIndex << endl;
    cout << "Host Port: " << pStreamChannel->hostPort << endl;
    cout << "Do not fragment bit: " << ( pStreamChannel->doNotFragment ? "Enabled" : "Disabled") << endl;
    cout << "Packet size: " << pStreamChannel->packetSize << endl;
    cout << "Inter packet delay: " << pStreamChannel->interPacketDelay << endl;
    cout << "Destination IP address: " << ipAddress.str() << endl;
    cout << "Source port (on camera): " << pStreamChannel->sourcePort << endl << endl;
}


void PG_Camera::printError( FlyCapture2::Error error )
{
    error.PrintErrorTrace();
}