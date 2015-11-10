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



        CameraDisplay { id: cameraDisplay }





        Rectangle{
                //cameracontrols AND DEBUG BUTTON RECTANGLE
                anchors.left: cameraDisplay.right
                width: Math.round(universe.width/3)
                height: Math.round(universe.height/2)
                border.width: 1

                id:cameracontrols
                CameraControls{id: sliderLED; anchors.bottom: cameracontrols.bottom; height:Math.round(parent.height/1.5); width: Math.round(parent.width/4); labelSize: 12+universe.width/200; }
                CameraControls{id: auto_exposure; anchors.bottom: cameracontrols.bottom; anchors.left: sliderLED.right; height:Math.round(parent.height/1.5); width: Math.round(parent.width/4); labelSize: 12+universe.width/200;}
                //CameraControls{id: controller3; anchors.bottom: cameracontrols.bottom; anchors.left: controller2.right; height:Math.round(parent.height/1.5); width: Math.round(parent.width/4); labelSize: 12+universe.width/200;}
                //CameraControls{id: controller4; anchors.bottom: cameracontrols.bottom; anchors.left: controller3.right; height:Math.round(parent.height/1.5); width: Math.round(parent.width/4); labelSize: 12+universe.width/200;}

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
        }

        Rectangle{
                //X, Y, Z COORDINATE RECTANGLE
                border.width: 1


                anchors.top: cameraDisplay.bottom
                width: Math.round(universe.width/3)
                height: Math.round(universe.height/2)

                id: xyzcontrols

            SliderMOTOR {id: zslider; anchors.right: parent.right; anchors.top: parent.top; anchors.bottom: yslider.bottom;  orientation: Qt.Vertical; height: Math.round(parent.height); width: Math.round(parent.width/4); label:"Z-Axis"; labelSize: 12+universe.width/200}
            SliderMOTOR {id: xslider; anchors.right: zslider.left; height:Math.round(parent.height/4); width: Math.round(parent.width); label:"X-Axis"; labelSize: 12+universe.width/200}
            SliderMOTOR {id: yslider; anchors.right: zslider.left; anchors.topMargin: 20; anchors.top: xslider.bottom; height:Math.round(parent.height/4); width: Math.round(parent.width); label:"Y-Axis"; labelSize: 12+universe.width/200}
        }

        Rectangle{
                id:knobrectangle
                border.width: 1

                anchors.top: xyzcontrols.top
                anchors.left: xyzcontrols.right
                anchors.bottom: parent.bottom
                width: Math.round(universe.width/3)
                height: Math.round(universe.height/2)

                YawKnob{
                    anchors.fill: parent
                }
        }




        Rectangle{
            border.width: 1
            anchors.top: knobrectangle.top
            anchors.left: knobrectangle.right
            anchors.bottom: parent.bottom

            width: Math.round(universe.width/3)
            height: Math.round(universe.height/2)

            SliderMOTOR {id: pitch; anchors.top: parent.top; orientation: Qt.Vertical; height: Math.round(parent.height/1.8); width: Math.round(parent.width/4); label:"Pitch"; labelSize: 12+universe.width/200}
            SliderMOTOR {anchors.top: pitch.bottom; anchors.bottom: parent.bottom; height:Math.round(parent.height/4); width: Math.round(parent.width); label:"Roll"; labelSize: 12+universe.width/200}
        }

        SliderMOTOR {
                id: sliderMOTOR1
                x: -61
                y: -68
                antialiasing: false
        }
}


// Graveyard of, potentially usefull for debugging, code.


/* QtQuick native support
VideoOutput {
    source: camera
    Layout.preferredWidth: Math.round(universe.width / 2);
    Layout.preferredHeight: Math.round(universe.height / 2.5);
    Layout.columnSpan: 2;
    Camera {
        id: camera

        // You can adjust various settings in here
    }
}

VideoOutput {
        id: videoOutput
        source: player
        anchors.fill: parent
}
*/



