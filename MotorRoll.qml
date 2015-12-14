import QtQuick 2.0
import QtQuick.Controls 1.4

Rectangle {
    Connections {
        target: BLE
        onMotorIgnore: {motorIgnore = true;}
        onRollMinReached: {motorIgnore = true; rollSlider.value = rollSlider.minimumValue; motorIgnore = false}
        onRollMaxReached: {motorIgnore = true; rollSlider.value = rollSlider.maximumValue; motorIgnore = false}
    }

    id: roll
    property alias value: rollSlider.value
    property alias minValue: rollSlider.minimumValue
    property alias maxValue: rollSlider.maximumValue
    property alias step:     rollSlider.stepSize
    property bool motorIgnore: false

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
        onValueChanged: {
            if ( !roll.motorIgnore )
            {
                BLE.setRoll(value);
            }
        }
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

    Text {
        id: text4
        x: 106
        y: 18
        text: rollSlider.value
        font.pixelSize: 12
    }
}

