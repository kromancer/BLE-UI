import QtQuick 2.5
import QtQuick.Controls 1.4

Rectangle {
    Connections {
        target: BLE
        onMotorIgnore: {motorIgnore = true;}
        onRollMinReached: {motorIgnore = true; rollSlider.value = rollSlider.minimumValue; motorIgnore = false}
        onRollMaxReached: {motorIgnore = true; rollSlider.value = rollSlider.maximumValue; motorIgnore = false}
        onStageIsReset: {motorIgnore = false;}
    }

    id: roll
    property alias value: rollSlider.value
    property alias minValue: rollSlider.minimumValue
    property alias maxValue: rollSlider.maximumValue
    property alias step:     rollSlider.stepSize
    property bool motorIgnore: false
    property int initialValue

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
            textR.text = value;
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
        anchors.right: rollSlider.left
        anchors.rightMargin: 20
        anchors.verticalCenter: rollSlider.verticalCenter
        font.bold: true
        font.pointSize: 11

    }

    Rectangle {
        height: textR.height
        anchors.left: rollSlider.right
        anchors.leftMargin: 20
        anchors.verticalCenter: rollSlider.verticalCenter
        width: textR.width
        border.color: "black"
        border.width: 1




        TextInput {
            id: textR
            width: 50
            validator: IntValidator{bottom: rollSlider.minimumValue; top: rollSlider.maximumValue}

            text: rollSlider.value
            anchors.centerIn: parent
            horizontalAlignment: TextInput.AlignHCenter


            onAccepted: {
                rollSlider.value = Number(text);
            }
        }
    }
}

