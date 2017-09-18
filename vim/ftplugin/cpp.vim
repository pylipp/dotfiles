" https://google.github.io/styleguide/cppguide.html#Spaces_vs._Tabs
set tabstop=2
set softtabstop=2
set shiftwidth=2

augroup cpp
    autocmd!
    autocmd BufWritePre * :call DeleteWhitespace()
augroup END
