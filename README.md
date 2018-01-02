# virtualVncScreen
Create a remote monitor via VNC (x11vnc)

this script require x11vnc for running properly,

sudo apt install x11vnc gksu

in case of disconnection from the vnc server don't run the script again just ALT+F2 , 
and run the commnad: 

gksu x11vnc -clip xinerama1  #when u don't have any HDMI monitor
gksu x11vnc -clip xinerama2 #when HDMI monitor is connected.

And i'm using xtightvncviewer to connect to x11vnc server (with virtual monitor)

sudo apt install xtightvncviewer