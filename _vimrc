"
"SETTINGS
"
set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.
" plugin on GitHub repo
" Code completion for C-languages and python
" Plugin 'Valloric/YouCompleteMe'
" TagBar
Plugin 'majutsushi/tagbar'
" NerdTree
Plugin 'scrooloose/nerdtree'
" TaskList
Plugin 'vim-scripts/tasklist.vim'
" Correct python indentation according to PEP8 from https://github.com/vim-scripts/indentpython.vim
"Plugin 'vim-scripts/indentpython.vim'
" Git integration https://github.com/tpope/vim-fugitive
Plugin 'tpope/vim-fugitive'
" Python code completion
"Plugin 'rkulla/pydiction'
" Ultisnips
"Plugin 'SirVer/Ultisnips'
" Even better error highlighting
Plugin 'scrooloose/syntastic'
" Python error highlighting
"Plugin 'kevinw/pyflakes-vim' "or rather 'nvie/vim-flake8' ?
" Airline plging
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
" filetype dependent commenting
Plugin 'tomtom/tcomment_vim'


" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

"
" PERSONAL SETTINGS
"
set autoindent  "indent if previous line is indented
set number      "set line numbering
set ls=2        "always show the status line
set ruler       "show cursor position in status bar
set background=dark "better readability
set ignorecase  "search options
set smartcase   "ignore case if search pattern is all lc, case-sensitive otherwise
set incsearch
set hlsearch    "highlight search patterns; escape with ...

set showcmd     " show incomplete cmds at the bottom
set showmode    " show current mode at the bottom

set tabstop=4
set expandtab     "convert tabs to whitespace
set softtabstop=4 "tab key indent
set shiftwidth=4  "autoindent width
set backspace=2   "stop weird backspace behavior
set cursorline    "highlight current line
set textwidth=79  "automatic line break after 79 chars
set fileformat=unix "avoid conversion issues
set encoding=utf-8  "set encoding, useful for python3
set nowrap        "don't wrap long line
set colorcolumn=81 "Show end of long line

set hidden      " allows making buffers hidden even without unsaved changes
set history=1000 "remember more commands and search history
set autoread    "autoread when a file is changed from the outside
set mouse=a     "enables the mouse in all modes

"Enable folding, from
"https://realpython.com/blog/python/vim-and-python-a-match-made-in-heaven/#.Vi9-CN7uzXY.reddit
set foldmethod=indent
set foldlevel=99

let mapleader=" "
" colorscheme settings (http://ethanschoonover.com/solarized/vim-colors-solarized)
syntax enable
set background=dark
colorscheme solarized

let python_highlight_all=1

au BufNewFile,BufRead,BufEnter *.iws set filetype=xml

map <F2> :NERDTreeToggle<CR>

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


" key mappings to insert a new line after current line without entering insert mode
"nmap <CR> o<Esc>
"map <Space> <C-d> "deprecated, Space used as leader key
noremap <C-Space> <C-u>
" save all current files
noremap <leader>w :wa<CR>
map Y y$
map ß $
noremap , ;
noremap ; ,
" disable arrow keys
noremap <Up> <NOP>
noremap <Down> <NOP>
noremap <Left> <NOP>
noremap <Right> <NOP>
" make vim's regex machine smarter at searching, refer to :h magic
nnoremap / /\v
" add closing brackets
"inoremap { {}<Esc>i
"inoremap [ []<Esc>i


" enter paste mode when pasting
set pastetoggle=<F12>
" clear search hightlighting
nnoremap <leader><Space> :noh<CR><Esc>

source $VIMRUNTIME/vimrc_example.vim
source $VIMRUNTIME/mswin.vim
behave mswin

set diffexpr=MyDiff()
" fix this via http://stackoverflow.com/questions/21862446/vimdiff-failing-with-cannot-read-or-write-temp-files
function MyDiff()
  let opt = '-a --binary '
  if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
  if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
  let arg1 = v:fname_in
  if arg1 =~ ' ' | let arg1 = '"' . arg1 . '"' | endif
  let arg2 = v:fname_new
  if arg2 =~ ' ' | let arg2 = '"' . arg2 . '"' | endif
  let arg3 = v:fname_out
  if arg3 =~ ' ' | let arg3 = '"' . arg3 . '"' | endif
  if $VIMRUNTIME =~ ' '
    if &sh =~ '\<cmd'
      if empty(&shellxquote)
        let l:shxq_sav = ''
        set shellxquote&
      endif
      let cmd = '"' . $VIMRUNTIME . '\diff"'
    else
      let cmd = substitute($VIMRUNTIME, ' ', '" ', '') . '\diff"'
    endif
  else
    let cmd = $VIMRUNTIME . '\diff'
  endif
  silent execute '!' . cmd . ' ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3
  if exists('l:shxq_sav')
    let &shellxquote=l:shxq_sav
  endif
endfunction
