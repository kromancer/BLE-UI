import QtQuick 2.0
import QtQuick.Controls 1.2

Rectangle{
        signal gainChanged(var gain_value)
        signal brightnessChanged(var bright_value)
        property int textSize

        // Gain Settings
        Rectangle{
            id: gainRect
            anchors.top: parent.top
            anchors.topMargin: 20
            anchors.left: parent.left
            anchors.leftMargin: 20
            anchors.right: parent.right
            anchors.rightMargin: 20
            height: parent.height / 8


            Label {
                id: gainTitleLabel
                font.pixelSize: textSize
                font.family: "Ubuntu"
                text: "Gain (dB)"
            }

            Label {
                id: gainValueLabel
                font.pixelSize: textSize
                anchors.right: gainSlider.left
                anchors.rightMargin: 20
                font.family: "Ubuntu"
                text: gainSlider.value


            }

            Slider {
                id: gainSlider


                anchors.left: parent.horizontalCenter
                anchors.right: parent.right


                maximumValue:  23
                minimumValue: -10
                value: 0
                stepSize: 1
                updateValueWhileDragging: true
                onValueChanged: gainChanged(value)

            }
        }
        /////////////////////////////////////////////////////





        // Brightness Setting
        Rectangle{
            id: brightRect
            anchors.top: gainRect.bottom
            anchors.topMargin: 10

            anchors.left: parent.left
            anchors.leftMargin: 20

            anchors.right: parent.right
            anchors.rightMargin: 20

            height: parent.height / 8


            Label {
                id: brightTitleLabel
                font.pixelSize: textSize
                font.family: "Ubuntu"
                text: "Brightness (%)"
            }

            Label {
                id: brightValueLabel
                font.pixelSize: textSize
                anchors.right: brightSlider.left
                anchors.rightMargin: 20
                font.family: "Ubuntu"
                text: brightSlider.value


            }

            Slider {
                id: brightSlider


                anchors.left: parent.horizontalCenter
                anchors.right: parent.right


                maximumValue:  100
                minimumValue:  0
                value: 50
                stepSize: 1
                updateValueWhileDragging: true
                onValueChanged: brightnessChanged(value)

            }
        }
        /////////////////////////////////////////////////////




        // Connect Button
        Button {
                anchors.bottom: parent.bottom
                text: "Connect to Stage"
                onClicked: {
                        VAQ.deviceSearch();
                }
        }
        //////////////////////////////////////////////////////









        //CameraControls{id: sliderLED; anchors.bottom: cameracontrols.bottom; height:Math.round(parent.height/1.5); width: Math.round(parent.width/4); labelSize: 12+universe.width/200; }
        //CameraControls{id: auto_exposure; anchors.bottom: cameracontrols.bottom; anchors.left: sliderLED.right; height:Math.round(parent.height/1.5); width: Math.round(parent.width/4); labelSize: 12+universe.width/200;}
        //CameraControls{id: controller3; anchors.bottom: cameracontrols.bottom; anchors.left: controller2.right; height:Math.round(parent.height/1.5); width: Math.round(parent.width/4); labelSize: 12+universe.width/200;}
        //CameraControls{id: controller4; anchors.bottom: cameracontrols.bottom; anchors.left: controller3.right; height:Math.round(parent.height/1.5); width: Math.round(parent.width/4); labelSize: 12+universe.width/200;}


        /*
        Grid{
                id: demogrid
                rows:2

                Button {
                        text: "Bluetooth demo"
                        onClicked: {
                                VAQ.deviceSearch();
                        }
                }
        }
        */
}
