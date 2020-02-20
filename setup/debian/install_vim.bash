#!/bin/bash

# Installation script for vim and plugins
# Installation location: /usr or ~/software/vim-rt
# Requires: - make
#           - git
#           - pip
#           - python3-dev or python-dev

set -e

source $(dirname "$0")/../utils.bash

install_vim() {
    mkcswdir
    method=${1:-global}

    echo_install_info vim
    if [[ $method = "global" ]]; then
        sudo apt-get remove -y vim vim-runtime gvim vim-tiny vim-common
        install_packages libncurses5-dev libcairo2-dev libx11-dev libxpm-dev libxt-dev \
            python-dev python3-dev \
            build-essential git \
            shellcheck xdotool markdown

        build_vim /usr
        sudo make install

        sudo update-alternatives --install /usr/bin/editor editor /usr/bin/vim 1
        sudo update-alternatives --set editor /usr/bin/vim
        sudo update-alternatives --install /usr/bin/vi vi /usr/bin/vim 1
        sudo update-alternatives --set vi /usr/bin/vim
    elif [[ $method = "local" ]]; then
        install_prefix=$HOME/.local
        build_vim "$install_prefix"
        make install
    else
        echo_error "Unknown method '$method'!"
        exit 1
    fi

    # setup_vim_config
}

build_vim() {
    mkcswdir

    if [ ! -d vim ]; then
        git clone https://github.com/vim/vim.git
    fi
    cd vim
    git pull

    VIM_PYTHON3_CONFIG_DIR=/usr/lib/python3.5/config-3.5m-x86_64-linux-gnu
    while [[ ! -e $VIM_PYTHON3_CONFIG_DIR ]]; do
        echo -n "Path to Python3 config dir: "
        read VIM_PYTHON3_CONFIG_DIR
    done

    make clean
    ./configure --with-features=huge \
        --enable-multibyte \
        --enable-python3interp \
        --with-python3-config-dir=$VIM_PYTHON3_CONFIG_DIR \
        --enable-cscope \
        --prefix=$1

    make
}

setup_vim_config() {
    mv_existing $HOME/.vim
    ln -s $HOME/.files/vim $HOME/.vim

    mv_existing $HOME/.vimrc
    ln -s ~/.files/vimrc ~/.vimrc

    vim +qall < /dev/tty
    vim +PlugInstall +qall < /dev/tty

    # install linter
    pip install --user vim-vint

    # don't install on ARM (clang not available on Raspbian)
    if [[ "$(arch)" = "x86_64" ]] && [[ -d "$HOME/.vim/bundle/YouCompleteMe" ]]; then
        echo_install_info YouCompleteMe
        cd $HOME/.vim/bundle/YouCompleteMe
        ./install.py --clang-completer
    fi
}

install_vim "$@"
