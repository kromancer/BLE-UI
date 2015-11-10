#include "cam_settings.h"

CamSettings::CamSettings(GigECamera *cam_): cam(cam_)
{

    auto_exposure.type = AUTO_EXPOSURE;
    auto_exposure.onOff = true;
    auto_exposure.autoManualMode = false;
    auto_exposure.absControl = true;

    shutter.type = SHUTTER;
    shutter.onOff = true;
    shutter.autoManualMode = false;
    shutter.absControl = true;

    gain.type = GAIN;
    gain.autoManualMode = false;
    gain.absControl = true;

    brightness.type = BRIGHTNESS;
    brightness.absControl = true;
}

// value is in milliseconds for 0.044ms to 32s
void CamSettings::setShutter(unsigned int value)
{
    shutter.absValue = value;
    qWarning("Changed shutter parameter: %d\n", value);
    cam->SetProperty(&shutter);
    return;
}

// This needs investigation, something about EV
void CamSettings::setAutoExposure(float value)
{
    auto_exposure.absValue = value;
    qWarning("Setting auto exposure to: %f\n", value);
    cam->SetProperty(&auto_exposure);
    return;
}


// value is a percentage
void CamSettings::setBrightness(float value)
{
    brightness.absValue = value;
    qWarning("Setting brightness value to: %f\n", value);
    cam->SetProperty(&brightness);
    return;
}


// value is in db from -11 to 24
void CamSettings::setGain(int value)
{
    gain.absValue = value;
    Error err = cam->SetProperty(&gain);
    qWarning("Setting gain to: %d\n", value);
    return;
}
