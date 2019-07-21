#! /bin/bash

# Installation script for core tools
# Installation location: /usr and ~/
# Requires: - git

set -e

source $(dirname "$0")/utils.bash

main() {
    local method=${1:-global}

    if [[ $method = "global" ]]; then
        echo_install_info "core utils"

        # development utilities
        install_packages \
            cmake build-essential doxygen graphviz python-dev exuberant-ctags
        # workflow
        install_packages tig silversearcher-ag xclip
        # system utilities
        install_packages network-manager lm-sensors htop
        # libraries
        install_packages libxml2-dev libxslt-dev libxml2-utils libxcb-composite0-dev
        # sound support
        install_packages pulseaudio libasound2-dev alsa-utils
        # base utilities
        install_packages wget curl gawk scrot zip unzip 

        # make zathura default application to open pdfs using xdg-open
        xdg-mime default zathura.desktop application/pdf

    elif [[ $method = "local" ]]; then
        echo_warn "Sorry, local core utils installation is not possible."
    else
        echo_error "Unknown method '$method'!"
        exit 1
    fi
}

main "$@"
