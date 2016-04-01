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
Plugin 'Valloric/YouCompleteMe'
" TagBar
Plugin 'majutsushi/tagbar'
" NerdTree
Plugin 'scrooloose/nerdtree'
" TaskList
Plugin 'vim-scripts/tasklist.vim'
" Correct python indentation according to PEP8 from https://github.com/vim-scripts/indentpython.vim
"Plugin 'vim-scripts/indentpython.vim'
" Git integration https://github.com/tpope/vim-fugitive
"Plugin 'tpope/vim-fugitive'
" Python code completion
"Plugin 'rkulla/pydiction'
" Ultisnips
"Plugin 'SirVer/Ultisnips'
" Even better error highlighting 
Plugin 'scrooloose/syntastic'
" Python error highlighting
"Plugin 'kevinw/pyflakes-vim' "or rather 'nvie/vim-flake8' ?


" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line


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
"nnoremap <space> za 
"Plugin 'tmhedberg/SimplyFold'
"let g:SimplyFold_docstring_preview=1

let mapleader=" "
"trying out this remapping of the Esc key
nnoremap üü <Esc>
inoremap üü <Esc>
vnoremap üü <Esc>gV
onoremap üü <Esc>

let python_highlight_all=1

syntax on       "enable syntax highlighting
set t_Co=256            " use 265 colors in vim
let g:solarized_termcolors=256
colorscheme solarized " an appropriate color scheme

if &term!="xterm"
   set t_Co=256            " use 265 colors in vim
   let g:solarized_termcolors=256
   colorscheme solarized " an appropriate color scheme
endif


"set wrap options 
autocmd FileType html,xml,text,README,tex set wrap linebreak textwidth=124 colorcolumn=125


if &term!="xterm"
   set t_Co=256            " use 265 colors in vim
   let g:solarized_termcolors=256
   colorscheme solarized " an appropriate color scheme
endif


" NERDTree - plugin to view the current directory
map <F2> :NERDTreeToggle<CR>


" short cut for running/compiling code


" comment/uncomment line
autocmd filetype vim noremap <C-s> I"<Esc>
autocmd filetype vim noremap <C-q> ^x
autocmd filetype glsl noremap <C-s> I//<Esc>
autocmd filetype glsl noremap <C-q> ^xx
"noremap <C-s> I#<Esc>


"Exuberant ctags - tag generation for language objects
"look for next tags file from current path up to Home
set tags=./tags;$HOME
"Goes to definition of function under cursor; <C-t> will jump back
map <C-z> <C-]>
"opens definition in horizontal split window
"map <C-i> <C-w><C-]> "avoiding because it shadows <TAB>
"refresh tags, calls bash script in /usr/bin
map <silent> <F7> :w <bar> :!.update-ctags.sh<CR><CR>


"Tagbar - displays current code structure
nmap <F3> :TagbarToggle<CR>
let g:tagbar_autofocus = 1 "jump to Tagbar when requested
let g:tagbar_autoclose = 1 "close Tagbar after tag selection
let g:tagbar_show_linenumbers = 1 "show linenumbers 


" YouCompleteMe code completion engine
" https://github.com/Valloric/YouCompleteMe/blob/master/doc/youcompleteme.txt
let g:ycm_global_ycm_extra_conf = '~/.ycm_extra_conf.py'
let g:ycm_confirm_extra_conf = 0
let g:ycm_error_symbol = '⚡︎ '
let g:ycm_warning_symbol = '⚠︎ '
let g:ycm_autoclose_preview_window_after_completion = 0
let g:ycm_autoclose_preview_window_after_insertion = 1
let g:ycm_complete_in_comments = 1
let g:ycm_key_list_select_completion = ['<Down>', '<Enter>']
"map <leader>g :YcmCompleter GoToDefinitionElseDeclaration<CR>



" Syntastic syntax check 
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
"let g:syntastic_always_populate_loc_list = 1
"let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_enable_signs = 1
let g:syntastic_python_checker_args = '--ignore=E225 --ignore=W291 --ignore=E231 --ignore=E702'


" UltiSnips plugin for snippet support
" remapping trigger key (originally TAB) to solve conflict with YCM
"function! g:UltiSnips_Complete()
"    call UltiSnips#ExpandSnippet()
"    if g:ulti_expand_res == 0
"        if pumvisible()
"            return "\<C-n>"
"        else
"            call UltiSnips#JumpForwards()
"            if g:ulti_jump_forwards_res == 0
"               return "\<TAB>"
"            endif
"        endif
"    endif
"    return ""
"endfunction
"
"au BufEnter * exec "inoremap <silent> " . g:UltiSnipsExpandTrigger . " <C-R>=g:UltiSnips_Complete()<cr>"
""let g:UltiSnipsExpandTrigger="<tab>" "done by default
"let g:UltiSnipsJumpForwardTrigger="<C-m>"
""let g:UltiSnipsListSnippets="<C-n>"
"let g:UltiSnipsJumpBackwardTrigger="<C-S-m>"


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


" Pyflakes
let g:pyflakes_use_quickfix = 0 "solves conflict with Quickfix
map <F6> :cc<CR>
noremap cn :cn<CR>


"search for pattern 
com -nargs=1 Pyfilesearch call Pyfilesearch(<f-args>)
com -nargs=1 Filesearch call Filesearch(<f-args>)
function! Pyfilesearch(pattern)
    exe "noautocmd silent grep " a:pattern "**/*.py"
    exe ":copen" 
endfunction 
function! Filesearch(pattern)
    exe "noautocmd silent grep -R" a:pattern "."
    exe ":copen" 
endfunction 
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
" C-s c | comment current line
" C-t c | move back to place of function call (reverse C-z)
" C-u d | move half-page up
" C-v c | start visual block mode
" C-w c | prefix for window switching commands
" C-x c | decrement number
" C-y d | scroll upwards, current line at the bottom
" C-z c | go to function definition under cursor (using ctags)
