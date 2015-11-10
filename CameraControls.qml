import QtQuick 2.1
import QtQuick.Controls 1.2

Rectangle {
    property int labelSize
    id: container
    border.width: 1
    color: "brown"
    Slider {
        id: sliderLED
        orientation: Qt.Vertical
        height: parent.height / 2
        anchors.left: parent.left
        anchors. verticalCenter: parent.verticalCenter

            //Control Guys mess this section
            value: 0
            minimumValue: -11
            maximumValue: 24
            stepSize: 1
            //Control Guys ideally stop here, or else they get their heads chopped off

         onValueChanged: cam_settings.setGain(value);
    }

    Label {
        anchors.top: sliderLED.bottom
        anchors.horizontalCenter: sliderLED.horizontalCenter
        font.family: "Ubuntu"
        font.pixelSize: labelSize
        text: "Light"
    }

    Button {
        text: "Demo"
        anchors.top: sliderLED.top
        anchors.left: sliderLED.right
        onClicked: {

        }
    }

}


