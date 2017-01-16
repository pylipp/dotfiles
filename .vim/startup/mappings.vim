" 
" CUSTOM MAPPINGS
"

let mapleader=" "

"trying out this remapping of the Esc key
nnoremap öö <Esc>
inoremap öö <Esc>
vnoremap öö <Esc>gV
onoremap öö <Esc>

" key mappings for switching between multiple windows
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l
" mapping also enabled in insert mode
imap <C-h> <Esc><C-w>h
imap <C-j> <Esc><C-w>j
imap <C-k> <Esc><C-w>k
imap <C-l> <Esc><C-w>l
" enable movement mappings in insert mode
imap <C-d> <Esc><C-d>i
imap <C-u> <Esc><C-u>i
imap <C-f> <Esc><C-f>i
imap <C-b> <Esc><C-b>i


" save file as sudo
cmap w!! w !sudo tee > /dev/null %

map Y y$
noremap , ;
noremap ; ,

" disable arrow keys
nnoremap <Up> <NOP>
nnoremap <Down> <NOP>
nnoremap <Left> <NOP>
nnoremap <Right> <NOP>
inoremap <Up> <NOP>
inoremap <Down> <NOP>
inoremap <Left> <NOP>
inoremap <Right> <NOP>

" make vim's regex machine smarter at searching, refer to :h magic
nnoremap / /\v
vnoremap / /\v

" add closing brackets
"inoremap { {}<Esc>i
"inoremap [ []<Esc>i
"
nnoremap j gj
nnoremap k gk

" enter paste mode when pasting
set pastetoggle=<F12>

" clear search hightlighting
nnoremap <leader><Space> :noh<CR><Esc>


" interact with system clipboard 
" http://sts10.github.io/blog/2016/02/12/best-of-my-vimrc/ 
nnoremap <leader>p "+]p
nnoremap <leader>P "+]P
nnoremap <leader>y :y+<CR>
vnoremap <leader>y "+y

" open .vimrc in new tab
noremap <leader>v :tabnew $MYVIMRC<CR>
" reload .vimrc and makes all changes active
noremap <silent> <leader>V :source $MYVIMRC<CR>:filetype detect<CR>:exe ":echo 'vimrc reloaded'"<CR>


"
" MY VIM KEYMAPPINGS
"
" F1
" F2  c | toggle NerdTreeWindow
" F3  c | toggle TagBar
" F4  c | switch between .c* and .h* files
" F5  c | execute/compile and execute
" F6  c | jump to error
" F7  c | update ctags
" F8  c | toggle TaskList
" F9
" F10
" F11
" F12 c | pastetoggle
"
" C-a d | n: increment number under cursor, i: insert text written most recently
" C-b d | move one page up
" C-c d | interrupt
" C-d d | move half-page down
" C-e d | scroll downwards, current line at the top
" C-f d | move one page down
" C-g d | display filename, current and total line number etc
" C-h c | move to window on the left
" C-i c | open function definition under cursor in new hor. split window
" C-j c | move to window below
" C-k c | move to window above
" C-l c | move to window to the right
" C-m d | FUTILE (inserts new line)
" C-n c | FUTILE (insert next matching word) or used for UltiSnips?
" C-o d | jump to previous cursor position
" C-p d | insert previous matching word
" C-q d | uncomment current line
" C-r d | redo (undo the undo)
" C-s c | go to function definition under cursor (using ctags)
" C-t c | move back to place of function call (reverse C-z)
" C-u d | move half-page up
" C-v c | start visual block mode
" C-w c | prefix for window switching commands
" C-x c | decrement number
" C-y d | scroll upwards, current line at the bottom
" C-z d | suspend vim and return to shell; return to vim with fg


