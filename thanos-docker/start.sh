#/bin/sh

setup-xorg-base

Xorg -configure

cat > disablehotplugging << EOF
Section "ServerFlags"
	Option "AutoAddDevices" "False"
EndSection
EOF

export DISPLAY=:0

cat disablehotplugging >> /root/xorg.conf.new

nohup /usr/bin/Xorg :0 -config /root/xorg.conf.new -ac > xorg.stdout 2> xorg.stderr < /dev/null &
