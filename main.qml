//The Qt Quick module provides graphical primitive types
import QtQuick 2.3
//Provide a resolution independent GUI (let scaling be done automatically)
import QtQuick.Layouts 1.1
import QtQuick.Controls 1.3


//The univesral layout of the application
GridLayout{
    id: universe
    columns: 3
    rows: 2

    ColumnLayout {
        id: translatoryKnobs

        SliderTranslatory {Layout.preferredWidth: 300 ; Layout.preferredHeight: 50 ; label:"X-Axis"}
        SliderTranslatory {Layout.preferredWidth: 300 ; Layout.preferredHeight: 50 ; label:"Y-Axis"}
        SliderTranslatory {Layout.preferredWidth: 300 ; Layout.preferredHeight: 50 ; label:"Z-Axis"}
    }

    Rectangle {
        id: to_be_used_sometime_in_the_future_till_then_will_remain_blank
        width: 300
        height: 150

        SliderLED {}




    }

    ColumnLayout {
        id: rotationalKnobs

        SliderTranslatory {Layout.preferredWidth: 300 ; Layout.preferredHeight: 50 ; label:"Yaw"}
        SliderTranslatory {Layout.preferredWidth: 300 ; Layout.preferredHeight: 50 ; label:"Pitch"}
        SliderTranslatory {Layout.preferredWidth: 300 ; Layout.preferredHeight: 50 ; label:"Roll"}
    }

}



