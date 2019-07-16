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
cd

# Check for sudo rights of current user
if groups $USER | grep -q sudo; then
    # Assume Debian-based distro
    sudo apt-get update && sudo apt-get upgrade -y
    sudo apt-get install wget git zsh gcc g++ make xclip vim python3-venv
fi

rm -f ~/.vimrc ~/.vim
ln -s ~/.files/vimrc ~/.vimrc
ln -s ~/.files/vim ~/.vim
vim +PlugInstall < /dev/tty

sdd install oh-my-zsh tmux pip direnv symlinks fzf keyboard st
sdd install watson=aa901567c5aa6129ff6dae799eddbfb0be06cb65

echo "Set up .files/global_gituser!"
