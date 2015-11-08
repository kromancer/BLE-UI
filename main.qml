//The Qt Quick module provides graphical primitive types
import QtQuick 2.1
//Provide a resolution independent GUI (let scaling be done automatically)
import QtQuick.Layouts 1.2
import QtQuick.Controls 1.3
import QtMultimedia 5.5



Rectangle {
    id: universe
    anchors.fill: parent

    GridLayout{
        anchors.fill: parent
        flow: GridLayout.TopToBottom
        rows: 4

        //Rectangle   {Layout.preferredWidth: Math.round(universe.width / 2); Layout.preferredHeight: Math.round(universe.height / 2.5); color: "grey"; Layout.columnSpan: 2}

        // Camera access through opencv
        Image {
            id: display;
            cache: false;
            Layout.preferredWidth: Math.round(universe.width / 2);
            Layout.preferredHeight: Math.round(universe.height / 2.5);
            Layout.columnSpan: 2;


            Timer{
                interval: 50; running: true; repeat: true
                //onTriggered: parent.source = "image://camera/image" + Math.random()
            }
        }


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
        */



        SliderMOTOR {Layout.preferredWidth: Math.round(universe.width / 4); Layout.preferredHeight: Math.round(universe.width/15); label:"X-Axis"; labelSize: 12+universe.width/200}
        SliderMOTOR {Layout.preferredWidth: universe.width / 4; Layout.preferredHeight: universe.width/15; label:"Y-Axis"; labelSize: 12+universe.width/200}
        SliderMOTOR {Layout.preferredWidth: universe.width / 4; Layout.preferredHeight: universe.width/15; label:"Z-Axis"; labelSize: 12+universe.width/200}

        YawKnob{}

        CameraControls{Layout.preferredHeight: universe.height / 2; labelSize: 12+universe.width/200}

        SliderMOTOR {Layout.preferredWidth: universe.width / 4 ; Layout.preferredHeight: universe.width/15; label:"Pitch"; labelSize: 12+universe.width/200}
        SliderMOTOR {Layout.preferredWidth: universe.width / 4 ; Layout.preferredHeight: universe.width/15; label:"Roll"; labelSize: 12+universe.width/200}
     }
 }




