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

# Unmute ALSA
echo "========"
echo "Unmuting ALSA"
echo "========"
amixer -c 0 set Master playback 100% unmute

# Start Firefox with current resolution
export DISPLAY=:0
# Set screen size to be highest possible resolution
resx=$(cat /var/lib/docker/config | jq '.resx')
resy=$(cat /var/lib/docker/config | jq '.resy')
xrandr -s ${resx}x${resy}
X=$(xrandr --current | grep '*' | uniq | awk '{print $1}' | cut -d 'x' -f1)
echo $X
Y=$(xrandr --current | grep '*' | uniq | awk '{print $1}' | cut -d 'x' -f2)
echo $Y
firefox -width $X -height $Y --kiosk --private-window `cat /var/lib/docker/config | jq -r '.url'`
