#/usr/bin/zsh 

cd ~
git clone git@github.com:pylipp/dotfiles.git .files

DOTFLS="~/.files/"

cd ~
ln -s "$DOTFLS".vimrc .vimrc
ln -s "$DOTFLS".vim .vim
ln -s "$DOTFLS".ycm_conf_extra.py .ycm_conf_extra.py
ln -s "$DOTFLS".gitconfig .gitconfig
ln -s "$DOTFLS".gitignore_global .gitignore_global
ln -s "$DOTFLS"gitstatus.py gitstatus.py

# Vim bundle manager
mkdir -p .files/.vim/bundle
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
vim +PluginInstall +qall

cd ~/.vim/bundle/YouCompleteMe
./install.py --clang-completer

mkdir -p ~/.config/git-cola/
cd ~/.config/git-cola 
ln -s "$DOTFLS"git-cola-settings settings
