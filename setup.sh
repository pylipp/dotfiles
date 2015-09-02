#/usr/bin/zsh 

DOTFLS="~/Documents/dotfiles/"

cd ~
ln -s "$DOTFLS".vimrc .vimrc
ln -s "$DOTFLS".vim .vim
ln -s "$DOTFLS".ycm_conf_extra.py .ycm_conf_extra.py

mkdir -p ~/.config/git-cola/
ln "$DOTFLS".git-cola-settings ~/.config/git-cola/settings
