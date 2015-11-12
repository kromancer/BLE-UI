import QtQuick 2.1
import QtQuick.Dialogs 1.1
import mymodule 1.0



Rectangle {
        id: streamwindow

        color: "grey"
        state: "MINIMIZED"
        states: [
            State {
                name: "MINIMIZED"
                PropertyChanges { target: streamwindow; width: Math.round(2*universe.width/3) }
                PropertyChanges { target: streamwindow; height: Math.round(6*width/8) }
                PropertyChanges { target: fullscreen; source: "qrc:/pics/maximize.png" }
            },
            State {
                name: "MAXIMIZED"
                PropertyChanges { target: streamwindow; anchors.fill: parent }
                PropertyChanges { target: fullscreen; source: "qrc:/pics/minimize.png" }
            }
        ]

       // Frame Display
       PG_Camera {
           id: camera
           anchors.fill: parent

           state: "PAUSED"
           states: [
               State {
                   name: "PAUSED"
                   PropertyChanges { target: displaytimer; running: false }
                   PropertyChanges { target: start_button; source: "qrc:/pics/play.png"}

               },
               State {
                   name: "RUNNING"
                   PropertyChanges { target: displaytimer; running: true }
                   PropertyChanges { target: start_button; source: "qrc:/pics/pause.png"}
               }
           ]

            Timer{
                id: displaytimer
                interval: 100;
                repeat: true
                onTriggered: camera.update()
            }

            Connections {
                target: cameraSettings
                onGainChanged: camera.setGain(gain_value)
                onBrightnessChanged: camera.setBrightness(bright_value)
            }

        }
        //////////////////////////////////////////////////



        // Toolbar ribbon
        Rectangle {
            id: ribbon
            anchors.bottom: parent.bottom
            height: Math.round(parent.width / 8)
            width: parent.width
            color: "white"
            opacity: 0.6

        }
        ////////////////////////////////////////////////////////



        // Snapshot button and directory choice dialog
        Image {
            id: snapshot
            anchors.bottom: parent.bottom
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: ribbon.top
            source: "qrc:/pics/snapshot2.svg"
            fillMode: Image.PreserveAspectFit
            smooth: true

            MouseArea{
                anchors.fill: parent
                onClicked: {
                    camera.state = "PAUSED"
                    fileDialog.open()
                }
            }
         }
        // Choosing image destination
        FileDialog {
            id: fileDialog
            selectFolder: true
            title: "Please choose a directory"
            folder: shortcuts.home
            onAccepted: {
                //**********************************************************************************************************************
                // Why on earth don't they provide a function to convert a qml url to a string, representing the system's absolute path?
                //**********************************************************************************************************************
                var path = fileDialog.fileUrl.toString();
                // remove prefixed "file:///"
                path = path.replace(/^(file:\/{2})/,"");
                // unescape html codes like '%23' for '#'
                var cleanPath = decodeURIComponent(path);

                camera.saveFrame(cleanPath + "/Snapshot" + Math.random() + ".bmp")
                console.log(cleanPath)
            }
            onRejected: {
                console.log("Saving snapshot cancelled")
                Qt.quit()
            }
        }
        ///////////////////////////////////////////////////////////





        // Fullscreen toggle button
        Image {
            id: fullscreen
            anchors.bottom: parent.bottom
            anchors.left: snapshot.right
            anchors.leftMargin: 20
            anchors.top: ribbon.top
            fillMode: Image.PreserveAspectFit
            smooth: true

            MouseArea {
                anchors.fill: parent
                onClicked: {
                    if(streamwindow.state == "MAXIMIZED"){
                        streamwindow.width = Math.round(2*universe.width/3)
                        streamwindow.height = Math.round(universe.height/2)
                        streamwindow.state = "MINIMIZED"

                    }else{
                        streamwindow.height = universe.height
                        streamwindow.width = universe.width
                        streamwindow.state = "MAXIMIZED"
                    }

                }
            }

        }
        ///////////////////////////////////////////////////////



        // Start/Pause Streaming button
        Image {
            id: start_button
            anchors.bottom: parent.bottom
            anchors.right: snapshot.left
            anchors.rightMargin: 20
            anchors.top: ribbon.top
            fillMode: Image.PreserveAspectFit
            smooth: true

            MouseArea{
                anchors.fill: parent
                onClicked: {
                    if (camera.state == "PAUSED"){
                        camera.state = "RUNNING"
                    }
                    else{
                        camera.state = "PAUSED"
                    }
                }
            }
        }

}
