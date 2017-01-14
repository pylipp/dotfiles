"
"SETTINGS

set nocompatible              " be iMproved, required

" install vim-plug if not existing
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" initialize vim-plug, including rtp update and more 
" https://github.com/junegunn/vim-plug/wiki/faq#migrating-from-other-plugin-managers
call plug#begin('~/.vim/bundle')

" Keep Plug commands between plug#begin/end. Use single quotes.
" Installing new plugin: add Plug, `source %`, :PlugInstall

" Code completion for C-languages and python
Plug 'Valloric/YouCompleteMe', { 'do': './install-py --clang-completer', 'frozen': 1 }
" TagBar
Plug 'majutsushi/tagbar'
" NerdTree
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
" TaskList
Plug 'vim-scripts/tasklist.vim'
" Correct python indentation according to PEP8 from https://github.com/vim-scripts/indentpython.vim
"Plug 'vim-scripts/indentpython.vim'
" Git integration https://github.com/tpope/vim-fugitive
Plug 'tpope/vim-fugitive'
" Python code completion
"Plug 'rkulla/pydiction'
" Ultisnips
"Plug 'SirVer/Ultisnips'
" Even better error highlighting
Plug 'scrooloose/syntastic'
" Python error highlighting
"Plug 'kevinw/pyflakes-vim' "or rather 'nvie/vim-flake8' ?
" Airline plging
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
" filetype dependent commenting
Plug 'tomtom/tcomment_vim'
" selection when opening files
Plug 'EinfachToll/DidYouMean'
" java completion
Plug 'artur-shaik/vim-javacomplete2', { 'for': 'java' }
" mappings to handle 'surroundings'
Plug 'tpope/vim-surround'
" correctly in/decrement dates and times
Plug 'tpope/vim-speeddating'
" enable repeating of plugin commands by .
Plug 'tpope/vim-repeat'
" ack integration in vim
Plug 'mileszs/ack.vim'
" Support for editing latex files 
Plug 'lervag/vimtex', {'for': 'tex' }
" Show git status of lines
Plug 'airblade/vim-gitgutter'
" Convenient moving of lines, TODO use mapping without Alt-key
" Plug 'matze/vim-move'


" All of your Plugs must be added before the following line
call plug#end()            " required


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


" for javacomplete2 plugin
" Solve Javavi error by running
" mvn -f ~/.vim/bundle/vim-javacomplete2/libs/javavi/pom.xml compile
autocmd FileType java setlocal omnifunc=javacomplete#Complete


" NERDTree - plugin to view the current directory
map <F2> :NERDTreeToggle<CR>


"Exuberant ctags - tag generation for language objects
"look for next tags file from current path up to Home
set tags=./tags;$HOME
"Goes to definition of function under cursor; <C-t> will jump back
map <C-s> <C-]>
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
let g:syntastic_auto_loc_list = 0
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_enable_signs = 1
let g:syntastic_python_checker_args = '--ignore=E225 --ignore=W291 --ignore=E231 --ignore=E702'
let g:syntastic_tex_checkers = []


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

" https://github.com/tomtom/tcomment_vim/issues/139
noremap <silent> gC :set opfunc=ToggleComment<CR>g@
vnoremap <silent> gC :<C-U>call ToggleComment(visualmode())<CR>

function! ToggleComment(type)
    " motion
    if a:type == "line" || a:type == "char" || a:type == "block"
        silent '[,'] norm gcc
    " visual
    else
        silent '<,'> norm gcc
    endif
endfunction
