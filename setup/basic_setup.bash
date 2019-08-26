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
# vim +PlugInstall +qa < /dev/tty

sdd install pip direnv symlinks fzf
sdd install watson=1.7.0
# sdd install oh-my-zsh tmux

echo "Set up .files/global_gituser!"
