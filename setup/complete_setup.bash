#! /bin/bash

set -e 

method=${1:-global}

if [[ $method = "global" ]]; then
    sudo apt-get update && sudo apt-get upgrade -y
else
    echo_error "Unknown method '$method'!"
    exit 1
fi

sdd install oh-my-zsh tmux pip direnv symlinks fzf keyboard
sdd install watson=aa901567c5aa6129ff6dae799eddbfb0be06cb65

for step in install_core_utils install_vim install_st; do
    bash $HOME/.files/setup/$step.bash $method
done
