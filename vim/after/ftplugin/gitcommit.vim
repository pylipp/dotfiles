" set cursor to top of file
call setpos('.', [0, 1, 1, 0])

" handy mapping of vim-git command
nnoremap <leader>d :DiffGitCached<CR>
