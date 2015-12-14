// Open the component in the design view
// Source code was automatically generated

import QtQuick 2.0
import QtQuick.Controls 1.4
import QtQuick.Dialogs 1.2
import QtKnobs 1.0
ApplicationWindow {
    id: applicationWindow1
    width: 457
    height: 493
    minimumWidth: 493
    maximumWidth: 493
    minimumHeight: 500
    maximumHeight: 500
    title: "Stage Control"

    Rectangle {
        signal resetSliders;
        Connections {
            target: BLE
            onMotorServiceIsReady: { busyIndication.running = false; root.state="CONNECTED" }
            onBusError: { root.state = "I2CERROR"; root.resetSliders(); }
            onStageIsReset: { root.state = "CONNECTED" }
        }

        onResetSliders: {
            xAxis.value = xAxis.minValue;
            yAxis.value = yAxis.minValue;
            zAxis.value = zAxis.minValue;
            roll.value = roll.minValue;
            pitch.value = pitch.minValue;
        }

        id: root
        height: 593
        anchors.right: parent.right
        anchors.rightMargin: 0
        anchors.left: parent.left
        anchors.leftMargin: 0
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 0
        anchors.top: parent.top


        state: "NOT_CONNECTED"
        states: [
            State {
                name: "NOT_CONNECTED"
                //PropertyChanges { target: connectButton; visible: true }
                PropertyChanges { target: resetButton; visible: false }
                PropertyChanges { target: xAxis; visible: false }
                PropertyChanges { target: yAxis; visible: false }
                PropertyChanges { target: zAxis; visible: false }
                PropertyChanges { target: roll;  visible: false }
                PropertyChanges { target: pitch; visible: false }
                PropertyChanges { target: yaw;   visible: false }
            },
            State {
                name: "CONNECTED"
                //PropertyChanges { target: connectButton; visible: false }
                PropertyChanges { target: resetButton; visible: true }
                PropertyChanges {
                    target: busyIndication;
                    running: false
                    text: "Moving..."
                }
                PropertyChanges { target: xAxis; visible: true }
                PropertyChanges { target: yAxis; visible: true }
                PropertyChanges { target: zAxis; visible: true  }
                PropertyChanges { target: roll;  visible: true  }
                PropertyChanges { target: pitch; visible: true  }
                PropertyChanges { target: yaw;   visible: true  }
                PropertyChanges { target: waitTimer; running: false }
            },
            State {
                name: "I2CERROR"
                //PropertyChanges { target: connectButton; visible: false }
                PropertyChanges {
                    target: busyIndication;
                    text: "I2C error encountered, attempting to recover..."
                    running: true
                }
                PropertyChanges { target: resetButton; enabled: false }
                PropertyChanges { target: waitTimer; running: true }
                PropertyChanges { target: resetButton; visible: false }
                PropertyChanges { target: xAxis; enabled: false; value: minValue }
                PropertyChanges { target: yAxis; enabled: false; value: minValue }
                PropertyChanges { target: zAxis; enabled: false; value: minValue }
                PropertyChanges { target: roll;  enabled: false; value: minValue }
                PropertyChanges { target: pitch; enabled: false; value: minValue }
                PropertyChanges { target: yaw;   enabled: false }
            },
            State {
                name: "NOT_RECOVERED_FROM_I2C_ERROR"
                PropertyChanges { target: busyIndication; running: false }
            }

        ]

        // Feedback from Sensor Tag's status characteristic
        /*

    */
        Component.onCompleted: {
            busyIndication.running = true
        }




        // This timer is activating when an I2C bus error is detected
        Timer {
            id: waitTimer
            interval: 20000
            running: false
            repeat: false

            onTriggered: {
                root.state = "NOT_RECOVERED_FROM_I2C_ERROR"
                errorMsg.open();
            }
        }

        // This the bus error Warning pop window
        MessageDialog {
            id: errorMsg
            visible: false
            icon: StandardIcon.Critical
            title: "Stage Error"
            text: "Power off the main board and try again"
            onAccepted: {
                applicationWindow1.destroy()
            }
            onRejected: {
                applicationWindow1.close()
            }
        }


//////////// RESET BUTTON /////////////////////////////////////////////////////////////////
        Image {
            id: resetButton
            anchors.centerIn: parent
            width: 116
            height: 74
            fillMode: Image.PreserveAspectFit
            anchors.verticalCenterOffset: -141
            anchors.horizontalCenterOffset: 166
            smooth: true
            source: "pics/reset.png"

            Label {
                id: resetLable
                x: 40
                y: 19
                width: 41
                height: 63
                text: "Reset"
                font.pointSize: 7
                font.bold: true
            }

            MouseArea{
                anchors.fill: parent
                onClicked: {
                    BLE.resetStage();
                    root.resetSliders();
                }
            }
        }
///////////////////////////////////////////////////////////////////////////////////////////



        // Busy Indicator
        BusyIndicator {
            id: busyIndication
            property alias text: busyText.text
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottomMargin: 0
            anchors.bottom: root.bottom
            clip: false
            running: false

            Text {
                visible: busyIndication.running
                id: busyText
                text: "Connecting to stage"
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenterOffset: 2
                font.pixelSize: 12
                anchors.verticalCenter: parent.verticalCenter
            }
        }




        // Translatory Motor Controls
        MotorX{ id: xAxis ; anchors.topMargin: 0; step: 1; minValue: 0; maxValue: 100 }
        MotorY{ id: yAxis ; anchors.right: yaw.left; anchors.rightMargin: -1; step: 1; minValue: 0; maxValue: 100 }
        MotorZ{ id: zAxis ; step: 1; minValue: 0; maxValue: 100 }


        // Rotational Axises
        MotorRoll{ id: roll ; step: 1; anchors.bottomMargin: 4 ; minValue: 0; maxValue: 100 }
        MotorPitch{ id: pitch ; step: 1; anchors.leftMargin: 8 ; minValue: 0; maxValue: 100 }
        Rectangle{
            id: yaw
            width: 200
            height: 200
            anchors.verticalCenter: root.verticalCenter
            anchors.horizontalCenter: root.horizontalCenter

            Knob {
                id: yawKnob
                property bool motorIgnore: false

                Connections {
                    target: BLE
                    onMotorIgnore: {motorIgnore = true}
                    onStageIsReset: {motorIgnore = false;}
                }


                style: Knob.Arc
                value: 0
                color: "#69BAFB"
                textColor: "#000000"
                maximumValue: 100

                onEndValueChanged: {
                    if (!yawKnob.motorIgnore)
                        BLE.setYaw(value)
                }
            }
        }




   } // Root rectangle ends here
} // Application Window ends here





































// GRAVEYARD OF PROPABLY USEFULL CODE
/*
Button {
    id: errorButton
    text: "I emit errors!"
    //This is for debug purposes only
    onClicked: {
       BLE.emitError();
    }
}
        // Connect Button
        Button {
            id: connectButton
            x: 162
            y: 0
            text: "Connect to Stage"
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter
            onClicked: {
                busyIndication.running = !busyIndication.running
                connectButton.visible = false
                BLE.deviceSearch();
            }
        }

 */





