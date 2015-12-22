import QtQuick 2.5
import QtQuick.Controls 1.4

// Y axis
Rectangle {
    Connections {
        target: BLE
        onMotorIgnore: {motorIgnore = true;}
        onYAxisMinReached: {motorIgnore = true; ySlider.value = ySlider.minimumValue; motorIgnore = false}
        onYAxisMaxReached: {motorIgnore = true; ySlider.value = ySlider.maximumValue; motorIgnore = false}
        onStageIsReset: {motorIgnore = false;}
    }


    id: yAxis
    property alias value: ySlider.value
    property alias minValue: ySlider.minimumValue
    property alias maxValue: ySlider.maximumValue
    property alias step:     ySlider.stepSize
    property bool motorIgnore: false
    //x: 80
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
            textY.text = value;
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
        font.pointSize: 11
    }

    Rectangle {
        border.color: "black"
        border.width: 1
        height: textY.height
        anchors.right: ySlider.right
        anchors.rightMargin: 0
        anchors.left: ySlider.left
        anchors.leftMargin: 0
        anchors.top: ySlider.bottom
        anchors.topMargin: 7



        TextInput {
            id: textY
            validator: IntValidator{bottom: ySlider.minimumValue; top: ySlider.maximumValue}

            text: ySlider.value
            anchors.centerIn: parent
            horizontalAlignment: TextInput.AlignHCenter


            onAccepted: {
                ySlider.value = Number(text);
            }
        }
    }
}
