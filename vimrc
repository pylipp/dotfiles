source ~/.vim/startup/settings.vim
source ~/.vim/startup/functions.vim
source ~/.vim/startup/mappings.vim
source ~/.vim/startup/plugins.vim

" optional machine-specific settings
if filereadable(expand('~/.files/local_vimrc'))
    source ~/.files/local_vimrc
endif
