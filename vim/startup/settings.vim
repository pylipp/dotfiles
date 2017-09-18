"
" PERSONAL SETTINGS
"

set encoding=utf-8
scriptencoding utf-8

set modelines=0 "prevent security exploits
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

set softtabstop=4 "tab key indent
set shiftwidth=4  "autoindent width, used for >>, << etc.
set expandtab     "convert tabs to whitespace
set autoindent  "indent if previous line is indented

set backspace=2   "stop weird backspace behavior
set novisualbell  "no display blinking at EOF
set cursorline    "highlight current line
set fileformat=unix "avoid conversion issues
set previewheight=25  " set preview window height
set updatetime=500 " for gitgutter
set synmaxcol=200 " highlight first 200 chars of a long line

set wildmenu "show completion options for command line
set wildmode=list:longest
set undofile  "store undo actions in file
set path+=** "recursively search from cwd downwards when :find

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

" match angular brackets
set matchpairs+=<:>

let g:mapleader=" "
let g:maplocalleader=" "

" hide banner in builtin file browser
let g:netrw_banner=0

let g:xml_syntax_folding = 1

" define autocmd group to avoid reloading after repeated vimrc sourcing
augroup vimrc
    autocmd!
augroup END

" automatically equalized splits when Vim is resized
autocmd vimrc VimResized * wincmd =

" automatically read and save modified buffers
autocmd vimrc TextChanged,InsertLeave,FocusLost * silent! wall
autocmd vimrc CursorHold * silent! checktime

" When editing a file, always jump to the last known cursor position.
" Don't do it for commit messages, when the position is invalid, or when
" inside an event handler (happens when dropping a file on gvim).
autocmd vimrc BufReadPost *
    \ if &ft != 'gitcommit' && line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal g`\"" |
    \ endif

"
" COLOR AND SYNTAX HIGHLIGHTING SETTINGS
"

if !exists('g:syntax_on')
    " https://stackoverflow.com/questions/33380451/is-there-a-difference-between-syntax-on-and-syntax-enable-in-vimscript
    syntax enable       "enable syntax highlighting
endif

set t_Co=16
if &term!="xterm-256color" && &term!="xterm" && &term!="screen"
    "gnome/mate-terminal
    set t_Co=256            " use 265 colors in vim
    let g:solarized_termcolors=256
endif
colorscheme solarized " an appropriate color scheme

" highlight errors in bold, underlined red font
highlight clear SpellBad
highlight SpellBad ctermfg=1 cterm=bold,underline
highlight clear SpellCap
highlight SpellCap ctermfg=1 cterm=bold
highlight clear SpellRare
highlight SpellRare term=underline cterm=underline
highlight clear SpellLocal
highlight SpellLocal term=underline cterm=underline


if has("nvim")
    " path to python interpreter of neovim virtualenv
    let g:python3_host_prog = $WORKON_HOME . '/neovim/bin/python3'
endif
