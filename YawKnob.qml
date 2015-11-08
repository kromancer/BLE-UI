import QtQuick 2.3

Rectangle
  {
      //Knob coordinates
      property int knobCenterX: width/2
      property int knobCenterY: height/2

      //Knob Image scaling
      property real knobScale: .8

      //Knob background pad
      property int knobBgPad: 4

      //Indicator's starting position
      property int startRotation: 0

      //How many degrees per radian & radians per revolution
      property real degreesPerRadian : 180.0/Math.PI
      property real radiansPerRev : 2 * Math.PI

      //Maximum and minimum value
      property real maxValue: 359
      property real minValue: 0
      property real incrementPerDeg : 1
      property real totalAngle : 360



      //Old value and current value
      property real oldValue : minValue
      property real currentValue : minValue


      function getEventAngle(event)
      {
          // Rather complicated section...
          // X axis symmetry transformation
          var x =  event.x - knobCenterX
          var y =-(event.y - knobCenterY)
          // Rotate the point by 270 degrees counter clockwise
          var x_ =  y
          var y_ = -x

          var angle = Math.atan2(y_,x_);
          if(angle < 0) angle += radiansPerRev; // add 2*PI to make the angle range from 0 to 2*PI

          /*
          print("*******************************")
          print("Knob center coordinates: ", knobCenterX, knobCenterY)
          print("Event coordinates: ", event.x, event.y)
          print("Event coordinates relative to knobCenter: ", x, y)
          print("Event coordinates rotated by 270 cc: ", x_, y_)
          */
          return angle;
      }

      function getValueFromAngle(angle)
      {
          var result = angle //* incrementPerDeg + midValue
          return result.toFixed(0)
      }

      function handleKnobMove(mouseEvent)
      {
          var angle_rad = getEventAngle(mouseEvent)
          var angle_deg = angle_rad * degreesPerRadian

          var new_value = getValueFromAngle(angle_deg)

          //to be used
          var delta = Math.abs(new_value - oldValue)

          currentValue = new_value
          knobImageId.rotation = -angle_deg//positive for this function means clockwise
          oldValue = new_value
          print("Radians: ", angle_rad.toFixed(2),"Degrees: ", angle_deg.toFixed(0))
      }

      id: knobBgId
      width : knobImageId.width * knobScale + knobBgPad
      height : width
      radius : width/2
      color: "gainsboro"
      anchors.horizontalCenter: parent.horizontalCenter
      Image{
          id: knobImageId
          source: "pics/knob4.png"
          scale: knobScale
          rotation: startRotation
          anchors.centerIn: parent
      }
      MouseArea{
          anchors.fill: parent
          hoverEnabled: true
          onMouseXChanged: if (pressedButtons === Qt.LeftButton) handleKnobMove(mouse)
          onMouseYChanged: if (pressedButtons === Qt.LeftButton) handleKnobMove(mouse)
          //onHoveredChanged: knobImageId.opacity = containsMouse ?  hoverOpacity :  1.0
      }
  }
