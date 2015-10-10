#include "VAQ.h"
#include "deviceinfo.h"



VAQ::VAQ(): m_control(0), m_service(0), m_currentDevice(QBluetoothDeviceInfo())
{
    m_deviceDiscoveryAgent = new QBluetoothDeviceDiscoveryAgent();
    connect(m_deviceDiscoveryAgent, SIGNAL(deviceDiscovered(const QBluetoothDeviceInfo&)),this, SLOT(addDevice(const QBluetoothDeviceInfo&)));
    connect(m_deviceDiscoveryAgent, SIGNAL(finished()), this, SLOT(scanFinished()));
}

VAQ::~VAQ()
{
    qDeleteAll(m_devices);
    m_devices.clear();
}

// ***************************************************
//QBluetoothDiscoveryAgent stuff
void VAQ::deviceSearch()
{
    m_deviceDiscoveryAgent->start();
    qWarning() << "Searching for Devices";
    return;
}
void VAQ::addDevice(const QBluetoothDeviceInfo &device)
{
    qWarning() << "Discovered LE Device name: " << device.name() << " Address: " << device.address().toString();
    DeviceInfo *dev = new DeviceInfo(device);
    m_devices.append(dev);
    qWarning() << "Low Energy device found. Scanning for more...";
    return;
}
void VAQ::scanFinished()
{
    qWarning() << "Scan has finished";
    connectToService();
    return;
}
//***************************************************



// **************************************************
// QLowEnergyController stuff
void VAQ::controllerError(QLowEnergyController::Error)
{
    qWarning() << "Welcome to the Candy Shop";
    return;
}



void VAQ::serviceDiscovered(const QBluetoothUuid &gatt)
{
    qWarning() << "Found something";
    return;
}


void VAQ::serviceScanDone()
{
    // IO: "{F000AA64-0451-4000-B000-000000000000}"
    // Luxometer: "{F000AA70-0451-4000-B000-000000000000}"
    m_service = m_control->createServiceObject( QBluetoothUuid(QUuid("{F000AA64-0451-4000-B000-000000000000}") ) );
    connect(m_service, SIGNAL(stateChanged(QLowEnergyService::ServiceState)), this, SLOT(serviceStateChanged(QLowEnergyService::ServiceState)));
    connect(m_service, SIGNAL(characteristicWritten(const QLowEnergyCharacteristic&, const QByteArray&)), this, SLOT( serviceCharacteristicWritten(const QLowEnergyCharacteristic&, const QByteArray&)));
    connect(m_service, SIGNAL(error(QLowEnergyService::ServiceError)), this, SLOT( serviceError(QLowEnergyService::ServiceError)));
    if (!m_service)
    {
        qWarning() << "Service not found";
        m_control->disconnectFromDevice();
        delete m_control;
        m_control = 0;
    }
    else
    {
        qWarning() << "Success";
        blinkLED();
    }
    return;
}

void VAQ::deviceDisconnected()
{
    qWarning() << "Disconnected by user request";
    return;
}


void VAQ::connectToService()
{
    m_currentDevice.setDevice(((DeviceInfo*)m_devices.at(0))->getDevice());
    m_control = new QLowEnergyController( m_currentDevice.getDevice(), this );

    connect(m_control, SIGNAL(connected()), this, SLOT(deviceConnected()));

    connect(m_control, SIGNAL( serviceDiscovered(QBluetoothUuid) ), this, SLOT( serviceDiscovered(QBluetoothUuid) ) );

    connect(m_control, SIGNAL( discoveryFinished() ), this, SLOT( serviceScanDone() ) );

    connect(m_control, SIGNAL (error(QLowEnergyController::Error)), this, SLOT(controllerError(QLowEnergyController::Error)));

    connect(m_control, SIGNAL( disconnected()), this, SLOT(deviceDisconnected()));

    qWarning() << "I will try to connect to the device: " << m_currentDevice.getAddress();

    m_control->connectToDevice();

    return;
}

void VAQ::deviceConnected()
{
    qWarning() << "I am connected to the device: " ;
    m_control->discoverServices();
    return;
}
// ******************************************************************

// ******************************************************************
// QLowEnergyService stuff
void VAQ::serviceStateChanged(QLowEnergyService::ServiceState newState)
{
    qWarning() << "Service State changed to: " << newState;
    if (newState==3)
    {
        const QLowEnergyCharacteristic IOconfig = m_service->characteristic( QBluetoothUuid(QUuid("{F000AA66-0451-4000-B000-000000000000}") ) );
        m_service->writeCharacteristic(IOconfig, QByteArray::fromHex("01"));
        const QLowEnergyCharacteristic IOData = m_service->characteristic( QBluetoothUuid(QUuid("{F000AA65-0451-4000-B000-000000000000}") ) );
        m_service->writeCharacteristic(IOData, QByteArray::fromHex("0F"));
    }
    return;
}

void VAQ::serviceCharacteristicWritten(const QLowEnergyCharacteristic& characteristic, const QByteArray& data)
{
    qWarning() << "I think I wrote: " << data;
    return;
}

void VAQ::serviceError(QLowEnergyService::ServiceError err)
{
    qWarning() << "Service error code: " << err;
    return;
}
// ******************************************************************

// ******************************************************************
// Demo application
void VAQ::blinkLED()
{
    qWarning() << "I will try to blink the LED now";
    qWarning() << m_service->serviceUuid();
    m_service->discoverDetails();
    return;
}
