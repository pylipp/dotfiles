#/usr/bin/zsh

echo "Installing zsh..."
# https://wiki.ubuntuusers.de/Zsh/
cd ~
sudo apt-get install zsh
wget -O .zshrc_original http://git.grml.org/f/grml-etc-core/etc/zsh/zshrc
sudo chsh -s /usr/bin/zsh
sudo apt-get install xclip

echo "Installing ack..."
sudo apt-get install ack-grep

echo "----------------------------------------------------------"
echo "Installing vim..."
# https://github.com/Valloric/YouCompleteMe/wiki/Building-Vim-from-source
mkdir -p ~/software
cd ~/software
if [[ ! -e vim ]]; then
    sudo apt-get remove -y vim vim-runtime gvim vim-tiny vim-common
    sudo apt-get install -y libncurses5-dev libgnome2-dev libgnomeui-dev \
        libgtk2.0-dev libatk1.0-dev libbonoboui2-dev \
        libcairo2-dev libx11-dev libxpm-dev libxt-dev python-dev \
        python3-dev
    git clone https://github.com/vim/vim.git
    cd vim
    # TODO: specify correct python config-dir!
    ./configure --with-features=huge \
        --enable-multibyte \
        --enable-pythoninterp \
        --with-python-config-dir=/usr/lib/python2.7/config-x86_64-linux-gnu \
        --enable-python3interp \
        --with-python3-config-dir=/usr/lib/python3.5/config-3.5m-x86_64-linux-gnu \
        --enable-gui=gtk2 \
        --enable-cscope \
        --prefix=/usr
    # obtain version info, strip quotes (http://stackoverflow.com/questions/9733338/shell-script-remove-first-and-last-quote-from-a-variable)
    vim_version=`ack '#define VIM_VERSION_NODOT' src/version.h | awk '{ print $3; }' | tr -d '"'`
    echo $vim_version
    make VIMRUNTIMEDIR=/usr/share/vim/$vim_version
    sudo make install
    sudo update-alternatives --install /usr/bin/editor editor /usr/bin/vim 1
    sudo update-alternatives --set editor /usr/bin/vim
    sudo update-alternatives --install /usr/bin/vi vi /usr/bin/vim 1
    sudo update-alternatives --set vi /usr/bin/vim
    echo
    vim --help | head -n1
fi

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
ln -s "$DOTFLS"lubuntu-rc.xml ~/.config/openbox/lubuntu-rc.xml
ln -s "$DOTFLS".ackrc .ackrc
cat ~/.zshrc_original "$DOTFLS"zshrc_tail >> ~/.zshrc
rm ~/.zshrc_original

echo "Installing vim plugins..."
# https://github.com/VundleVim/Vundle.vim
cd ~
mkdir -p .files/.vim/bundle
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
vim +PluginInstall +qall

echo "Installing ycm..."
# https://github.com/Valloric/YouCompleteMe#installation
cd ~/.vim/bundle/YouCompleteMe
./install.py --clang-completer

echo "Installing pip..."
# http://stackoverflow.com/questions/27711184/why-is-pip-raising-an-assertionerror-on-pip-freeze
# https://pip.pypa.io/en/latest/installing/
cd ~/software
sudo apt-get --purge remove python-pip
curl -O https://bootstrap.pypa.io/get-pip.py
sudo python get-pip.py
hash -r
rm get-pip.py

echo "Installing ipython..."
# http://stackoverflow.com/questions/34851801/jupyter-cant-create-new-notebook
cd ~/software
sudo apt-get --purge remove ipython
sudo pip uninstall ipython
git clone https://github.com/ipython/ipython.git
cd ipython
sudo pip install -e .

echo "Installing virtualenv..."
cd ~
sudo pip install virtualenv
sudo pip install virtualenvwrapper

echo "Installing watson..."
sudo pip install td-watson
sudo wget -O /etc/bash_completion.d/watson https://raw.githubusercontent.com/TailorDev/Watson/master/watson.completion 
ln -s "$DOTFLS"watson_config ~/.config/watson/config
