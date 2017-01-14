set nocompatible              " be iMproved, required

" load plugins from separate file
source ~/.vim/startup/plugins.vim

"
" PERSONAL SETTINGS
"

set modelines=0 "prevent security exploits
set autoindent  "indent if previous line is indented
set number      "set line numbering
set relativenumber "set relative line numbering
set laststatus=2        "always show the status line
set ttyfast "faster scrolling
set ruler       "show cursor position in status bar
set background=dark "better readability
set ignorecase  "search options
set wildignorecase  "ignore case for filename completion on command line
set smartcase   "ignore case if search pattern is all lc, case-sensitive otherwise
set gdefault "global substitutions by default
set incsearch
set showmatch
set hlsearch    "highlight search patterns; escape with ...


set showcmd     " show incomplete cmds at the bottom
set showmode    " show current mode at the bottom

set tabstop=4
set expandtab     "convert tabs to whitespace
set softtabstop=4 "tab key indent
set shiftwidth=4  "autoindent width
set backspace=2   "stop weird backspace behavior
set visualbell
set cursorline    "highlight current line
set textwidth=79  "automatic line break after 79 chars
set fileformat=unix "avoid conversion issues
set encoding=utf-8  "set encoding, useful for python3
set nowrap        "don't wrap long line
set colorcolumn=81 "Show end of long line
set pvh=25  " set preview window height
set updatetime=500 " for gitgutter

set wildmenu "show completion options for command line
set wildmode=list:longest
set undofile  "store undo actions in file

set hidden      " allows making buffers hidden even without unsaved changes
set history=1000 "remember more commands and search history
set autoread    "autoread when a file is changed from the outside
set mouse=a     "enables the mouse in all modes

" put backup, swp, and undo files into central location 
if has("unix")
    silent !mkdir -p ~/.vim/{backup,swp,undo}/
endif
set backupdir=~/.vim/backup/  " in neovim (different location)
set directory=~/.vim/swp/  " in neovim (different location)
set undodir=~/.vim/undo/  " in neovim (different location)

"Enable folding, from
"https://realpython.com/blog/python/vim-and-python-a-match-made-in-heaven/#.Vi9-CN7uzXY.reddit
set foldmethod=indent
set foldlevel=99
"nnoremap <space> za
"Plug 'tmhedberg/SimplyFold'
"let g:SimplyFold_docstring_preview=1

let mapleader=" "
"trying out this remapping of the Esc key
nnoremap öö <Esc>
inoremap öö <Esc>
vnoremap öö <Esc>gV
onoremap öö <Esc>

let python_highlight_all=1

syntax on       "enable syntax highlighting

set t_Co=256            " use 265 colors in vim
let g:solarized_termcolors=256
colorscheme solarized " an appropriate color scheme


" TaskList plugin for managing TODOs, FIXMEs and XXXs
map <F8> :ToggleTaskList<CR>
imap <F8> <Esc>:ToggleTaskList<CR>


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


" save all current files
noremap <leader>w :wa<CR>
" save file as sudo
cmap w!! w !sudo tee > /dev/null %

map Y y$
map ß $
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
nnoremap j gj
nnoremap k gk


" enter paste mode when pasting
set pastetoggle=<F12>

" clear search hightlighting
nnoremap <leader><Space> :noh<CR><Esc>


" Pyflakes
let g:pyflakes_use_quickfix = 0 "solves conflict with Quickfix
map <F6> :cc<CR>
noremap cn :cn<CR>
noremap <leader>c :cc<CR>
noremap <leader>n :cn<CR>
noremap <leader>p :cp<CR>
noremap <leader>cl :cclose<CR>
noremap <leader>co :copen<CR>


" open .vimrc in new tab
noremap <leader>v :tabnew $MYVIMRC<CR>
" reload .vimrc and makes all changes active
noremap <silent> <leader>V :source $MYVIMRC<CR>:filetype detect<CR>:exe ":echo 'vimrc reloaded'"<CR>


" highlight errors in gray background and bold red font
highlight clear SpellBad
highlight SpellBad ctermbg=7 ctermfg=1 cterm=bold
highlight clear SpellCap
highlight SpellBad ctermbg=7 ctermfg=1 cterm=bold
highlight clear SpellRare
highlight SpellRare term=underline cterm=underline
highlight clear SpellLocal
highlight SpellLocal term=underline cterm=underline

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

