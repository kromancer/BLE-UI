import QtQuick 2.5
import QtQuick.Controls 1.4
import QtKnobs 1.0

ApplicationWindow {
    id: myWindow
    title: "Sandvik VAQ System"

    minimumWidth: 634
    minimumHeight: 482

    PanelCamera {
        id: cameraPanel;
        anchors.fill: parent

        iconScale: 0.7
        ribbonHeight: height / 11

        onMinimized: {
            myWindow.width   = 634
            myWindow.height  = 482
        }

        onMaximized: {
            myWindow.width  = 1268
            myWindow.height = 964
        }

        Component.onCompleted: {
            stagePanelComponent = Qt.createComponent("PanelStage.qml");
            stagePanelWindow    = stagePanelComponent.createObject(myWindow);

            ledPanelComponent = Qt.createComponent("PanelLED.qml");
            ledPanelWindow    = ledPanelComponent.createObject(myWindow);

            myWindow.visible = true
        }


    }
}




/*
        StagePanel  {
            id: stagePanel
            anchors.top: cameraPanel.bottom
            anchors.bottom: universe.bottom
        }
*/










// Graveyard of, potentially usefull for debugging, code.


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

VideoOutput {
        id: videoOutput
        source: player
        anchors.fill: parent
}
*/


/*

//////////////////////////////////////////////////////
*/

