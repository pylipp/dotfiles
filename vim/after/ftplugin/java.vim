if exists('b:custom_java')
    finish
endif
let b:custom_java=1

" for javacomplete2 plugin
" Solve Javavi error by running
" mvn -f ~/.vim/bundle/vim-javacomplete2/libs/javavi/pom.xml compile
setlocal omnifunc=javacomplete#Complete
