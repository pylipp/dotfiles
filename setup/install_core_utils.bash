#! /bin/bash

# Installation script for core tools

set -e

install_packages() {
    sudo apt-get install --yes "$@"
}

main() {
    # development utilities
    install_packages cmake build-essential
    # workflow
    install_packages tig
    # system utilities
    install_packages network-manager lm-sensors htop
    # sound support
    install_packages pulseaudio libasound2-dev alsa-utils
    # base utilities
    install_packages curl gawk zip unzip
}

main "$@"
