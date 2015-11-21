// Open the component in the design view
// Source code was automatically generated

import QtQuick 2.0
import QtQuick.Controls 1.4


ApplicationWindow {
    id: applicationWindow1
    width: 457
    height: 408
    title: "Stage Control"

    Rectangle {
        id: root
        anchors.right: parent.right
        anchors.rightMargin: 0
        anchors.left: parent.left
        anchors.leftMargin: 0
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 0
        anchors.top: parent.top


        state: "CONNECTED"
        states: [
            State {
                name: "NOT_CONNECTED"
                PropertyChanges { target: connectButton; visible: true }
                PropertyChanges { target: xAxis; visible: false }
                PropertyChanges { target: yAxis; visible: false }
                PropertyChanges { target: zAxis; visible: false }
                PropertyChanges { target: roll;  visible: false }
                PropertyChanges { target: pitch; visible: false }
                PropertyChanges { target: yaw;   visible: false }
            },
            State {
                name: "CONNECTED"
                PropertyChanges { target: connectButton; visible: false }
                PropertyChanges { target: xAxis; visible: true }
                PropertyChanges { target: yAxis; visible: true }
                PropertyChanges { target: zAxis; visible: true  }
                PropertyChanges { target: roll;  visible: true  }
                PropertyChanges { target: pitch; visible: true  }
                PropertyChanges { target: yaw;   visible: true  }
            }
        ]


        Connections {
            target: VAQ
            onStageIsConnected: {console.log("shit")}
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
                    VAQ.deviceSearch();
                }
        }

        // Translatory Sliders
        Rectangle {
            id: xAxis
            x: 117
            width: 192
            height: 50
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: yaw.bottom
            anchors.topMargin: 67

            Slider {
                id: xSlider
                anchors.fill: parent
                x: 130
                updateValueWhileDragging: false
                stepSize: 1
                tickmarksEnabled: false
                minimumValue: -10
                maximumValue: 10
                value: 0

                onValueChanged: {
                    VAQ.setX(value)
                }
            }
            Label {
                id: xLabel
                x: 214
                text: qsTr("X")
                anchors.top: xSlider.bottom
                anchors.topMargin: 6
                anchors.horizontalCenter: xSlider.horizontalCenter
                font.bold: true
                font.pointSize: 16
            }
        }

        Rectangle {
            id: yAxis
            x: 80
            width: 50
            height: 192
            anchors.verticalCenterOffset: 0
            anchors.verticalCenter: parent.verticalCenter

            Slider {
                id: ySlider
                anchors.fill: parent
                x: 27
                y: 98
                updateValueWhileDragging: false
                orientation: Qt.Vertical

                onValueChanged: {
                    VAQ.setY(value)
                }
            }
            Label {
                id: yLabel
                x: 0
                y: 455
                text: qsTr("Y")
                anchors.bottom: ySlider.top
                anchors.bottomMargin: 0
                anchors.horizontalCenter: ySlider.horizontalCenter
                font.bold: true
                font.pointSize: 16
            }
        }


        Rectangle{
            id: zAxis
            width: 50
            height: 192
            anchors.right: yAxis.left
            anchors.rightMargin: 15
            anchors.verticalCenter: parent.verticalCenter

            Slider {
                id: zSlider
                anchors.fill: parent
                x: 390
                y: 98
                updateValueWhileDragging: false

                orientation: Qt.Vertical

                onValueChanged: {
                    VAQ.setZ(value)
                }
            }
            Label {
                id: zLabel
                x: 33
                y: 180
                text: qsTr("Z")
                anchors.horizontalCenter: zSlider.horizontalCenter
                anchors.bottom: zSlider.top
                anchors.bottomMargin: 0
                font.bold: true
                font.pointSize: 16
            }
        }


        Rectangle {
            id: roll
            width: 100
            height: 50
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottom: yaw.top
            anchors.bottomMargin: 70
            Slider {
                id: rollSlider
                anchors.fill: parent
                x: 130
                y: 99
                width: 110
                updateValueWhileDragging: false
            }
            Label {
                id: rollLabel
                x: 213
                y: 149
                text: qsTr("Roll")
                anchors.horizontalCenter: rollSlider.horizontalCenter
                anchors.bottom: rollSlider.top
                anchors.bottomMargin: 6
                font.bold: true
                font.pointSize: 11
            }
        }

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
        }


        Rectangle {
            id: pitch
            width: 50
            height: 100
            anchors.left: yaw.right
            anchors.leftMargin: 71
            anchors.verticalCenter: parent.verticalCenter
            Slider {
                id: pitchSlider
                anchors.fill: parent
                y: 147
                height: 110
                updateValueWhileDragging: false
                orientation: Qt.Vertical
            }
            Label {
                id: pitchLabel
                y: 307
                text: qsTr("Pitch")
                anchors.left: pitchSlider.right
                anchors.leftMargin: 6
                anchors.verticalCenter: pitchSlider.verticalCenter
                font.bold: true
                font.pointSize: 11
            }
        }
    }
}









