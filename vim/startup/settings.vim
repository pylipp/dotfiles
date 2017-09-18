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
set shiftwidth=4  "autoindent width, used for >>, << etc.
set backspace=2   "stop weird backspace behavior
set novisualbell  "no display blinking at EOF
set cursorline    "highlight current line
set textwidth=80  "automatic line break after 79 chars
set fileformat=unix "avoid conversion issues
set encoding=utf-8  "set encoding, useful for python3
set nowrap        "don't wrap long line
set colorcolumn=81 "Show end of long line
set pvh=25  " set preview window height
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

let mapleader=" "
let maplocalleader=" "

" hide banner in builtin file browser
let g:netrw_banner=0

" automatically read and save modified buffers
set autoread

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

syntax on       "enable syntax highlighting

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

" https://vi.stackexchange.com/questions/3359/how-do-i-fix-the-status-bar-symbols-in-the-airline-plugin?rq=1
" air-line
let g:airline_powerline_fonts = 1

if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif

" unicode symbols
let g:airline_left_sep = '»'
let g:airline_left_sep = '▶'
let g:airline_right_sep = '«'
let g:airline_right_sep = '◀'
let g:airline_symbols.linenr = '␊'
let g:airline_symbols.linenr = '␤'
let g:airline_symbols.linenr = '¶'
let g:airline_symbols.branch = '⎇'
let g:airline_symbols.paste = 'ρ'
let g:airline_symbols.paste = 'Þ'
let g:airline_symbols.paste = '∥'
let g:airline_symbols.whitespace = 'Ξ'

" airline symbols
let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_symbols.branch = ''
let g:airline_symbols.readonly = ''
let g:airline_symbols.linenr = ''
