import QtQuick 2.0
import QtQuick.Controls 1.4

Rectangle {
    anchors.fill: parent

    Slider {
        orientation: Qt.Vertical
        tickmarksEnabled: true


            //Control Guys mess this section
            value: 0
            minimumValue: 0
            maximumValue: 10
            stepSize: 1
            //Control Guys ideally stop here, or else they get their heads chopped off
    }

}


