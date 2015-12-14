import QtQuick 2.0
import QtQuick.Controls 1.4

// Y axis
Rectangle {
    Connections {
        target: BLE
        onMotorIgnore: {motorIgnore = true;}
        onYAxisMinReached: {motorIgnore = true; ySlider.value = ySlider.minimumValue; motorIgnore = false}
        onYAxisMaxReached: {motorIgnore = true; ySlider.value = ySlider.maximumValue; motorIgnore = false}
    }


    id: yAxis
    property alias value: ySlider.value
    property alias minValue: ySlider.minimumValue
    property alias maxValue: ySlider.maximumValue
    property alias step:     ySlider.stepSize
    property bool motorIgnore: false
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
        value: 0
        maximumValue: 40
        stepSize: 1
        updateValueWhileDragging: false
        orientation: Qt.Vertical

        onValueChanged: {
            if ( !yAxis.motorIgnore )
            {
                BLE.setY(value);
            }
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

    Text {
        id: text2
        x: 20
        y: 198
        text: ySlider.value
        font.pixelSize: 12
    }
}
