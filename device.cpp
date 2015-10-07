/*
#include "device.h"
#include <iostream>

Device::Device()
{
    agent = new QBluetoothDeviceDiscoveryAgent();
    connect(agent, SIGNAL(deviceDiscovered(const QBluetoothDeviceInfo&)),this, SLOT(addDevice(const QBluetoothDeviceInfo&)));
}


void Device::addDevice(const QBluetoothDeviceInfo &discDevice)
{
    std::cout << "Found Device" << std::endl;
}


void Device::initiateAgent()
{
    agent->start();
}
*/
