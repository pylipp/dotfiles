" toggle between source and header file (C++)
set path=.,,..,../..,./*,./*/*,../*,~/,~/**,/usr/include/*
function! Mosh_Flip_Ext()
  " Switch editing between .c* and .h* files (and more).
  "   " Since .h file can be in a different dir, call find.
  if match(expand("%"),'\.c') > 0
    let s:flipname = substitute(expand("%"),'\.c\(.*\)','.h\1',"")
    exe ":find " s:flipname
  elseif match(expand("%"),"\\.h") > 0
	let s:flipname = substitute(expand("%"),'\.h\(.*\)','.c\1',"")
	exe ":e " s:flipname
  endif
endfun
map <F4> :call Mosh_Flip_Ext()<CR>


" Compile and execute. Creates a generic main executable
nnoremap <F5> :w <bar> exec '!g++ -Wall -g  -std=c++11 '.shellescape('%').' -o '.shellescape('main').' && ./'.shellescape('main')<CR>
"autocmd filetype c nnoremap <F5> :w <bar> exec '!gcc '.shellescape('%').' -o '.shellescape('%:r').' && ./'.shellescape('%:r')<CR>
