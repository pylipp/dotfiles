" 
" CUSTOM MAPPINGS
"

" save file as sudo
cnoremap w!! w !sudo tee > /dev/null %

noremap Y y$
nnoremap ß $
xnoremap ß $

inoremap  <C-w>

" more convenient jumping to mark position on German keyboard
noremap ' `
noremap ` '

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
inoremap (<CR> (<CR>)<Esc>O
inoremap {<CR> {<CR>}<Esc>O
inoremap {; {<CR>};<Esc>O
inoremap {, {<CR>},<Esc>O
inoremap [<CR> [<CR>]<Esc>O
inoremap [; [<CR>];<Esc>O
inoremap [, [<CR>],<Esc>O

" navigate between visual lines when line wrapped
nnoremap j gj
nnoremap k gk
nnoremap 0 g0
nnoremap ^ g^
nnoremap $ g$
nnoremap gj j
nnoremap gk k
nnoremap g0 0
nnoremap g^ ^
nnoremap g$ $
vnoremap j gj
vnoremap k gk
vnoremap 0 g0
vnoremap ^ g^
vnoremap $ g$
vnoremap gj j
vnoremap gk k
vnoremap g0 0
vnoremap g^ ^
vnoremap g$ $

" Toggle fold in regular windows (not command line or quickfix window)
nnoremap <CR> za
augroup resetenter
    autocmd!
    autocmd CmdwinEnter * nnoremap <buffer> <CR> <CR>
    autocmd BufReadPost quickfix nnoremap <buffer> <CR> <CR>
augroup END

" Move visual block (https://vimrcfu.com/snippet/77)
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

" Reselect visual block after changing indent
vnoremap < <gv
vnoremap > >gv

" enter paste mode when pasting
set pastetoggle=<F12>

" open netrw file browser
nnoremap <leader>N :Vexplore<CR>
" open URL under cursor
" https://github.com/vim/vim/issues/4738#issuecomment-521506447
nmap gx yiW:!xdg-open <cWORD><CR> <C-r>" & <CR><CR>

" clear search hightlighting
nnoremap <leader>n :noh<CR><Esc>
" jump to previous buffer
nnoremap <leader><Space> <C-^>
" change current word; next occurrences with .
nnoremap <leader>x *``cgn

" paste from most recent used register in insert mode
" overrides built-in i_Ctrl-V behaviour which can be achieved by C-q, too
inoremap <C-v> <C-r>"

" open .vimrc in new tab
noremap <leader>v :tabnew ~/.vim/startup<CR>
" reload .vimrc and makes all changes active
noremap <silent> <leader>V :source $MYVIMRC<CR>:filetype detect<CR>:exe ":echo 'vimrc reloaded'"<CR>

" Prettily format json: https://stackoverflow.com/a/16625961/3865876
command! -range -nargs=0 -bar Jsonify <line1>,<line2>!python -m json.tool
" ... and XML
command! Xmlify %!xmllint --format %

nnoremap g= mmgg=G''

" Open file under cursor without blocking vim
nnoremap gX :silent :execute
            \ "!xdg-open" expand('%:p:h') . "/" . expand("<cfile>") " &"<cr>

" Copy File to clipboard
nnoremap <leader>cf gg"+yG<CR>``
" Yank absolute Path of current buffer to clipboard
nmap <leader>yp :let @" = expand("%")<CR>

" Substitute Umlaute in current buffer
nnoremap <leader>su :%S/oe/ö/ge<CR>:%S/ae/ä/ge<CR>:%S/ue/ü/ge<CR>:%S/eü/eue/ge<CR>:%S/aü/aue/ge<CR>:%S/qü/que/ge<CR>:%S/aktüll/aktuell/ge<CR>:%S/söben/soeben/ge<CR>:nohlsearch<CR>

" Delete trailing Whitespace (automatically done in Python/C++ files when saving)
nnoremap <leader>dw :call DeleteWhitespace()<CR>

" Open :h in new tab; https://stackoverflow.com/a/3132202/3865876
cnoreabbrev <expr> h getcmdtype() == ":" && getcmdline() == 'h' ? 'tab help' : 'h'

" Insert current line in command line
cnoremap <C-r><C-l> <C-r>=getline('.')<CR>

" Substitute First suggestion of badly spelled word
nnoremap <leader>sf 1z=

" Set spelling language of buffer
nnoremap <leader>se :setlocal spell spelllang=en_us<CR>
nnoremap <leader>sd :setlocal spell spelllang=de_20<CR>

" Search and replace word under cursor/selection on current line...
nnoremap <space>sl :s/\<<c-r><c-w>\>//g<left><left>
xnoremap <space>sl y:s/<c-r><c-0>//g<left><left>
" ...and in entire buffer
nnoremap <space>sb :%s/\<<c-r><c-w>\>//g<left><left>
xnoremap <space>sb y:%s/<c-r><c-0>//g<left><left>
" ...and in quickfix entries
nnoremap <space>sq :cfdo %s/\<<c-r><c-w>\>//g<left><left>
xnoremap <space>sq y:cfdo %s/<c-r><c-0>//g<left><left>

" Delete all buffers except the current one, https://stackoverflow.com/a/42071865/3865876
command! BufOnly silent! execute '%bd | e# | bd#'

" https://vi.stackexchange.com/a/13435
command! -nargs=? -bar GChanges call setqflist(map(systemlist("git diff --name-only --ignore-submodules <args>"), '{"filename": v:val, "lnum": 1}')) | copen

" F1
" F2  c | toggle NerdTreeWindow
" F3  c | toggle TagBar
" F4  c | switch between .c* and .h* files
" F5  c | execute/compile and execute
" F6  c | jump to error
" F7  c | update ctags
" F8
" F9
" F10
" F11
" F12 c | pastetoggle

" NORMAL MODE CTRL KEYMAPPINGS (d: vim default, c: custom)
" C-a d | n: increment number under cursor, i: insert text written most recently
" C-b d | move one page up
" C-c d | interrupt
" C-d d | move half-page down
" C-e d | scroll downwards, current line at the top
" C-f d | move one page down
" C-g d | display filename, current and total line number etc
" C-h c | move to window on the left
" C-i d | jump to next cursor position
" C-j c | move to window below
" C-k c | move to window above
" C-l c | move to window to the right
" C-m d | FUTILE (inserts new line)
" C-n d | FUTILE (insert next matching word)
" C-o d | jump to previous cursor position
" C-p d | insert previous matching word
" C-q d | uncomment current line
" C-r d | redo (undo the undo)
" C-s c | UltiSnips select/next
" C-t d | jump to previous tag
" C-u d | move half-page up
" C-v d | start visual block mode
" C-w d | prefix for window switching commands
" C-x d | decrement number
" C-y d | scroll upwards, current line at the bottom
" C-z d | suspend vim and return to shell; return to vim with fg
" C-] d | go to function definition under cursor (using ctags)
