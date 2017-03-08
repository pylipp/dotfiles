#/bin/bash 

install_core_utils() {
    echo "----------------------------------------------------------"
    echo "Installing zsh..."
    # https://wiki.ubuntuusers.de/Zsh/
    sudo apt-get install -y zsh > /dev/null
    wget https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh
    sed -i "s/env zsh//g" install.sh 
    sh install.sh > /dev/null
    # https://github.com/robbyrussell/oh-my-zsh/issues/1224#issuecomment-31623113
    # This workaround might be required:
    # sudo sed -i 's/^auth[[:space:]]*required/#auth required/' /etc/pam.d/chsh
    # sudo chsh $USER -s $(which zsh)
    rm install.sh .zshrc .zshrc.pre-oh-my-zsh
    sudo apt-get install -y xclip > /dev/null


    echo "----------------------------------------------------------"
    echo "Installing ag..."
    sudo apt-get install -y silversearcher-ag ack-grep > /dev/null



    echo "----------------------------------------------------------"
    echo "Installing ripgrep..."
    wget https://raw.githubusercontent.com/BurntSushi/ripgrep/4e8c0fc4ade785775005b416dc030295c684cb67/Cargo.toml
    ripgrep_version=`grep version Cargo.toml | head -1 | cut -d" " -f3 | tr -d'"'`
    wget https://github.com/BurntSushi/ripgrep/releases/download/$ripgrep_version/ripgrep-$ripgrep_version-x86_64-unknown-linux-musl.tar.gz
    tar xf ripgrep-$ripgrep_version-x86_64-unknown-linux-musl.tar.gz
    sudo cp ripgrep-$ripgrep_version-x86_64-unknown-linux-musl/rg /usr/local/bin
    rm -rf ripgrep-$ripgrep_version-x86_64-unknown-linux-musl.tar.gz ripgrep-$ripgrep_version-x86_64-unknown-linux-musl


    echo "----------------------------------------------------------"
    echo "Installing virtualenv..."
    cd $home
    sudo apt-get install -y python-virtualenv > /dev/null
    sudo apt-get install -y virtualenvwrapper > /dev/null 


    echo "----------------------------------------------------------"
    echo "Installing hub..."
    cd $home/software 
    wget -q https://raw.githubusercontent.com/github/hub/master/version/version.go 
    hub_version=`grep "var Version" version.go | cut -d" " -f4 | tr -d \"`
    hub_dir=hub-linux-amd64-$hub_version
    wget -q https://github.com/github/hub/releases/download/v$hub_version/$hub_dir.tgz
    tar xf $hub_dir.tgz
    sudo $hub_dir/./install && rm -rf $hub_dir $hub_dir.tgz version.go


    echo "----------------------------------------------------------"
    echo "Installing i3..."
    sudo apt-get install -y i3 rofi xautolock feh > /dev/null 
    sudo ln -s $home/.files/i3exit /usr/local/bin/i3exit


    echo "----------------------------------------------------------"
    echo "Installing more programs (nautilus, dropbox, ctags, tmux)..."
    # TODO install fzf, hub
    # sudo apt-get install -y thefuck
    # sudo apt-get install -y nautilus nautilus-dropbox > /dev/null
    sudo apt-get install -y exuberant-ctags > /dev/null
    sudo apt-get install -y tmux > /dev/null
    sudo apt-get install -y tig > /dev/null
    sudo wget -q -O /usr/local/share/zsh/site-functions/_hub \
        https://raw.githubusercontent.com/github/hub/master/etc/hub.zsh_completion > /dev/null
}


install_vim() {
    echo "----------------------------------------------------------"
    echo "Installing vim..."
    # https://github.com/Valloric/YouCompleteMe/wiki/Building-Vim-from-source
    mkdir -p $home/software
    cd $home/software
    if [[ ! -e vim ]]; then
        sudo apt-get remove -y vim vim-runtime gvim vim-tiny vim-common > /dev/null
        sudo apt-get install -y libncurses5-dev libgnome2-dev libgnomeui-dev \
            libgtk2.0-dev libatk1.0-dev libbonoboui2-dev \
            libcairo2-dev libx11-dev libxpm-dev libxt-dev python-dev \
            python3-dev > /dev/null
        git clone https://github.com/vim/vim.git > /dev/null
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
    ln -s $home/.files/.vim $home/.vim


    echo "----------------------------------------------------------"
    echo "Configuring vim..."
    cd $home/.files 
    bash generate_vimrc.sh
    ln -s $home/.files/vimrc $home/.vimrc
    vim +qall > /dev/null


    if [[ -d "$home/.vim/bundle/YouCompleteMe" ]]; then
        echo "----------------------------------------------------------"
        echo "Installing ycm..."
        # https://github.com/Valloric/YouCompleteMe#installation
        sudo apt-get install -y cmake > /dev/null
        cd $home/.vim/bundle/YouCompleteMe
        ./install.py --clang-completer > /dev/null
    fi
}


install_neovim() {
    echo "----------------------------------------------------------"
    echo "Installing neovim..."
    mkvirtualenv --python=/usr/bin/python3.5 neovim > /dev/null
    pip install neovim > /dev/null
    sudo apt-get install -y  neovim > /dev/null 2>&1
    if [[ "$?" -ne "0" ]]; then 
        # Ubuntu installation 
        sudo apt-get install -y  software-properties-common > /dev/null 
        sudo add-apt-repository ppa:neovim-ppa/unstable
        sudo apt-get update > /dev/null 
        sudo apt-get install -y  neovim 
    fi 
    ln -s $home/.files/.vim $home/.config/nvim
}


setup_links() {
    echo "----------------------------------------------------------"
    echo "Setting up symbolic links to .files..."
    cd $home
    ln -s $home/.files/ycm_extra_conf.py $home/.ycm_extra_conf.py
    mv $home/.gitconfig $home/.gitconfig_old 2>/dev/null
    ln -s $home/.files/gitconfig $home/.gitconfig
    ln -s $home/.files/ackrc $home/.ackrc
    rm $home/.bashrc
    ln -s $home/.files/bashrc $home/.bashrc
    ln -s $home/.files/zshrc $home/.zshrc
    ln -s $home/.files/oh-my-zsh/themes $home/.oh-my-zsh/custom/themes
    ln -s $home/.files/tmux.conf $home/.tmux.conf
    mkdir -p $home/.config/i3
    ln -s $home/.files/i3_config $home/.config/i3/config
    ln -s $home/.files/latexmkrc $home/.latexmkrc
}


install_qtcreator() {
    echo "----------------------------------------------------------"
    echo "Installing qtcreator..."
    cd $home/Downloads 
    wget -q http://download.qt.io/official_releases/online_installers/qt-unified-linux-x64-online.run > /dev/null
    chmod 755 qt-unified-linux-x64-online.run 
    ./qt-unified-linux-x64-online.run
}

install_complete() {
    sudo apt-get update > /dev/null && sudo apt-get upgrade > /dev/null
    install_core_utils 
    install_vim 
    setup_links 
}
