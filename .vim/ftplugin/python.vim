"Execute the current script
nnoremap <F5> :w <bar> exec '!python '.shellescape('%')<CR>

"Comment/uncomment line
noremap <C-s> I#<Esc>
inoremap <C-s> <Esc>I#<Esc>
noremap <C-q> ^x
inoremap <C-q> <Esc>^x

" insert python debugger line 
map <leader>D Oimport pdb; pdb.set_trace()<Esc>
map <leader>Q Oimport pdb; import QtCore; QtCore.pyqtRemoveInputHook(); pdb.set_trace()<Esc>
