import QtQuick 2.5
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

    // Frame display item. Basically
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

        // The display update timer. The interval determines the display frame rate (not the camera's)
        Timer{
            id: displaytimer
            interval: 200;
            repeat: true
            onTriggered: camera.update()
        }

        // Camera not connected image
        Image {
            id: notConnectedIcon
            width: 100
            height: 100
            visible: false
            anchors.centerIn: parent
            scale: 0.5
            source: "qrc:/pics/error.png"

            Label {
                anchors.top: parent.bottom
                horizontalAlignment: parent.horizontalAlignment
                text: "Camera not connected"
                anchors.horizontalCenter: parent.horizontalCenter
                font.bold: true
                font.pixelSize: 32
            }
        }

        Component.onCompleted: {
            if (!camera.cameraConnected){
                camera.state = "NOT_CONNECTED"
            }
        }
    }


    // Toolbar ribbon
    Rectangle {
        id: ribbon
        anchors.bottom: parent.bottom
        height: ribbonHeight
        width: parent.width
        color: "white"
        opacity: 0.6

    }


    // Bluetooth scan button
    Image {
        id: bluetoothsearchbutton
        anchors.bottom: parent.bottom
        anchors.top: ribbon.top
        anchors.right: parent.right
        fillMode: Image.PreserveAspectFit
        smooth: true
        source: "qrc:/pics/bluetooth_connect.png"
        scale: iconScale

        Connections {
            target: BLE
            onDeviceScanDone: {bluetoothsearchbutton.visible = true}
        }

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
                bluetoothsearchbutton.visible = false;
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


    //Motor SensorTag Spinner
    Image {
        Connections {
            target: BLE
            onMotorSensorTagIsFound: { busyIndicationStage.running=false; busyIndicationStage.text = "Found Stage SensorTag" }
            onMotorSensorTagNotFound:{ busyIndicationStage.running = false; bluetoothsearchstage.source = "qrc:/pics/error.png"; busyIndicationStage.text = "Motor sensor tag not found"}
            onDeviceScanDone: {
                busyIndicationStage.running=false;
                if ( BLE.isMotorsSensorTagFound() )
                    busyIndicationStage.text = ""
            }
        }
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
                //PropertyChanges { target: stageMovement; visible: true }
            }
        ]

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


    //Motor Panel Button
    Image {

        Connections {
            target: BLE
            onDeviceScanStarted: {
                stageMovement.visible = false;
            }

            onDeviceScanDone: {
                if ( BLE.isMotorsSensorTagFound() )
                    stageMovement.visible = true;
            }

            onMotorServiceIsFound: {
                stagePanelWindow.show();
                stageMovement.state = "EXPOSED";
                stagePanelWindow.closing.connect(toggleState)
            }

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


    //LED SensorTag Spinner
    Image {
        Connections {
            target: BLE
            onLedSensorTagIsFound: { busyIndicationLed.running = false; busyIndicationLed.text = "Found LED SensorTag"}
            onLedSensorTagNotFound:{ busyIndicationLed.running = false; bluetoothsearchled.source = "qrc:/pics/error.png";  busyIndicationLed.text = "LED SensorTag not found"}
            onDeviceScanDone: {
                busyIndicationLed.running = false;
                if ( BLE.isLEDSensorTagFound() )
                    busyIndicationLed.text = ""
            }
        }

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
                //PropertyChanges { target: ledControl; visible: true }
            }
        ]

        BusyIndicator {
            id: busyIndicationLed
            property alias text: busyTextLed.text
            anchors.fill: parent
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


    //LED control button
    Image {
        id: ledControl
        Connections {
            target: BLE
            onDeviceScanStarted: {
                ledControl.visible = false;
            }

            onDeviceScanDone: {
                if ( BLE.isLEDSensorTagFound() )
                    ledControl.visible = true;
            }
            onLedServiceIsFound: {
                ledPanelWindow.show();
                ledControl.state = "EXPOSED";
                ledPanelWindow.closing.connect(toggleState)
            }
            function toggleState()
            {
                ledControl.state = "NOT_EXPOSED"
            }
        }
        anchors.bottom: parent.bottom
        anchors.top: ribbon.top
        anchors.left: stageMovement.right
        anchors.leftMargin: 160
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
}
