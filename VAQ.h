#ifndef VAQ_H
#define VAQ_H

#include <QString>
#include <QDebug>
#include <QDateTime>
#include <QVector>
#include <QTimer>
#include <QBluetoothDeviceDiscoveryAgent>
#include <QBluetoothDeviceInfo>
#include <QLowEnergyController>
#include <QLowEnergyService>
#include "deviceinfo.h"
#include "stdint.h"

class VAQ: public QObject
{
    Q_OBJECT


public:
    VAQ();
    ~VAQ();
    void blinkLED();


    //LED control methods
    Q_INVOKABLE void setLED(char value);

    //Stage control methods
    Q_INVOKABLE void setX(char value);
    Q_INVOKABLE void setY(char value);
    Q_INVOKABLE void setZ(char value);
    Q_INVOKABLE void setYaw(char value);

    //Failure handling methods
    Q_INVOKABLE void incrementFailureCount();
    Q_INVOKABLE void resetFailureCount();

    //This is for debug purposes only
    Q_INVOKABLE void emitError();

public slots:
     void deviceSearch();
     void connectToService();

signals:
     void stageIsConnected();
     //signals emitted when receiving subscription signals
     //emitted              received
     void stageIsReset();   //1
     void stageIsBusy();    //2
     void stageIsIdle();    //3
     void busReadError();   //4
     void busWriteError();  //5
     //When we failed three times, this is emitted
     void busHasFailed();

private slots:
    void addDevice(const QBluetoothDeviceInfo&);
    void scanFinished();
    void deviceConnected();
    void serviceDiscovered(const QBluetoothUuid &gatt);
    void serviceScanDone();
    void controllerError(QLowEnergyController::Error);
    void deviceDisconnected();
    void serviceStateChanged(QLowEnergyService::ServiceState newState);
    void serviceCharacteristicWritten(const QLowEnergyCharacteristic& characteristic, const QByteArray& data);
    void serviceError(QLowEnergyService::ServiceError err);
    //subscription stuff
    void updateSubscriptionValue(const QLowEnergyCharacteristic &c, const QByteArray &value);



private:
    int failureCount;
    bool sensorfound;
    bool connectedToStage;
    DeviceInfo m_currentDevice;
    QBluetoothDeviceDiscoveryAgent *m_deviceDiscoveryAgent;
    QLowEnergyController *m_control;
    QLowEnergyService *m_service;
    QList<QObject*> m_devices;

};



#endif // DEVICE_H


