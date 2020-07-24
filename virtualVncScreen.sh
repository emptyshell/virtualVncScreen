#!/bin/bash
### BEGIN INFO
# Short-Description: Creating VNC virtual screen.
# Description:       Creating virtual x11vnc server to a virtual monitor that can be connected with a remote viewer(monitor)
### END INFO

#hdmi status in case if hdmi connected (make sure to choose the right card)
HDMI_STATUS="$(cat /sys/class/drm/card0-HDMI-A-1/status)"
TRIGER=0
VNC_SERVER=1

#creating the virtual screen with size 1440x900(in my case, u can change the size to your screen)
function initVirtualSamsungMonitor {
	gtf 1440 900 60
	xrandr --newmode "1440x900_60.00"  104.58  1440 1520 1672 1904  900 901 904 931  -HSync +Vsync
	xrandr --addmode VIRTUAL1 1440x900_60.00
	if [[ $HDMI_STATUS = connected ]]; then 
		xrandr --output VIRTUAL1 --mode 1440x900_60.00 --pos 0x540 --output HDMI1 --pos 1440x0
	fi
	xrandr --verbose
}

function compare {
	if [[ "${HDMI_STATUS}" != "$(cat /sys/class/drm/card0-HDMI-A-1/status)" ]]; then
		x11vnc -R stop
		HDMI_STATUS="$(cat /sys/class/drm/card0-HDMI-A-1/status)"
		TRIGER=0
	else
		TRIGER=5m		
	fi
	
}

echo "Initializating the virtual monitor"
initVirtualSamsungMonitor
	
	
	
	while [[ $VNC_SERVER=1 ]]; do
		if ps aux | grep x11vnc | grep -v grep | grep -v terminator ; then
  			VNC_STATUS="running"
  			compare
		else
   			VNC_STATUS="notrunning"
   			x11vnc -auth /var/lib/gdm/:0.Xauth -viewonly -clip xinerama0 -bg -xkb -noxrecord -noxfixes -noxdamage -modtweak
			TRIGER=5m
		fi
		sleep $TRIGER
	done