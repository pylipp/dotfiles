"
" PLUGIN MANAGEMENT
"  

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
Plug 'pylipp/tasklist.vim'
" Correct python indentation according to PEP8 from https://github.com/vim-scripts/indentpython.vim
"Plug 'vim-scripts/indentpython.vim'
" Git integration https://github.com/tpope/vim-fugitive
Plug 'tpope/vim-fugitive'
" Python code completion
"Plug 'rkulla/pydiction'
" Ultisnips
Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'
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
" Support for editing latex files 
Plug 'lervag/vimtex', {'for': 'tex' }
" Show git status of lines
Plug 'airblade/vim-gitgutter'
" Convenient moving of lines, TODO use mapping without Alt-key
" Plug 'matze/vim-move'
" ROS helpers
Plug 'taketwo/vim-ros'
" Seamless tmux and vim navigation
Plug 'christoomey/vim-tmux-navigator'
" quick split and join of lines using gS and gJ
Plug 'AndrewRadev/splitjoin.vim'
" Helpers for UNIX shell commands 
Plug 'tpope/vim-eunuch'
" Fuzzy file, buffer etc. searching
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
" asynchronous linting
Plug 'w0rp/ale'
" continuously update session files 
Plug 'tpope/vim-obsession'
" swap between eponymous files with different extensions (C++ header/src)
Plug 'kana/vim-altr'
" instant markdown preview in browser
Plug 'pylipp/vim-markdown-preview', { 'branch': 'bugfix/firefox' }
Plug 'Yggdroot/indentLine'
" manage tag files
Plug 'ludovicchabant/vim-gutentags'
Plug 'peterhoeg/vim-qml'
Plug 'wellle/targets.vim'
Plug 'bronson/vim-visual-star-search'
Plug 'michaeljsmith/vim-indent-object'
Plug 'tpope/tpope-vim-abolish'


" All of your Plugs must be added before the following line
call plug#end()            " required


"
" ADDITIONAL PLUGIN-SPECIFIC SETTINGS AND MAPPINGS
"


"Exuberant ctags - tag generation for language objects
"look for next tags file from current path up to Home
set tags=./tags;$HOME


" NERDTree - plugin to view the current directory
map <F2> :NERDTreeToggle<CR>


"Tagbar - displays current code structure
nmap <F3> :TagbarToggle<CR>
let g:tagbar_autofocus = 1 "jump to Tagbar when requested
let g:tagbar_autoclose = 1 "close Tagbar after tag selection
let g:tagbar_show_linenumbers = 1 "show linenumbers


" TaskList plugin for managing TODOs, FIXMEs and XXXs
map <F8> :ToggleTaskList<CR>
imap <F8> <Esc>:ToggleTaskList<CR>


" YouCompleteMe code completion engine
" https://github.com/Valloric/YouCompleteMe/blob/master/doc/youcompleteme.txt
" let g:ycm_global_ycm_extra_conf = '~/.ycm_extra_conf.py'
let g:ycm_confirm_extra_conf = 0
let g:ycm_error_symbol = '⚡︎ '
let g:ycm_warning_symbol = '⚠︎ '
let g:ycm_autoclose_preview_window_after_completion = 0
let g:ycm_autoclose_preview_window_after_insertion = 1
let g:ycm_complete_in_comments = 1
let g:ycm_key_list_select_completion = ['<C-n>', '<TAB>']
let g:ycm_key_list_previous_completion = ['<C-p>', '<S-TAB>']
" make jedi select Python interpreter from PATH (helpful in venvs)
let g:ycm_python_binary_path = 'python'
" let g:ycm_key_invoke_completion = '<leader>ys' "s = semantic completion
nnoremap <leader>yg :YcmCompleter GoTo<CR>
nnoremap <leader>yd :YcmDiags<CR>
nnoremap <leader>yf :YcmCompleter FixIt<CR>
nnoremap <leader>yr :YcmCompleter GoToReferences<CR>
nnoremap <leader>yt :YcmCompleter GetType<CR>
" h for help
nnoremap <leader>yh :YcmCompleter GetDoc<CR>

let g:ycm_semantic_triggers = {
\   'roslaunch' : ['="', '$(', '/'],
\   'rosmsg,rossrv,rosaction' : ['re!^', '/'],
\ }

" Syntastic syntax check
set statusline+=%#warningmsg#
" set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

" make ALE linting less aggressive
" from https://github.com/christoomey/dotfiles/blob/master/vim/rcplugins/ale-lint
set updatetime=1000
" autocmd CursorHold * call ale#Lint()
" autocmd CursorHoldI * call ale#Lint()
autocmd InsertLeave * call ale#Lint()
autocmd TextChanged * call ale#Lint()
let g:ale_lint_on_text_changed = 0

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

let g:vimtex_view_method = 'zathura'

" https://github.com/lervag/vimtex/issues/537#issuecomment-249684619
" open Vimtex compile output in tab and return to first tab
augroup MyVimtex
  au!
  autocmd User VimtexEventCompileStarted 
    \   call vimtex#compiler#output() 
    \   | wincmd T | tabfirst
augroup END

let g:ros_catkin_make_options = '-DCMAKE_EXPORT_COMPILE_COMMANDS=ON'

if executable('ag')
    " stole those from https://github.com/colbycheeze/dotfiles/blob/master/vimrc.bundles
    set grepprg=ag\ --nogroup\ --nocolor
endif

" fzf.vim mappings
noremap <C-p> :Files<CR>
nnoremap <silent> <leader>b :Buffers<CR>

let g:fzf_action = {
            \ 'ctrl-s': 'split', 
            \ 'ctrl-v': 'vsplit',
            \ 'ctrl-t': 'tab split' }

" altr-vim mappings, mnemonic: SourceHeader
nmap <leader>sh <Plug>(altr-forward)

nnoremap <leader>se :set spell! spelllang=en_us<CR>
nnoremap <leader>sd :set spell! spelllang=de_20<CR>

" vim-markdown-preview settings (requires see, ~/.mailcap)
let vim_markdown_preview_hotkey='<leader>mp'
let vim_markdown_preview_browser='firefox'
" update preview on BufWrite
let vim_markdown_preview_toggle=3

" indentLine settings to max out performance
let g:indentLine_faster = 1
" let g:indentLine_setConceal = 0

let g:UltiSnipsExpandTrigger='<C-j>'
let g:UltiSnipsJumpForwardTrigger='<C-j>'
let g:UltiSnipsJumpBackwardTrigger='<C-k>'
let g:UltiSnipsEditSplit = 'vertical'
"let g:UltiSnipsSnippetsDir = '~/.files/snippets'
