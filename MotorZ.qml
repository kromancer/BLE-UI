import QtQuick 2.5
import QtQuick.Controls 1.4


Rectangle{
    Connections {
        target: BLE
        onMotorIgnore: {motorIgnore = true;}
        onZAxisMinReached: {motorIgnore = true; zSlider.value = zSlider.minimumValue; motorIgnore = false}
        onZAxisMaxReached: {motorIgnore = true; zSlider.value = zSlider.maximumValue; motorIgnore = false}
        onStageIsReset: {motorIgnore = false;}
    }

    id: zAxis
    property alias value: zSlider.value
    property alias minValue: zSlider.minimumValue
    property alias maxValue: zSlider.maximumValue
    property alias step:     zSlider.stepSize
    property bool motorIgnore: false
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
        value: 0
        maximumValue: 40
        stepSize: 1
        updateValueWhileDragging: false

        orientation: Qt.Vertical

        onValueChanged: {
            textZ.text = value;
            if (!zAxis.motorIgnore)
                BLE.setZ(value);
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
        font.pointSize: 11
    }

    Rectangle {
        border.color: "black"
        border.width: 1
        height: textZ.height
        anchors.right: zSlider.right
        anchors.rightMargin: 0
        anchors.left: zSlider.left
        anchors.leftMargin: 0
        anchors.top: zSlider.bottom
        anchors.topMargin: 7



        TextInput {
            id: textZ
            validator: IntValidator{bottom: zSlider.minimumValue; top: zSlider.maximumValue}

            text: zSlider.value
            anchors.centerIn: parent
            horizontalAlignment: TextInput.AlignHCenter


            onAccepted: {
                zSlider.value = Number(text);
            }
        }
    }

}
