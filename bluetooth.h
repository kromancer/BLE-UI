#ifndef BLUETOOTH_H
#define BLUETOOTH_H

#include <QString>
#include <QDebug>
#include <QDateTime>
#include <QVector>
#include <QTimer>
#include <QBluetoothDeviceDiscoveryAgent>
#include <QBluetoothDeviceInfo>
#include <QLowEnergyController>
#include <QLowEnergyService>
#include "stdint.h"

class Bluetooth: public QObject
{
    Q_OBJECT
public:
    Bluetooth();
    ~Bluetooth();

    //LED control methods
    Q_INVOKABLE void setLED(char value);

    //Stage control methods
    Q_INVOKABLE void setX(char value);
    Q_INVOKABLE void setY(char value);
    Q_INVOKABLE void setZ(char value);
    //Q_INVOKABLE void setYaw(char value);
    Q_INVOKABLE void resetStage();

public slots:
     void deviceSearch();
     void connectToService();

signals:
     void stageIsConnected();
     //Signals emitted when receiving status notifications
     //emitted              received
     void stageIsReset();   //1
     void stageIsBusy();    //2
     void stageIsIdle();    //3
     void busError();       //4


private slots:
    // Slots for capturing QBluetoothDeviceDiscoveryAgent's signals
    void addDevice(const QBluetoothDeviceInfo&);
    void scanFinished();
    // Slots for capturing QLowEnergyController's signals
    void deviceConnected();
    void serviceDiscovered(const QBluetoothUuid &gatt);
    void serviceScanDone();
    void controllerError(QLowEnergyController::Error);
    void deviceDisconnected();
    // Slots for capturing QLowEnergyServicel's signals
    void serviceStateChanged(QLowEnergyService::ServiceState newState);
    void serviceCharacteristicWritten(const QLowEnergyCharacteristic& characteristic, const QByteArray& data);
    void serviceError(QLowEnergyService::ServiceError err);
    void statusNotification(const QLowEnergyCharacteristic &c, const QByteArray &value);



private:
    bool motorsSensorTagFound;
    bool connectedToStage;
    QBluetoothDeviceInfo motorsSensorTag;
    QBluetoothDeviceDiscoveryAgent *m_deviceDiscoveryAgent;
    QLowEnergyController *m_control;
    QLowEnergyService *m_service;
    QLowEnergyCharacteristic X_char;
    QLowEnergyCharacteristic Y_char;
    QLowEnergyCharacteristic Z_char;
    QLowEnergyCharacteristic Roll_char;
    QLowEnergyCharacteristic Pitch_char;
    QLowEnergyCharacteristic Yaw_char;
    QLowEnergyCharacteristic Status_char;
    QLowEnergyCharacteristic Reset_char;
    QLowEnergyCharacteristic LED_char;
};



#endif // BLUETOOTH_H


