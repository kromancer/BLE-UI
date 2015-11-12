import QtQuick 2.3

Rectangle
  {
      anchors.fill: parent

      //Knob coordinates
      property int knobCenterX: knobImageId.x + knobImageId.width/2
      property int knobCenterY: knobImageId.y + knobImageId.height/2

      //Knob Image scaling
      property real knobScale: .8

      //Indicator's starting position
      property int startRotation: 0

      //How many degrees per radian & radians per revolution
      property real degreesPerRadian : 180.0/Math.PI
      property real radiansPerRev : 2 * Math.PI

      //Resolution of Yaw Knob
      property real resolutionDegrees: 1.8


      //Old value and current value
      property real oldValue : 0
      property int currentValue : 0


      onCurrentValueChanged: VAQ.setYaw(currentValue)

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
      }

      //***********************************************************
      // Functionality Section
      //***********************************************************

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

          // Some Debugging Info
          print("*******************************")
          print("Knob center coordinates: ", knobCenterX, knobCenterY)
          print("Event coordinates: ", event.x, event.y)
          print("Event coordinates relative to knobCenter: ", x, y)
          print("Event coordinates rotated by 270 cc: ", x_, y_)

          return angle;
      }

      function handleKnobMove(mouseEvent)
      {
          var angle_rad = getEventAngle(mouseEvent)
          var angle_deg = angle_rad * degreesPerRadian
          var delta = Math.abs(angle_deg - oldValue)

          if (delta >= resolutionDegrees)
          {
            currentValue = Math.floor(angle_deg / resolutionDegrees)

            oldValue = currentValue * 1.8

            knobImageId.rotation = -oldValue
          }
      }
  }
