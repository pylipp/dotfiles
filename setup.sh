#/bin/bash 
if [[ "$#" -ne 1 ]]; then 
    echo "Usage: bash setup.sh home_dir"
    exit 
fi

home=$1
echo
read -n 1 -p "Home directory specified: $1 OK [y/n]" reply
echo
if [[ "$reply" != 'y' ]]; then exit; fi

echo "----------------------------------------------------------"
echo "Installing git..."
sudo apt-get install -y git

echo "----------------------------------------------------------"
echo "Installing zsh..."
# https://wiki.ubuntuusers.de/Zsh/
sudo apt-get install -y zsh
# https://github.com/robbyrussell/oh-my-zsh/issues/1224#issuecomment-31623113
# This workaround might be required:
# sudo sed -i 's/^auth[[:space:]]*required/#auth required/' /etc/pam.d/chsh
sudo chsh $USER -s $(which zsh)
sudo apt-get install -y xclip

echo "----------------------------------------------------------"
echo "Installing ag..."
sudo apt-get install -y silversearcher-ag ack

echo "----------------------------------------------------------"
echo "Installing vim..."
# https://github.com/Valloric/YouCompleteMe/wiki/Building-Vim-from-source
mkdir -p $home/software
cd $home/software
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

echo "----------------------------------------------------------"
echo "Setting up symbolic links to .files..."
cd $home
ln -s $home/.files/.vim $home/.vim
ln -s $home/.files/ycm_extra_conf.py $home/.ycm_extra_conf.py
ln -s $home/.files/gitconfig $home/.gitconfig
sudo ln -s $home/.files/gitstatus.py /usr/bin/gitstatus 
# ln -s ~/.files/lubuntu-rc.xml ~/.config/openbox/lubuntu-rc.xml
ln -s $home/.files/ackrc $home/.ackrc
rm $home/.bashrc
ln -s $home/.files/bashrc $home/.bashrc
ln -s $home/.files/zshrc $home/.zshrc
ln -s $home/.files/tmux.conf $home/.tmux.conf

echo "----------------------------------------------------------"
echo "Installing vim plugins..."
vim +qall
# setup link now to avoid errors due to uninstalled plugins
ln -s $home/.files/vimrc $home/.vimrc

echo "----------------------------------------------------------"
echo "Installing ycm..."
# https://github.com/Valloric/YouCompleteMe#installation
sudo apt-get install -y cmake
cd $home/.vim/bundle/YouCompleteMe
./install.py --clang-completer

echo "----------------------------------------------------------"
echo "Installing virtualenv..."
cd $home
sudo apt install virtualenv
sudo apt install virtualenvwrapper

echo "----------------------------------------------------------"
echo "Installing more programs (git-cola, thefuck, dropbox, ctags)..."
# sudo apt-get install -y thefuck
sudo apt-get install -y nautilus nautilus-dropbox
sudo apt-get install -y exuberant-ctags
sudo apt-get install -y tmux
sudo wget -O /usr/local/share/zsh/site-functions/_hub https://raw.githubusercontent.com/github/hub/master/etc/hub.zsh_completion

echo "----------------------------------------------------------"
read -n 1 -p "Install QtCreator...?" reply
echo
if [[ "$reply" != 'y' ]]; then 
    echo "Installing qtcreator..."
    cd $home/Downloads 
    wget http://download.qt.io/official_releases/online_installers/qt-unified-linux-x64-online.run
    chmod 755 qt-unified-linux-x64-online.run 
    ./qt-unified-linux-x64-online.run
fi

# echo "----------------------------------------------------------"
# echo "Configuring keyboard shortcuts..."
# gsettings set org.gnome.settings-daemon.plugins.media-keys screensaver '<Control><Alt>b'
# gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-right ['<Shift><Control><Alt>l']
# gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-left ['<Shift><Control><Alt>h']
# gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-up ['<Shift><Control><Alt>k']
# gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-down ['<Shift><Control><Alt>j']
# gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-right ['<Control><Alt>l']
# gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-left ['<Control><Alt>h']
# gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-up ['<Control><Alt>k']
# gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-down ['<Control><Alt>j']
