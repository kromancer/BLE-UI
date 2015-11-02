# UI
The GUI, the famous and notorious GUI

GUI for communicating with the bluetooth devices and the camera
=========

BLE demo
--------
Connects to the sensors tag and lights a led by writing to it.

Camera demo
--------
Currently it just connects to a remote host and fetches a sample video just to see if it worked.
Needs the Gstreamer ffmpeg decoder do properly show the video which can be fetched on ubuntu by running the commands:


```
sudo add-apt-repository ppa:mc3man/gstffmpeg-keep
sudo apt-get update
sudo apt-get install gstreamer0.10-ffmpeg
```

NOTE: It seems the audio and video is really out of sync so the player shows a dark screen with some audio for the first 20 seconds before the video start which isn't great but can be looked at when we start integrating. Right now it's just to demonstrate that we can get some video.
