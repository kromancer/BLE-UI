//The Qt Quick module provides graphical primitive types
import QtQuick 2.1
//Provide a resolution independent GUI (let scaling be done automatically)
import QtQuick.Layouts 1.1
import QtQuick.Controls 1.3



RowLayout{
    id: universe
    anchors.fill: parent





        ColumnLayout {
            id: translatorySlidersXY
            SliderMOTOR {Layout.preferredWidth: universe.width / 4; Layout.preferredHeight: universe.width/15; label:"X-Axis"; labelSize: 12+universe.width/200}
            SliderMOTOR {Layout.preferredWidth: universe.width / 4; Layout.preferredHeight: universe.width/15; label:"Y-Axis"; labelSize: 12+universe.width/200}
        }
        RowLayout {
            id: translatorySliderZ
            SliderMOTOR {Layout.preferredWidth: universe.width / 4; Layout.preferredHeight: universe.width/15; label:"Z-Axis"; labelSize: 12+universe.width/200}

        }



        Image {
            Layout.preferredWidth: universe.width/5
            Layout.preferredHeight: width
            source: "qrc:/pics/knob.png"
        }



        ColumnLayout {
            id: rotationalSliders
            SliderMOTOR {Layout.preferredWidth: universe.width / 4 ; Layout.preferredHeight: universe.width/15; label:"Yaw"; labelSize: 12+universe.width/200}
            SliderMOTOR {Layout.preferredWidth: universe.width / 4 ; Layout.preferredHeight: universe.width/15; label:"Pitch"; labelSize: 12+universe.width/200}
            SliderMOTOR {Layout.preferredWidth: universe.width / 4 ; Layout.preferredHeight: universe.width/15; label:"Roll"; labelSize: 12+universe.width/200}
        }


 }




