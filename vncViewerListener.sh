#!/bin/bash

Help()
{
   # Display Help
   echo
   echo "Syntax: vncViewerListener.sh <ip address to listen> "
   echo "options:"
   echo "h     Print this Help."
   echo
}

while getopts ":h" option; do
   case $option in
      h) # display Help
         Help
         exit;;
	  help) # display Help
	     Help
         exit;;
     \?) # incorrect option
         echo "Error: Invalid option"
         exit;;
   esac
done

while true; do
	if [[ -z "$1"]]; then
		Help
         exit;;
	fi	
	if ps aux | grep vncviewer | grep -v grep | grep -v terminator ; then
  		VNC_STATUS="running"
	else
   		VNC_STATUS="notrunning"
		vncviewer $1:5900 -fullscreen -encodings "tight copyrect"
	fi
done 
