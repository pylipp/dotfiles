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

echo_colored() {
    # print output in yellow
    echo -e "\033[0;33m$*\033[0m"
}

install_packages() {
    for package in $@; do 
        echo_colored Installing $package........................
        sudo apt-get install -y $package
    done 
}

mkdir -p $HOME/software

install_core_utils() {
    echo "----------------------------------------------------------"
    install_packages python2.7 g++ python-requests python-psutils python-netifaces \
        exuberant-ctags tmux cmake tig zathura htop fonts-hack-ttf \
        network-manager usbmount libxml2-dev libxslt-dev pulseaudio libasound2-dev \
        libxcb-composite0-dev python-dev curl doxygen graphviz lm-sensors direnv

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


    echo_colored "----------------------------------------------------------"
    install_packages silversearcher-ag


    echo_colored "----------------------------------------------------------"
    echo_colored "Installing pip..."
    # http://stackoverflow.com/questions/27711184/why-is-pip-raising-an-assertionerror-on-pip-freeze
    # https://pip.pypa.io/en/latest/installing/
    cd $HOME/software
    sudo apt-get --purge -y remove python-pip python3-pip
    curl -O https://bootstrap.pypa.io/get-pip.py
    python2 get-pip.py --user
    python3 get-pip.py --user
    hash -r
    rm get-pip.py


    echo_colored "----------------------------------------------------------"
    install_packages python-virtualenv virtualenvwrapper


    echo_colored "----------------------------------------------------------"
    echo_colored "Installing hub..."
    echo -n "What architecture are you using (arm/amd64): "
    read ARCH
    cd $HOME/software 
    wget -q https://raw.githubusercontent.com/github/hub/master/version/version.go 
    hub_version=`grep "var Version" version.go | cut -d" " -f4 | tr -d \"`
    hub_dir=hub-linux-"$ARCH"-$hub_version
    wget -q https://github.com/github/hub/releases/download/v$hub_version/$hub_dir.tgz
    tar xf $hub_dir.tgz
    sudo $hub_dir/./install && rm -rf $hub_dir $hub_dir.tgz version.go
    sudo wget -q -O /usr/local/share/zsh/site-functions/_hub \
        https://raw.githubusercontent.com/github/hub/master/etc/hub.zsh_completion > /dev/null

    echo_colored "----------------------------------------------------------"
    echo_colored "Installing fzf..."
    git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
    ~/.fzf/install --all

    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

    # make automounted devices readable for user
    sudo sed -i -r 's/(FS_MOUNTOPTIONS=").*"/\1uid=1000,gid=1000"/' /etc/usbmount/usbmount.conf
}


install_i3() {
    echo_colored "----------------------------------------------------------"
    install_packages i3 xautolock xorg xinit feh dunst
    cd $HOME/software
    install_packages pkg-config libxcb1 libpam-dev libcairo-dev \
        libxcb-xinerama0-dev libev-dev libx11-dev libx11-xcb-dev libxkbcommon0 \
        libxkbcommon-x11-0 libxcb-dpms0-dev libxcb-image0-dev libxcb-util0-dev \
        libxcb-xkb-dev libxkbcommon-x11-dev libxkbcommon-dev xterm
    git clone https://github.com/chrjguill/i3lock-color
    cd i3lock-color 
    sudo make install 
    cd ~/.files/i3/i3lock-fancy
    git checkout multimonitor
    git clone https://github.com/tobi-wan-kenobi/bumblebee-status $HOME/software/bumblebee-status
}


install_ripgrep() {
    echo_colored "----------------------------------------------------------"
    echo_colored "Installing ripgrep..."
    wget https://raw.githubusercontent.com/BurntSushi/ripgrep/4e8c0fc4ade785775005b416dc030295c684cb67/Cargo.toml
    ripgrep_version=`grep version Cargo.toml | head -1 | cut -d" " -f3 | tr -d'"'`
    wget https://github.com/BurntSushi/ripgrep/releases/download/$ripgrep_version/ripgrep-$ripgrep_version-x86_64-unknown-linux-musl.tar.gz
    tar xf ripgrep-$ripgrep_version-x86_64-unknown-linux-musl.tar.gz
    sudo cp ripgrep-$ripgrep_version-x86_64-unknown-linux-musl/rg /usr/local/bin
    rm -rf ripgrep-$ripgrep_version-x86_64-unknown-linux-musl.tar.gz ripgrep-$ripgrep_version-x86_64-unknown-linux-musl
}


install_vim() {
    echo_colored "----------------------------------------------------------"
    echo_colored "Installing vim..."
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
        echo_colored $vim_version
        echo
        make VIMRUNTIMEDIR=/usr/share/vim/$vim_version > /dev/null
        sudo make install > /dev/null
        sudo update-alternatives --install /usr/bin/editor editor /usr/bin/vim 1
        sudo update-alternatives --set editor /usr/bin/vim
        sudo update-alternatives --install /usr/bin/vi vi /usr/bin/vim 1
        sudo update-alternatives --set vi /usr/bin/vim
    fi
    mv_existing $HOME/.vim
    ln -s $HOME/.files/vim $HOME/.vim


    echo_colored "----------------------------------------------------------"
    echo_colored "Configuring vim..."
    mv_existing $HOME/.vimrc
    bash $HOME/.files/generate_vimrc.sh
    vim +qall > /dev/null


    if [[ -d "$HOME/.vim/bundle/YouCompleteMe" ]]; then
        echo_colored "----------------------------------------------------------"
        echo_colored "Installing ycm..."
        # https://github.com/Valloric/YouCompleteMe#installation
        cd $HOME/.vim/bundle/YouCompleteMe
        ./install.py --clang-completer > /dev/null
    fi

    # http://vim.wikia.com/wiki/Enable_servername_capability_in_vim/xterm
    # using method 2B (with 2C, window switching stopped working)
    # required for vimtex plugin, see https://github.com/lervag/vimtex/issues/852
    # ~/.local/bin has to be before /usr/bin in $PATH
    mkdir -p $HOME/.local/bin
    cd $HOME/.local/bin
    mv_existing vim
    echo '#!/bin/sh' > vim
    echo 'exec /usr/bin/vim --servername VIM "$@"' >> vim
    chmod 755 vim
}


install_neovim() {
    echo_colored "----------------------------------------------------------"
    echo_colored "Installing neovim..."
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
    echo /usr/local/lib/libvte-2.91.so | sudo tee --append /etc/ld.so.conf.d/vte.conf > /dev/null
    sudo ldconfig
    cd ..
    git clone --recursive https://github.com/thestinger/termite.git 
    cd termite 
    make && sudo make install || echo "Could not build termite!"
    sudo mkdir -p /lib/terminfo/x
    sudo cp termite.terminfo /lib/terminfo/x/xterm-termite
    tic -x termite.terminfo
}


install_powerline_font_xterm() {
    # https://powerline.readthedocs.io/en/latest/installation/linux.html#fonts-installation
    # https://github.com/powerline/powerline/issues/1589
    cd $HOME/software
    git clone https://github.com/powerline/fonts
    mkdir -p ~/.local/share/fonts
    cp fonts/DejaVuSansMono/"DejaVu Sans Mono Oblique for Powerline.ttf" ~/.local/share/fonts
    fc-cache -v -f ~/.local/share/fonts
    # maybe not required?
    ln -s ~/.local/share/fonts ~/.fonts
}


setup_links() {
    echo_colored "----------------------------------------------------------"
    echo_colored "Setting up symbolic links to .files..."
    cd $HOME
    ln -s $HOME/.files/ycm_extra_conf.py $HOME/.ycm_extra_conf.py
    mv_existing $HOME/.gitconfig 
    ln -s $HOME/.files/gitconfig $HOME/.gitconfig
    rm_existing $HOME/.bashrc
    ln -s $HOME/.files/bashrc $HOME/.bashrc
    rm_existing $HOME/.zshrc
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
    ln -s $HOME/.files/direnvrc $HOME/.direnvrc
    ln -s $HOME/.files/pythonrc $HOME/.pythonrc
}


install_qtcreator() {
    echo_colored "----------------------------------------------------------"
    install_package libgl1-mesa-dev
    echo_colored "Installing qtcreator..."
    cd $HOME/Downloads 
    wget -q http://download.qt.io/official_releases/online_installers/qt-unified-linux-x64-online.run > /dev/null
    chmod 755 qt-unified-linux-x64-online.run 
    sudo ./qt-unified-linux-x64-online.run
    sudo ln -s /opt/Qt/5.9.1/gcc_64/include /usr/include/qt
}


post_install() {
    # steps performed last because they require dotfiles links being set up
    echo_colored "----------------------------------------------------------"
    echo_colored "Install tmux plugings..."
    $HOME/.tmux/plugins/tpm/scripts/./install_plugins.sh
}

install_complete() {
    sudo apt-get update > /dev/null && sudo apt-get upgrade -y > /dev/null
    install_core_utils 
    install_vim 
    setup_links 
    post_install
}
