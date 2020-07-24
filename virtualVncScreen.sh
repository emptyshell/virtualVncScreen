#!/bin/bash
### BEGIN INFO
# Short-Description: Creating VNC virtual screen.
# Description:       Creating virtual x11vnc server to a virtual monitor that can be connected with a remote viewer(monitor)
### END INFO

VNC_SERVER=1

#creating the virtual screen with size 1440x900(in my case, u can change the size to your screen)
function initVirtualSamsungMonitor {
	gtf 1440 900 60
	xrandr --newmode "1440x900_60.00"  104.58  1440 1520 1672 1904  900 901 904 931  -HSync +Vsync
	xrandr --addmode VIRTUAL1 1440x900_60.00
	xrandr --output VIRTUAL1 --mode 1440x900_60.00 --pos 0x540 --output HDMI1 --pos 1440x0
	xrandr --verbose
}

echo "Initializating the virtual monitor"
initVirtualSamsungMonitor
	
while [[ $VNC_SERVER=1 ]]; do
	#hdmi status in case if hdmi connected (make sure to choose the right card)
	if [[ "$(cat /sys/class/drm/card0-HDMI-A-1/status)" != "disconnected" ]]; then
		if ps aux | grep x11vnc | grep -v grep | grep -v terminator ; then
			echo "vnc running"
		else
			xrandr --output VIRTUAL1 --mode 1440x900_60.00 --pos 0x540 --output HDMI1 --pos 1440x0
			echo "vnc not running"
			x11vnc -auth /var/lib/sddm/* -viewonly -clip xinerama0 -bg -noxdamage -modtweak
		fi
	else
		echo "HDMI disconnected"
		x11vnc -R stop
		xrandr --output VIRTUAL1 --off
	fi
	sleep 15s
done