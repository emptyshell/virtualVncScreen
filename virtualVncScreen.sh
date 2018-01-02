#!/bin/bash
### BEGIN INIT INFO
# Provides:          virtualVncScreen
# Required-Start:    $remote_fs $syslog
# Required-Stop:     $remote_fs $syslog
# Default-Start:     2 3 4 5
# Default-Stop:      0 1 6
# Short-Description: Creating VNC virtual screen.
# Description:       Creating virtual x11vnc server to a virtual monitor that can be connected with a remote viewer(monitor)
### END INIT INFO

#hdmi status in case if hdmi connected (make sure to choose the right card)
HDMI_STATUS="$(cat /sys/class/drm/card1-HDMI-A-1/status)"

#creating the virtual screen with size 1440x900(in my case, u can change the size to your screen)
function initVirtualSamsungMonitor {
	gtf 1440 900 60
	xrandr --newmode "1440x900_60.00"  104.58  1440 1520 1672 1904  900 901 904 931  -HSync +Vsync
	xrandr --addmode VIRTUAL1 1440x900_60.00
	xrandr --output VIRTUAL1 --mode 1440x900_60.00 --right-of eDP1
}
echo "Initializating the virtual monitor"
initVirtualSamsungMonitor

if [[ "${HDMI_STATUS}" = connected ]]; then
	echo "HDMI connected"
	x11vnc -clip xinerama2
else
	echo "HDMI disconected"
	x11vnc -clip xinerama1
fi