// Open the component in the design view
// Source code was automatically generated

import QtQuick 2.0
import QtQuick.Controls 1.4
import QtQuick.Dialogs 1.2

ApplicationWindow {
    id: applicationWindow1
    width: 457
    height: 493
    minimumHeight: 500
    maximumHeight: 500
    title: "Stage Control"

    Rectangle {
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
        Connections {
            target: BLE
            onStageIsConnected: { busyIndication.running = false; root.state="CONNECTED" }
            onBusError: { root.state = "I2CERROR"}
            onStageIsReset: { root.state = "CONNECTED" }
        }

        Component.onCompleted: {
            busyIndication.running = true
            BLE.deviceSearch();
        }




        // This timer is activating when an I2C bus error is detected
        Timer {
            id: waitTimer
            interval: 10000
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
                applicationWindow1.close()
            }
            onRejected: {
                applicationWindow1.close()
            }
        }



        Button {
            id: resetButton
            visible: false
            text: "Reset"
            onClicked: {
                //Reset sliders and stage
                root.resetSliders();
                BLE.resetStage();
            }

        }

        function resetSliders() {
            xAxis.motorIgnore = true;
            xAxis.value = xAxis.minValue;
            xAxis.motorIgnore = false;

            yAxis.motorIgnore = true;
            yAxis.value = yAxis.minValue;
            yAxis.motorIgnore = false;

            zAxis.motorIgnore = true;
            zAxis.value = yAxis.minValue;
            zAxis.motorIgnore = false;

            //yawKnob.currentValue = 0;
            //roll.value = roll.minValue;
            //pitch.value = pitch.value;
        }


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
        MotorX{ id: xAxis }
        MotorY{ id: yAxis }
        MotorZ{ id: zAxis }


        // Rotational Axises
        MotorRoll{ id: roll }
        MotorPitch{ id: pitch }
        Rectangle {
            id: yaw
            width: 50
            height: 50
            anchors.verticalCenterOffset: 0
            anchors.horizontalCenterOffset: 0
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            YawKnob {
                id: yawKnob
                anchors.fill: parent

            }

            Text {
                id: text6
                x: 21
                y: 106
                text: yawKnob.currentValue
                font.pixelSize: 12
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





