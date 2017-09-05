#!/bin/sh

# from /etc/X11/xinit/xinitrc
# invoke global X session script
# . /etc/X11/Xsession

[ -f ~/.xprofile ] && . ~/.xprofile

exec /usr/bin/i3
