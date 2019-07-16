#!/bin/bash

if [[ ! -z $TMUX ]]; then
    # Don't run inside tmux or plugin installation will fail
    echo "Please quit tmux!" >&2
    exit 1
fi

# Check for sudo rights of current user
if groups $USER | grep -q sudo; then
    # Assume Debian-based distro
    sudo apt-get update && sudo apt-get upgrade -y
    sudo apt-get install wget git zsh gcc g++ make xclip vim python3-venv
fi

set -e

cd

ln -s ~/.files/vimrc .vimrc
ln -s ~/.files/vim .vim
vim +qa
vim +PlugInstall < /dev/tty

sdd install oh-my-zsh tmux pip direnv symlinks fzf keyboard st
sdd install watson=aa901567c5aa6129ff6dae799eddbfb0be06cb65

echo "Set up .files/global_gituser!"
