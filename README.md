# VirtualVncScreen
Create a remote monitor via VNC (x11vnc)

This scriipt is an automatization of an virtual vnc connected monitor.

Use scenario:
* Use other device monitor as your main machine monitor


#### My use case:

I have a Raspberry pi (Rpi) with a monitor connected to it and my laptop and an hdmi monitor connected to it, on my laptop I run ``virtualVncScreen.sh`` this is the vnc server connected to virtual monitor created via `xrandr`. And on my Rpi, I run `vncViewerListener.sh` and pass as argument the ip I want to listen. I also added to autostart those scripts, so when machines reboots both still runniing propperly.

### Install and config
___

This script require xrandr and x11vnc for running properly,

```bash
sudo apt install xrandr x11vnc
```
And I'm using xtightvncviewer to connect to x11vnc server (with virtual monitor)

```bash
sudo apt install xtightvncviewer
```

1) Check if virtual monitor is enabled `xrandr --verbose`
```
eDP1 connected primary 

...

HDMI1 disconnected

...

VIRTUAL1 connected (normal left inverted right x axis y axis)
        Identifier: 0x46
        Timestamp:  3213300
        Subpixel:   no subpixels
        Clones:     VIRTUAL2
        CRTCs:      3 4
        Transform:  1.000000 0.000000 0.000000
                    0.000000 1.000000 0.000000
                    0.000000 0.000000 1.000000
                   filter: 
        non-desktop: 0 
                supported: 0, 1
  1440x900_60.00 (0x1cc) 104.580MHz -HSync +VSync
        h: width  1440 start 1520 end 1672 total 1904 skew    0 clock  54.93KHz
        v: height  900 start  901 end  904 total  931           clock  59.00Hz
VIRTUAL2 disconnected (normal left inverted right x axis y axis)
        Identifier: 0x47
        Timestamp:  3213300
        Subpixel:   no subpixels
        Clones:     VIRTUAL1
        CRTCs:      3 4
        Transform:  1.000000 0.000000 0.000000
                    0.000000 1.000000 0.000000
                    0.000000 0.000000 1.000000
                   filter: 
        non-desktop: 0 
                supported: 0, 1

```
>If you don't have `VIRTUAL1` and `VIRTUAL2` check [This topic](https://unix.stackexchange.com/questions/378373/add-virtual-output-to-xorg)

2) Some changes may bee required to `virtualVncScreen.sh`, you may need to modify the screen resolution in my case is 1440x900 wiith 60 refresh rate.
```bash
function initVirtualSamsungMonitor {
	gtf 1440 900 60
	xrandr --newmode "1440x900_60.00"  104.58  1440 1520 1672 1904  900 901 904 931  -HSync +Vsync
	xrandr --addmode VIRTUAL1 1440x900_60.00
	xrandr --output VIRTUAL1 --mode 1440x900_60.00 --pos 0x540 --output HDMI1 --pos 1440x0
	xrandr --verbose
}
```
>Change all the `--mode <your_new_mode_name>` everywhere

