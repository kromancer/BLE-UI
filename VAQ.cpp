#include "VAQ.h"
#include "deviceinfo.h"


/***************************************************
Motor Controlling Methods
****************************************************/
void VAQ::setX(char value)
{
    if(connectedToStage)
    {
        qWarning("Changing Yaw Value\n");
        // Later on we must put it somewhere else, so that we do not recreate it everytime
        const QLowEnergyCharacteristic Yaw = m_service->characteristic( QBluetoothUuid(QUuid("{00000000-0000-1000-8000-00805f9b34fb}") ));
        m_service->writeCharacteristic(Yaw, QByteArray(1,value));
    }
    return;
}

void VAQ::setY(char value)
{
    if(connectedToStage)
    {
        qWarning("Changing Yaw Value\n");
        // Later on we must put it somewhere else, so that we do not recreate it everytime
        const QLowEnergyCharacteristic Yaw = m_service->characteristic( QBluetoothUuid(QUuid("{00000001-0000-1000-8000-00805f9b34fb}") ));
        m_service->writeCharacteristic(Yaw, QByteArray(1,value));
    }
    return;
}

void VAQ::setZ(char value)
{
    if(connectedToStage)
    {
        qWarning("Changing Z\n");
        // Later on we must put it somewhere else, so that we do not recreate it everytime
        const QLowEnergyCharacteristic Yaw = m_service->characteristic( QBluetoothUuid(QUuid("{00000002-0000-1000-8000-00805f9b34fb}") ));
        m_service->writeCharacteristic(Yaw, QByteArray(1,value));
    }
    return;
}

void VAQ::setYaw(char value)
{
    if(connectedToStage)
    {
        qWarning("Changing Yaw Value\n");
        // Later on we must put it somewhere else, so that we do not recreate it everytime
        const QLowEnergyCharacteristic Yaw = m_service->characteristic( QBluetoothUuid(QUuid("{00000004-0000-1000-8000-00805f9b34fb}") ));
        m_service->writeCharacteristic(Yaw, QByteArray(1,value));
    }
    return;
}

/***************************************************
Constructor & Destructor
****************************************************/
VAQ::VAQ(): connectedToStage(false), sensorfound(false), m_control(0), m_service(0), m_currentDevice(QBluetoothDeviceInfo())
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

/***************************************************
QBluetoothDiscoveryAgent stuff
****************************************************

button press ==> deviceSearch ==> m_deviceDiscoveryAgent.start

    SIGNAL                  CALLBACK
    ------                  --------
    deviceDiscovered        addDevice
    finished                scanFinished ===> connectToService

****************************************************/
void VAQ::deviceSearch()
{
    m_deviceDiscoveryAgent->start();
    qWarning() << "Searching for Devices";
    return;
}

void VAQ::addDevice(const QBluetoothDeviceInfo &device)
{

    qWarning() << "Low Energy device found. Scanning for more...";
    if (device.coreConfigurations() & QBluetoothDeviceInfo::LowEnergyCoreConfiguration)
    {
        qWarning() << "Discovered LE Device name: " << device.name() << " Address: " << device.address().toString();
        if(!sensorfound)
        {
            DeviceInfo *dev = new DeviceInfo(device);
            if(dev->getName() == "Sandvik")
                qWarning() << "Found Sandvik device";
                m_devices.append(dev);
         }
    }
    return;
}
void VAQ::scanFinished()
{
    qWarning() << "Scan has finished";
    connectToService();
    return;
}



/***************************************************
QLowEnergyController stuff
****************************************************

connectToService ==> m_control.connectToDevice

    SIGNAL                  CALLBACK
    ------                  --------
    connected               deviceConnected
    serviceDiscovered       serviceDiscovered (gives just a print)
    discoveryFinished       serviceScanDone ==>
                                            if successfull in discoverying stage movement service
                                                m_service.discoverService
                                            else
                                                m_device.disconnect


****************************************************/
void VAQ::connectToService()
{
    if (!m_devices.isEmpty())
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
    }
    else{
        qWarning() << "Device named Sandvik not found" ;
    }
    return;
}


void VAQ::deviceConnected()
{
    qWarning() << "I am connected to the device" ;
    m_control->discoverServices();
    return;
}

void VAQ::serviceDiscovered(const QBluetoothUuid &gatt)
{
    qWarning() << "Found Service";
    return;
}

// This is where you need to hardwire uuid of service
void VAQ::serviceScanDone()
{
    m_service = m_control->createServiceObject( QBluetoothUuid(QUuid("{0000CCC1-0000-1000-8000-00805F9B34FB}") ) );
    connect(m_service, SIGNAL(stateChanged(QLowEnergyService::ServiceState)), this, SLOT(serviceStateChanged(QLowEnergyService::ServiceState)));
    connect(m_service, SIGNAL(characteristicWritten(const QLowEnergyCharacteristic&, const QByteArray&)), this, SLOT( serviceCharacteristicWritten(const QLowEnergyCharacteristic&, const QByteArray&)));
    connect(m_service, SIGNAL(error(QLowEnergyService::ServiceError)), this, SLOT( serviceError(QLowEnergyService::ServiceError)));

    //This is for the subscription service
    connect(m_service, SIGNAL(characteristicChanged(QLowEnergyCharacteristic,QByteArray)),
               this, SLOT(updateSubscriptionValue(QLowEnergyCharacteristic,QByteArray)));

    if (!m_service)
    {
        qWarning() << "Service not found";
        m_control->disconnectFromDevice();
        delete m_control;
        m_control = 0;
    }
    else
    {
        qWarning() << "I am connected to the Stage Movement Service";
        m_service->discoverDetails();
    }

    return;
}

void VAQ::deviceDisconnected()
{
    qWarning() << "Disconnected";
    connectedToStage = false;
    return;
}

void VAQ::controllerError(QLowEnergyController::Error error)
{
    qWarning() << "QLowEnergyController Error: " << error;
    return;
}

/******************************************************************
QLowEnergyService stuff

serviceScanDone ==> m_service.discoverDetails

    SIGNAL                  CALLBACK
    ------                  --------
    stateChanged            serviceStateChanged
                                if state == 3
                                    connectedToStage = true
                                    (maybe emit a singal for the GUI)
******************************************************************/

void VAQ::serviceStateChanged(QLowEnergyService::ServiceState newState)
{
    qWarning() << "Service State changed to: " << newState;
    if (newState==3)
    {
        const QLowEnergyCharacteristic hrChar = m_service->characteristic(QBluetoothUuid(QUuid("{00000006-0000-1000-8000-00805f9b34fb}")));
        if (!hrChar.isValid()) {
            qWarning() << "Subscription Data not found.";

        }else{
            const QLowEnergyDescriptor m_notificationDesc = hrChar.descriptor(
                        QBluetoothUuid::ClientCharacteristicConfiguration);
            if (m_notificationDesc.isValid()) {
                m_service->writeDescriptor(m_notificationDesc, QByteArray::fromHex("0100"));
                qWarning() << "Measuring";
            }
        }
        qWarning("Now you can proceed with moving things!");
        stageIsConnected();
        connectedToStage = true;
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


/*******************************************************************
 * GRAVEYARD OF POTENTIALLY USEFUL CODE
 * *****************************************************************

SERVICE UUIDS
-------------
IO: "{F000AA64-0451-4000-B000-000000000000}"
Luxometer: "{F000AA70-0451-4000-B000-00000000000}"


UNKNOWN STUFF
-------------
        //const QLowEnergyCharacteristic IOconfig = m_service->characteristic( QBluetoothUuid(QUuid("{F000AA66-0451-4000-B000-000000000000}") ) );
        //m_service->writeCharacteristic(IOconfig, QByteArray::fromHex("01"));
        //const QLowEnergyCharacteristic IOData = m_service->characteristic( QBluetoothUuid(QUuid("{F000AA65-0451-4000-B000-000000000000}") ) );
        //m_service->writeCharacteristic(IOData, QByteArray::fromHex("0F"));
        /*const QLowEnergyCharacteristic IOData = m_service->characteristic( QBluetoothUuid(QUuid("{0000ccc1-0000-1000-8000-00805f9b34fb}") ) );
        for(int i=0; i<3; i++){
            m_service->writeCharacteristic(IOData, QByteArray::fromHex("01"));
            //QTest::qSleep(1000);
            m_service->writeCharacteristic(IOData, QByteArray::fromHex("02"));
            //QTest::qSleep(1000);
            m_service->writeCharacteristic(IOData, QByteArray::fromHex("03"));
        }
*/

/************************************
 *
 * This is for the subscription service
 *
 *
 ************************************/


void VAQ::updateSubscriptionValue(const QLowEnergyCharacteristic &c, const QByteArray &value)
{

    // ignore any other changes other than the subscription service
    if (c.uuid() != QBluetoothUuid(QBluetoothUuid(QUuid("{00000006-0000-1000-8000-00805f9b34fb}"))) ){
        return;
    }

    const char *data = value.constData();
    quint8 flags = data[0];
    qWarning() << flags;

    switch(flags){
    case 1:
        emit stageIsReset();
    break;

    case 2:
        emit stageIsBusy();
    break;

    case 3:
        emit stageIsIdle();
    break;

    case 4:
        emit busReadError();
    break;

    case 5:
        emit busWriteError();
    break;

    default:
    break;
    }

    return;
}


