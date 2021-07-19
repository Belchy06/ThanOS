#!/bin/sh
# Install X11
echo "========"
echo "Installing X11"
echo "========"
setup-xorg-base
# Configure X11
echo "========"
echo "Configuring X11"
echo "========"
Xorg -configure
cat > disablehotplugging << EOF
Section "ServerFlags"
	Option "AutoAddDevices" "False"
EndSection
EOF
cat disablehotplugging >> /root/xorg.conf.new
# Start X11
echo "========"
echo "Starting X11"
echo "========"
nohup Xorg :0 -config /root/xorg.conf.new -ac > xorg.out < /dev/null &
export DISPLAY=:0

# Unmute ALSA
echo "========"
echo "Unmuting ALSA"
echo "========"
amixer -c 0 set Master playback 100% unmute
# Start Firefox container
# docker run -it --rm -e DISPLAY -v /tmp/.X11-unix:/tmp/.X11-unix -v /dev:/dev --privileged belchy06/firefox:alpine
