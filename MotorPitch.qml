import QtQuick 2.0
import QtQuick.Controls 1.4

Rectangle {
    Connections {
        target: BLE
        onMotorIgnore: {motorIgnore = true;}
        onPitchMinReached: {motorIgnore = true; pitchSlider.value = pitchSlider.minimumValue; motorIgnore = false}
        onPitchMaxReached: {motorIgnore = true; pitchSlider.value = pitchSlider.maximumValue; motorIgnore = false}
        onStageIsReset: {motorIgnore = false;}
    }

    id: pitch
    property alias value: pitchSlider.value
    property alias minValue: pitchSlider.minimumValue
    property alias maxValue: pitchSlider.maximumValue
    property alias step:     pitchSlider.stepSize
    property bool motorIgnore: false

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
        onValueChanged: {
            if ( !pitch.motorIgnore )
            {
                BLE.setPitch(value);
            }
        }
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

    Text {
        id: text5
        x: 21
        y: 106
        text: pitchSlider.value
        font.pixelSize: 12
    }
}
