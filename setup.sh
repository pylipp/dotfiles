#!/bin/bash

set -e

echo_info() {
    # print output in green
    echo -e "\033[0;32m$*\033[0m"
}

echo_warn() {
    # print output in yellow
    echo -e "\033[0;33m$*\033[0m"
}

echo_error() {
    # print output in red
    echo -e "\033[0;31m$*\033[0m"
}

rm_existing() {
    if [ -e "$1" ]; then
        rm -rf "$1"
    fi
}

mv_existing() {
    if [ -e "$1" ]; then
        echo_warn "Backing up existing file $1"
        mv "$1" "$1"_old
    fi
}

install_packages() {
    for package in $@; do 
        echo_info Installing $package........................
        sudo apt-get install -y $package
        if [[ $? -ne 0 ]]; then
            echo_error "##################################################"
            echo_error "Error installing $package!"
            echo_error "##################################################"
        fi
    done 
}


install_core_utils() {
    mkdir -p $HOME/software

    echo "----------------------------------------------------------"
    install_packages python2.7 g++ \
        exuberant-ctags tmux cmake tig zathura htop fonts-hack-ttf \
        network-manager usbmount libxml2-dev libxslt-dev pulseaudio libasound2-dev \
        zip unzip alsa-utils \
        libxcb-composite0-dev python-dev curl doxygen graphviz lm-sensors direnv \
        scrot silversearcher-ag python-virtualenv virtualenvwrapper

    echo "----------------------------------------------------------"
    cd $HOME
    install_packages zsh xclip
    wget https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh
    sed -i "s/env zsh//g" install.sh 
    sh install.sh > /dev/null
    # https://github.com/robbyrussell/oh-my-zsh/issues/1224#issuecomment-31623113
    # This workaround might be required:
    # sudo sed -i 's/^auth[[:space:]]*required/#auth required/' /etc/pam.d/chsh
    sudo chsh $USER -s $(which zsh)
    for file in install.sh .zshrc .zshrc.pre-oh-my-zsh; do
        rm_existing "$file"
    done


    echo_info "----------------------------------------------------------"
    echo_info "Installing pip..."
    # http://stackoverflow.com/questions/27711184/why-is-pip-raising-an-assertionerror-on-pip-freeze
    # https://pip.pypa.io/en/latest/installing/
    cd $HOME/software
    sudo apt-get --purge -y remove python-pip python3-pip
    curl -O https://bootstrap.pypa.io/get-pip.py
    python2 get-pip.py --user
    python3 get-pip.py --user
    hash -r
    rm get-pip.py


    echo_info "----------------------------------------------------------"
    echo_info "Installing hub..."
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

    echo_info "----------------------------------------------------------"
    echo_info "Installing fzf..."
    install_packages coderay
    git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
    ~/.fzf/install --all

    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
    pip install --user tmuxp

    # make automounted devices readable for user
    # https://unix.stackexchange.com/a/155689/192726
    if [[ -e /etc/usbmount/usbmount.conf ]]; then
        sudo sed -i -r 's/(^MOUNTOPTIONS=".*)"/\1,uid=1000,gid=1000"/' /etc/usbmount/usbmount.conf
    fi

    # make zathura default application to open pdfs using xdg-open
    xdg-mime default zathura.desktop application/pdf
}


install_i3() {
    mkdir -p $HOME/software
    cd $HOME/software

    echo_info "----------------------------------------------------------"
    install_packages i3 xautolock xorg xinit feh imagemagick

    # install dunst from source. v1.1.0 from the debian repos is outdated
    install_packages libdbus-1-dev libx11-dev libxinerama-dev libxrandr-dev libxss-dev libglib2.0-dev libpango1.0-dev libgtk-3-dev libxdg-basedir-dev
    git clone https://github.com/dunst-project/dunst
    cd dunst
    git checkout v1.2.0
    make
    sudo make install
    

    cd $HOME/software
    install_packages pkg-config libxcb1 libpam-dev libcairo-dev \
        libxcb-xinerama0-dev libev-dev libx11-dev libx11-xcb-dev libxkbcommon0 \
        libxkbcommon-x11-0 libxcb-dpms0-dev libxcb-image0-dev libxcb-util0-dev \
        libxcb-xkb-dev libxkbcommon-x11-dev libxkbcommon-dev xterm dbus-x11
    git clone https://github.com/chrjguill/i3lock-color
    cd i3lock-color 
    sudo make install 
    cd ~/.files/i3/i3lock-fancy
    git checkout multimonitor

    install_packages python-requests python-psutils python-netifaces
    git clone https://github.com/tobi-wan-kenobi/bumblebee-status $HOME/software/bumblebee-status
}


install_ripgrep() {
    echo_info "----------------------------------------------------------"
    echo_info "Installing ripgrep..."
    wget https://raw.githubusercontent.com/BurntSushi/ripgrep/4e8c0fc4ade785775005b416dc030295c684cb67/Cargo.toml
    ripgrep_version=`grep version Cargo.toml | head -1 | cut -d" " -f3 | tr -d'"'`
    wget https://github.com/BurntSushi/ripgrep/releases/download/$ripgrep_version/ripgrep-$ripgrep_version-x86_64-unknown-linux-musl.tar.gz
    tar xf ripgrep-$ripgrep_version-x86_64-unknown-linux-musl.tar.gz
    sudo cp ripgrep-$ripgrep_version-x86_64-unknown-linux-musl/rg /usr/local/bin
    rm -rf ripgrep-$ripgrep_version-x86_64-unknown-linux-musl.tar.gz ripgrep-$ripgrep_version-x86_64-unknown-linux-musl
}


install_vim() {
    mkdir -p $HOME/software

    echo_info "----------------------------------------------------------"
    echo_info "Installing vim..."
    # https://github.com/Valloric/YouCompleteMe/wiki/Building-Vim-from-source
    cd $HOME/software
    if [[ ! -e vim ]]; then
        sudo apt-get remove -y vim vim-runtime gvim vim-tiny vim-common > /dev/null
        install_packages libncurses5-dev \
            libcairo2-dev libx11-dev libxpm-dev libxt-dev python-dev \
            python3-dev pylint shellcheck xdotool markdown

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
        echo_info $vim_version
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


    echo_info "----------------------------------------------------------"
    echo_info "Configuring vim..."
    mv_existing $HOME/.vimrc
    bash $HOME/.files/generate_vimrc.sh
    vim +qall > /dev/null

    # install linter
    pip install --user vim-vint

    if [[ -d "$HOME/.vim/bundle/YouCompleteMe" ]]; then
        echo_info "----------------------------------------------------------"
        echo_info "Installing ycm..."
        # https://github.com/Valloric/YouCompleteMe#installation
        cd $HOME/.vim/bundle/YouCompleteMe
        ./install.py --clang-completer > /dev/null
    fi
}


install_neovim() {
    echo_info "----------------------------------------------------------"
    echo_info "Installing neovim..."
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
    mkdir -p $HOME/software

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
    mkdir -p $HOME/software

    # https://powerline.readthedocs.io/en/latest/installation/linux.html#fonts-installation
    # https://github.com/powerline/powerline/issues/1589
    cd $HOME/software
    git clone https://github.com/powerline/fonts
    mkdir -p ~/.local/share/fonts
    cp fonts/DejaVuSansMono/"DejaVu Sans Mono for Powerline.ttf" ~/.local/share/fonts
    fc-cache -v -f ~/.local/share/fonts
    # maybe not required?
    ln -s ~/.local/share/fonts ~/.fonts
}


install_texlive() {
    echo_info "----------------------------------------------------------"
    echo_info "Installing texlive..."

    # https://www.tug.org/texlive/doc/install-tl.html
    if [[ ! -f $HOME/.files/texlive.profile ]]; then
        echo_error "$HOME/.files/texlive.profile not found!"
        exit
    fi
    mkdir -p ~/Downloads
    cd ~/Downloads
    wget http://mirror.ctan.org/systems/texlive/tlnet/install-tl-unx.tar.gz
    tar xf install-tl-unx.tar.gz
    cd install-tl-$(date +%Y%m%d)
    sudo ./install-tl -profile ~/.files/texlive.profile
    cd ..
    rm -rf install-tl-*

    # create symlinks to tex binaries in /usr/local/bin
    sudo /usr/local/texlive/$(date +%Y)/bin/x86_64-linux/./tlmgr path add

    install_packages latexmk xzdec
}


setup_link() {
    echo_info "Setting up link to $1..."
    ln -s .files/$1 $2
}


setup_links() {
    echo_info "----------------------------------------------------------"
    echo_info "Setting up symbolic links to .files..."
    cd $HOME
    for rcfile in ycm_extra_conf.py gitconfig bashrc zshrc tmux.conf i3 \
        Xresources xinitrc dir_colors latexmkrc pylintrc tigrc direnvrc \
        pythonrc mailcap vimperatorrc profile zprofile xprofile tmuxp \
        vintrc.yaml
    do
        link_name="."$rcfile
        link_path=$HOME/$link_name
        mv_existing $link_path
        setup_link $rcfile $link_path
    done
    
    ln -s $HOME/.files/oh-my-zsh/themes $HOME/.oh-my-zsh/custom/themes
    mkdir -p $HOME/.config/zathura
    ln -s $HOME/.files/zathurarc $HOME/.config/zathura/zathurarc
    mkdir -p $HOME/.ptpython 
    ln -s $HOME/.files/ptpython_config.py $HOME/.ptpython/config.py
    mkdir -p $HOME/.config/termite 
    ln -s $HOME/.files/termite_config $HOME/.config/termite/config
    mkdir -p $HOME/.config/pudb
    ln -s $HOME/.files/pudb.cfg $HOME/.config/pudb/pudb.cfg
    mkdir -p $HOME/.config/feh
    ln -s $HOME/.files/feh $HOME/.config/feh
    mkdir -p $HOME/.local/share
    ln -s $HOME/.files/local/share/applications $HOME/.local/share/applications
}


install_qtcreator() {
    echo_info "----------------------------------------------------------"
    install_package libgl1-mesa-dev
    echo_info "Installing qtcreator..."
    cd $HOME/Downloads 
    wget -q http://download.qt.io/official_releases/online_installers/qt-unified-linux-x64-online.run > /dev/null
    chmod 755 qt-unified-linux-x64-online.run 
    sudo ./qt-unified-linux-x64-online.run
    sudo ln -s /opt/Qt/5.9.1/gcc_64/include /usr/include/qt
}


post_install() {
    # steps performed last because they require dotfiles links being set up
    echo_info "----------------------------------------------------------"
    echo_info "Install tmux plugings..."
    $HOME/.tmux/plugins/tpm/scripts/./install_plugins.sh

    sudo cp "$HOME/.files/keyboard" /usr/share/X11/xkb/symbols/pylipp
    setxkbmap pylipp
}

install_complete() {
    sudo apt-get update > /dev/null && sudo apt-get upgrade -y > /dev/null
    install_core_utils 
    install_vim 
    setup_links 
    post_install
}
