if exists('b:custom_cpp')
    finish
endif
let b:custom_cpp=1

" https://google.github.io/styleguide/cppguide.html#Spaces_vs._Tabs
setlocal softtabstop=2
setlocal shiftwidth=2

setlocal textwidth=80

augroup cpp
    autocmd!
    autocmd BufWritePre * :call DeleteWhitespace()
augroup END

" Turn off annoying error highlighting
highlight clear SpellBad
