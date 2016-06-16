"Execute the current script
nnoremap <F5> :w <bar> exec '!python '.shellescape('%')<CR>

" insert python debugger line 
map <leader>D Oimport pdb; pdb.set_trace()<Esc>
map <leader>Q Oimport pdb; import QtCore; QtCore.pyqtRemoveInputHook(); pdb.set_trace()<Esc>
