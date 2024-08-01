augroup filetypes
    autocmd!

    " OpenCL, from http://www.vim.org/scripts/script.php?script_id=3157
    autocmd BufNewFile,BufRead *.cl setf opencl

    "GL syntax hightlighting
    autocmd BufNewFile,BufRead *.gl,*.frag,*.vert,*.fp,*.vp,*.glsl setf glsl

    "xml syntax highlighting
    autocmd BufNewFile,BufRead *.xml,*.imf,*.iws,*.qrc setf xml

    autocmd BufNewFile,BufRead *.ino,*.pde setf cpp

    autocmd BufNewFile,BufRead qutebrowser-editor-* setf text

    autocmd BufNewFile,BufRead *_shrc,*profile,.env.* setf sh

    " Options for text-like files. Global defaults should suffice
    autocmd BufRead,BufNewFile *.html,*.xml,*.txt,README*,*.tex,*.md setlocal linebreak

    " enable dictionary completion with C-n/C-p by setting spelling langugage
    autocmd FileType text setlocal spell spelllang=en_us complete+=k
    autocmd FileType tex setlocal spell spelllang=en_us complete+=k
    autocmd FileType markdown setlocal spell spelllang=en_us complete+=k

    autocmd FileType requirements setlocal nospell

    autocmd BufNewFile,BufRead *.log setlocal nowrap
augroup END
