#!/bin/sh

# /etc/X11/xinit/xinitrc
#
# global xinitrc file, used by all X sessions started by xinit (startx)

# invoke global X session script
# . /etc/X11/Xsession

# map Escape key to Capslock
setxkbmap -option caps:escape

xrdb -load ~/.Xresources

exec /usr/bin/i3
