import QtQuick 2.5
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
    //x: 117
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
            textX.text = value;
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
        anchors.right: xSlider.left
        anchors.rightMargin: 20
        anchors.verticalCenter: xSlider.verticalCenter
        font.bold: true
        font.pointSize: 11
    }

    Rectangle {
        height: textX.height
        anchors.left: xSlider.right
        anchors.leftMargin: 20
        anchors.verticalCenter: xSlider.verticalCenter
        width: textX.width
        border.color: "black"
        border.width: 1



        TextInput {
            id: textX
            width: 50
            validator: IntValidator{bottom: xSlider.minimumValue; top: xSlider.maximumValue}

            text: xSlider.value
            anchors.verticalCenterOffset: 0
            anchors.horizontalCenterOffset: 0
            anchors.centerIn: parent
            horizontalAlignment: TextInput.AlignHCenter


            onAccepted: {
                xSlider.value = Number(text);
            }
        }
    }
}
