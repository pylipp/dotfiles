"
" PLUGIN MANAGEMENT
"

" initialize vim-plug, including rtp update and more
call plug#begin('~/.vim/bundle')

" Keep Plug commands between plug#begin/end. Use single quotes.
" Installing new plugin: add Plug, `source %`, :PlugInstall

" Code completion for C-languages and python
Plug 'Valloric/YouCompleteMe', { 'do': './install-py --clang-completer', 'frozen': 1 }
" TagBar
Plug 'majutsushi/tagbar'
" Git integration https://github.com/tpope/vim-fugitive
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-git'
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
" enable repeating of plugin commands by .
Plug 'tpope/vim-repeat'
" end certain control structures wisely
Plug 'tpope/vim-endwise'
" Support for editing latex files
Plug 'lervag/vimtex', {'for': 'tex' }
" Show git status of lines
Plug 'airblade/vim-gitgutter'
" Seamless tmux and vim navigation
Plug 'christoomey/vim-tmux-navigator'
" Helpers for UNIX shell commands
Plug 'tpope/vim-eunuch'
" Create non-existing directory when saving new file
Plug 'pbrisbin/vim-mkdir'
" Fuzzy file, buffer etc. searching
Plug '~/.fzf'
Plug 'junegunn/fzf.vim'
" asynchronous linting
Plug 'w0rp/ale'
" swap between eponymous files with different extensions (C++ header/src)
Plug 'kana/vim-altr'
" manage tag files
Plug 'ludovicchabant/vim-gutentags'
Plug 'joereynolds/gtags-scope', { 'for': ['c', 'cpp'], }
" QML syntax highlighting
Plug 'peterhoeg/vim-qml'
" more VIM objects
Plug 'wellle/targets.vim'
Plug 'michaeljsmith/vim-indent-object'
Plug 'jeetsukumaran/vim-pythonsense', { 'for': 'python', }
" enhanced * searching
Plug 'bronson/vim-visual-star-search'
" enhanced substitution
Plug 'tpope/tpope-vim-abolish'
Plug 'arthurxavierx/vim-caser'
" more [ ] mappings for navigation etc.
Plug 'tpope/vim-unimpaired'
" highlight all occurences of word under cursor
Plug 'RRethy/vim-illuminate', { 'for': ['python', 'cpp', 'qml', 'javascript', 'typescript', 'php'], }
" Python indents acc. to PEP8
Plug 'Vimjas/vim-python-pep8-indent', { 'for': 'python', }
" Python code folding
Plug 'tmhedberg/SimpylFold', { 'for': 'python', }
" grep integration
Plug 'mhinz/vim-grepper'
" enhanced C/C++ syntax highlighting
Plug 'octol/vim-cpp-enhanced-highlight'
" Enhanced hlsearch
Plug 'romainl/vim-cool'
" Resize location/quickfix window
Plug 'blueyed/vim-qf_resize'
" Syntax highlighting for bats test files
Plug 'aliou/bats.vim', { 'for': 'bats', }
" Utilities for CSV files
Plug 'chrisbra/csv.vim', { 'for': 'csv', }
" Markdown runtime files
Plug 'tpope/vim-markdown'
" Indentation highlighting
Plug 'nathanaelkane/vim-indent-guides'
" Split single-line instructions into multiline; and join again
Plug 'AndrewRadev/splitjoin.vim'
" Session management
Plug 'tpope/vim-obsession'
" behave utilities
Plug 'ea2809/behave.vim'
" GraphQL syntax files
Plug 'jparise/vim-graphql'
Plug 'wellle/context.vim'
Plug 'leafgarland/typescript-vim'
Plug 'cespare/vim-toml', { 'branch': 'main' }
Plug 'raimon49/requirements.txt.vim', {'for': 'requirements'}

" All of your Plugs must be added before the following line
call plug#end()


"
" ADDITIONAL PLUGIN-SPECIFIC SETTINGS AND MAPPINGS
"


"Exuberant ctags - tag generation for language objects
"look for next tags file from current path up to Home
set tags=./tags,./qmltags;$HOME
let g:gutentags_ctags_exclude = ['.mypy_cache/**/*.json']

" GNU Global integration using cscope interface
"   's'   symbol: find all references to the token under cursor
"   'g'   global: find global definition(s) of the token under cursor
"   'c'   calls:  find all calls to the function name under cursor
"   't'   text:   find all instances of the text under cursor
"   'e'   egrep:  egrep search for the word under cursor
"   'f'   file:   open the filename under cursor (key binding p for path)
"   'i'   includes: find files that include the filename under cursor
"   'd'   called: find functions that function under cursor calls
let g:GtagsCscope_Auto_Map = 0
let g:GtagsCscope_Auto_Load = 1
let g:GtagsCscope_Quiet = 1
nnoremap <leader>cs :cs find s <C-R>=expand("<cword>")<CR><CR>
nnoremap <leader>cg :cs find g <C-R>=expand("<cword>")<CR><CR>
nnoremap <leader>cc :cs find c <C-R>=expand("<cword>")<CR><CR>
nnoremap <leader>ct :cs find t <C-R>=expand("<cword>")<CR><CR>
nnoremap <leader>ce :cs find e <C-R>=expand("<cword>")<CR><CR>
nnoremap <leader>cp :cs find f <C-R>=expand("<cfile>")<CR><CR>
nnoremap <leader>ci :cs find i <C-R>=expand("<cfile>")<CR><CR>

"Tagbar - displays current code structure
nmap <leader>T :TagbarToggle<CR>
let g:tagbar_autofocus = 1 "jump to Tagbar when requested
let g:tagbar_autoclose = 1 "close Tagbar after tag selection
let g:tagbar_show_linenumbers = 1 "show linenumbers


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

" see also https://github.com/christoomey/dotfiles/blob/master/vim/rcplugins/ale-lint
" ALE populates the loclist; use [l, ]l from vim-unimpaired for navigating
let g:ale_lint_on_text_changed = 'normal'
let g:ale_lint_on_insert_leave = 1
let g:ale_sign_error = 'E>'
let g:ale_sign_warning = 'W>'
let g:ale_echo_msg_format = '[%linter%] %s'
let g:ale_linters = {
    \'python': ['flake8','mypy',],
    \'tex': ['chktex',],
    \'qml': ['qmlfmt',],
    \}
let g:ale_fixers = {
    \'python': ['black','isort'],
    \'qml': ['qmlfmt',],
    \}
let g:ale_fix_on_save = 1
" navigate between Warnings
nmap <silent> ]w <Plug>(ale_next_wrap)
nmap <silent> [w <Plug>(ale_previous_wrap)

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

" fzf.vim mappings
command! -bang -nargs=? -complete=dir Files
  \ call fzf#vim#files(<q-args>, fzf#vim#with_preview(), <bang>0)
nnoremap <leader>f :Files<CR>
nnoremap <leader>F :Files!<CR>

" mnemonic: Jump to buffer
nnoremap <silent> <leader>j :Buffers<CR>

" https://github.com/junegunn/fzf.vim/issues/732#issuecomment-437276088
command! -bang -nargs=* Rg
  \ call fzf#vim#grep('rg --column --no-heading --line-number --color=always '.shellescape(<q-args>),
  \ 1,
  \ fzf#vim#with_preview(),
  \ <bang>0)
nnoremap <leader>r :Rg<CR>

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

nnoremap <leader>g :Grepper<CR>
nmap gs <plug>(GrepperOperator)
xmap gs <plug>(GrepperOperator)
let g:grepper = {}
let g:grepper.tools = ['rg', 'ag', 'ack', 'ack-grep', 'grep', 'findstr',]
let g:grepper.prompt_mapping_tool = '<c-t>'

function! LightlineObsession()
    return '%{ObsessionStatus()}'
endfunction

let g:lightline = {
    \ 'active': {
    \   'left': [ [ 'mode', 'paste', 'spell' ],
    \             [ 'gitbranch', 'readonly', 'filename', 'modified', 'obsession' ] ]
    \ },
    \ 'component_function': {
    \   'gitbranch': 'fugitive#head'
    \ },
    \ 'component_expand': {
    \   'obsession': 'LightlineObsession'
    \ },
    \ }

highlight illuminatedWord term=bold cterm=bold
let g:Illuminate_ftHighlightGroups = {
    \ 'python:blacklist': ['pythonStatement', 'pythonImport'],
    \ }

" Force updating of gitgutter symbols in simple terminal
let g:gitgutter_terminal_reports_focus=0

" Customize mapping because gs is already used by vim-grepper
" This overwrites vim-abolish's coercion key binding
let g:caser_prefix='cr'

" Highlight cursor column in CSV file
let g:csv_highlight_column = 'y'
let g:csv_delim=';'

" vim-indent-guides settings
let g:indent_guides_start_level=2
let g:indent_guides_enable_on_vim_startup=1
let g:indent_guides_guide_size=4

" splitjoin settings
let g:splitjoin_trailing_comma = 1
