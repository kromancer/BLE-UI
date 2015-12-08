#include "bluetooth.h"

/***************************************************
LED Controlling Methods
****************************************************/
void Bluetooth::setLED(char value){
    if(connectedToStage)
    {
        //m_service->writeCharacteristic(LED, QByteArray(1,value));
    }
    return;
}


/***************************************************
Motor Controlling Methods
****************************************************/
void Bluetooth::setX(char value)
{
    if(connectedToStage)
    {
        qWarning("Changing X Value\n");    
        m_service->writeCharacteristic(X_char, QByteArray(1,value));
    }
    return;
}

void Bluetooth::setY(char value)
{
    if(connectedToStage)
    {
        qWarning("Changing Y Value\n");
        m_service->writeCharacteristic(Y_char, QByteArray(1,value));
    }
    return;
}

void Bluetooth::setZ(char value)
{
    if(connectedToStage)
    {
        qWarning("Changing Z\n");
        m_service->writeCharacteristic(Z_char, QByteArray(1,value));
    }
    return;
}

void Bluetooth::resetStage(){
    m_service->writeCharacteristic(Reset_char, QByteArray(1,1));
}
/***************************************************
Constructor & Destructor
****************************************************/
Bluetooth::Bluetooth(): /*motorsSensorTag(),*/ connectedToStage(false), motorsSensorTagFound(false), m_control(0), m_service(0)
{
    m_deviceDiscoveryAgent = new QBluetoothDeviceDiscoveryAgent();
    connect(m_deviceDiscoveryAgent, SIGNAL(deviceDiscovered(const QBluetoothDeviceInfo&)),this, SLOT(addDevice(const QBluetoothDeviceInfo&)));
    connect(m_deviceDiscoveryAgent, SIGNAL(finished()), this, SLOT(scanFinished()));
    connect(m_deviceDiscoveryAgent, SIGNAL(canceled()), this, SLOT(scanFinished()));
}

Bluetooth::~Bluetooth()
{
    m_service->~QLowEnergyService();
    m_control->~QLowEnergyController();
    m_deviceDiscoveryAgent->~QBluetoothDeviceDiscoveryAgent();
}

/***************************************************
QBluetoothDiscoveryAgent stuff
****************************************************

When the application is launched ==> deviceSearch is invoked, which leads to ==> m_deviceDiscoveryAgent.start()

The QBluetoothDiscoveryAgent scans for BLE devices

The discoveryAgent emits the following signals:
(The connection is performed in the constructor)

    SIGNAL                  SLOT
    ------                  --------
    deviceDiscovered        addDevice
    finished                scanFinished ===> connectToService

****************************************************/
void Bluetooth::deviceSearch()
{
    m_deviceDiscoveryAgent->start();
    qWarning() << "Searching for Devices";
    return;
}

void Bluetooth::addDevice(const QBluetoothDeviceInfo &device)
{
    if (device.coreConfigurations() & QBluetoothDeviceInfo::LowEnergyCoreConfiguration)
    {
        qWarning() << "Discovered LE Device name: " << device.name() << " Address: " << device.address().toString();
        if(device.name() == "SandviS")
        {
            motorsSensorTagFound = true;
            qWarning() << "Found Stage SensorTag: " << device.address();
            motorsSensorTag = device;
            qWarning() << "Stored: " << motorsSensorTag.address();
            m_deviceDiscoveryAgent->stop();
        }
    }
    return;
}
void Bluetooth::scanFinished()
{
    qWarning() << "Scan has finished";
    connectToService();
    return;
}



/***************************************************
QLowEnergyController related slots
****************************************************

connectToService ==> m_control.connectToDevice

    SIGNAL                  SLOT
    ------                  --------
    connected               deviceConnected
    serviceDiscovered       serviceDiscovered (gives just a print)
    discoveryFinished       serviceScanDone ==>
                                            if successfull in discoverying stage movement service
                                                m_service.discoverService
                                            else
                                                m_device.disconnect


****************************************************/
void Bluetooth::connectToService()
{
    if ( motorsSensorTagFound )
    {
        m_control = new QLowEnergyController( motorsSensorTag, this );

        connect(m_control, SIGNAL(connected()), this, SLOT(deviceConnected()));

        connect(m_control, SIGNAL( serviceDiscovered(QBluetoothUuid) ), this, SLOT( serviceDiscovered(QBluetoothUuid) ) );

        connect(m_control, SIGNAL( discoveryFinished() ), this, SLOT( serviceScanDone() ) );

        connect(m_control, SIGNAL (error(QLowEnergyController::Error)), this, SLOT(controllerError(QLowEnergyController::Error)));

        connect(m_control, SIGNAL( disconnected()), this, SLOT(deviceDisconnected()));

        qWarning() << "I will try to connect to the device: " << motorsSensorTag.address();

        m_control->connectToDevice();
    }
    else{
        qWarning() << motorsSensorTag.address();
        qWarning() << "Device named Sandvik not found" ;
    }
    return;
}


void Bluetooth::deviceConnected()
{
    qWarning() << "I am connected to the device" ;
    m_control->discoverServices();
    return;
}

void Bluetooth::serviceDiscovered(const QBluetoothUuid &gatt)
{
    qWarning() << "Found Service";
    return;
}


void Bluetooth::serviceScanDone()
{
    // This is where the uuid of services are hardwired
    m_service = m_control->createServiceObject( QBluetoothUuid(QUuid("{0000CCC1-0000-1000-8000-00805F9B34FB}") ) );
    connect(m_service, SIGNAL(stateChanged(QLowEnergyService::ServiceState)), this, SLOT(serviceStateChanged(QLowEnergyService::ServiceState)));
    connect(m_service, SIGNAL(characteristicWritten(const QLowEnergyCharacteristic&, const QByteArray&)), this, SLOT( serviceCharacteristicWritten(const QLowEnergyCharacteristic&, const QByteArray&)));
    connect(m_service, SIGNAL(error(QLowEnergyService::ServiceError)), this, SLOT( serviceError(QLowEnergyService::ServiceError)));

    //This is to enable notifications from the Status Characteristic
    connect(m_service, SIGNAL(characteristicChanged(QLowEnergyCharacteristic,QByteArray)), this, SLOT(statusNotification(QLowEnergyCharacteristic,QByteArray)));

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

void Bluetooth::deviceDisconnected()
{
    qWarning() << "Disconnected";
    connectedToStage = false;
    return;
}

void Bluetooth::controllerError(QLowEnergyController::Error error)
{
    qWarning() << "QLowEnergyController Error: " << error;
    return;
}


/******************************************************************
QLowEnergyService related slots

serviceScanDone ==> m_service.discoverDetails

    SIGNAL                  SLOT
    ------                  --------
    stateChanged            serviceStateChanged
                                if state == 3
                                    connectedToStage = true
                                    (maybe emit a singal for the GUI)
******************************************************************/
void Bluetooth::serviceStateChanged(QLowEnergyService::ServiceState newState)
{
    qWarning() << "Service State changed to: " << newState;
    if (newState==3)
    {
        // Motor movement characteristics
        qWarning() << "Connecting to motor control characteristics";
        X_char =        m_service->characteristic( QBluetoothUuid(QUuid("{00000000-0000-1000-8000-00805f9b34fb}")));
        Y_char =        m_service->characteristic( QBluetoothUuid(QUuid("{00000001-0000-1000-8000-00805f9b34fb}")));
        Z_char =        m_service->characteristic( QBluetoothUuid(QUuid("{00000002-0000-1000-8000-00805f9b34fb}")));
        Roll_char =     m_service->characteristic( QBluetoothUuid(QUuid("{00000003-0000-1000-8000-00805f9b34fb}")));
        Pitch_char =    m_service->characteristic( QBluetoothUuid(QUuid("{00000004-0000-1000-8000-00805f9b34fb}")));
        Yaw_char =      m_service->characteristic( QBluetoothUuid(QUuid("{00000005-0000-1000-8000-00805f9b34fb}")));

        // Status characteristic. From this characteristic we get all our notifications
        qWarning() << "Connecting to status characteristic, enable notifications";
        Status_char =   m_service->characteristic( QBluetoothUuid(QUuid("{00000006-0000-1000-8000-00805f9b34fb}")));
        const QLowEnergyDescriptor m_notificationDesc = Status_char.descriptor( QBluetoothUuid::ClientCharacteristicConfiguration);
        m_service->writeDescriptor(m_notificationDesc, QByteArray::fromHex("0100"));


        // This characteristic resets the Arduino (The mcu on the main board, responsible for controlling the motors)
        qWarning() << "Connecting to reset characteristic";
        Reset_char =    m_service->characteristic( QBluetoothUuid(QUuid("{00000007-0000-1000-8000-00805f9b34fb}")));

        // LED master value...
        qWarning() << "Connecting to LED control characteristics";
        //LED_char =      m_service->characteristic( QBluetoothUuid(QUuid("{00000008-0000-1000-8000-00805f9b34fb}")));

        connectedToStage = true;
        qWarning("Now you can proceed with moving things");
        // Emit signal, so that the QML context (the visual objects) are aware of the situation
        stageIsConnected();        
    }
    return;
}

void Bluetooth::serviceCharacteristicWritten(const QLowEnergyCharacteristic& characteristic, const QByteArray& data)
{
    qWarning() << "I think I wrote: " << data.toInt();
    return;
}

void Bluetooth::serviceError(QLowEnergyService::ServiceError err)
{
    qWarning() << "Service error code: " << err;
    return;
}

void Bluetooth::statusNotification(const QLowEnergyCharacteristic &c, const QByteArray &value)
{
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
            resetStage();
            emit busError();
        break;

        default:
        break;
    }
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




/* GRAVEYARD OF POTENTIALLY USEFULL CODE
 ignore any other changes other than the subscription service
 if (c.uuid() != QBluetoothUuid(QBluetoothUuid(QUuid("{00000006-0000-1000-8000-00805f9b34fb}"))) ){
    return;
}
//This is for debug purposes only
void VAQ::emitError(){
    emit busWriteError();
}


//When the application gets a bus error three times there's definatly something wrong with the tag
void VAQ::incrementFailureCount(){
    failureCount++;
    if (failureCount == 3){
        failureCount = 0;
        emit busHasFailed();


        //if(connectedToStage)
        {
            qWarning("Writing to reset\n");
            // Later on we must put it somewhere else, so that we do not recreate it everytime
            const QLowEnergyCharacteristic Reset = m_service->characteristic( QBluetoothUuid(QUuid("{00000007-0000-1000-8000-00805f9b34fb}") ));
            m_service->writeCharacteristic(Reset, QByteArray(1,value));
        }
    }
}

void VAQ::addDevice(const QBluetoothDeviceInfo &device)
{


    if (device.coreConfigurations() & QBluetoothDeviceInfo::LowEnergyCoreConfiguration)
    {
        qWarning() << "Low Energy device found. Scanning for more...";
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
*/
