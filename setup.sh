#/usr/bin/zsh 

cd ~
git clone git@github.com:pylipp/dotfiles.git 

mv -r dotfiles .files
DOTFLS="~/.files/"

cd ~
ln -s "$DOTFLS".vimrc .vimrc
ln -s "$DOTFLS".vim .vim
ln -s "$DOTFLS".ycm_conf_extra.py .ycm_conf_extra.py
ln -s "$DOTFLS".gitconfig .gitconfig
ln -s "$DOTFLS".gitignore_global .gitignore_global
ln -s "$DOTFLS"gitstatus.py gitstatus.py

mkdir -p ~/.config/git-cola/
cd ~/.config/git-cola 
ln -s "$DOTFLS"git-cola-settings settings
