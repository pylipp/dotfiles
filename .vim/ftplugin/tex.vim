" from http://vim-latex.sourceforge.net/documentation/latex-suite/recommended-settings.html
" this is mostly a matter of taste. but LaTeX looks good with just a bit
" of indentation.
set sw=2
" TIP: if you write your \label's as \label{fig:something}, then if you
" type in \ref{fig: and press <C-n> you will automatically cycle through
" all the figure labels. Very useful!
set iskeyword+=:

"Comment/uncomment line
noremap <C-s> I%<Esc>
inoremap <C-s> <Esc>I%<Esc>
noremap <C-q> ^x
inoremap <C-q> <Esc>^x
