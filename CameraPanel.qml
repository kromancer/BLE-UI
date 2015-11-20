import QtQuick 2.1
import QtQuick.Dialogs 1.1
import mymodule 1.0



Rectangle {
        id: root
        signal minimized
        signal maximized
        property real iconScale
        property real ribbonHeight
        property var stagePanelComponent
        property var stagePanelWindow

        color: "grey"
        state: "MINIMIZED"
        states: [
            State {
                name: "MINIMIZED"
                //PropertyChanges { target: root; width: 634 }
                //PropertyChanges { target: root; height: 482 }
                PropertyChanges { target: fullscreen; source: "qrc:/pics/maximize.png" }
            },
            State {
                name: "MAXIMIZED"
                //PropertyChanges { target: root; width: 1268 }
                //PropertyChanges { target: root; height: 964 }
                PropertyChanges { target: fullscreen; source: "qrc:/pics/minimize.png" }
            }
        ]

       // Frame Display
       PGCamera {
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
        }
        //////////////////////////////////////////////////



        // Toolbar ribbon
        Rectangle {
            id: ribbon
            anchors.bottom: parent.bottom
            height: ribbonHeight
            width: parent.width
            color: "white"
            opacity: 0.6

        }
        ////////////////////////////////////////////////////////



        // Stage Movement Button
        Image {
            id: stageMovement
            anchors.bottom: parent.bottom
            anchors.top: ribbon.top
            anchors.left: parent.left
            fillMode: Image.PreserveAspectFit
            smooth: true
            source: "qrc:/pics/move.png"
            scale: iconScale

            state: "NOT_EXPOSED"
            states: [
                State {
                    name: "NOT_EXPOSED"
                    PropertyChanges { target: stageMovement; visible: true }
                },
                State {
                    name: "EXPOSED"
                    PropertyChanges { target: stageMovement; visible: false }
                }
            ]


            MouseArea{
                anchors.fill: parent
                onClicked: {
                    stageMovement.state = "EXPOSED"
                    stagePanelWindow.closing.connect(toggleState)
                    stagePanelWindow.show()
                }

                function toggleState()
                {
                    stageMovement.state = "NOT_EXPOSED"
                }
            }
        }



        //////////////////////////////////////////////////////////////

        // Snapshot button and directory choice dialog
        Image {
            id: snapshot
            anchors.bottom: parent.bottom
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: ribbon.top
            source: "qrc:/pics/snapshot2.svg"
            scale: iconScale
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
            scale: iconScale

            MouseArea {
                anchors.fill: parent
                onClicked: {
                    if(root.state == "MAXIMIZED"){
                        root.state = "MINIMIZED"
                        minimized()

                    }else{
                        root.state = "MAXIMIZED"
                        maximized()
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
            scale: iconScale

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
        /////////////////////////////////////////////////////////////


        // Settings Button
        Image {
            id: settings_button
            anchors.bottom: parent.bottom
            anchors.top: ribbon.top
            anchors.right: ribbon.right
            fillMode: Image.PreserveAspectFit
            smooth: true
            source: "qrc:/pics/settings2.png"
            scale: iconScale
            state: "NOT_EXPOSED"
            states: [
                State {
                    name: "NOT_EXPOSED"
                    PropertyChanges { target: settings_button; visible: true }
                },
                State {
                    name: "EXPOSED"
                    PropertyChanges { target: settings_button; visible: false }
                }
            ]


            MouseArea{
                anchors.fill: parent
                onClicked: {
                    settings_button.state = "EXPOSED"
                    camera.showSettings()
                    settings_button.state = "NOT_EXPOSED"
                }
            }
        }
        //////////////////////////////////////////////////////////////

}
