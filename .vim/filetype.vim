" OpenCL, from http://www.vim.org/scripts/script.php?script_id=3157
au BufNewFile,BufRead *.cl setf opencl
"GL syntax hightlighting 
au BufNewFile,BufRead *.gl,*.frag,*.vert,*.fp,*.vp,*.glsl setf glsl 
"xml syntax highlighting 
let g:xml_syntax_folding = 1
au BufNewFile,BufRead *.xml,*.imf,*.iws setf xml
