#!/bin/sh

nm-applet &
blueman-applet &
#redshift -l -6.21462:106.84513 &

/usr/bin/pipewire &
/usr/bin/pipewire-pulse &
#/usr/bin/wireplumber &
~/.fehbg &
fcitx &
flameshot &
copyq &
#copyq &
#/usr/bin/emacs --daemon &
#emacsclient -c -a emacs &
#megasync &
#syncthing 
#mictray &
pasystray &
#dead-notification-center &
#picom &

/usr/local/bin/Obsidian-1.6.5.AppImage &

#picom --experimental-backends & ##& disown
#/usr/lib/xfce-polkit/xfce-polkit & ##& disown # start polkit agent from xfce
#xfsettingsd &
#/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 & disown # start polkit agent from GNOME
