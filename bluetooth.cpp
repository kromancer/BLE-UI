#include "bluetooth.h"

/***************************************************
Constructor & Destructor
****************************************************/
Bluetooth::Bluetooth():
    connectedToStage(false),
    connectedToLed(false),
    motorsSensorTagFound(false),
    ledSensorTagFound(false),
    i2cError(false),
    m_control(0),
    l_control(0),
    m_service(0),
    l_service(0),
    destro(this)
{
    destro.powerOn();
    m_deviceDiscoveryAgent = new QBluetoothDeviceDiscoveryAgent();
    connect(m_deviceDiscoveryAgent, SIGNAL(deviceDiscovered(const QBluetoothDeviceInfo&)),this, SLOT(addDevice(const QBluetoothDeviceInfo&)));
    connect(m_deviceDiscoveryAgent, SIGNAL(finished()), this, SLOT(scanFinished()));
    connect(m_deviceDiscoveryAgent, SIGNAL(canceled()), this, SLOT(scanFinished()));
    connect( QCoreApplication::instance(), SIGNAL(aboutToQuit()), this, SLOT(releaseBLE()));
}

Bluetooth::~Bluetooth()
{   
}

/*****************************************************
CLEAN UP CODE (WHEN USER CLOSES APPLICATION'S WINDOWS
*****************************************************/
void Bluetooth::releaseBLE()
{

    // qWarning() << "Releasing BLE stack ...";

    // Unsuscribe from any notifications
    if (motorNotificationDesc.isValid() && m_service) {
        m_service->writeDescriptor(motorNotificationDesc, QByteArray::fromHex("0000"));
        // qWarning() << "Unsuscribed from stage notifications";
    }

    // qWarning() << "Deleting discovery agent";
    if (m_deviceDiscoveryAgent->isActive())
        m_deviceDiscoveryAgent->stop();

    if (m_deviceDiscoveryAgent)
    {
        delete m_deviceDiscoveryAgent;
        m_deviceDiscoveryAgent = 0;
    }

    if (connectedToStage)
    {
        // qWarning() << "Deleting motor service";
        m_service->disconnect();
        delete m_service;
        // qWarning() << "Deleting motor controller";
        m_control->disconnectFromDevice();
        delete m_control;
    }

    if (connectedToLed)
    {
        // qWarning() << "Deleting led service";
        l_service->disconnect();
        delete l_service;
        // qWarning() << "Deleting led controller";
        l_control->disconnectFromDevice();
        delete l_control;
    }

    // qWarning() << "BLE stack released";

    destro.setHostMode(QBluetoothLocalDevice::HostPoweredOff);
    return;
}

void Bluetooth::disconnectFromStage(){
    // qWarning() << "Deleting motor service";
    m_service->disconnect();
    delete m_service;
    // qWarning() << "Deleting motor controller";
    m_control->disconnectFromDevice();
    delete m_control;
    connectedToStage = false;
    return;
}

void Bluetooth::disconnectFromLED()
{ 
    // qWarning() << "Deleting led service";
    l_service->disconnect();
    delete l_service;
    // qWarning() << "Deleting led controller";
    l_control->disconnectFromDevice();
    delete l_control;
    connectedToLed = false;
    return;
}

/***************************************************
Motor Controlling Methods
****************************************************/
void Bluetooth::setX(char value)
{
    if(connectedToStage)
    {
        // qWarning("Changing X Value\n");
        m_service->writeCharacteristic(X_char, QByteArray(1,value));
    }
    return;
}

void Bluetooth::setY(char value)
{
    if(connectedToStage)
    {
        // qWarning("Changing Y Value\n");
        m_service->writeCharacteristic(Y_char, QByteArray(1,value));
    }
    return;
}

void Bluetooth::setZ(char value)
{
    if(connectedToStage)
    {
        // qWarning("Changing Z\n");
        m_service->writeCharacteristic(Z_char, QByteArray(1,value));
    }
    return;
}

void Bluetooth::setRoll(char value)
{
    if(connectedToStage)
    {
        // qWarning("Changing Roll\n");
        m_service->writeCharacteristic(Roll_char, QByteArray(1,value));
    }
    return;
}

void Bluetooth::setPitch(char value)
{
    if(connectedToStage)
    {
        // qWarning("Changing Pitch\n");
        m_service->writeCharacteristic(Pitch_char, QByteArray(1,value));
    }
    return;
}

void Bluetooth::setYaw(char value)
{
    if(connectedToStage)
    {
        // qWarning("Changing Yaw: %d", value);
        m_service->writeCharacteristic(Yaw_char, QByteArray(1,value));
    }
    return;
}

void Bluetooth::resetStage(){
    emit motorIgnore();
    m_service->writeCharacteristic(Reset_char, QByteArray(1,1));
    return;
}


/***************************************************
LED Controlling Method
****************************************************/
void Bluetooth::setLED(char value){
    QLowEnergyCharacteristic LED_char = l_service->characteristic( QBluetoothUuid(QUuid("{00000000-0000-1000-8000-00805f9b34fb}")));
    // qWarning() << "Changing LED: " << hex << QByteArray(1,value).toHex();
    l_service->writeCharacteristic(LED_char, QByteArray(1,value));
    return;
}



/***************************************************
QBluetoothDiscoveryAgent stuff
****************************************************

When the BLE Scan button is pressed ==> deviceSearch is invoked, which leads to ==> m_deviceDiscoveryAgent.start()

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

    // qWarning() << "Searching for Devices";
    emit deviceScanStarted();
    m_deviceDiscoveryAgent->start();

    return;
}

void Bluetooth::addDevice(const QBluetoothDeviceInfo &device)
{
    if (device.coreConfigurations() & QBluetoothDeviceInfo::LowEnergyCoreConfiguration)
    {
        //// qWarning() << "Discovered LE Device name: " << device.name() << " Address: " << device.address().toString();
        if(device.name() == "StageMotors")
        {
            motorsSensorTagFound = true;
            // qWarning() << "Found Stage SensorTag: " << device.address();
            motorsSensorTag = device;
            emit motorSensorTagIsFound();
        }
        else if( device.name() == "StageLEDs")
        {
            ledSensorTagFound = true;
            // qWarning() << "Found LED SensorTag: " << device.address();
            ledSensorTag = device;
            emit ledSensorTagIsFound();
            //m_deviceDiscoveryAgent->stop();
        }
        else
            ;

        if ( motorsSensorTagFound && ledSensorTagFound)
            m_deviceDiscoveryAgent->stop();
    }
    return;
}

void Bluetooth::scanFinished()
{
    emit deviceScanDone();
    // qWarning() << "************************************";
    // qWarning() << "Scan has finished";
    if (!motorsSensorTagFound && !ledSensorTagFound)
    {
        // qWarning() << "None of the SensorTags was found";
        emit motorSensorTagNotFound();
        emit ledSensorTagNotFound();

    }
    else if (!motorsSensorTagFound)
    {
        emit motorSensorTagNotFound();
        // qWarning() << "Motor SensorTag was not found";
    }
    else if (!ledSensorTagFound)
    {
        emit ledSensorTagNotFound();
        // qWarning() << "LED SensorTag was not found";
    }
    // qWarning() << "************************************";
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
void Bluetooth::connectToMotorSensorTag()
{
    if(motorsSensorTagFound)
    {
        // Motor Sensor Tag Stuff
        m_control = new QLowEnergyController( motorsSensorTag );

        connect(m_control, SIGNAL(connected()), this, SLOT(m_deviceConnected()));

        connect(m_control, SIGNAL( serviceDiscovered(QBluetoothUuid) ), this, SLOT( m_serviceDiscovered(QBluetoothUuid) ) );

        connect(m_control, SIGNAL( discoveryFinished() ), this, SLOT( m_serviceScanDone() ) );

        connect(m_control, SIGNAL (error(QLowEnergyController::Error)), this, SLOT(m_controllerError(QLowEnergyController::Error)));

        connect(m_control, SIGNAL( disconnected()), this, SLOT(m_deviceDisconnected()));

        // qWarning() << "I will try to connect to the motors SensorTag ";

        m_control->connectToDevice();
    }

    return;
}

void Bluetooth::connectToLEDSensorTag()
{
    if(ledSensorTagFound)
    {
        l_control = new QLowEnergyController( ledSensorTag );

        connect(l_control, SIGNAL( connected()), this, SLOT(l_deviceConnected()));

        connect(l_control, SIGNAL( serviceDiscovered(QBluetoothUuid) ), this, SLOT( l_serviceDiscovered(QBluetoothUuid) ) );

        connect(l_control, SIGNAL( discoveryFinished() ), this, SLOT( l_serviceScanDone() ) );

        connect(l_control, SIGNAL (error(QLowEnergyController::Error)), this, SLOT(l_controllerError(QLowEnergyController::Error)));

        connect(l_control, SIGNAL( disconnected()), this, SLOT(l_deviceDisconnected()));

        // qWarning() << "I will try to connect to the LED SensorTag ";

        l_control->connectToDevice();

    }

    return;
}

/******************************************************
 * Motors SensorTag QLowEnergy controller related slots
 * ****************************************************/
void Bluetooth::m_deviceConnected()
{
    // qWarning() << "I am connected to the motors SensorTag" ;
    m_control->discoverServices();
    return;
}

void Bluetooth::m_serviceDiscovered(const QBluetoothUuid &gatt)
{
    // qWarning() << "Found motor SensorTag service" << gatt.toString();
    return;
}

void Bluetooth::m_serviceScanDone()
{
    // This is where the uuid of services are hardwired
    m_service = m_control->createServiceObject( QBluetoothUuid(QUuid("{0000CCC1-0000-1000-8000-00805F9B34FB}") ) );
    connect(m_service, SIGNAL(stateChanged(QLowEnergyService::ServiceState)), this, SLOT(m_serviceStateChanged(QLowEnergyService::ServiceState)));
    connect(m_service, SIGNAL(characteristicWritten(const QLowEnergyCharacteristic&, const QByteArray&)), this, SLOT( m_serviceCharacteristicWritten(const QLowEnergyCharacteristic&, const QByteArray&)));
    connect(m_service, SIGNAL(error(QLowEnergyService::ServiceError)), this, SLOT( m_serviceError(QLowEnergyService::ServiceError)));

    //This is to enable notifications from the Status Characteristic
    connect(m_service, SIGNAL(characteristicChanged(QLowEnergyCharacteristic,QByteArray)), this, SLOT(m_statusNotification(QLowEnergyCharacteristic,QByteArray)));

    if (!m_service)
    {
        // qWarning() << "Motos service not found";
        m_control->disconnectFromDevice();
        delete m_control;
        m_control = 0;
    }
    else
    {
        // qWarning() << "I am connected to the motors service";
        emit motorServiceIsFound();
        m_service->discoverDetails();
    }

    return;
}

void Bluetooth::m_deviceDisconnected()
{
    // qWarning() << "Disconnecting from stage";
    disconnectFromStage();
    return;
}

void Bluetooth::m_controllerError(QLowEnergyController::Error error)
{
    // qWarning() << "Motor SensorTag QLowEnergyController Error: " << error;
    return;
}

/******************************************************
 * LED SensorTag QLowEnergy controller related slots
 * ****************************************************/
void Bluetooth::connectToLEDService()
{
    l_control->connectToDevice();
    return;
}

void Bluetooth::l_deviceConnected()
{
    // qWarning() << "I am connected to the LED SensorTag" ;
    l_control->discoverServices();
    return;
}

void Bluetooth::l_serviceDiscovered(const QBluetoothUuid &gatt)
{
    // qWarning() << "Found LED service" << gatt.toString();
    return;
}

void Bluetooth::l_serviceScanDone()
{
    // This is where the uuid of services are hardwired
    l_service = l_control->createServiceObject( QBluetoothUuid(QUuid("{0000CCC0-0000-1000-8000-00805F9B34FB}") ) );
    connect(l_service, SIGNAL(stateChanged(QLowEnergyService::ServiceState)), this, SLOT(l_serviceStateChanged(QLowEnergyService::ServiceState)));
    connect(l_service, SIGNAL(characteristicWritten(const QLowEnergyCharacteristic&, const QByteArray&)), this, SLOT( l_serviceCharacteristicWritten(const QLowEnergyCharacteristic&, const QByteArray&)));
    connect(l_service, SIGNAL(error(QLowEnergyService::ServiceError)), this, SLOT( l_serviceError(QLowEnergyService::ServiceError)));

    if (!l_service)
    {
        // qWarning() << "LED service not found";
        l_control->disconnectFromDevice();
        delete l_control;
        l_control = 0;
    }
    else
    {
        // qWarning() << "I am connected to the LED service";
        emit ledServiceIsFound();
        l_service->discoverDetails();
    }

    return;
}

void Bluetooth::l_deviceDisconnected()
{
    // qWarning() << "Disconnected from LED service";
    disconnectFromLED();
    return;
}

void Bluetooth::l_controllerError(QLowEnergyController::Error error)
{
    // qWarning() << "LED SensorTag QLowEnergyController Error: " << error;
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


/*******************************************************************
 *  Motor Service Related Stuff
 * *****************************************************************/
void Bluetooth::m_serviceStateChanged(QLowEnergyService::ServiceState newState)
{
    // qWarning() << "Motors service State changed to: " << newState;
    if (newState==3)
    {
        // Motor movement characteristics
        // qWarning() << "Connecting to motor control characteristics";
        X_char =        m_service->characteristic( QBluetoothUuid(QUuid("{00000000-0000-1000-8000-00805f9b34fb}")));
        Y_char =        m_service->characteristic( QBluetoothUuid(QUuid("{00000001-0000-1000-8000-00805f9b34fb}")));
        Z_char =        m_service->characteristic( QBluetoothUuid(QUuid("{00000002-0000-1000-8000-00805f9b34fb}")));
        Roll_char =     m_service->characteristic( QBluetoothUuid(QUuid("{00000003-0000-1000-8000-00805f9b34fb}")));
        Pitch_char =    m_service->characteristic( QBluetoothUuid(QUuid("{00000004-0000-1000-8000-00805f9b34fb}")));
        Yaw_char =      m_service->characteristic( QBluetoothUuid(QUuid("{00000005-0000-1000-8000-00805f9b34fb}")));

        // Status characteristic. From this characteristic we get all our notifications
        // qWarning() << "Connecting to status characteristic, enable notifications";
        Status_char           = m_service->characteristic( QBluetoothUuid(QUuid("{00000006-0000-1000-8000-00805f9b34fb}")));
        motorNotificationDesc = Status_char.descriptor( QBluetoothUuid::ClientCharacteristicConfiguration);
        m_service->writeDescriptor(motorNotificationDesc, QByteArray::fromHex("0100"));

        // This characteristic resets the Arduino (The mcu on the main board, responsible for controlling the motors)
        // qWarning() << "Connecting to reset characteristic";
        Reset_char =    m_service->characteristic( QBluetoothUuid(QUuid("{00000007-0000-1000-8000-00805f9b34fb}")));

        connectedToStage = true;
        emit motorServiceIsReady();
        // qWarning("Now you can proceed with moving things");
    }
    return;
}

void Bluetooth::m_serviceCharacteristicWritten(const QLowEnergyCharacteristic& characteristic, const QByteArray& data)
{
    // qWarning() << characteristic.uuid() << " written";
    return;
}

void Bluetooth::m_serviceError(QLowEnergyService::ServiceError err)
{
    // qWarning() << "Motors Service error: " << err;
    return;
}

void Bluetooth::m_statusNotification(const QLowEnergyCharacteristic &c, const QByteArray &value)
{
    const char *data = value.constData();
    quint8 flags = data[0];
    // qWarning() << flags;

    switch(flags){
    case 1:
        if (i2cError)
            i2cError = false;
        emit stageIsReset();
        break;

    case 2:
        emit stageIsBusy();
        break;

    case 3:
        emit stageIsIdle();
        break;

    case 4:
        if (!i2cError)
        {
            i2cError = true;
            resetStage();
            emit busError();
        }
        break;
    case 17:
        emit xAxisMinReached();
        // qWarning() << "X min reached";
        break;

    case 18:
        emit xAxisMaxReached();
        // qWarning() << "X max reached";
        break;

    case 19:
        emit yAxisMinReached();
        // qWarning() << "Y min reached";
        break;

    case 20:
        emit yAxisMaxReached();
        // qWarning() << "Y max reached";
        break;

    case 21:
        emit zAxisMinReached();
        // qWarning() << "Z min reached";
        break;

    case 22:
        emit zAxisMaxReached();
        // qWarning() << "Z max reached";
        break;

    case 23:
        emit rollMinReached();
        // qWarning() << "Roll min reached";
        break;

    case 24:
        emit rollMaxReached();
        // qWarning() << "Roll max reached";
        break;

    case 25:
        emit pitchMinReached();
        // qWarning() << "Pitch min reached";
        break;

    case 26:
        emit pitchMaxReached();
        // qWarning() << "Pitch max reached";
        break;

    default:
        break;
    }
    return;
}


/*******************************************************************
 *  LED Service Related Stuff
 * *****************************************************************/
void Bluetooth::l_serviceStateChanged(QLowEnergyService::ServiceState newState)
{
    // qWarning() << "LED Service State changed to: " << newState;
    if (newState==3)
    {
        connectedToLed = true;
        // qWarning("Now you can proceed with Lighting the Stage!");
        emit ledServiceIsReady();

    }
    return;
}

void Bluetooth::l_serviceCharacteristicWritten(const QLowEnergyCharacteristic& characteristic, const QByteArray& data)
{
    // qWarning() << "LED characteristic written" << characteristic.uuid();
    return;
}

void Bluetooth::l_serviceError(QLowEnergyService::ServiceError err)
{
    // qWarning() << "LED Service error: " << err;
    return;
}




/*******************************************************************
 *  General Functions
 * *****************************************************************/
bool Bluetooth::isLEDSensorTagFound(){
    return ledSensorTagFound;
}

bool Bluetooth::isMotorsSensorTagFound(){
    return motorsSensorTagFound;
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
            // qWarning("Writing to reset\n");
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
        // qWarning() << "Low Energy device found. Scanning for more...";
        // qWarning() << "Discovered LE Device name: " << device.name() << " Address: " << device.address().toString();
        if(!sensorfound)
        {
            DeviceInfo *dev = new DeviceInfo(device);
            if(dev->getName() == "Sandvik")
                // qWarning() << "Found Sandvik device";
                m_devices.append(dev);
         }
    }
    return;
}

        const QLowEnergyCharacteristic hrChar = m_service->characteristic(QBluetoothUuid(QUuid("{00000006-0000-1000-8000-00805f9b34fb}")));
        if (!hrChar.isValid()) {
            // qWarning() << "Subscription Data not found.";

        }else{
            const QLowEnergyDescriptor m_notificationDesc = hrChar.descriptor(
                        QBluetoothUuid::ClientCharacteristicConfiguration);
            if (m_notificationDesc.isValid()) {
                m_service->writeDescriptor(m_notificationDesc, QByteArray::fromHex("0100"));
                // qWarning() << "Measuring";
            }
        }
*/
