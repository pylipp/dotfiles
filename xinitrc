#!/bin/sh

# /etc/X11/xinit/xinitrc
#
# global xinitrc file, used by all X sessions started by xinit (startx)

# invoke global X session script
# . /etc/X11/Xsession

# load custom keyboard layout or fallback to de(nodeadkeys)
setxkbmap -layout pylipp 2> /dev/null || setxkbmap de -variant nodeadkeys

# swap Escape key and Capslock
setxkbmap -option caps:swapescape

xrdb -load ~/.Xresources

exec /usr/bin/i3
