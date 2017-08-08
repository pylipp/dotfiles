#!/bin/bash

set -e

rm_existing() {
    if [ -e "$1" ]; then
        rm -rf "$1"
    fi
}

mv_existing() {
    if [ -e "$1" ]; then
        mv "$1" "$1"_old
    fi
}

install_packages() {
    for package in $@; do 
        echo -e "\033[0;33mInstalling $package........................\033[0m"
        sudo apt-get install -y $package
    done 
}

mkdir -p $HOME/software

install_core_utils() {
    echo "----------------------------------------------------------"
    # https://wiki.ubuntuusers.de/Zsh/
    install_packages zsh xclip
    wget https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh
    sed -i "s/env zsh//g" install.sh 
    sh install.sh > /dev/null
    # https://github.com/robbyrussell/oh-my-zsh/issues/1224#issuecomment-31623113
    # This workaround might be required:
    # sudo sed -i 's/^auth[[:space:]]*required/#auth required/' /etc/pam.d/chsh
    # sudo chsh $USER -s $(which zsh)
    for file in install.sh .zshrc .zshrc.pre-oh-my-zsh; do
        rm_existing "$file"
    done


    echo "----------------------------------------------------------"
    install_packages silversearcher-ag


    echo "----------------------------------------------------------"
    install_packages python-virtualenv virtualenvwrapper


    echo "----------------------------------------------------------"
    echo "Installing hub..."
    echo -n "What architecture are you using (arm/amd64): "
    read ARCH
    cd $HOME/software 
    wget -q https://raw.githubusercontent.com/github/hub/master/version/version.go 
    hub_version=`grep "var Version" version.go | cut -d" " -f4 | tr -d \"`
    hub_dir=hub-linux-"$ARCH"-$hub_version
    wget -q https://github.com/github/hub/releases/download/v$hub_version/$hub_dir.tgz
    tar xf $hub_dir.tgz
    sudo $hub_dir/./install && rm -rf $hub_dir $hub_dir.tgz version.go


    echo "----------------------------------------------------------"
    install_packages i3 xautolock xorg xinit feh dunst
    cd $HOME/software
    install_packages pkg-config libxcb1 libpam-dev libcairo-dev \
        libxcb-xinerama0-dev libev-dev libx11-dev libx11-xcb-dev libxkbcommon0 \
        libxkbcommon-x11-0 libxcb-dpms0-dev libxcb-image0-dev libxcb-util0-dev \
        libxcb-xkb-dev libxkbcommon-x11-dev libxkbcommon-dev
    git clone https://github.com/chrjguill/i3lock-color
    cd i3lock-color 
    sudo make install 
    cd ~/.files/i3
    git submodule add https://github.com/zeorin/i3lock-fancy
    cd i3lock-fancy
    git checkout -b multimonitor origin/multimonitor
    git clone https://github.com/tobi-wan-kenobi/bumblebee-status $HOME/software/bumblebee-status


    echo "----------------------------------------------------------"
    echo "Installing fzf..."
    git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
    ~/.fzf/install --all

    # sudo apt-get install -y thefuck
    install_packages exuberant-ctags tmux cmake tig zathura \
        network-manager usbmount libxml2-dev libxslt-dev pulseaudio libasound2-dev
    sudo wget -q -O /usr/local/share/zsh/site-functions/_hub \
        https://raw.githubusercontent.com/github/hub/master/etc/hub.zsh_completion > /dev/null
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

    # make automounted devices readable for user
    sudo sed -i -r 's/(FS_MOUNTOPTIONS=").*"/\1uid=1000,gid=1000"/' /etc/usbmount/usbmount.conf
}


install_ripgrep() {
    echo "----------------------------------------------------------"
    echo "Installing ripgrep..."
    wget https://raw.githubusercontent.com/BurntSushi/ripgrep/4e8c0fc4ade785775005b416dc030295c684cb67/Cargo.toml
    ripgrep_version=`grep version Cargo.toml | head -1 | cut -d" " -f3 | tr -d'"'`
    wget https://github.com/BurntSushi/ripgrep/releases/download/$ripgrep_version/ripgrep-$ripgrep_version-x86_64-unknown-linux-musl.tar.gz
    tar xf ripgrep-$ripgrep_version-x86_64-unknown-linux-musl.tar.gz
    sudo cp ripgrep-$ripgrep_version-x86_64-unknown-linux-musl/rg /usr/local/bin
    rm -rf ripgrep-$ripgrep_version-x86_64-unknown-linux-musl.tar.gz ripgrep-$ripgrep_version-x86_64-unknown-linux-musl
}


install_vim() {
    echo "----------------------------------------------------------"
    echo "Installing vim..."
    # https://github.com/Valloric/YouCompleteMe/wiki/Building-Vim-from-source
    cd $HOME/software
    if [[ ! -e vim ]]; then
        sudo apt-get remove -y vim vim-runtime gvim vim-tiny vim-common > /dev/null
        install_packages libncurses5-dev \
            libcairo2-dev libx11-dev libxpm-dev libxt-dev python-dev \
            python3-dev pylint shellcheck

        git clone https://github.com/vim/vim.git > /dev/null
        cd vim

        echo -n "Path to Python2 config dir (/usr/lib/...): "
        read VIM_PYTHON2_CONFIG_DIR
        echo -n "Path to Python3 config dir (/usr/lib/...): "
        read VIM_PYTHON3_CONFIG_DIR

        # TODO: lua installation for neocomplete with
        # https://gist.github.com/dyzajash/9cfd2c821fc599cbb1a5d1c72305a0b7

        ./configure --with-features=huge \
            --enable-multibyte \
            --enable-pythoninterp \
            --with-python-config-dir=$VIM_PYTHON2_CONFIG_DIR \
            --enable-python3interp \
            --with-python3-config-dir=$VIM_PYTHON3_CONFIG_DIR \
            --enable-gui=gtk2 \
            --enable-cscope \
            --prefix=/usr > /dev/null

        # obtain version info, strip quotes (http://stackoverflow.com/questions/9733338/shell-script-remove-first-and-last-quote-from-a-variable)
        vim_version=`grep '#define VIM_VERSION_NODOT' src/version.h | awk '{ print $3; }' | tr -d '"'`
        echo
        echo $vim_version
        echo
        make VIMRUNTIMEDIR=/usr/share/vim/$vim_version > /dev/null
        sudo make install > /dev/null
        sudo update-alternatives --install /usr/bin/editor editor /usr/bin/vim 1
        sudo update-alternatives --set editor /usr/bin/vim
        sudo update-alternatives --install /usr/bin/vi vi /usr/bin/vim 1
        sudo update-alternatives --set vi /usr/bin/vim
    fi
    ln -s $HOME/.files/vim $HOME/.vim


    echo "----------------------------------------------------------"
    echo "Configuring vim..."
    cd $HOME/.files 
    bash generate_vimrc.sh
    ln -s $HOME/.files/vimrc $HOME/.vimrc
    vim +qall > /dev/null


    if [[ -d "$HOME/.vim/bundle/YouCompleteMe" ]]; then
        echo "----------------------------------------------------------"
        echo "Installing ycm..."
        # https://github.com/Valloric/YouCompleteMe#installation
        cd $HOME/.vim/bundle/YouCompleteMe
        ./install.py --clang-completer > /dev/null
    fi
}


install_neovim() {
    echo "----------------------------------------------------------"
    echo "Installing neovim..."
    mkvirtualenv --python=/usr/bin/python3.5 neovim > /dev/null
    pip install neovim > /dev/null
    install_packages neovim
    if [[ "$?" -ne "0" ]]; then 
        # Ubuntu installation 
        install_package software-properties-common
        sudo add-apt-repository ppa:neovim-ppa/unstable
        sudo apt-get update > /dev/null 
        install_packages neovim
    fi 
    ln -s $HOME/.files/vim $HOME/.config/nvim
}


install_termite() {
    # alternatively use script from  https://github.com/Corwind/termite-install
    cd $HOME/software 
    git clone https://github.com/thestinger/vte-ng.git 
    install_packages g++ libgtk-3-dev gtk-doc-tools gnutls-bin valac intltool \
        libpcre2-dev libglib3.0-cil-dev libgnutls28-dev libgirepository1.0-dev \
        libxml2-utils m4 gperf
    cd vte-ng 
    ./autogen.sh && make && sudo make install
    sudo echo /usr/local/lib/libvte-2.91.so >> /etc/ld.so.conf.d/vte.conf 
    sudo ldconfig
    cd ..
    git clone --recursive https://github.com/thestinger/termite.git 
    cd termite 
    make && sudo make install || echo "Could not build termite!"
    sudo mkdir -p /lib/terminfo/x
    sudo cp termite.terminfo /lib/terminfo/x/xterm-termite
    tic -x termite.terminfo
}


setup_links() {
    echo "----------------------------------------------------------"
    echo "Setting up symbolic links to .files..."
    cd $HOME
    ln -s $HOME/.files/ycm_extra_conf.py $HOME/.ycm_extra_conf.py
    mv_existing $HOME/.gitconfig 
    ln -s $HOME/.files/gitconfig $HOME/.gitconfig
    rm_existing $HOME/.bashrc
    ln -s $HOME/.files/bashrc $HOME/.bashrc
    ln -s $HOME/.files/zshrc $HOME/.zshrc
    ln -s $HOME/.files/oh-my-zsh/themes $HOME/.oh-my-zsh/custom/themes
    ln -s $HOME/.files/tmux.conf $HOME/.tmux.conf
    ln -s $HOME/.files/i3 $HOME/.i3
    ln -s $HOME/.files/Xresources $HOME/.Xresources
    ln -s $HOME/.files/xinitrc $HOME/.xinitrc
    ln -s $HOME/.files/dir_colors $HOME/.dir_colors
    ln -s $HOME/.files/latexmkrc $HOME/.latexmkrc
    mkdir -p $HOME/.config/zathura 2> /dev/null
    ln -s $HOME/.files/zathurarc $HOME/.config/zathura/zathurarc
    ln -s $HOME/.files/pylintrc $HOME/.pylintrc
    mkdir -p $HOME/.ptpython && ln -s $HOME/.files/ptpython_config.py $HOME/.ptpython/config.py
    mkdir -p $HOME/.config/termite 
    ln -s $HOME/.files/termite_config $HOME/.config/termite/config
    ln -s $HOME/.files/tigrc $HOME/.tigrc
}


install_qtcreator() {
    echo "----------------------------------------------------------"
    echo "Installing qtcreator..."
    cd $HOME/Downloads 
    wget -q http://download.qt.io/official_releases/online_installers/qt-unified-linux-x64-online.run > /dev/null
    chmod 755 qt-unified-linux-x64-online.run 
    ./qt-unified-linux-x64-online.run
}

install_complete() {
    sudo apt-get update > /dev/null && sudo apt-get upgrade -y > /dev/null
    install_core_utils 
    install_vim 
    setup_links 
}
