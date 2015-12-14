import QtQuick 2.0
import QtQuick.Controls 1.4

Rectangle {

    Connections {
        target: BLE
        onMotorIgnore: {motorIgnore = true;}
        onXAxisMinReached: {motorIgnore = true; xSlider.value = xSlider.minimumValue; motorIgnore = false}
        onXAxisMaxReached: {motorIgnore = true; xSlider.value = xSlider.maximumValue; motorIgnore = false}
        onStageIsReset: {motorIgnore = false;}
    }

    id: xAxis
    property alias value: xSlider.value
    property alias minValue: xSlider.minimumValue
    property alias maxValue: xSlider.maximumValue
    property alias step:     xSlider.stepSize
    property bool motorIgnore: false
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
        minimumValue: 0
        maximumValue: 40
        value: 0

        onValueChanged: {
            if ( !xAxis.motorIgnore )
            {
                BLE.setX(value);
            }
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

    Text {
        id: text3
        x: 91
        y: 87
        text: xSlider.value
        font.pixelSize: 12
    }
}
