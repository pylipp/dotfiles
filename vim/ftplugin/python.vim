if exists('b:custom_python')
    finish
endif
let b:custom_python=1

setlocal textwidth=80

augroup python
    autocmd!
    autocmd BufWritePre * :call DeleteWhitespace()

    " highligh long lines
    highlight ColorColumn ctermfg=DarkYellow
    call matchadd('ColorColumn', '\%81v', 100)
augroup END

if system('python --version') =~# '^Python 2.'
    Python2Syntax
endif
