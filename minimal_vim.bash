#!/bin/bash 

set -eu

cd ~
mkdir -p .vim/{autoload,bundle}

curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

if [[ -e .vimrc ]]
then
    echo Adding vim-plug plugin manager to existing vimrc!
    mv .vimrc old_vimrc
    echo -e "call plug#begin('~/.vim/bundle')\n\nPlug 'pylipp/vim-sensible'\n\ncall plug#end()" > .vimrc
    cat old_vimrc >> .vimrc 
    rm old_vimrc 
else
    echo -e "call plug#begin('~/.vim/bundle')\n\nPlug 'pylipp/vim-sensible'\n\ncall plug#end()" > .vimrc
fi

vim +PlugInstall +qa
