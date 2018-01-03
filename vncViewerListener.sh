#!/bin/bash
while true; do	
	if ps aux | grep vncviewer | grep -v grep | grep -v terminator ; then
  		VNC_STATUS="running"
	else
   		VNC_STATUS="notrunning"
		vncviewer 192.168.0.2:5900 -fullscreen -encodings "tight copyrect"
	fi
done 
