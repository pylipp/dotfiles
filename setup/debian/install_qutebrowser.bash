#!/bin/bash

set -e

QUTEBROWSER_VERSION=v1.8.0

_install() {
    pipx install tox
    if python -m platform | grep -qi xenial; then
        # Additional packages for Ubuntu 16.04
        sudo apt-get install --yes libglib2.0-0 libgl1 libfontconfig1 libx11-xcb1 libxi6 libxrender1 libdbus-1-3
    else
        printf 'Assuming Debian 9 (stretch)...\n' >&2
    fi

    git clone https://github.com/qutebrowser/qutebrowser
    cd qutebrowser
    git checkout $QUTEBROWSER_VERSION
    tox -v -e mkvenv-pypi

    # generate docs
    # https://qutebrowser.org/INSTALL.html#_additional_hints
    sudo apt install -y --no-install-recommends asciidoc source-highlight
    python3 scripts/asciidoc2html.py

    ln -s ~/.files/qutebrowser_config.py ~/.config/qutebrowser/config.py

    # make x-www-browser call qutebrowser
    sudo update-alternatives --install /usr/bin/x-www-browser x-www-browser ~/.files/bin/qutebrowser 200
    update-alternatives --config x-www-browser

    # to make thunderbird open links in qutebrowser, edit ~/.thunderbird/<profile>.default/prefs.js
    # the network.protocol-handler.warn-external.* entries require the value 'true'
    # also delete ~/.thunderbird/<profile>.default/mimeTypes.rdf
    # then thunderbird asks for a new default application to open links etc.
    # see also: http://kb.mozillazine.org/Setting_Your_Default_Browser#Setting_the_browser_that_opens_in_Thunderbird_-_Linux
}

main() {
    mkdir -p ~/software
    cd ~/software

    if [[ $1 = "install" ]]; then
        _install
    elif [[ "$1" = "update" ]]; then
        cd qutebrowser
        git fetch
        git checkout $QUTEBROWSER_VERSION
        tox -v -r -e mkvenv-pypi
        python3 scripts/asciidoc2html.py
    elif [[ "$1" = "remove" ]]; then
        rm -rfv qutebrowser
    else
        echo "No or incorrect command given: $*"
        echo "Select one of: install | update | remove"
    fi
}

main "$@"
