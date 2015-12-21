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
#include <QCoreApplication>
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
    Q_INVOKABLE void setRoll(char value);
    Q_INVOKABLE void setPitch(char value);
    Q_INVOKABLE void setYaw(char value);


    //Q_INVOKABLE void setYaw(char value);
    Q_INVOKABLE void resetStage();

    //Q_INVOKABLE void connectToMotorService();
    Q_INVOKABLE void connectToLEDService();
    Q_INVOKABLE void disconnectFromStage();
    Q_INVOKABLE void disconnectFromLED();

public slots:
     void deviceSearch();
     void connectToLEDSensorTag();
     void connectToMotorSensorTag();

signals:
     //Signals emitted when receiving status notifications
     //emitted              received
     void stageIsReset();   //1
     void stageIsBusy();    //2
     void stageIsIdle();    //3
     void busError();       //4


     void ledSensorTagNotFound();
     void ledSensorTagIsFound();
     void motorSensorTagNotFound();
     void motorSensorTagIsFound();

     void motorServiceIsFound();
     void motorServiceIsReady();


     void ledServiceIsFound();
     void ledServiceIsReady();
     void restoreLED(int i);

//Reset situations
     void motorIgnore();

     void xAxisMinReached();

     void xAxisMaxReached();

     void yAxisMinReached();

     void yAxisMaxReached();

     void zAxisMinReached();

     void zAxisMaxReached();

     void rollMinReached();

     void rollMaxReached();

     void pitchMinReached();

     void pitchMaxReached();



private slots:
    void releaseBLE();

    // Slots for capturing QBluetoothDeviceDiscoveryAgent's signals
    void addDevice(const QBluetoothDeviceInfo&);
    void scanFinished();

    // Slots for capturing QLowEnergyController's signals
    void m_deviceConnected();
    void m_serviceDiscovered(const QBluetoothUuid &gatt);
    void m_serviceScanDone();
    void m_controllerError(QLowEnergyController::Error);
    void m_deviceDisconnected();

    void l_deviceConnected();
    void l_serviceDiscovered(const QBluetoothUuid &gatt);
    void l_serviceScanDone();
    void l_controllerError(QLowEnergyController::Error);
    void l_deviceDisconnected();

    // Slots for capturing QLowEnergyServicel's signals
    void m_serviceStateChanged(QLowEnergyService::ServiceState newState);
    void m_serviceCharacteristicWritten(const QLowEnergyCharacteristic& characteristic, const QByteArray& data);
    void m_serviceError(QLowEnergyService::ServiceError err);
    void m_statusNotification(const QLowEnergyCharacteristic &c, const QByteArray &value);

    void l_serviceStateChanged(QLowEnergyService::ServiceState newState);
    void l_serviceCharacteristicWritten(const QLowEnergyCharacteristic& characteristic, const QByteArray& data);
    void l_serviceError(QLowEnergyService::ServiceError err);




private:
    bool motorsSensorTagFound, ledSensorTagFound;
    bool connectedToStage, connectedToLed;

    QBluetoothDeviceInfo motorsSensorTag, ledSensorTag;

    QBluetoothDeviceDiscoveryAgent *m_deviceDiscoveryAgent;
    QLowEnergyController *m_control, *l_control;
    QLowEnergyService *m_service, *l_service;
    QLowEnergyCharacteristic X_char;
    QLowEnergyCharacteristic Y_char;
    QLowEnergyCharacteristic Z_char;
    QLowEnergyCharacteristic Roll_char;
    QLowEnergyCharacteristic Pitch_char;
    QLowEnergyCharacteristic Yaw_char;
    QLowEnergyCharacteristic Status_char;
    QLowEnergyCharacteristic Reset_char;



    QLowEnergyDescriptor motorNotificationDesc;
};



#endif // BLUETOOTH_H


