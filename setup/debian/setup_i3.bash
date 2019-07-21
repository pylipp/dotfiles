#! /bin/bash

# Installation script for i3 and tools (dunst, i3lock-color, bumblebee-status)
# Installation location: /usr and ~/software
# Requires: - git
#           - make
#           - curl
#           - bash

set -e

source $(dirname "$0")/utils.bash

main() {
    local method=${1:-global}

    if [[ $method = "global" ]]; then
        echo_install_info i3

        install_packages i3 i3lock xautolock xorg xinit feh scrot imagemagick arandr dunst
    elif [[ $method = "local" ]]; then
        echo_warn "Sorry, local i3 installation is not possible."
    else
        echo_error "Unknown method '$method'!"
        exit 1
    fi
}

main "$@"
