import QtQuick 2.1
import QtQuick.Dialogs 1.1



Rectangle {
        id: streamwindow


        // Expose the timer running property
        property alias running: displaytimer.running


        color: "grey"
        state: "MINIMIZED"
        states: [
            State {
                name: "MINIMIZED"
                PropertyChanges { target: streamwindow; width: Math.round(2*universe.width/3) }
                PropertyChanges { target: streamwindow; height: Math.round(universe.height/2) }
                PropertyChanges { target: fullscreen; source: "qrc:/pics/maximize.png" }
            },
            State {
                name: "MAXIMIZED"
                PropertyChanges { target: streamwindow; anchors.fill: parent }
                PropertyChanges { target: fullscreen; source: "qrc:/pics/minimize.png" }
            }
        ]


        // Camera stream display canvas
        Canvas {
            id: display;
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


            Image {
                id: frame;
                anchors.fill: parent;
                cache: false
            }

            onPaint: {
                frame.source = "image://camera/image" + Math.random()
                loadImage(frame)
            }

            onImageLoaded: {
                var ctx = getContext("2d")
                ctx.drawImage(frame,0,0)
            }

            Timer{
                id: displaytimer
                interval: 100;
                repeat: true
                onTriggered: display.requestPaint()
            }

        }
        //////////////////////////////////////////////////



        // Toolbar ribbon
        Rectangle {
            id: ribbon
            anchors.bottom: parent.bottom
            height: Math.round(parent.width / 6)
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
                    display.state = "PAUSED"
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
                console.log("You chose: " + Qt.resolvedUrl(fileDialog.fileUrl).toString())

                display.save(Qt.resolvedUrl(fileDialog.fileUrl).toString() +  "/Snapshot" + Math.random() + ".bmp")
                Qt.quit()
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
                    if (display.state == "PAUSED"){
                        display.state = "RUNNING"
                    }
                    else{
                        display.state = "PAUSED"
                    }
                }
            }
        }

}
