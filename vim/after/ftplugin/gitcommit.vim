" set cursor to top of file
call setpos('.', [0, 1, 1, 0])

" handy mapping of vim-git command
nnoremap <leader>d :DiffGitCached<CR>

" Activate spell checking
setlocal spell spelllang=en_us

" Avoid indenting when inserting newline (e.g. after multi-line in bulleted list)
setlocal noautoindent
