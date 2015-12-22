import QtQuick 2.5
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
    property int initialValue

    width: 50
    height: 192
    anchors.left: yaw.right
    anchors.leftMargin: 71
    anchors.verticalCenter: parent.verticalCenter

    Slider {
        id: pitchSlider
        anchors.fill: parent
        y: 147
        height: 192
        updateValueWhileDragging: false
        orientation: Qt.Vertical
        onValueChanged: {
            textP.text = value;
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
        anchors.horizontalCenter: pitchSlider.horizontalCenter
        anchors.bottom: pitchSlider.top
        anchors.bottomMargin: 0
        font.bold: true
        font.pointSize: 11
    }

    Rectangle {
        border.color: "black"
        border.width: 1
        height: textP.height
        anchors.right: pitch.right
        anchors.rightMargin: 0
        anchors.left: pitch.left
        anchors.leftMargin: 0
        anchors.top: pitch.bottom
        anchors.topMargin: 7



        TextInput {
            id: textP
            validator: IntValidator{bottom: pitchSlider.minimumValue; top: pitchSlider.maximumValue}

            text: pitchSlider.value
            anchors.centerIn: parent
            horizontalAlignment: TextInput.AlignHCenter


            onAccepted: {
                pitchSlider.value = Number(text);
            }
        }
    }
}
