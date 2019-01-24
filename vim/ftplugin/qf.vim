if exists('b:custom_qf')
    finish
endif
let b:custom_qf=1

" http://vim.wikia.com/wiki/Automatically_fitting_a_quickfix_window_height
exe max([min([line('$'), 10]), 1]) . 'wincmd _'
setlocal nowrap
