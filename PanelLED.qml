import QtQuick 2.0
import QtQuick.Controls 1.4




ApplicationWindow{
    width: 420
    height: 420
    minimumWidth: 420
    minimumHeight: 420
    maximumWidth: 420
    maximumHeight: 420
    color: "#ffffff"

    title: "LED Ring"


    Rectangle{
        id: root
        width: 400
        height: 400
        color: "#ffffff"
        border.color: "#ffffff"
        border.width: 0
        anchors.centerIn: parent
        signal ledSelected(var ledID)
        property var selectedLEDid: l1
        property bool connected:false

        onLedSelected: {
            selectedLEDid.source = "qrc:/pics/ledButton.png"
            selectedLEDid.selected = false
            selectedLEDid = ledID
            selectedLEDid.source = "qrc:/pics/ledButtonSelected.png"
            selectedLEDid.selected = true
            selectedSlider.value = selectedLEDid.value
        }
        /*
        Image {
            id: root
            property int scaleFactor: 20
            property int sliderSize: maximumWidth/scaleFactor
            antialiasing: true
            z: 0
            rotation: 180
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
        */

        Connections {
            target: BLE
            onLedIsConnected: { root.connected = true }
        }

        Slider {
            id: masterSlider
            x: 95
            y: 249
            width: 214
            height: 46
            updateValueWhileDragging: false
            value: 100
            stepSize: 1
            maximumValue: 100
            orientation: Qt.Horizontal
            onValueChanged: {
                if (root.connected)
                    BLE.setLED(0, masterSlider.value);
            }
        }

        Slider {
            id: selectedSlider
            x: 95
            y: 133
            width: 214
            height: 50
            updateValueWhileDragging: false
            value: 0
            stepSize: 1
            maximumValue: 100
            orientation: Qt.Horizontal
            onValueChanged:
            {
                if (root.connected)
                {
                    if (root.selectedLEDid.value != selectedSlider.value)
                    {
                        BLE.setLED(root.selectedLEDid.intID, value);
                        root.selectedLEDid.value = selectedSlider.value
                    }
                }
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
            source: "qrc:/pics/ledButtonSelected.png"
            property bool selected: true
            property int intID: 1
            property int value: 0
            MouseArea{
                anchors.fill: parent
                onClicked: {
                    if (!l1.selected)
                        root.ledSelected(l1);
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
            property int intID: 2
            property int value: 0
            MouseArea{
                anchors.fill: parent
                onClicked: {
                    if (!l2.selected)
                        root.ledSelected(l2);
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
                    if (!l3.selected)
                        root.ledSelected(l3);
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
                    if (!l4.selected)
                        root.ledSelected(l4);
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
                    if (!l5.selected)
                        root.ledSelected(l5);
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
                    if (!l6.selected)
                        root.ledSelected(l6);
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
                anchors.topMargin: 0
                anchors.fill: parent
                onClicked: {
                    if (!l7.selected)
                        root.ledSelected(l7);
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
                    if (!l8.selected)
                        root.ledSelected(l8);
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
                    if (!l9.selected)
                        root.ledSelected(l9);
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
                    if (!l10.selected)
                        root.ledSelected(l10);
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
                    if (!l11.selected)
                        root.ledSelected(l11);
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
                    if (!l12.selected)
                        root.ledSelected(l12);
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
                    if (!l13.selected)
                        root.ledSelected(l13);
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
                    if (!l14.selected)
                        root.ledSelected(l14);
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
                    if (!l15.selected)
                        root.ledSelected(l15);
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
                    if (!l16.selected)
                        root.ledSelected(l16);
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
                    if (!l17.selected)
                        root.ledSelected(l17);
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
                    if (!l18.selected)
                        root.ledSelected(l18);
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
                    if (!l19.selected)
                        root.ledSelected(l19);
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
                    if (!l20.selected)
                        root.ledSelected(l20);
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
                    if (!l21.selected)
                        root.ledSelected(l21);
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
                    if (!l22.selected)
                        root.ledSelected(l22);
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
                    if (!l23.selected)
                        root.ledSelected(l23);
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
                    if (!l24.selected)
                        root.ledSelected(l24);
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
                    if (!l25.selected)
                        root.ledSelected(l25);
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
                    if (!l26.selected)
                        root.ledSelected(l26);
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
                    if (!l27.selected)
                        root.ledSelected(l27);
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
                    if (!l28.selected)
                        root.ledSelected(l28);
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
                    if (!l29.selected)
                        root.ledSelected(l29);
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
                    if (!l30.selected)
                        root.ledSelected(l30);
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
                    if (!l31.selected)
                        root.ledSelected(l31);
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
                    if (!l32.selected)
                        root.ledSelected(l32);
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
                    if (!l33.selected)
                        root.ledSelected(l33);
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
                    if (!l34.selected)
                        root.ledSelected(l34);
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
                    if (!l35.selected)
                        root.ledSelected(l35);
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
                    if (!l36.selected)
                        root.ledSelected(l36);
                }
            }
        }



        // SLIDER LABELS
        Label {
            id: label1
            x: 110
            y: 93
            text: qsTr("Selected LED level")
            font.bold: true
            font.pointSize: 15
        }

        Label {
            id: label2
            x: 140
            y: 220
            text: qsTr("Master Level")
            font.family: "Ubuntu"
            font.bold: true
            font.pointSize: 15
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
