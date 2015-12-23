import QtQuick 2.5
import QtQuick.Controls 1.4




ApplicationWindow{
    id: ledcontrolwindow
    width: 420
    height: 420
    minimumWidth: 420
    minimumHeight: 420
    maximumWidth: 420
    maximumHeight: 420
    color: "#ffffff"

    signal ledWindowClosed

    title: "LED Ring"

    onClosing: {
        BLE.disconnectFromLED();
        root.connected = false;
        root.state = "NOT_CONNECTED"
        busyIndication.running = true
    }


    Rectangle{
        id: root
        width: 400
        height: 400
        color: "#ffffff"
        border.color: "#ffffff"
        border.width: 0
        anchors.centerIn: parent
        signal masterOn()
        signal masterOff()
        property bool connected:false
        property int ledsOn: 0

        Connections {
            target: BLE
            onLedServiceIsReady: { busyIndication.running = false; root.state="CONNECTED"; root.connected = true }
        }

        state: "NOT_CONNECTED"
        states: [
            State {
                name: "NOT_CONNECTED"
                PropertyChanges { target: masterRect; visible: false }
                PropertyChanges { target: l1; visible: false }
                PropertyChanges { target: l2; visible: false }
                PropertyChanges { target: l3; visible: false }
                PropertyChanges { target: l4; visible: false }
                PropertyChanges { target: l5; visible: false }
                PropertyChanges { target: l6; visible: false }
                PropertyChanges { target: l7; visible: false }
                PropertyChanges { target: l8; visible: false }
                PropertyChanges { target: l9; visible: false }
                PropertyChanges { target: l10; visible: false }
                PropertyChanges { target: l11; visible: false }
                PropertyChanges { target: l12; visible: false }
                PropertyChanges { target: l13; visible: false }
                PropertyChanges { target: l14; visible: false }
                PropertyChanges { target: l15; visible: false }
                PropertyChanges { target: l16; visible: false }
                PropertyChanges { target: l17; visible: false }
                PropertyChanges { target: l18; visible: false }
                PropertyChanges { target: l19; visible: false }
                PropertyChanges { target: l20; visible: false }
                PropertyChanges { target: l21; visible: false }
                PropertyChanges { target: l22; visible: false }
                PropertyChanges { target: l23; visible: false }
                PropertyChanges { target: l24; visible: false }
                PropertyChanges { target: l25; visible: false }
                PropertyChanges { target: l26; visible: false }
                PropertyChanges { target: l27; visible: false }
                PropertyChanges { target: l28; visible: false }
                PropertyChanges { target: l29; visible: false }
                PropertyChanges { target: l30; visible: false }
                PropertyChanges { target: l31; visible: false }
                PropertyChanges { target: l32; visible: false }
                PropertyChanges { target: l33; visible: false }
                PropertyChanges { target: l34; visible: false }
                PropertyChanges { target: l35; visible: false }
                PropertyChanges { target: l36; visible: false }
            },
            State {
                name: "CONNECTED"
                PropertyChanges { target: masterRect; visible: true }
                PropertyChanges { target: master; visible: true}
                PropertyChanges { target: l1; visible: true }
                PropertyChanges { target: l2; visible: true }
                PropertyChanges { target: l3; visible: true }
                PropertyChanges { target: l4; visible: true }
                PropertyChanges { target: l5; visible: true }
                PropertyChanges { target: l6; visible: true }
                PropertyChanges { target: l7; visible: true }
                PropertyChanges { target: l8; visible: true }
                PropertyChanges { target: l9; visible: true }
                PropertyChanges { target: l10; visible: true }
                PropertyChanges { target: l11; visible: true }
                PropertyChanges { target: l12; visible: true }
                PropertyChanges { target: l13; visible: true }
                PropertyChanges { target: l14; visible: true }
                PropertyChanges { target: l15; visible: true }
                PropertyChanges { target: l16; visible: true }
                PropertyChanges { target: l17; visible: true }
                PropertyChanges { target: l18; visible: true }
                PropertyChanges { target: l19; visible: true }
                PropertyChanges { target: l20; visible: true }
                PropertyChanges { target: l21; visible: true }
                PropertyChanges { target: l22; visible: true }
                PropertyChanges { target: l23; visible: true }
                PropertyChanges { target: l24; visible: true }
                PropertyChanges { target: l25; visible: true }
                PropertyChanges { target: l26; visible: true }
                PropertyChanges { target: l27; visible: true }
                PropertyChanges { target: l28; visible: true }
                PropertyChanges { target: l29; visible: true }
                PropertyChanges { target: l30; visible: true }
                PropertyChanges { target: l31; visible: true }
                PropertyChanges { target: l32; visible: true }
                PropertyChanges { target: l33; visible: true }
                PropertyChanges { target: l34; visible: true }
                PropertyChanges { target: l35; visible: true }
                PropertyChanges { target: l36; visible: true }
            }
        ]

        Component.onCompleted: {
            busyIndication.running = true
        }

        onMasterOn: {
            ledsOn = 36;
            l1.source = "qrc:/pics/ledButtonSelected.png";
            l2.source = "qrc:/pics/ledButtonSelected.png";
            l3.source = "qrc:/pics/ledButtonSelected.png";
            l4.source = "qrc:/pics/ledButtonSelected.png";
            l5.source = "qrc:/pics/ledButtonSelected.png";
            l6.source = "qrc:/pics/ledButtonSelected.png";
            l7.source = "qrc:/pics/ledButtonSelected.png";
            l8.source = "qrc:/pics/ledButtonSelected.png";
            l9.source = "qrc:/pics/ledButtonSelected.png";
            l10.source = "qrc:/pics/ledButtonSelected.png";
            l11.source = "qrc:/pics/ledButtonSelected.png";
            l12.source = "qrc:/pics/ledButtonSelected.png";
            l13.source = "qrc:/pics/ledButtonSelected.png";
            l14.source = "qrc:/pics/ledButtonSelected.png";
            l15.source = "qrc:/pics/ledButtonSelected.png";
            l16.source = "qrc:/pics/ledButtonSelected.png";
            l17.source = "qrc:/pics/ledButtonSelected.png";
            l18.source = "qrc:/pics/ledButtonSelected.png";
            l19.source = "qrc:/pics/ledButtonSelected.png";
            l20.source = "qrc:/pics/ledButtonSelected.png";
            l21.source = "qrc:/pics/ledButtonSelected.png";
            l22.source = "qrc:/pics/ledButtonSelected.png";
            l23.source = "qrc:/pics/ledButtonSelected.png";
            l24.source = "qrc:/pics/ledButtonSelected.png";
            l25.source = "qrc:/pics/ledButtonSelected.png";
            l26.source = "qrc:/pics/ledButtonSelected.png";
            l27.source = "qrc:/pics/ledButtonSelected.png";
            l28.source = "qrc:/pics/ledButtonSelected.png";
            l29.source = "qrc:/pics/ledButtonSelected.png";
            l30.source = "qrc:/pics/ledButtonSelected.png";
            l31.source = "qrc:/pics/ledButtonSelected.png";
            l32.source = "qrc:/pics/ledButtonSelected.png";
            l33.source = "qrc:/pics/ledButtonSelected.png";
            l34.source = "qrc:/pics/ledButtonSelected.png";
            l35.source = "qrc:/pics/ledButtonSelected.png";
            l36.source = "qrc:/pics/ledButtonSelected.png";
            l1.selected = true;
            l2.selected = true;
            l3.selected = true;
            l4.selected = true;
            l5.selected = true;
            l6.selected = true;
            l7.selected = true;
            l8.selected = true;
            l9.selected = true;
            l10.selected = true;
            l11.selected = true;
            l12.selected = true;
            l13.selected = true;
            l14.selected = true;
            l15.selected = true;
            l16.selected = true;
            l17.selected = true;
            l18.selected = true;
            l19.selected = true;
            l20.selected = true;
            l21.selected = true;
            l22.selected = true;
            l23.selected = true;
            l24.selected = true;
            l25.selected = true;
            l26.selected = true;
            l27.selected = true;
            l28.selected = true;
            l29.selected = true;
            l30.selected = true;
            l31.selected = true;
            l32.selected = true;
            l33.selected = true;
            l34.selected = true;
            l35.selected = true;
            l36.selected = true;
        }
        onMasterOff: {
            ledsOn = 0;
            l1.source = "qrc:/pics/ledButton.png";
            l2.source = "qrc:/pics/ledButton.png";
            l3.source = "qrc:/pics/ledButton.png";
            l4.source = "qrc:/pics/ledButton.png";
            l5.source = "qrc:/pics/ledButton.png";
            l6.source = "qrc:/pics/ledButton.png";
            l7.source = "qrc:/pics/ledButton.png";
            l8.source = "qrc:/pics/ledButton.png";
            l9.source = "qrc:/pics/ledButton.png";
            l10.source = "qrc:/pics/ledButton.png";
            l11.source = "qrc:/pics/ledButton.png";
            l12.source = "qrc:/pics/ledButton.png";
            l13.source = "qrc:/pics/ledButton.png";
            l14.source = "qrc:/pics/ledButton.png";
            l15.source = "qrc:/pics/ledButton.png";
            l16.source = "qrc:/pics/ledButton.png";
            l17.source = "qrc:/pics/ledButton.png";
            l18.source = "qrc:/pics/ledButton.png";
            l19.source = "qrc:/pics/ledButton.png";
            l20.source = "qrc:/pics/ledButton.png";
            l21.source = "qrc:/pics/ledButton.png";
            l22.source = "qrc:/pics/ledButton.png";
            l23.source = "qrc:/pics/ledButton.png";
            l24.source = "qrc:/pics/ledButton.png";
            l25.source = "qrc:/pics/ledButton.png";
            l26.source = "qrc:/pics/ledButton.png";
            l27.source = "qrc:/pics/ledButton.png";
            l28.source = "qrc:/pics/ledButton.png";
            l29.source = "qrc:/pics/ledButton.png";
            l30.source = "qrc:/pics/ledButton.png";
            l31.source = "qrc:/pics/ledButton.png";
            l32.source = "qrc:/pics/ledButton.png";
            l33.source = "qrc:/pics/ledButton.png";
            l34.source = "qrc:/pics/ledButton.png";
            l35.source = "qrc:/pics/ledButton.png";
            l36.source = "qrc:/pics/ledButton.png";
            l1.selected = false;
            l2.selected = false;
            l3.selected = false;
            l4.selected = false;
            l5.selected = false;
            l6.selected = false;
            l7.selected = false;
            l8.selected = false;
            l9.selected = false;
            l10.selected = false;
            l11.selected = false;
            l12.selected = false;
            l13.selected = false;
            l14.selected = false;
            l15.selected = false;
            l16.selected = false;
            l17.selected = false;
            l18.selected = false;
            l19.selected = false;
            l20.selected = false;
            l21.selected = false;
            l22.selected = false;
            l23.selected = false;
            l24.selected = false;
            l25.selected = false;
            l26.selected = false;
            l27.selected = false;
            l28.selected = false;
            l29.selected = false;
            l30.selected = false;
            l31.selected = false;
            l32.selected = false;
            l33.selected = false;
            l34.selected = false;
            l35.selected = false;
            l36.selected = false;
        }

        // Busy Indicator
        BusyIndicator {
            id: busyIndication
            property alias text: busyText.text
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottomMargin: 0
            anchors.bottom: root.bottom
            clip: false
            running: false

            Text {
                visible: busyIndication.running
                id: busyText
                text: "Connecting to LED ring"
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenterOffset: 2
                font.pixelSize: 12
                anchors.verticalCenter: parent.verticalCenter
            }
        }

        // Master switch
        Rectangle {
            id: masterRect
            property alias checked: master.checked
            width: 100
            height: 64
            anchors.verticalCenterOffset: -7
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            Switch {
                id: master
                x: 177
                y: 205
                width: 50
                height: 20
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 0
                anchors.horizontalCenter: parent.horizontalCenter
                scale: 2

                onClicked: {
                    if (checked)
                    {
                        root.masterOn();
                        BLE.setLED(0xff);
                    }
                    else
                    {
                        root.masterOff();
                        BLE.setLED(0x7f);
                    }
                }
            }

            Label {
                x: 0
                text: "LED Power"
                anchors.top: parent.top
                anchors.topMargin: 0
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.bottom: master.top
                anchors.bottomMargin: 17
                font.bold: true
                font.pointSize: 14

            }
        }

        // INDIVIDUAL LEDS
        Image {
            id: l1
            x: 199
            y: 2
            width: 32
            height: 32
            antialiasing: true
            fillMode: Image.PreserveAspectFit
            source: "qrc:/pics/ledButton.png"
            property bool selected: false
            property int value: 0

            MouseArea{
                anchors.fill: parent
                onClicked: {
                    if (l1.selected)
                    {
                        BLE.setLED(0x00);
                        l1.selected = false;
                        l1.source = "qrc:/pics/ledButton.png";
                        root.ledsOn--;
                        if ( root.ledsOn == 0 )
                            masterRect.checked = false;
                    }
                    else
                    {
                        BLE.setLED(0x80);
                        l1.selected = true;
                        l1.source = "qrc:/pics/ledButtonSelected.png";
                        root.ledsOn++;
                        masterRect.checked = true;
                    }

                }
            }
        }

        Image {
            id: l2
            x: 231
            y: 7
            width: 32
            height: 32
            antialiasing: true
            fillMode: Image.PreserveAspectFit
            source: "qrc:/pics/ledButton.png"
            property bool selected: false
            property int value: 0
            MouseArea{
                anchors.fill: parent
                onClicked: {
                    if (l2.selected)
                    {
                        BLE.setLED(0x01);
                        l2.selected = false;
                        l2.source = "qrc:/pics/ledButton.png";
                        root.ledsOn--;
                        if ( root.ledsOn == 0)
                            masterRect.checked = false;
                    }
                    else
                    {
                        BLE.setLED(0x81);
                        l2.selected = true;
                        l2.source = "qrc:/pics/ledButtonSelected.png";
                        root.ledsOn++;
                        masterRect.checked = true;
                    }
                }
            }
        }

        Image {
            id: l3
            x: 261
            y: 17
            width: 32
            height: 32
            antialiasing: true
            fillMode: Image.PreserveAspectFit
            source: "qrc:/pics/ledButton.png"
            property bool selected: false
            property int intID: 3
            property int value: 0
            MouseArea{
                anchors.fill: parent
                onClicked: {
                    if (l3.selected)
                    {
                        BLE.setLED(0x02);
                        l3.selected = false;
                        l3.source = "qrc:/pics/ledButton.png";
                        root.ledsOn--;
                        if ( root.ledsOn == 0)
                            masterRect.checked = false;

                    }
                    else
                    {
                        BLE.setLED(0x82);
                        l3.selected = true;
                        l3.source = "qrc:/pics/ledButtonSelected.png";
                        root.ledsOn++;
                        masterRect.checked = true;
                    }
                }
            }

        }

        Image {
            id: l4
            x: 289
            y: 34
            width: 32
            height: 32
            antialiasing: true
            fillMode: Image.PreserveAspectFit
            source: "qrc:/pics/ledButton.png"
            property bool selected: false
            property int intID: 4
            property int value: 0
            MouseArea{
                anchors.fill: parent
                onClicked: {
                    if (l4.selected)
                    {
                        BLE.setLED(0x03);
                        l4.selected = false;
                        l4.source = "qrc:/pics/ledButton.png";
                        root.ledsOn--;
                        if ( root.ledsOn == 0)
                            masterRect.checked = false;
                    }
                    else
                    {
                        BLE.setLED(0x83);
                        l4.selected = true;
                        l4.source = "qrc:/pics/ledButtonSelected.png";
                        root.ledsOn++;
                        masterRect.checked = true;
                    }
                }
            }

        }

        Image {
            id: l5
            x: 312
            y: 54
            width: 32
            height: 32
            antialiasing: true
            fillMode: Image.PreserveAspectFit
            source: "qrc:/pics/ledButton.png"
            property bool selected: false
            property int intID: 5
            property int value: 0
            MouseArea{
                anchors.fill: parent
                onClicked: {
                    if (l5.selected)
                    {
                        BLE.setLED(0x04);
                        l5.selected = false;
                        l5.source = "qrc:/pics/ledButton.png";
                        root.ledsOn--;
                        if ( root.ledsOn == 0)
                            masterRect.checked = false;
                    }
                    else
                    {
                        BLE.setLED(0x84);
                        l5.selected = true;
                        l5.source = "qrc:/pics/ledButtonSelected.png";
                        root.ledsOn++;
                        masterRect.checked = true;
                    }
                }
            }

        }

        Image {
            id: l6
            x: 333
            y: 78
            width: 32
            height: 32
            antialiasing: true
            fillMode: Image.PreserveAspectFit
            source: "qrc:/pics/ledButton.png"
            property bool selected: false
            property int intID: 6
            property int value: 0
            MouseArea{
                anchors.fill: parent
                onClicked: {
                    if (l6.selected)
                    {
                        BLE.setLED(0x05);
                        l6.selected = false;
                        l6.source = "qrc:/pics/ledButton.png";
                        root.ledsOn--;
                        if ( root.ledsOn == 0)
                            masterRect.checked = false;
                    }
                    else
                    {
                        BLE.setLED(0x85);
                        l6.selected = true;
                        l6.source = "qrc:/pics/ledButtonSelected.png";
                        root.ledsOn++;
                        masterRect.checked = true;
                    }
                }
            }

        }

        Image {
            id: l7
            x: 347
            y: 98
            width: 36
            height: 45
            sourceSize.height: 32
            sourceSize.width: 32
            scale: 0.9
            antialiasing: true
            fillMode: Image.PreserveAspectFit
            source: "qrc:/pics/ledButton.png"
            property bool selected: false
            property int intID: 7
            property int value: 0
            MouseArea{
                anchors.fill: parent
                onClicked: {
                    if (l7.selected)
                    {
                        BLE.setLED(0x06);
                        l7.selected = false;
                        l7.source = "qrc:/pics/ledButton.png";
                        root.ledsOn--;
                        if ( root.ledsOn == 0)
                            masterRect.checked = false;
                    }
                    else
                    {
                        BLE.setLED(0x86);
                        l7.selected = true;
                        l7.source = "qrc:/pics/ledButtonSelected.png";
                        root.ledsOn++;
                        masterRect.checked = true;
                    }
                }
            }

        }

        Image {
            id: l8
            x: 360
            y: 136
            width: 32
            height: 32
            antialiasing: true
            fillMode: Image.PreserveAspectFit
            source: "qrc:/pics/ledButton.png"
            property bool selected: false
            property int intID: 8
            property int value: 0
            MouseArea{
                anchors.fill: parent
                onClicked: {
                    if (l8.selected)
                    {
                        BLE.setLED(0x07);
                        l8.selected = false;
                        l8.source = "qrc:/pics/ledButton.png";
                        root.ledsOn--;
                        if ( root.ledsOn == 0)
                            masterRect.checked = false;
                    }
                    else
                    {
                        BLE.setLED(0x87);
                        l8.selected = true;
                        l8.source = "qrc:/pics/ledButtonSelected.png";
                        root.ledsOn++;
                        masterRect.checked = true;
                    }
                }
            }

        }

        Image {
            id: l9
            x: 365
            y: 167
            width: 32
            height: 32
            antialiasing: true
            fillMode: Image.PreserveAspectFit
            source: "qrc:/pics/ledButton.png"
            property bool selected: false
            property int intID: 9
            property int value: 0
            MouseArea{
                anchors.fill: parent
                onClicked: {
                    if (l9.selected)
                    {
                        BLE.setLED(0x08);
                        l9.selected = false;
                        l9.source = "qrc:/pics/ledButton.png";
                        root.ledsOn--;
                        if ( root.ledsOn == 0)
                            masterRect.checked = false;
                    }
                    else
                    {
                        BLE.setLED(0x88);
                        l9.selected = true;
                        l9.source = "qrc:/pics/ledButtonSelected.png";
                        root.ledsOn++;
                        masterRect.checked = true;
                    }
                }
            }

        }

        Image {
            id: l10
            x: 366
            y: 199
            width: 32
            height: 32
            antialiasing: true
            fillMode: Image.PreserveAspectFit
            source: "qrc:/pics/ledButton.png"
            property bool selected: false
            property int intID: 10
            property int value: 0
            MouseArea{
                anchors.fill: parent
                onClicked: {
                    if (l10.selected)
                    {
                        BLE.setLED(0x09);
                        l10.selected = false;
                        l10.source = "qrc:/pics/ledButton.png";
                        root.ledsOn--;
                        if ( root.ledsOn == 0)
                            masterRect.checked = false;
                    }
                    else
                    {
                        BLE.setLED(0x89);
                        l10.selected = true;
                        l10.source = "qrc:/pics/ledButtonSelected.png";
                        root.ledsOn++;
                        masterRect.checked = true;
                    }
                }
            }

        }

        Image {
            id: l11
            x: 361
            y: 231
            width: 32
            height: 32
            fillMode: Image.PreserveAspectFit
            source: "qrc:/pics/ledButton.png"
            property bool selected: false
            property int intID: 11
            property int value: 0
            MouseArea{
                anchors.fill: parent
                onClicked: {
                    if (l11.selected)
                    {
                        BLE.setLED(0x0a);
                        l11.selected = false;
                        l11.source = "qrc:/pics/ledButton.png";
                        root.ledsOn--;
                        if ( root.ledsOn == 0)
                            masterRect.checked = false;
                    }
                    else
                    {
                        BLE.setLED(0x8a);
                        l11.selected = true;
                        l11.source = "qrc:/pics/ledButtonSelected.png";
                        root.ledsOn++;
                        masterRect.checked = true;
                    }
                }
            }

        }

        Image {
            id: l12
            x: 350
            y: 260
            width: 32
            height: 32
            fillMode: Image.PreserveAspectFit
            source: "qrc:/pics/ledButton.png"
            property bool selected: false
            property int intID: 12
            property int value: 0
            MouseArea{
                anchors.fill: parent
                onClicked: {
                    if (l12.selected)
                    {
                        BLE.setLED(0x0b);
                        l12.selected = false;
                        l12.source = "qrc:/pics/ledButton.png";
                        if ( root.ledsOn == 0)
                            masterRect.checked = false;
                    }
                    else
                    {
                        BLE.setLED(0x8b);
                        l12.selected = true;
                        l12.source = "qrc:/pics/ledButtonSelected.png";
                        root.ledsOn++;
                        masterRect.checked = true;
                    }
                }
            }

        }

        Image {
            id: l13
            x: 334
            y: 288
            width: 32
            height: 32
            fillMode: Image.PreserveAspectFit
            source: "qrc:/pics/ledButton.png"
            property bool selected: false
            property int intID: 13
            property int value: 0
            MouseArea{
                anchors.fill: parent
                onClicked: {
                    if (l13.selected)
                    {
                        BLE.setLED(0x0c);
                        l13.selected = false;
                        l13.source = "qrc:/pics/ledButton.png";
                        root.ledsOn--;
                        if ( root.ledsOn == 0)
                            masterRect.checked = false;
                    }
                    else
                    {
                        BLE.setLED(0x8c);
                        l13.selected = true;
                        l13.source = "qrc:/pics/ledButtonSelected.png";
                        root.ledsOn++;
                        masterRect.checked = true;
                    }
                }
            }

        }

        Image {
            id: l14
            x: 313
            y: 312
            width: 32
            height: 32
            fillMode: Image.PreserveAspectFit
            source: "qrc:/pics/ledButton.png"
            property bool selected: false
            property int intID: 14
            property int value: 0
            MouseArea{
                anchors.fill: parent
                onClicked: {
                    if (l14.selected)
                    {
                        BLE.setLED(0x0d);
                        l14.selected = false;
                        l14.source = "qrc:/pics/ledButton.png";
                        root.ledsOn--;
                        if ( root.ledsOn == 0)
                            masterRect.checked = false;
                    }
                    else
                    {
                        BLE.setLED(0x8d);
                        l14.selected = true;
                        l14.source = "qrc:/pics/ledButtonSelected.png";
                        root.ledsOn++;
                        masterRect.checked = true;
                    }
                }
            }

        }

        Image {
            id: l15
            x: 290
            y: 333
            width: 32
            height: 32
            fillMode: Image.PreserveAspectFit
            source: "qrc:/pics/ledButton.png"
            property bool selected: false
            property int intID: 15
            property int value: 0
            MouseArea{
                anchors.fill: parent
                onClicked: {
                    if (l15.selected)
                    {
                        BLE.setLED(0x0e);
                        l15.selected = false;
                        l15.source = "qrc:/pics/ledButton.png";
                        root.ledsOn--;
                        if ( root.ledsOn == 0)
                            masterRect.checked = false;
                    }
                    else
                    {
                        BLE.setLED(0x8e);
                        l15.selected = true;
                        l15.source = "qrc:/pics/ledButtonSelected.png";
                        root.ledsOn++;
                        masterRect.checked = true;
                    }
                }
            }

        }

        Image {
            id: l16
            x: 262
            y: 349
            width: 32
            height: 32
            fillMode: Image.PreserveAspectFit
            source: "qrc:/pics/ledButton.png"
            property bool selected: false
            property int intID: 16
            property int value: 0
            MouseArea{
                anchors.fill: parent
                onClicked: {
                    if (l16.selected)
                    {
                        BLE.setLED(0x0f);
                        l16.selected = false;
                        l16.source = "qrc:/pics/ledButton.png";
                        root.ledsOn--;
                        if ( root.ledsOn == 0)
                            masterRect.checked = false;
                    }
                    else
                    {
                        BLE.setLED(0x8f);
                        l16.selected = true;
                        l16.source = "qrc:/pics/ledButtonSelected.png";
                        root.ledsOn++;
                        masterRect.checked = true;
                    }
                }
            }

        }

        Image {
            id: l17
            x: 232
            y: 360
            width: 32
            height: 32
            fillMode: Image.PreserveAspectFit
            source: "qrc:/pics/ledButton.png"
            property bool selected: false
            property int intID: 17
            property int value: 0
            MouseArea{
                anchors.fill: parent
                onClicked: {
                    if (l17.selected)
                    {
                        BLE.setLED(0x10);
                        l17.selected = false;
                        l17.source = "qrc:/pics/ledButton.png";
                        root.ledsOn--;
                        if ( root.ledsOn == 0)
                            masterRect.checked = false;
                    }
                    else
                    {
                        BLE.setLED(0x90);
                        l17.selected = true;
                        l17.source = "qrc:/pics/ledButtonSelected.png";
                        root.ledsOn++;
                        masterRect.checked = true;
                    }
                }
            }

        }

        Image {
            id: l18
            x: 200
            y: 365
            width: 32
            height: 32
            fillMode: Image.PreserveAspectFit
            source: "qrc:/pics/ledButton.png"
            property bool selected: false
            property int intID: 18
            property int value: 0
            MouseArea{
                anchors.fill: parent
                onClicked: {
                    if (l18.selected)
                    {
                        BLE.setLED(0x11);
                        l18.selected = false;
                        l18.source = "qrc:/pics/ledButton.png";
                        root.ledsOn--;
                        if ( root.ledsOn == 0)
                            masterRect.checked = false;
                    }
                    else
                    {
                        BLE.setLED(0x91);
                        l18.selected = true;
                        l18.source = "qrc:/pics/ledButtonSelected.png";
                        root.ledsOn++;
                        masterRect.checked = true;
                    }
                }
            }

        }

        Image {
            id: l19
            x: 169
            y: 366
            width: 32
            height: 32
            fillMode: Image.PreserveAspectFit
            source: "qrc:/pics/ledButton.png"
            property bool selected: false
            property int intID: 19
            property int value: 0
            MouseArea{
                anchors.fill: parent
                onClicked: {
                    if (l19.selected)
                    {
                        BLE.setLED(0x12);
                        l19.selected = false;
                        l19.source = "qrc:/pics/ledButton.png";
                        root.ledsOn--;
                        if ( root.ledsOn == 0)
                            masterRect.checked = false;
                    }
                    else
                    {
                        BLE.setLED(0x92);
                        l19.selected = true;
                        l19.source = "qrc:/pics/ledButtonSelected.png";
                        root.ledsOn++;
                        masterRect.checked = true;
                    }
                }
            }

        }

        Image {
            id: l20
            x: 137
            y: 361
            width: 32
            height: 32
            fillMode: Image.PreserveAspectFit
            source: "qrc:/pics/ledButton.png"
            property bool selected: false
            property int intID: 20
            property int value: 0
            MouseArea{
                anchors.fill: parent
                onClicked: {
                    if (l20.selected)
                    {
                        BLE.setLED(0x13);
                        l20.selected = false;
                        l20.source = "qrc:/pics/ledButton.png";
                        root.ledsOn--;
                        if ( root.ledsOn == 0)
                            masterRect.checked = false;
                    }
                    else
                    {
                        BLE.setLED(0x93);
                        l20.selected = true;
                        l20.source = "qrc:/pics/ledButtonSelected.png";
                        root.ledsOn++;
                        masterRect.checked = true;
                    }
                }
            }

        }

        Image {
            id: l21
            x: 106
            y: 349
            width: 33
            height: 32
            fillMode: Image.PreserveAspectFit
            source: "qrc:/pics/ledButton.png"
            property bool selected: false
            property int intID: 21
            property int value: 0
            MouseArea{
                anchors.fill: parent
                onClicked: {
                    if (l21.selected)
                    {
                        BLE.setLED(0x14);
                        l21.selected = false;
                        l21.source = "qrc:/pics/ledButton.png";
                        root.ledsOn--;
                        if ( root.ledsOn == 0)
                            masterRect.checked = false;
                    }
                    else
                    {
                        BLE.setLED(0x94);
                        l21.selected = true;
                        l21.source = "qrc:/pics/ledButtonSelected.png";
                        root.ledsOn++;
                        masterRect.checked = true;
                    }
                }
            }

        }

        Image {
            id: l22
            x: 79
            y: 334
            width: 32
            height: 32
            fillMode: Image.PreserveAspectFit
            source: "qrc:/pics/ledButton.png"
            property bool selected: false
            property int intID: 22
            property int value: 0
            MouseArea{
                anchors.fill: parent
                onClicked: {
                    if (l22.selected)
                    {
                        BLE.setLED(0x15);
                        l22.selected = false;
                        l22.source = "qrc:/pics/ledButton.png";
                        root.ledsOn--;
                        if ( root.ledsOn == 0)
                            masterRect.checked = false;
                    }
                    else
                    {
                        BLE.setLED(0x95);
                        l22.selected = true;
                        l22.source = "qrc:/pics/ledButtonSelected.png";
                        root.ledsOn++;
                        masterRect.checked = true;
                    }
                }
            }

        }

        Image {
            id: l23
            x: 55
            y: 313
            width: 32
            height: 32
            fillMode: Image.PreserveAspectFit
            source: "qrc:/pics/ledButton.png"
            property bool selected: false
            property int intID: 23
            property int value: 0
            MouseArea{
                anchors.fill: parent
                onClicked: {
                    if (l23.selected)
                    {
                        BLE.setLED(0x16);
                        l23.selected = false;
                        l23.source = "qrc:/pics/ledButton.png";
                        root.ledsOn--;
                        if ( root.ledsOn == 0)
                            masterRect.checked = false;
                    }
                    else
                    {
                        BLE.setLED(0x96);
                        l23.selected = true;
                        l23.source = "qrc:/pics/ledButtonSelected.png";
                        root.ledsOn++;
                        masterRect.checked = true;
                    }
                }
            }

        }

        Image {
            id: l24
            x: 34
            y: 289
            width: 32
            height: 32
            fillMode: Image.PreserveAspectFit
            source: "qrc:/pics/ledButton.png"
            property bool selected: false
            property int intID: 24
            property int value: 0
            MouseArea{
                anchors.fill: parent
                onClicked: {
                    if (l24.selected)
                    {
                        BLE.setLED(0x17);
                        l24.selected = false;
                        l24.source = "qrc:/pics/ledButton.png";
                        root.ledsOn--;
                        if ( root.ledsOn == 0)
                            masterRect.checked = false;
                    }
                    else
                    {
                        BLE.setLED(0x97);
                        l24.selected = true;
                        l24.source = "qrc:/pics/ledButtonSelected.png";
                        root.ledsOn++;
                        masterRect.checked = true;
                    }
                }
            }

        }

        Image {
            id: l25
            x: 19
            y: 262
            width: 32
            height: 32
            fillMode: Image.PreserveAspectFit
            source: "qrc:/pics/ledButton.png"
            property bool selected: false
            property int intID: 25
            property int value: 0
            MouseArea{
                anchors.fill: parent
                onClicked: {
                    if (l25.selected)
                    {
                        BLE.setLED(0x18);
                        l25.selected = false;
                        l25.source = "qrc:/pics/ledButton.png";
                        root.ledsOn--;
                        if ( root.ledsOn == 0)
                            masterRect.checked = false;
                    }
                    else
                    {
                        BLE.setLED(0x98);
                        l25.selected = true;
                        l25.source = "qrc:/pics/ledButtonSelected.png";
                        root.ledsOn++;
                        masterRect.checked = true;
                    }
                }
            }

        }

        Image {
            id: l26
            x: 8
            y: 232
            width: 32
            height: 32
            fillMode: Image.PreserveAspectFit
            source: "qrc:/pics/ledButton.png"
            property bool selected: false
            property int intID: 26
            property int value: 0
            MouseArea{
                anchors.fill: parent
                onClicked: {
                    if (l26.selected)
                    {
                        BLE.setLED(0x19);
                        l26.selected = false;
                        l26.source = "qrc:/pics/ledButton.png";
                        root.ledsOn--;
                        if ( root.ledsOn == 0)
                            masterRect.checked = false;
                    }
                    else
                    {
                        BLE.setLED(0x99);
                        l26.selected = true;
                        l26.source = "qrc:/pics/ledButtonSelected.png";
                        root.ledsOn++;
                        masterRect.checked = true;
                    }
                }
            }

        }

        Image {
            id: l27
            x: 3
            y: 200
            width: 32
            height: 32
            fillMode: Image.PreserveAspectFit
            source: "qrc:/pics/ledButton.png"
            property bool selected: false
            property int intID: 27
            property int value: 0
            MouseArea{
                anchors.fill: parent
                onClicked: {
                    if (l27.selected)
                    {
                        BLE.setLED(0x1a);
                        l27.selected = false;
                        l27.source = "qrc:/pics/ledButton.png";
                        root.ledsOn--;
                        if ( root.ledsOn == 0)
                            masterRect.checked = false;
                    }
                    else
                    {
                        BLE.setLED(0x9a);
                        l27.selected = true;
                        l27.source = "qrc:/pics/ledButtonSelected.png";
                        root.ledsOn++;
                        masterRect.checked = true;
                    }
                }
            }

        }

        Image {
            id: l28
            x: 2
            y: 168
            width: 32
            height: 32
            fillMode: Image.PreserveAspectFit
            source: "qrc:/pics/ledButton.png"
            property bool selected: false
            property int intID: 28
            property int value: 0
            MouseArea{
                anchors.fill: parent
                onClicked: {
                    if (l28.selected)
                    {
                        BLE.setLED(0x1b);
                        l28.selected = false;
                        l28.source = "qrc:/pics/ledButton.png";
                        root.ledsOn--;
                        if ( root.ledsOn == 0)
                            masterRect.checked = false;
                    }
                    else
                    {
                        BLE.setLED(0x9b);
                        l28.selected = true;
                        l28.source = "qrc:/pics/ledButtonSelected.png";
                        root.ledsOn++;
                        masterRect.checked = true;
                    }
                }
            }

        }

        Image {
            id: l29
            x: 7
            y: 137
            width: 32
            height: 32
            fillMode: Image.PreserveAspectFit
            source: "qrc:/pics/ledButton.png"
            property bool selected: false
            property int intID: 29
            property int value: 0
            MouseArea{
                anchors.fill: parent
                onClicked: {
                    if (l29.selected)
                    {
                        BLE.setLED(0x1c);
                        l29.selected = false;
                        l29.source = "qrc:/pics/ledButton.png";
                        root.ledsOn--;
                        if ( root.ledsOn == 0)
                            masterRect.checked = false;
                    }
                    else
                    {
                        BLE.setLED(0x9c);
                        l29.selected = true;
                        l29.source = "qrc:/pics/ledButtonSelected.png";
                        root.ledsOn++;
                        masterRect.checked = true;
                    }
                }
            }

        }

        Image {
            id: l30
            x: 18
            y: 107
            width: 32
            height: 32
            fillMode: Image.PreserveAspectFit
            source: "qrc:/pics/ledButton.png"
            property bool selected: false
            property int intID: 30
            property int value: 0
            MouseArea{
                anchors.fill: parent
                onClicked: {
                    if (l30.selected)
                    {
                        BLE.setLED(0x1d);
                        l30.selected = false;
                        l30.source = "qrc:/pics/ledButton.png";
                        root.ledsOn--;
                        if ( root.ledsOn == 0)
                            masterRect.checked = false;
                    }
                    else
                    {
                        BLE.setLED(0x9d);
                        l30.selected = true;
                        l30.source = "qrc:/pics/ledButtonSelected.png";
                        root.ledsOn++;
                        masterRect.checked = true;
                    }
                }
            }

        }

        Image {
            id: l31
            x: 34
            y: 79
            width: 32
            height: 32
            fillMode: Image.PreserveAspectFit
            source: "qrc:/pics/ledButton.png"
            property bool selected: false
            property int intID: 31
            property int value: 0
            MouseArea{
                anchors.fill: parent
                onClicked: {
                    if (l31.selected)
                    {
                        BLE.setLED(0x1e);
                        l31.selected = false;
                        l31.source = "qrc:/pics/ledButton.png";
                        root.ledsOn--;
                        if ( root.ledsOn == 0)
                            masterRect.checked = false;
                    }
                    else
                    {
                        BLE.setLED(0x9e);
                        l31.selected = true;
                        l31.source = "qrc:/pics/ledButtonSelected.png";
                        root.ledsOn++;
                        masterRect.checked = true;
                    }
                }
            }

        }

        Image {
            id: l32
            x: 55
            y: 56
            width: 32
            height: 32
            fillMode: Image.PreserveAspectFit
            source: "qrc:/pics/ledButton.png"
            property bool selected: false
            property int intID: 32
            property int value: 0
            MouseArea{
                anchors.fill: parent
                onClicked: {
                    if (l32.selected)
                    {
                        BLE.setLED(0x1f);
                        l32.selected = false;
                        l32.source = "qrc:/pics/ledButton.png";
                        root.ledsOn--;
                        if ( root.ledsOn == 0)
                            masterRect.checked = false;
                    }
                    else
                    {
                        BLE.setLED(0x9f);
                        l32.selected = true;
                        l32.source = "qrc:/pics/ledButtonSelected.png";
                        root.ledsOn++;
                        masterRect.checked = true;
                    }
                }
            }

        }

        Image {
            id: l33
            x: 79
            y: 35
            width: 32
            height: 32
            fillMode: Image.PreserveAspectFit
            source: "qrc:/pics/ledButton.png"
            property bool selected: false
            property int intID: 33
            property int value: 0
            MouseArea{
                anchors.fill: parent
                onClicked: {
                    if (l33.selected)
                    {
                        BLE.setLED(0x20);
                        l33.selected = false;
                        l33.source = "qrc:/pics/ledButton.png";
                        root.ledsOn--;
                        if ( root.ledsOn == 0)
                            masterRect.checked = false;
                    }
                    else
                    {
                        BLE.setLED(0xa0);
                        l33.selected = true;
                        l33.source = "qrc:/pics/ledButtonSelected.png";
                        root.ledsOn++;
                        masterRect.checked = true;
                    }
                }
            }

        }

        Image {
            id: l34
            x: 106
            y: 19
            width: 32
            height: 32
            fillMode: Image.PreserveAspectFit
            source: "qrc:/pics/ledButton.png"
            property bool selected: false
            property int intID: 34
            property int value: 0
            MouseArea{
                anchors.fill: parent
                onClicked: {
                    if (l34.selected)
                    {
                        BLE.setLED(0x21);
                        l34.selected = false;
                        l34.source = "qrc:/pics/ledButton.png";
                        root.ledsOn--;
                        if ( root.ledsOn == 0)
                            masterRect.checked = false;
                    }
                    else
                    {
                        BLE.setLED(0xa1);
                        l34.selected = true;
                        l34.source = "qrc:/pics/ledButtonSelected.png";
                        root.ledsOn++;
                        masterRect.checked = true;
                    }
                }
            }

        }

        Image {
            id: l35
            x: 136
            y: 8
            width: 32
            height: 32
            fillMode: Image.PreserveAspectFit
            source: "qrc:/pics/ledButton.png"
            property bool selected: false
            property int intID: 35
            property int value: 0
            MouseArea{
                anchors.fill: parent
                onClicked: {
                    if (l35.selected)
                    {
                        BLE.setLED(0x22);
                        l35.selected = false;
                        l35.source = "qrc:/pics/ledButton.png";
                        root.ledsOn--;
                        if ( root.ledsOn == 0)
                            masterRect.checked = false;
                    }
                    else
                    {
                        BLE.setLED(0xa2);
                        l35.selected = true;
                        l35.source = "qrc:/pics/ledButtonSelected.png";
                        root.ledsOn++;
                        masterRect.checked = true;
                    }
                }
            }

        }

        Image {
            id: l36
            x: 168
            y: 3
            width: 32
            height: 32
            fillMode: Image.PreserveAspectFit
            source: "qrc:/pics/ledButton.png"
            property bool selected: false
            property int intID: 36
            property int value: 0
            MouseArea{
                anchors.fill: parent
                onClicked: {
                    if (l36.selected)
                    {
                        BLE.setLED(0x23);
                        l36.selected = false;
                        l36.source = "qrc:/pics/ledButton.png";
                        root.ledsOn--;
                        masterRect.checked = true;
                        if ( root.ledsOn == 0)
                            masterRect.checked = false;
                    }
                    else
                    {
                        BLE.setLED(0xa3);
                        l36.selected = true;
                        l36.source = "qrc:/pics/ledButtonSelected.png";
                        root.ledsOn++;
                        masterRect.checked = true;
                    }
                }
            }

        }
    }
}


/* This images helped us position the LEDS in a circular fashion
        Image {
            id: skeleton
            property int scaleFactor: 20
            property int sliderSize: maximumWidth/scaleFactor
            z: 0
            rotation: 360
            anchors.rightMargin: 0
            anchors.bottomMargin: 0
            anchors.leftMargin: 0
            anchors.topMargin: 0
            visible: true
            fillMode: Image.PreserveAspectFit
            source: "qrc:/pics/LEDlayoutSMALL.png"
            anchors.fill: parent
            sourceSize.height: 900
            sourceSize.width: 900
        }
    Image {
        id: root
        property int scaleFactor: 20
        property int sliderSize: maximumWidth/scaleFactor
        rotation: 270
        anchors.rightMargin: 0
        anchors.bottomMargin: 0
        anchors.leftMargin: 0
        anchors.topMargin: 0
        visible: false
        fillMode: Image.PreserveAspectFit
        source: "qrc:/pics/LEDlayoutSMALL.png"
        anchors.fill: parent
        sourceSize.height: 900
        sourceSize.width: 900
    }
*/
