import QtQuick 2.0
import QtQuick.Controls 1.4

Rectangle {
    id: roll
    property alias value: rollSlider.value
    property alias minValue: rollSlider.minimumValue
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
    }
    Label {
        id: rollLabel
        x: 213
        y: 149
        text: qsTr("Roll")
        anchors.horizontalCenter: rollSlider.horizontalCenter
        anchors.bottom: rollSlider.top
        anchors.bottomMargin: 6
        font.bold: true
        font.pointSize: 11
    }

    Text {
        id: text4
        x: 106
        y: 18
        text: rollSlider.value
        font.pixelSize: 12
    }
}

