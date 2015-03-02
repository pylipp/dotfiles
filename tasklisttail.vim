" FOLLOWING CODE IS FROM https://github.com/vim-scripts/TaskList.vim/pull/2
" Quick-and-dirty toggle soluton.
" TODO: perfect simply solution: setup directory for [text_buffer, tasklist_buffer]
" Function: open task list for toggle {{{1
let s:tasklist_open = 0
function! s:OpenTaskList()
    let has_task_info = 0
    let has_task_info = s:TaskList()
    if (has_task_info == -1)
        " No task info found
        return
    endif
    let s:tasklist_open = 1
endfunction
" }}}

" Function: open task list for toggle {{{1
function! s:CloseTaskList()
    let tasklist_bufnr = bufnr('-TaskList_')
    if (bufloaded(tasklist_bufnr))
        " tasklist buffer is active.
        let tasklist_bufwinnr = bufwinnr(tasklist_bufnr)
        exec tasklist_bufwinnr . 'wincmd w'
        call s:Exit(0)
        let s:tasklist_open = 0
    else
        " Tasklist windows was closed by 'q', so 's:tasklist_open' can not
        " be reset.
        call s:OpenTaskList()
        return
    endif
endfunction
" }}}

" Function: Support toggle {{{1
function! s:ToggleTaskList()
    if (s:tasklist_open == 0)
        call s:OpenTaskList()
    else
        call s:CloseTaskList()
    endif
endfunction
" }}}
" Toggle Command
command! ToggleTaskList call s:ToggleTaskList()
" Key map to Toggle Command
nnoremap <unique> <script> <Plug>ToggleTaskList :ToggleTaskList<CR>

" vim:fdm=marker:tw=75:ff=unix:
