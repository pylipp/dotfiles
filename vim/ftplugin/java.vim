" for javacomplete2 plugin
" Solve Javavi error by running
" mvn -f ~/.vim/bundle/vim-javacomplete2/libs/javavi/pom.xml compile
autocmd FileType java setlocal omnifunc=javacomplete#Complete
