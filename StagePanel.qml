// Open the component in the design view
// Source code was automatically generated

import QtQuick 2.0
import QtQuick.Controls 1.4


ApplicationWindow {
    width: 457
    height: 408
    title: "Stage Control"
    Rectangle {
        id: root
        anchors.rightMargin: 0
        anchors.bottomMargin: 0
        anchors.leftMargin: 0
        anchors.topMargin: 0
        anchors.fill: parent


        // Connect Button
        Button {
            x: 162
            text: "Connect to Stage"
            anchors.horizontalCenter: yawKnob.horizontalCenter
            anchors.top: parent.top
            anchors.topMargin: 0
                onClicked: {
                    VAQ.deviceSearch();
                }
        }

        // Translatory Sliders
        Slider {
            id: xAxis
            x: 130
            updateValueWhileDragging: false
            stepSize: 1
            tickmarksEnabled: false
            minimumValue: -10
            maximumValue: 10
            value: 0
            anchors.top: yawKnob.bottom
            anchors.topMargin: 63
            anchors.horizontalCenter: yawKnob.horizontalCenter

            onValueChanged: {
                VAQ.setX(value)
            }
        }

        Slider {
            id: yAxis
            x: 27
            y: 98
            updateValueWhileDragging: false
            anchors.right: yawKnob.left
            anchors.rightMargin: 63
            anchors.verticalCenter: yawKnob.verticalCenter
            orientation: Qt.Vertical

            onValueChanged: {
                VAQ.setY(value)
            }
        }

        Slider {
            id: zAxis
            x: 390
            y: 98
            updateValueWhileDragging: false
            anchors.right: yAxis.left
            anchors.rightMargin: 18
            anchors.verticalCenter: yawKnob.verticalCenter
            orientation: Qt.Vertical

            onValueChanged: {
                VAQ.setZ(value)
            }
        }

        Slider {
            id: roll
            x: 130
            y: 99
            width: 110
            updateValueWhileDragging: false
            anchors.horizontalCenter: yawKnob.horizontalCenter
            anchors.bottom: yawKnob.top
            anchors.bottomMargin: 63
        }

        YawKnob {
            id: yawKnob
            x: 172
            y: 158
            width: 100
            height: 100
            anchors.verticalCenterOffset: 28
            anchors.horizontalCenterOffset: 5
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
        }

        Slider {
            id: pitch
            y: 147
            height: 110
            updateValueWhileDragging: false
            anchors.left: yawKnob.right
            anchors.leftMargin: 63
            anchors.verticalCenter: yawKnob.verticalCenter
            orientation: Qt.Vertical
        }

        Label {
            id: rollLabel
            x: 213
            y: 149
            text: qsTr("Roll")
            anchors.horizontalCenter: roll.horizontalCenter
            anchors.bottom: roll.top
            anchors.bottomMargin: 6
            font.bold: true
            font.pointSize: 11
        }

        Label {
            id: xLabel
            x: 214
            text: qsTr("X")
            anchors.top: xAxis.bottom
            anchors.topMargin: 6
            anchors.horizontalCenter: xAxis.horizontalCenter
            font.bold: true
            font.pointSize: 16
        }

        Label {
            id: pitchLabel
            y: 307
            text: qsTr("Pitch")
            anchors.left: pitch.right
            anchors.leftMargin: 6
            anchors.verticalCenter: pitch.verticalCenter
            font.bold: true
            font.pointSize: 11
        }

        Label {
            id: yLabel
            x: 0
            y: 455
            text: qsTr("Y")
            anchors.bottom: yAxis.top
            anchors.bottomMargin: 6
            anchors.horizontalCenter: yAxis.horizontalCenter
            font.bold: true
            font.pointSize: 16
        }

        Label {
            id: zLabel
            x: 33
            y: 180
            text: qsTr("Z")
            anchors.horizontalCenter: zAxis.horizontalCenter
            anchors.bottom: zAxis.top
            anchors.bottomMargin: 6
            font.bold: true
            font.pointSize: 16
        }
    }
}









