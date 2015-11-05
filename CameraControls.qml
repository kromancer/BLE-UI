import QtQuick 2.0
import QtQuick.Controls 1.3
import QtQuick 2.1
import QtQuick.Controls 1.2

Rectangle {
    property int labelSize
    id: container
    border.width: 1
    //color: "brown"
    Slider {
        id: sliderLED
        orientation: Qt.Vertical
        height: parent.height / 2
        anchors.left: parent.left
        anchors.verticalCenter: parent.verticalCenter
        anchors.centerIn: parent

            //Control Guys mess this section
            value: 0
            minimumValue: 0
            maximumValue: 10
            stepSize: 1
            //Control Guys ideally stop here, or else they get their heads chopped off
    }

    Label {
        width: 28
        height: 15
        anchors.top: sliderLED.bottom
        anchors.horizontalCenter: sliderLED.horizontalCenter
        font.family: "Ubuntu"
        font.pixelSize: labelSize
        text: "Light"
        anchors.horizontalCenterOffset: -8
        anchors.topMargin: 8
    }

}


