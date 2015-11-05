//Import the built-in QML types
import QtQuick 2.1
import QtQuick.Controls 1.3




Rectangle {
    property alias label: label.text
    property alias labelSize: label.font.pixelSize
    property alias orientation: slider.orientation
    id: container
    border.width: 1

    Label {
        id: label
        font.family: "Ubuntu"
        anchors.top: parent.top
        anchors.horizontalCenter: parent.horizontalCenter
    }

    Slider {
        id: slider
        anchors.top: label.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom

        anchors.topMargin: 1
        anchors.bottomMargin: 1

        //The tick marks refuse to play nice
        //tickmarksEnabled: true

            //Control Guys mess this section
            value: 0
            maximumValue: 5
            minimumValue: -5
            stepSize: 1
            //Control Guys ideally stop here, or else they get their heads chopped off
    }

    Label {
        id: tickmarksLabel
        anchors.top: slider.bottom
        anchors.topMargin: 3
        text: slider.value
    }




}



