#!/bin/sh

export GTK_IM_MODULE=fcitx
export GTK_IM_MODULE=xim
export QT_IM_MODULE=fcitx
export XMODIFIERS=@im=fcitx

/usr/bin/pipewire &s
/usr/bin/pipewire-pulse &
##/usr/bin/wireplumber &

fcitx &
##picom &
sxhkd &
flameshot &
copyq &
#xsetroot -name "The Purpose is Always You!!! ;)" &
#slstatus &
#wal -r &
feh --bg-scale /home/marks/Pictures/MarkWalls/thinkpad.jpg
#while true; do
#    dwm >/dev/null 2>&1
#done

#exec dbus-run-session dwm
exec qtile start
#exec awesome 
