#/usr/bin/zsh 

echo "Installing zsh..."
# https://wiki.ubuntuusers.de/Zsh/
cd ~
sudo apt-get install zsh
wget -O .zshrc http://git.grml.org/f/grml-etc-core/etc/zsh/zshrc
sudo chsh -s /usr/bin/zsh

echo "Installing vim..."
sudo apt-get remove vim vim-runtime gvim
mkdir -p software
cd software 
hg clone https://code.google.com/p/vim/
cd vim 
./configure --with-features=huge --enable-multibyte --enable-rubyinterp --enable-pythoninterp --with-python-config-dir=/usr/lib/python2.7/config --enable-perlinterp --enable-luainterp --enable-gui=gtk2 --enable-cscope --prefix=/usr
make VIMRUNTIMEDIR=/usr/share/vim/vim74
sudo make install
# sudo update-alternatives --install /usr/bin/editor editor /usr/bin/vim 1

echo "Setting up .files..."
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

echo "Installing vim plugins..."
# Vim bundle manager
mkdir -p .files/.vim/bundle
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
vim +PluginInstall +qall

echo "Installing ycm..."
cd ~/.vim/bundle/YouCompleteMe
./install.py --clang-completer
