import QtQuick 2.0

MouseArea {
    anchors.fill: parent
    enabled: !readOnly

    function calculateValue(x,y) {
        var dx = (x - parent.height/2)
        var dy = (y - parent.width/2)
        if(mode===10)
            value = chunk.endValueFromPoint(dx,dy)
        else
            percent = chunk.endValueFromPoint(dx,dy)
    }

    onClicked: calculateValue(mouseX,mouseY)
    //onPositionChanged: calculateValue(mouseX,mouseY)
}
