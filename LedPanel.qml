// Open the component in the design view
// Source code was automatically generated

import QtQuick 2.0
import QtQuick.Controls 1.4


ApplicationWindow {
    id: applicationWindow2
    width: 457
    height: 408
    title: "LED Control"

    Rectangle {
        id: root2
        anchors.right: parent.right
        anchors.rightMargin: 0
        anchors.left: parent.left
        anchors.leftMargin: 0
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 0
        anchors.top: parent.top


        state: "NOT_CONNECTED"
        states: [
            State {
                name: "CONNECTED"
                PropertyChanges { target: connectButton; visible: true }
                PropertyChanges { target: scalar; visible: false }
            },
            State {
                name: "NOT_CONNECTED"
                PropertyChanges { target: connectButton; visible: false }
                PropertyChanges { target: scalar; visible: true }
            }
        ]


        Connections {
            target: BLE
            onStageIsConnected: {busyIndication.running = false; root2.state="CONNECTED"}
            //onBusWriteError: { VAQ.incrementFailureCount(); }
            //onBusHasFailed: {busErrorButton.visible = true}

        }

        // Connect Button
        Button {
            id: connectButton
            x: 162
            y: 0
            text: "Connect to Stage"
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter
            onClicked: {
                busyIndication.running = !busyIndication.running
                connectButton.visible = false
                VAQ.deviceSearch();
            }


        }


        BusyIndicator {
            Text {
                visible: busyIndication.running
                id: busyText
                text: "Connecting to stage"
                font.pixelSize: 12
                anchors.centerIn: parent
            }
            running: false
            id: busyIndication
            y: -92
            anchors.centerIn: parent
            clip: false

        }

        // Translatory Sliders

        Rectangle {
            id: scalar
            x: 117
            width: 192
            height: 50
            anchors.horizontalCenter: parent.horizontalCenter
            //anchors.top: yaw.bottom
            anchors.topMargin: 67

            Slider {
                id: ledscalarslider
                anchors.fill: parent
                x: 130
                updateValueWhileDragging: false
                stepSize: 1
                tickmarksEnabled: false
                minimumValue: 0
                maximumValue: 40
                value: 0

                onValueChanged: {
                    VAQ.setLed()
                }
            }
            Label {
                id: ledscalarlabel
                //x: 214
                text: qsTr("Scalar")
                anchors.left: ledscalarslider.right
                anchors.leftMargin: 6
                anchors.horizontalCenter: ledscalarslider.horizontalCenter
                font.bold: true
                font.pointSize: 10
            }

            Text {
                id: text3
               // x: 91
              //  y: 87
                text: ledscalarslider.value
                font.pixelSize: 12
            }
        }
    }
}

/*
Button {
    id: busErrorButton
    anchors.left: errorButton.right
    visible: false
    text: "Three errors received!"
    onClicked: {
        VAQ.resetFailureCount();
        busErrorButton.visible = false;
    }

}


Button {
    id: errorButton
    text: "I emit errors!"
    //This is for debug purposes only
    onClicked: {
        VAQ.emitError();
    }
}
*/








