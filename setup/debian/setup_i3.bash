#! /bin/bash

# Installation script for i3 and X-server tools

set -e

main() {
    sudo apt-get install --yes --no-install-recommends i3 i3lock xss-lock xorg xinit feh arandr dunst xclip scrot zathura

    sdd install keyboard st

    # make zathura default application to open pdfs using xdg-open
    xdg-mime default zathura.desktop application/pdf
}

main "$@"
