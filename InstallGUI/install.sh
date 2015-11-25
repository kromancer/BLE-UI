#! /bin/bash

# Fly Capture Installation
apt-get install libraw1394-11 libgtkmm-2.4-1c2a libglademm-2.4-1c2a libgtkglextmm-x11-1.2-dev libgtkglextmm-x11-1.2 libusb-1.0-0
./flycapture2/install_flycapture.sh

# Qt installation
chmod +x qt-unified-linux-x64-2.0.2-2-online.run
./qt-unified-linux-x64-2.0.2-2-online.run
