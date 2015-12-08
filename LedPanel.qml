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
                PropertyChanges { target: ledmaster; visible: false }
            },
            State {
                name: "NOT_CONNECTED"
                PropertyChanges { target: connectButton; visible: false }
                PropertyChanges { target: ledmaster; visible: true }
            }
        ]


        Connections {
            target: BLE
            onStageIsConnected: {busyIndication.running = false; root2.state="CONNECTED"}
            //onBusWriteError: { BLE.incrementFailureCount(); }
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
                BLE.deviceSearch();
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

        // LED scalar slider

        Rectangle {
            id: ledmaster
            x: 117
            width: 192
            height: 50
            anchors.horizontalCenter: parent.horizontalCenter
            //anchors.top: yaw.bottom
            anchors.topMargin: 67

            Slider {
                id: ledmasterslider
                anchors.fill: parent
                x: 130
                updateValueWhileDragging: false
                stepSize: 1
                tickmarksEnabled: false
                minimumValue: 0
                maximumValue: 40
                value: 0

                onValueChanged: {
                    BLE.setLed()
                }
            }
            Label {
                id: ledmasterlabel
                text: qsTr("Master")
                anchors.left: ledmasterslider.right
                anchors.leftMargin: 6
                anchors.horizontalCenter: ledmasterslider.horizontalCenter
                font.bold: true
                font.pointSize: 10
            }

            Text {
                id: text3
                text: ledmasterslider.value
                font.pixelSize: 12
            }
        }



        /* LED SLIDERS
         *  -The most beautiful qml code ever written
         */
        Rectangle{
            id:ledrect1
            anchors.top: ledmaster.bottom

            //LED 1
            Rectangle {
                id: led1
                width: 192
                height: 50
                anchors.top: ledmaster.bottom
                Slider {
                    id: led1slider
                    anchors.fill: parent
                    x: 130
                    updateValueWhileDragging: false
                    stepSize: 1
                    tickmarksEnabled: false
                    minimumValue: 0
                    maximumValue: 40
                    value: 0
                    onValueChanged: {
                        BLE.setLed(1)
                    }
                }
                Label {
                    id: led1label
                    text: qsTr("LED1")
                    anchors.leftMargin: 6
                    anchors.horizontalCenter: led1slider.horizontalCenter
                    font.bold: true
                    font.pointSize: 10
                }
                Text {
                    id: led1text
                    text: led1slider.value
                    font.pixelSize: 12
                }
            }

            //LED 2
            Rectangle {
                id: led2
                width: 192
                height: 50
                anchors.top: led1.bottom
                Slider {
                    id: led2slider
                    anchors.fill: parent
                    x: 130
                    updateValueWhileDragging: false
                    stepSize: 1
                    tickmarksEnabled: false
                    minimumValue: 0
                    maximumValue: 40
                    value: 0
                    onValueChanged: {
                        BLE.setLed(2)
                    }
                }
                Label {
                    id: led2label
                    text: qsTr("LED2")
                    anchors.leftMargin: 6
                    anchors.horizontalCenter: led2slider.horizontalCenter
                    font.bold: true
                    font.pointSize: 10
                }
                Text {
                    id: led2text
                    text: led2slider.value
                    font.pixelSize: 12
                }
            }

            //LED 3
            Rectangle {
                id: led3
                width: 192
                height: 50
                anchors.top: led2.bottom
                Slider {
                    id: led3slider
                    anchors.fill: parent
                    x: 130
                    updateValueWhileDragging: false
                    stepSize: 1
                    tickmarksEnabled: false
                    minimumValue: 0
                    maximumValue: 40
                    value: 0
                    onValueChanged: {
                        BLE.setLed(3)
                    }
                }
                Label {
                    id: led3label
                    text: qsTr("LED3")
                    anchors.leftMargin: 6
                    anchors.horizontalCenter: led3slider.horizontalCenter
                    font.bold: true
                    font.pointSize: 10
                }
                Text {
                    id: led3text
                    text: led3slider.value
                    font.pixelSize: 12
                }
            }

            //LED 4
            Rectangle {
                id: led4
                width: 192
                height: 50
                anchors.top: led3.bottom
                Slider {
                    id: led4slider
                    anchors.fill: parent
                    x: 130
                    updateValueWhileDragging: false
                    stepSize: 1
                    tickmarksEnabled: false
                    minimumValue: 0
                    maximumValue: 40
                    value: 0
                    onValueChanged: {
                        BLE.setLed(4)
                    }
                }
                Label {
                    id: led4label
                    text: qsTr("LED4")
                    anchors.leftMargin: 6
                    anchors.horizontalCenter: led4slider.horizontalCenter
                    font.bold: true
                    font.pointSize: 10
                }
                Text {
                    id: led4text
                    text: led4slider.value
                    font.pixelSize: 12
                }
            }

            //LED 5
            Rectangle {
                id: led5
                width: 192
                height: 50
                anchors.top: led4.bottom
                Slider {
                    id: led5slider
                    anchors.fill: parent
                    x: 130
                    updateValueWhileDragging: false
                    stepSize: 1
                    tickmarksEnabled: false
                    minimumValue: 0
                    maximumValue: 40
                    value: 0
                    onValueChanged: {
                        BLE.setLed(5)
                    }
                }
                Label {
                    id: led5label
                    text: qsTr("LED2")
                    anchors.leftMargin: 6
                    anchors.horizontalCenter: led5slider.horizontalCenter
                    font.bold: true
                    font.pointSize: 10
                }
                Text {
                    id: led5text
                    text: led5slider.value
                    font.pixelSize: 12
                }
            }

            //LED 6
            Rectangle {
                id: led6
                width: 192
                height: 50
                anchors.top: led5.bottom
                Slider {
                    id: led6slider
                    anchors.fill: parent
                    x: 130
                    updateValueWhileDragging: false
                    stepSize: 1
                    tickmarksEnabled: false
                    minimumValue: 0
                    maximumValue: 40
                    value: 0
                    onValueChanged: {
                        BLE.setLed(6)
                    }
                }
                Label {
                    id: led6label
                    text: qsTr("LED6")
                    anchors.leftMargin: 6
                    anchors.horizontalCenter: led6slider.horizontalCenter
                    font.bold: true
                    font.pointSize: 10
                }
                Text {
                    id: led6text
                    text: led6slider.value
                    font.pixelSize: 12
                }
            }

            //LED 7
            Rectangle {
                id: led7
                width: 192
                height: 50
                anchors.top: led6.bottom
                Slider {
                    id: led7slider
                    anchors.fill: parent
                    x: 130
                    updateValueWhileDragging: false
                    stepSize: 1
                    tickmarksEnabled: false
                    minimumValue: 0
                    maximumValue: 40
                    value: 0
                    onValueChanged: {
                        Q.setLed(7)
                    }
                }
                Label {
                    id: led7label
                    text: qsTr("LED7")
                    anchors.leftMargin: 6
                    anchors.horizontalCenter: led7slider.horizontalCenter
                    font.bold: true
                    font.pointSize: 10
                }
                Text {
                    id: led7text
                    text: led7slider.value
                    font.pixelSize: 12
                }
            }

            //LED 8
            Rectangle {
                id: led8
                width: 192
                height: 50
                anchors.top: led7.bottom
                Slider {
                    id: led8slider
                    anchors.fill: parent
                    x: 130
                    updateValueWhileDragging: false
                    stepSize: 1
                    tickmarksEnabled: false
                    minimumValue: 0
                    maximumValue: 40
                    value: 0
                    onValueChanged: {
                        BLE.setLed(8)
                    }
                }
                Label {
                    id: led8label
                    text: qsTr("LED8")
                    anchors.leftMargin: 6
                    anchors.horizontalCenter: led8slider.horizontalCenter
                    font.bold: true
                    font.pointSize: 10
                }
                Text {
                    id: led8text
                    text: led8slider.value
                    font.pixelSize: 12
                }
            }

            //LED 9
            Rectangle {
                id: led9
                width: 192
                height: 50
                anchors.top: led8.bottom
                Slider {
                    id: led9slider
                    anchors.fill: parent
                    x: 130
                    updateValueWhileDragging: false
                    stepSize: 1
                    tickmarksEnabled: false
                    minimumValue: 0
                    maximumValue: 40
                    value: 0
                    onValueChanged: {
                        BLE.setLed(9)
                    }
                }
                Label {
                    id: led9label
                    text: qsTr("LED2")
                    anchors.leftMargin: 6
                    anchors.horizontalCenter: led9slider.horizontalCenter
                    font.bold: true
                    font.pointSize: 10
                }
                Text {
                    id: led9text
                    text: led9slider.value
                    font.pixelSize: 12
                }
            }

            //LED 10
            Rectangle {
                id: led10
                width: 192
                height: 50
                anchors.top: led9.bottom
                Slider {
                    id: led10slider
                    anchors.fill: parent
                    x: 130
                    updateValueWhileDragging: false
                    stepSize: 1
                    tickmarksEnabled: false
                    minimumValue: 0
                    maximumValue: 40
                    value: 0
                    onValueChanged: {
                        BLE.setLed(10)
                    }
                }
                Label {
                    id: led10label
                    text: qsTr("LED10")
                    anchors.leftMargin: 6
                    anchors.horizontalCenter: led10slider.horizontalCenter
                    font.bold: true
                    font.pointSize: 10
                }
                Text {
                    id: led10text
                    text: led10slider.value
                    font.pixelSize: 12
                }
            }

            //LED 11
            Rectangle {
                id: led11
                width: 192
                height: 50
                anchors.top: led10.bottom
                Slider {
                    id: led11slider
                    anchors.fill: parent
                    x: 130
                    updateValueWhileDragging: false
                    stepSize: 1
                    tickmarksEnabled: false
                    minimumValue: 0
                    maximumValue: 40
                    value: 0
                    onValueChanged: {
                        BLE.setLed(11)
                    }
                }
                Label {
                    id: led11label
                    text: qsTr("LED11")
                    anchors.leftMargin: 6
                    anchors.horizontalCenter: led11slider.horizontalCenter
                    font.bold: true
                    font.pointSize: 10
                }
                Text {
                    id: led11text
                    text: led11slider.value
                    font.pixelSize: 12
                }
            }

            //LED 12
            Rectangle {
                id: led12
                width: 192
                height: 50
                anchors.top: led11.bottom
                Slider {
                    id: led12slider
                    anchors.fill: parent
                    x: 130
                    updateValueWhileDragging: false
                    stepSize: 1
                    tickmarksEnabled: false
                    minimumValue: 0
                    maximumValue: 40
                    value: 0
                    onValueChanged: {
                        BLE.setLed(12)
                    }
                }
                Label {
                    id: led12label
                    text: qsTr("LED12")
                    anchors.leftMargin: 6
                    anchors.horizontalCenter: led12slider.horizontalCenter
                    font.bold: true
                    font.pointSize: 10
                }
                Text {
                    id: led12text
                    text: led12slider.value
                    font.pixelSize: 12
                }
            }
        }


        /*
        Rectangle{
            id:ledrect2
            anchors.top: ledmaster.bottom
            anchors.left: ledrect1.right

            //LED 1
            Rectangle {
                id: led13
                width: 192
                height: 50
                anchors.top: ledmaster.bottom
                Slider {
                    id: led13slider
                    anchors.fill: parent
                    x: 130
                    updateValueWhileDragging: false
                    stepSize: 1
                    tickmarksEnabled: false
                    minimumValue: 0
                    maximumValue: 40
                    value: 0
                    onValueChanged: {
                        BLE.setLed()
                    }
                }
                Label {
                    id: led13label
                    text: qsTr("LED13")
                    anchors.leftMargin: 6
                    anchors.horizontalCenter: led13slider.horizontalCenter
                    font.bold: true
                    font.pointSize: 10
                }
                Text {
                    id: led13text
                    text: led13slider.value
                    font.pixelSize: 12
                }
            }

            //LED 2
            Rectangle {
                id: led14
                width: 192
                height: 50
                anchors.top: led13.bottom
                Slider {
                    id: led14slider
                    anchors.fill: parent
                    x: 130
                    updateValueWhileDragging: false
                    stepSize: 1
                    tickmarksEnabled: false
                    minimumValue: 0
                    maximumValue: 40
                    value: 0
                    onValueChanged: {
                        BLE.setLed()
                    }
                }
                Label {
                    id: led14label
                    text: qsTr("LED14")
                    anchors.leftMargin: 6
                    anchors.horizontalCenter: led14slider.horizontalCenter
                    font.bold: true
                    font.pointSize: 10
                }
                Text {
                    id: led14text
                    text: led14slider.value
                    font.pixelSize: 12
                }
            }

            //LED 3
            Rectangle {
                id: led15
                width: 192
                height: 50
                anchors.top: led14.bottom
                Slider {
                    id: led15slider
                    anchors.fill: parent
                    x: 130
                    updateValueWhileDragging: false
                    stepSize: 1
                    tickmarksEnabled: false
                    minimumValue: 0
                    maximumValue: 40
                    value: 0
                    onValueChanged: {
                        BLE.setLed()
                    }
                }
                Label {
                    id: led15label
                    text: qsTr("LED15")
                    anchors.leftMargin: 6
                    anchors.horizontalCenter: led15slider.horizontalCenter
                    font.bold: true
                    font.pointSize: 10
                }
                Text {
                    id: led15text
                    text: led15slider.value
                    font.pixelSize: 12
                }
            }

            //LED 4
            Rectangle {
                id: led16
                width: 192
                height: 50
                anchors.top: led15.bottom
                Slider {
                    id: led16slider
                    anchors.fill: parent
                    x: 130
                    updateValueWhileDragging: false
                    stepSize: 1
                    tickmarksEnabled: false
                    minimumValue: 0
                    maximumValue: 40
                    value: 0
                    onValueChanged: {
                        BLE.setLed()
                    }
                }
                Label {
                    id: led16label
                    text: qsTr("LED17")
                    anchors.leftMargin: 6
                    anchors.horizontalCenter: led16slider.horizontalCenter
                    font.bold: true
                    font.pointSize: 10
                }
                Text {
                    id: led16text
                    text: led16slider.value
                    font.pixelSize: 12
                }
            }

            //LED 5
            Rectangle {
                id: led17
                width: 192
                height: 50
                anchors.top: led16.bottom
                Slider {
                    id: led17slider
                    anchors.fill: parent
                    x: 130
                    updateValueWhileDragging: false
                    stepSize: 1
                    tickmarksEnabled: false
                    minimumValue: 0
                    maximumValue: 40
                    value: 0
                    onValueChanged: {
                        BLE.setLed()
                    }
                }
                Label {
                    id: led17label
                    text: qsTr("LED17")
                    anchors.leftMargin: 6
                    anchors.horizontalCenter: led17slider.horizontalCenter
                    font.bold: true
                    font.pointSize: 10
                }
                Text {
                    id: led17text
                    text: led17slider.value
                    font.pixelSize: 12
                }
            }

            //LED 6
            Rectangle {
                id: led18
                width: 192
                height: 50
                anchors.top: led17.bottom
                Slider {
                    id: led18slider
                    anchors.fill: parent
                    x: 130
                    updateValueWhileDragging: false
                    stepSize: 1
                    tickmarksEnabled: false
                    minimumValue: 0
                    maximumValue: 40
                    value: 0
                    onValueChanged: {
                        BLE.setLed()
                    }
                }
                Label {
                    id: led18label
                    text: qsTr("LED18")
                    anchors.leftMargin: 6
                    anchors.horizontalCenter: led18slider.horizontalCenter
                    font.bold: true
                    font.pointSize: 10
                }
                Text {
                    id: led18text
                    text: led18slider.value
                    font.pixelSize: 12
                }
            }

            //LED 7
            Rectangle {
                id: led19
                width: 192
                height: 50
                anchors.top: led18.bottom
                Slider {
                    id: led19slider
                    anchors.fill: parent
                    x: 130
                    updateValueWhileDragging: false
                    stepSize: 1
                    tickmarksEnabled: false
                    minimumValue: 0
                    maximumValue: 40
                    value: 0
                    onValueChanged: {
                        BLE.setLed()
                    }
                }
                Label {
                    id: led19label
                    text: qsTr("LED19")
                    anchors.leftMargin: 6
                    anchors.horizontalCenter: led19slider.horizontalCenter
                    font.bold: true
                    font.pointSize: 10
                }
                Text {
                    id: led19text
                    text: led19slider.value
                    font.pixelSize: 12
                }
            }

            //LED 8
            Rectangle {
                id: led20
                width: 192
                height: 50
                anchors.top: led19.bottom
                Slider {
                    id: led20slider
                    anchors.fill: parent
                    x: 130
                    updateValueWhileDragging: false
                    stepSize: 1
                    tickmarksEnabled: false
                    minimumValue: 0
                    maximumValue: 40
                    value: 0
                    onValueChanged: {
                        BLE.setLed()
                    }
                }
                Label {
                    id: led20label
                    text: qsTr("LED20")
                    anchors.leftMargin: 6
                    anchors.horizontalCenter: led20slider.horizontalCenter
                    font.bold: true
                    font.pointSize: 10
                }
                Text {
                    id: led20text
                    text: led20slider.value
                    font.pixelSize: 12
                }
            }

            //LED 9
            Rectangle {
                id: led21
                width: 192
                height: 50
                anchors.top: led20.bottom
                Slider {
                    id: led21slider
                    anchors.fill: parent
                    x: 130
                    updateValueWhileDragging: false
                    stepSize: 1
                    tickmarksEnabled: false
                    minimumValue: 0
                    maximumValue: 40
                    value: 0
                    onValueChanged: {
                        BLE.setLed()
                    }
                }
                Label {
                    id: led21label
                    text: qsTr("LED21")
                    anchors.leftMargin: 6
                    anchors.horizontalCenter: led21slider.horizontalCenter
                    font.bold: true
                    font.pointSize: 10
                }
                Text {
                    id: led21text
                    text: led21slider.value
                    font.pixelSize: 12
                }
            }

            //LED 10
            Rectangle {
                id: led22
                width: 192
                height: 50
                anchors.top: led21.bottom
                Slider {
                    id: led22slider
                    anchors.fill: parent
                    x: 130
                    updateValueWhileDragging: false
                    stepSize: 1
                    tickmarksEnabled: false
                    minimumValue: 0
                    maximumValue: 40
                    value: 0
                    onValueChanged: {
                        BLE.setLed()
                    }
                }
                Label {
                    id: led22label
                    text: qsTr("LED22")
                    anchors.leftMargin: 6
                    anchors.horizontalCenter: led22slider.horizontalCenter
                    font.bold: true
                    font.pointSize: 10
                }
                Text {
                    id: led22text
                    text: led22slider.value
                    font.pixelSize: 12
                }
            }

            //LED 11
            Rectangle {
                id: led23
                width: 192
                height: 50
                anchors.top: led22.bottom
                Slider {
                    id: led23slider
                    anchors.fill: parent
                    x: 130
                    updateValueWhileDragging: false
                    stepSize: 1
                    tickmarksEnabled: false
                    minimumValue: 0
                    maximumValue: 40
                    value: 0
                    onValueChanged: {
                        BLE.setLed()
                    }
                }
                Label {
                    id: led23label
                    text: qsTr("LED23")
                    anchors.leftMargin: 6
                    anchors.horizontalCenter: led23slider.horizontalCenter
                    font.bold: true
                    font.pointSize: 10
                }
                Text {
                    id: led23text
                    text: led23slider.value
                    font.pixelSize: 12
                }
            }

            //LED 11
            Rectangle {
                id: led24
                width: 192
                height: 50
                anchors.top: led23.bottom
                Slider {
                    id: led24slider
                    anchors.fill: parent
                    x: 130
                    updateValueWhileDragging: false
                    stepSize: 1
                    tickmarksEnabled: false
                    minimumValue: 0
                    maximumValue: 40
                    value: 0
                    onValueChanged: {
                        BLE.setLed()
                    }
                }
                Label {
                    id: led24label
                    text: qsTr("LED24")
                    anchors.leftMargin: 6
                    anchors.horizontalCenter: led24slider.horizontalCenter
                    font.bold: true
                    font.pointSize: 10
                }
                Text {
                    id: led24text
                    text: led24slider.value
                    font.pixelSize: 12
                }
            }
        }
        */
    }
}

/*
Button {
    id: busErrorButton
    anchors.left: errorButton.right
    visible: false
    text: "Three errors received!"
    onClicked: {
        BLE.resetFailureCount();
        busErrorButton.visible = false;
    }

}


Button {
    id: errorButton
    text: "I emit errors!"
    //This is for debug purposes only
    onClicked: {
        BLE.emitError();
    }
}
*/








