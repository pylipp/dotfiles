## General information

This is a collection of setup scripts, configuration files and notes that I find useful for my daily workflow and my choice of tools and environments. 

## Installation 

When setting up a vanilla system (Debian based, i.e. Ubuntu 14.04 and 16.04 as well as Stretch), I do:
```
sudo apt-get install git
cd $HOME
git clone https://github.com/pylipp/dotfiles .files
cd .files
git submodule update --init --recursive
source setup.sh
install_complete
```

This will install and set up vim, zsh, and some more tools.
