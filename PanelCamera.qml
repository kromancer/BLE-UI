import QtQuick 2.1
import QtQuick.Dialogs 1.1
import mymodule 1.0
import QtQuick.Controls 1.4




Rectangle {
        id: root
        signal minimized
        signal maximized
        property real iconScale
        property real ribbonHeight
        property var stagePanelComponent
        property var stagePanelWindow
        property var ledPanelComponent
        property var ledPanelWindow



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
               },
               State {
                   name: "NOT_CONNECTED"
                   PropertyChanges { target: notConnectedIcon; visible: true }
                   PropertyChanges { target: start_button;     visible: false }
                   PropertyChanges { target: snapshot;         visible: false }
                   PropertyChanges { target: fullscreen;       visible: false }
                   PropertyChanges { target: settings_button;  visible: false }
               }

           ]

            Timer{
                id: displaytimer
                interval: 200;
                repeat: true
                onTriggered: camera.update()
            }

            Image {
                id: notConnectedIcon
                visible: false
                anchors.centerIn: parent
                scale: 0.5
                source: "qrc:/pics/oops.png"
            }

            Component.onCompleted: {
                if (!camera.cameraConnected){
                    camera.state = "NOT_CONNECTED"
                }
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




/////////////////////// BLUETOOTH SCAN BUTTON ////////////////////////////////////////////////////////
        Image {
            id: bluetoothsearchbutton
            anchors.bottom: parent.bottom
            anchors.top: ribbon.top
            anchors.right: parent.right
            fillMode: Image.PreserveAspectFit
            smooth: true
            source: "qrc:/pics/bluetooth_connect.png"
            scale: iconScale

            state: "NOT_CONNECTED"
            states: [
                State {
                    name: "NOT_CONNECTED"
                    PropertyChanges { target: bluetoothsearchstage; visible: true }
                    PropertyChanges { target: stageMovement; visible: false }
                },
                State {
                    name: "CONNECTED"
                    PropertyChanges { target: bluetoothsearchstage; visible: false }
                    PropertyChanges { target: stageMovement; visible: true }
                }
            ]

            MouseArea{
                anchors.fill: parent
                onClicked: {
                        BLE.deviceSearch();
                        busyIndicationStage.text = "Searching for Motor SensorTag";
                        busyIndicationLed.text = "Searching for LED SensorTag";
                        bluetoothsearchstage.source = "qrc:/pics/Empty.png";
                        bluetoothsearchled.source = "qrc:/pics/Empty.png";
                        busyIndicationStage.running = true;
                        busyIndicationLed.running = true;
                }
            }
        }




////////////////////////MOTOR SPINNER HOLDER///////////////////////////////////////////////////
        Image {
            id: bluetoothsearchstage
            anchors.bottom: parent.bottom
            anchors.top: ribbon.top
            anchors.left: parent.left
            fillMode: Image.PreserveAspectFit
            smooth: true
            source: "qrc:/pics/Empty.png"
            scale: iconScale

            state: "NOT_CONNECTED"
            states: [
                State {
                    name: "NOT_CONNECTED"
                    PropertyChanges { target: bluetoothsearchstage; visible: true }
                    PropertyChanges { target: stageMovement; visible: false }
                },
                State {
                    name: "CONNECTED"
                    PropertyChanges { target: bluetoothsearchstage; visible: false }
                    PropertyChanges { target: stageMovement; visible: true }
                }
            ]


            Connections {
                target: BLE
                onMotorSensorTagIsFound: { bluetoothsearchstage.state="CONNECTED"; busyIndicationStage.running=false }
                onMotorSensorTagNotFound:{ bluetoothsearchstage.source = "qrc:/pics/error.png"; busyIndicationStage.running = false; busyIndicationStage.text = "Motor sensor tag not found"}
            }
///////////////////////////////MOTOR SPINNER///////////////////////////////////////////////////////////
            BusyIndicator {
                id: busyIndicationStage
                property alias text: busyTextStage.text
                anchors.fill: parent
                //anchors.horizontalCenter: parent.horizontalCenter
                //anchors.bottomMargin: 0
                //anchors.bottom: root.bottom
                clip: false
                running: false

                Text {
                    //visible: busyIndicationStage.running
                    id: busyTextStage
                    text: ""
                    anchors.left: parent.right
                    anchors.leftMargin: 4
                    anchors.verticalCenterOffset: 2
                    font.pixelSize: 12
                    anchors.verticalCenter: parent.verticalCenter
                }
            }
        }
///////////////////////MOTOR PANEL BUTTON///////////////////////////////////////////////
        Image {

            Connections {
                target: BLE
                onMotorServiceIsFound: {
                    stagePanelWindow.show();
                    stageMovement.state = "EXPOSED";
                    stagePanelWindow.closing.connect(toggleState) }

                function toggleState()
                {
                    stageMovement.state = "NOT_EXPOSED"
                }
            }

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
                    BLE.connectToMotorSensorTag();
                }
            }
        }






///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////









//////////////////////LED SPINNER PLACEHOLDER///////////////////////////////////////////////////////////
        Image {
            id: bluetoothsearchled
            anchors.bottom: parent.bottom
            anchors.top: ribbon.top
            anchors.left: stageMovement.right
            anchors.leftMargin: 160
            fillMode: Image.PreserveAspectFit
            smooth: true
            source: "qrc:/pics/Empty.png"
            scale: iconScale

            state: "NOT_CONNECTED"
            states: [
                State {
                    name: "NOT_CONNECTED"
                    PropertyChanges { target: bluetoothsearchled; visible: true }
                    PropertyChanges { target: ledControl; visible: false }
                },
                State {
                    name: "CONNECTED"
                    PropertyChanges { target: bluetoothsearchled; visible: false }
                    PropertyChanges { target: ledControl; visible: true }
                }
            ]

            Connections {
                target: BLE
                onLedSensorTagIsFound: { bluetoothsearchled.state="CONNECTED"; busyIndicationLed.running = false; }
                onLedSensorTagNotFound: {bluetoothsearchled.source = "qrc:/pics/error.png"; busyIndicationLed.running = false; busyIndicationLed.text = "LED Sensor tag not found"}
            }
/////////////////// LED SPINNER /////////////////////////////////////////////////////////////
            BusyIndicator {
                id: busyIndicationLed
                property alias text: busyTextLed.text
                anchors.fill: parent
                //anchors.horizontalCenter: parent.horizontalCenter
                //anchors.bottomMargin: 0
                //anchors.bottom: root.bottom
                clip: false
                running: false

                Text {
                    //visible: busyIndicationLed.running
                    id: busyTextLed
                    text: ""
                    anchors.left: parent.right
                    anchors.leftMargin: 4
                    anchors.verticalCenterOffset: 2
                    font.pixelSize: 12
                    anchors.verticalCenter: parent.verticalCenter
                }
            }
        }
///////////////////LED PANEL BUTTON///////////////////////////////////////////////////////////////////
        Image {

            Connections {
                target: BLE
                onLedServiceIsFound: { ledPanelWindow.show(); ledControl.state = "EXPOSED"; ledPanelWindow.closing.connect(toggleState) }

                function toggleState()
                {
                    ledControl.state = "NOT_EXPOSED"
                }
            }



            id: ledControl
            anchors.bottom: parent.bottom
            anchors.top: ribbon.top
            anchors.left: stageMovement.right
            anchors.leftMargin: 130
            fillMode: Image.PreserveAspectFit
            smooth: true
            source: "qrc:/pics/led.png"
            scale: iconScale

            state: "NOT_EXPOSED"
            states: [
                State {
                    name: "NOT_EXPOSED"
                    PropertyChanges { target: ledControl; visible: true }
                },
                State {
                    name: "EXPOSED"
                    PropertyChanges { target: ledControl; visible: false }
                }
            ]

            MouseArea{
                anchors.fill: parent
                onClicked: {
                    BLE.connectToLEDSensorTag();

                }
            }
        }
//////////////////////////////////////////////////////////////////////////////////////////////////







        // Snapshot button and directory choice dialog
        Image {
            id: snapshot
            anchors.bottom: parent.bottom
            //anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: ribbon.top
            anchors.right: fullscreen.left
            source: "qrc:/pics/snapshot.png"
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
            }
        }
        ///////////////////////////////////////////////////////////





        // Fullscreen toggle button
        Image {
            id: fullscreen

            anchors.right: settings_button.left
            anchors.bottom: parent.bottom
            //anchors.left: snapshot.right
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
            anchors.right: bluetoothsearchbutton.left
            fillMode: Image.PreserveAspectFit
            smooth: true
            source: "qrc:/pics/settings.png"
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
