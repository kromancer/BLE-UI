//The Qt Quick module provides graphical primitive types
import QtQuick 2.1
//Provide a resolution independent GUI (let scaling be done automatically)
import QtQuick.Layouts 1.1
import QtQuick.Controls 1.3
//Qt videoplayer
import QtMultimedia 5.0

/*
 * Everything is arranges into rectangles now,
 * since it's a lot easier to manage all the sliders
 * and knobs when they're not all in one big grid
 */

Rectangle {
        id: universe
        anchors.fill: parent
           border.width: 1

        Rectangle {
                //VIDEO OUTPUT RECTANGLE
                width: Math.round(2*universe.width/3)
                height: Math.round(universe.height/2)

                id: streamwindow
                color: "grey"

                MediaPlayer {
                        id: player
                        //example stream, it's a bit dark in the first part
                        source: "rtmp://184.72.239.149/vod/mp4:bigbuckbunny_450.mp4"
                }

                VideoOutput {
                        id: videoOutput
                        source: player
                        anchors.fill: parent
                }
        }

        Rectangle{
                //LIGHTSLIDER AND DEBUG BUTTON RECTANGLE
                anchors.left: streamwindow.right
                width: Math.round(universe.width/3)
                height: Math.round(universe.height/2)
            border.width: 1

                id:lightslider
                CameraControls{anchors.centerIn: parent; height:Math.round(parent.height/1.5); width: Math.round(parent.width/4); labelSize: 12+universe.width/200}
                Grid{
                        id: demogrid
                        rows:2

                        Button {
                                text: "Remote video demo"
                                onClicked: {
                                        player.play();
                                        //VAQ.deviceSearch();
                                }
                        }

                        Button {
                                text: "Bluetooth demo"
                                onClicked: {
                                        VAQ.deviceSearch();
                                }
                        }
                }
        }

        Rectangle{
                //X, Y, Z COORDINATE RECTANGLE
                border.width: 1

                anchors.top: streamwindow.bottom
                width: Math.round(universe.width/3)
                height: Math.round(universe.height/2)

                id: xyzcontrols

            SliderMOTOR {id: zslider; anchors.right: parent.right; anchors.top: parent.top; anchors.bottom: yslider.bottom;  orientation: Qt.Vertical; height: Math.round(parent.height); width: Math.round(parent.width/4); label:"Pitch"; labelSize: 12+universe.width/200}
            SliderMOTOR {id: xslider; anchors.right: zslider.left; height:Math.round(parent.height/4); width: Math.round(parent.width); label:"X-Axis"; labelSize: 12+universe.width/200}
            SliderMOTOR {id: yslider; anchors.right: zslider.left; anchors.topMargin: 20; anchors.top: xslider.bottom; height:Math.round(parent.height/4); width: Math.round(parent.width); label:"Y-Axis"; labelSize: 12+universe.width/200}
        }

        Rectangle{
                border.width: 1

                anchors.left: xyzcontrols.right
                anchors.bottom: parent.bottom
                width: Math.round(universe.width/3)
                height: Math.round(universe.height/2)
                id:knobrectangle

                Image {
                        anchors.centerIn: parent
                        id: knob
                        Layout.rowSpan: 3
                        Layout.preferredWidth: universe.width/5
                        Layout.preferredHeight: width
                        source: "qrc:/pics/knob.png"
                }
        }




        Rectangle{
            border.width: 1
            anchors.left: knobrectangle.right
            anchors.bottom: parent.bottom

            width: Math.round(universe.width/3)
            height: Math.round(universe.height/2)

            SliderMOTOR {id: pitch; anchors.top: parent.top; orientation: Qt.Vertical; height: Math.round(parent.height/1.8); width: Math.round(parent.width/4); label:"Pitch"; labelSize: 12+universe.width/200}
            SliderMOTOR {anchors.bottomMargin: 30; anchors.topMargin: 24;anchors.top: pitch.bottom; anchors.bottom: parent.bottom; height:Math.round(parent.height/4); width: Math.round(parent.width); label:"Roll"; labelSize: 12+universe.width/200}
        }

        SliderMOTOR {
                id: sliderMOTOR1
                x: -61
                y: -68
                antialiasing: false
        }
}




