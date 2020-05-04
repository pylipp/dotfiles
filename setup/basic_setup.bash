#!/bin/bash

if [[ ! -z $TMUX ]]; then
    # Don't run inside tmux or plugin installation will fail
    echo "Please quit tmux!" >&2
    exit 1
fi

set -e

# Bootstrap sdd
git clone https://github.com/pylipp/sdd /tmp/sdd
cd /tmp/sdd
./bootstrap.sh
mkdir -p ~/.config/sdd
ln -s ~/.files/sdd_apps ~/.config/sdd/apps
cd -

# Check for sudo rights of current user
if groups $USER | grep -q sudo; then
    # Assume Debian-based distro
    sudo apt-get update && sudo apt-get upgrade -y
    sudo apt-get install -y wget git zsh gcc g++ make vim python3-venv
fi

rm -f ~/.vimrc ~/.vim
ln -s ~/.files/vimrc ~/.vimrc
ln -s ~/.files/vim ~/.vim
vim +qa

systems=(aspire)
if printf '%s\n' "${systems[@]}" | grep -q -P "$(hostname)"; then
    vim +PlugInstall +qa < /dev/tty

    command -v wget bash 2>&1 || { echo "sdd dependencies not installed"; exit 1; }
    sdd install $(xargs < ~/.files/systems/"$(hostname)"/sdd.txt)
else
    echo "Unknown system..."
    echo "Skipping installation of vim plugins, sdd apps, and pipx apps"
    # sdd install bat delta diff-so-fancy direnv fd fzf hub jq pipx=0.15.1.3 ripgrep shellcheck symlinks tmux
fi

# pipx install docker-compose qr-filetransfer==2.7 tox==3.14.0 watson==1.8.0 financeager==0.23.1.0 git+https://github.com/pylipp/virtualenvwrapper@96ecc8afe3d9fb059bf16babbe16a7af1dc4dd3c

echo "Set up .files/global_gituser!"
