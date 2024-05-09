#!/bin/sh

export GTK_IM_MODULE=fcitx
export GTK_IM_MODULE=xim
export QT_IM_MODULE=fcitx
export XMODIFIERS=@im=fcitx

/usr/bin/pipewire &
/usr/bin/pipewire-pulse &
##/usr/bin/wireplumber &

fcitx &
##picom &
sxhkd &
#xsetroot -name "The Purpose is Always You!!! ;)" &
slstatus &
wal -r &
feh --bg-scale /home/marks/Pictures/MarkWalls/artistswall.png
while true; do
    dwm >/dev/null 2>&1
done

#exec dbus-run-session dwm

#qtile start
#exec awesome 
