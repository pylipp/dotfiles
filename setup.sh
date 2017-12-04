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
    mkdir -p $HOME/.config/termite 
    ln -s $HOME/.files/termite_config $HOME/.config/termite/config
}


install_powerline_font() {
    mkdir -p $HOME/software

    # https://powerline.readthedocs.io/en/latest/installation/linux.html#fonts-installation
    # https://github.com/powerline/powerline/issues/1589
    cd $HOME/software
    git clone https://github.com/powerline/fonts
    mkdir -p ~/.local/share/fonts
    cp fonts/DejaVuSansMono/"DejaVu Sans Mono for Powerline.ttf" ~/.local/share/fonts
    fc-cache -v -f ~/.local/share/fonts
    # not consistent across distros, hence set links
    ln -s ~/.local/share/fonts ~/.fonts
    ln -s ~/.config/fontconfig/conf.d ~/.fonts.conf.d
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
    for rcfile in ycm_extra_conf.py gitconfig bashrc i3 \
        xinitrc dir_colors latexmkrc pylintrc tigrc direnvrc \
        pythonrc mailcap profile zprofile xprofile \
        vintrc.yaml
    do
        link_name="."$rcfile
        link_path=$HOME/$link_name
        mv_existing $link_path
        setup_link $rcfile $link_path
    done
    
    mkdir -p $HOME/.config/zathura
    ln -s $HOME/.files/zathurarc $HOME/.config/zathura/zathurarc
    mkdir -p $HOME/.ptpython 
    ln -s $HOME/.files/ptpython_config.py $HOME/.ptpython/config.py
    mkdir -p $HOME/.config/pudb
    ln -s $HOME/.files/pudb.cfg $HOME/.config/pudb/pudb.cfg
    mkdir -p $HOME/.config/feh
    ln -s $HOME/.files/feh $HOME/.config/feh
    mkdir -p $HOME/.local/share
    ln -s $HOME/.files/local/share/applications $HOME/.local/share/applications
    ln -s $HOME/.files/flake8rc $HOME/.config/flake8
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

    sudo cp "$HOME/.files/keyboard" /usr/share/X11/xkb/symbols/pylipp
    setxkbmap pylipp
}

install_complete() {
    sudo apt-get update > /dev/null && sudo apt-get upgrade -y > /dev/null
    setup_links 
    post_install
}
