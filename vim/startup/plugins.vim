"
" PLUGIN MANAGEMENT
"

" install vim-plug if not existing
" TODO use git submodule instead
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" initialize vim-plug, including rtp update and more
call plug#begin('~/.vim/bundle')

" Keep Plug commands between plug#begin/end. Use single quotes.
" Installing new plugin: add Plug, `source %`, :PlugInstall

" Code completion for C-languages and python
Plug 'Valloric/YouCompleteMe', { 'do': './install-py --clang-completer', 'frozen': 1 }
" TagBar
Plug 'majutsushi/tagbar'
" TaskList
Plug 'pylipp/tasklist.vim'
" Git integration https://github.com/tpope/vim-fugitive
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-git'
" Ultisnips
Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'
" Lightline statusline plugin
Plug 'itchyny/lightline.vim'
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
if has('python')
    " ROS helpers
    Plug 'taketwo/vim-ros'
endif
" Seamless tmux and vim navigation
Plug 'christoomey/vim-tmux-navigator'
" Helpers for UNIX shell commands
Plug 'tpope/vim-eunuch'
" Create non-existing directory when saving new file
Plug 'pbrisbin/vim-mkdir'
" Fuzzy file, buffer etc. searching
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
" asynchronous linting
Plug 'w0rp/ale'
" swap between eponymous files with different extensions (C++ header/src)
Plug 'kana/vim-altr'
" instant markdown preview in browser
Plug 'pylipp/vim-markdown-preview', { 'for': 'markdown', 'branch': 'feature/colorscheme' }
" manage tag files
Plug 'ludovicchabant/vim-gutentags'
" QML syntax highlighting
Plug 'peterhoeg/vim-qml'
" more VIM objects
Plug 'wellle/targets.vim'
Plug 'michaeljsmith/vim-indent-object'
" enhanced * searching
Plug 'bronson/vim-visual-star-search'
" enhanced substutite
Plug 'tpope/tpope-vim-abolish'
" more [ ] mappings for navigation etc.
Plug 'tpope/vim-unimpaired'
" template files
Plug 'aperezdc/vim-template'
" highlight all occurences of word under cursor
Plug 'dominikduda/vim_current_word', { 'for': ['python', 'cpp', 'qml'], }
" Python indents acc. to PEP8
Plug 'Vimjas/vim-python-pep8-indent', { 'for': 'python', }
" Python code folding
Plug 'tmhedberg/SimpylFold', { 'for': 'python', }
" grep integration
Plug 'mhinz/vim-grepper'

" All of your Plugs must be added before the following line
call plug#end()


"
" ADDITIONAL PLUGIN-SPECIFIC SETTINGS AND MAPPINGS
"


"Exuberant ctags - tag generation for language objects
"look for next tags file from current path up to Home
set tags=./tags;$HOME


"Tagbar - displays current code structure
nmap <leader>T :TagbarToggle<CR>
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

" make ALE linting less aggressive
" from https://github.com/christoomey/dotfiles/blob/master/vim/rcplugins/ale-lint
" ALE populates the loclist; use [l, ]l from vim-unimpaired for navigating
augroup plugin-ale
    autocmd!
    autocmd InsertLeave * call ale#Lint()
    autocmd TextChanged * call ale#Lint()
    " autocmd CursorHold * call ale#Lint()
    " autocmd CursorHoldI * call ale#Lint()
    highlight ALEWarningSign ctermfg=3
augroup END
let g:ale_lint_on_text_changed = 0
let g:ale_sign_error = 'E>'
let g:ale_sign_warning = 'W>'
let g:ale_echo_msg_format = '[%linter%] %s'
let g:ale_linters = {
    \'python': ['flake8',],
    \'tex': ['chktex',],
    \'qml': ['qmlfmt',],
    \}
let g:ale_fixers = {
    \'python': ['yapf',],
    \'qml': ['qmlfmt',],
    \}
" navigate between Warnings
nmap <silent> ]w <Plug>(ale_next_wrap)
nmap <silent> [w <Plug>(ale_previous_wrap)

nnoremap <leader>cb :<C-u>call CommentBox()<CR>

" https://github.com/tomtom/tcomment_vim/issues/139
nnoremap <silent> gC :set opfunc=ToggleComment<CR>g@
xnoremap <silent> gC :<C-U>call ToggleComment(visualmode())<CR>

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
augroup plugin-vimtex
  autocmd!
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
command! -bang -nargs=? -complete=dir Files
  \ call fzf#vim#files(<q-args>, fzf#vim#with_preview(), <bang>0)
nnoremap <leader>f :Files<CR>
nnoremap <leader>F :Files!<CR>

" mnemonic: Jump to buffer
nnoremap <silent> <leader>j :Buffers<CR>

command! -bang -nargs=* Ag
  \ call fzf#vim#ag(<q-args>,
  \                 fzf#vim#with_preview('right:50%', '?'),
  \                 <bang>0)
nnoremap <leader>a :Ag<CR>
" Search for word under cursor
nnoremap <leader>A :Ag <C-R>=expand('<cword>')<CR><CR>

" http://www.wezm.net/technical/2016/09/ripgrep-with-vim/
command! -bang -nargs=* Rg
      \ call fzf#vim#grep(
      \   'rg --column --color --ignore-case '.shellescape(<q-args>), 1,
      \   <bang>0)
nnoremap <leader>r :Rg<space>

" slow; would be nicer to have output of g] in quickfix list
nnoremap <leader>t :Tags <C-R>=expand('<cword>')<CR><CR>

nnoremap <leader>l :Lines<CR>

" These two paragraph are from :h fzf-vim-usage
" Search command mappings in normal, visual and operator pending mode
nmap <leader><tab> <plug>(fzf-maps-n)
xmap <leader><tab> <plug>(fzf-maps-x)
omap <leader><tab> <plug>(fzf-maps-o)

" Insert mode completion, see :h fzf-vim-mappings
imap <c-x><c-k> <plug>(fzf-complete-word)
imap <c-x><c-f> <plug>(fzf-complete-path)
imap <c-x><c-j> <plug>(fzf-complete-file-ag)
imap <c-x><c-l> <plug>(fzf-complete-line)

let g:fzf_action = {
            \ 'ctrl-s': 'split',
            \ 'ctrl-v': 'vsplit',
            \ 'ctrl-t': 'tab split' }

" altr-vim mappings, mnemonic: SourceHeader
nnoremap <leader>sh :call altr#forward()<CR>

nnoremap <leader>se :setlocal spell spelllang=en_us<CR>
nnoremap <leader>sd :setlocal spell spelllang=de_20<CR>

nnoremap <leader>g :Grepper<CR>
nmap gs <plug>(GrepperOperator)
xmap gs <plug>(GrepperOperator)

" vim-markdown-preview settings (requires see, ~/.mailcap)
let g:vim_markdown_preview_hotkey='<leader>mp'
let g:vim_markdown_preview_browser='qutebrowser'
let g:vim_markdown_preview_colorscheme='solarized-dark'
" update preview on BufWrite
let g:vim_markdown_preview_toggle=3

let g:UltiSnipsExpandTrigger='<C-s>'
let g:UltiSnipsSnippetDirectories=['UltiSnips', 'snips']

" specify non-public and public custom templates
let g:templates_directory=['~/.templates', '~/.vim/templates']
let g:templates_no_builtin_templates=1

let g:lightline = {
    \ 'colorscheme': 'solarized',
    \ 'active': {
    \   'left': [ [ 'mode', 'paste', 'spell' ],
    \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
    \ },
    \ 'component_function': {
    \   'gitbranch': 'fugitive#head'
    \ },
    \ }

highlight CurrentWord term=bold cterm=bold

" Force updating of gitgutter symbols in simple terminal
let g:gitgutter_terminal_reports_focus=0
