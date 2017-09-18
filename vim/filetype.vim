augroup filetypes
    autocmd!

    " OpenCL, from http://www.vim.org/scripts/script.php?script_id=3157
    autocmd BufNewFile,BufRead *.cl setf opencl

    "GL syntax hightlighting
    autocmd BufNewFile,BufRead *.gl,*.frag,*.vert,*.fp,*.vp,*.glsl setf glsl

    "xml syntax highlighting
    let g:xml_syntax_folding = 1
    autocmd BufNewFile,BufRead *.xml,*.imf,*.iws setf xml

    " Options for text-like files. Global defaults should suffice
    autocmd BufRead,BufNewFile *.html,*.xml,*.txt,README*,*.tex,*.md setlocal linebreak
augroup END
