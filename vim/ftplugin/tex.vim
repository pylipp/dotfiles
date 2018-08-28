if exists('b:custom_tex')
    finish
endif
let b:custom_tex=1

" from http://vim-latex.sourceforge.net/documentation/latex-suite/recommended-settings.html
" this is mostly a matter of taste. but LaTeX looks good with just a bit
" of indentation.
setlocal shiftwidth=2
setlocal softtabstop=2

" Convert some expressions to utf-8 symbols (delimiters, math symbols, greek
" letters, super/subscripts); see :help tex-conceal
setlocal conceallevel=2
let g:tex_conceal='bdmgs'

" TIP: if you write your \label's as \label{fig:something}, then if you
" type in \ref{fig: and press <C-n> you will automatically cycle through
" all the figure labels. Very useful!
setlocal iskeyword+=:

if !exists('g:ycm_semantic_triggers')
  let g:ycm_semantic_triggers = {}
endif
let g:ycm_semantic_triggers.tex = g:vimtex#re#youcompleteme

let g:vimtex_fold_enabled=1
