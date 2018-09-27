" 
" CUSTOM MAPPINGS
"

if has("nvim")
    " Neovim terminal key mappings, see :help terminal-emulator-input
    tnoremap <Esc> <C-\><C-n>
    tnoremap <C-h> <C-\><C-n><C-h>
    tnoremap <C-j> <C-\><C-n><C-j>
    tnoremap <C-k> <C-\><C-n><C-k>
    tnoremap <C-l> <C-\><C-n><C-l>
endif


" save file as sudo
cnoremap w!! w !sudo tee > /dev/null %

noremap Y y$
noremap , ;
noremap ; ,
nnoremap ß $
xnoremap ß $

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
vnoremap j gj
vnoremap k gk
vnoremap 0 g0
vnoremap ^ g^
vnoremap $ g$

" Toggle fold in regular windows (not command line or quickfix window)
nnoremap <CR> za
augroup resetenter
    autocmd!
    autocmd CmdwinEnter * nnoremap <buffer> <CR> <CR>
    autocmd BufReadPost quickfix nnoremap <buffer> <CR> <CR>
augroup END

" enter paste mode when pasting
set pastetoggle=<F12>

" open netrw file browser
nnoremap <leader>N :Vexplore<CR>

" clear search hightlighting
nnoremap <leader>n :noh<CR><Esc>
" jump to previous buffer
nnoremap <leader><Space> <C-^>

" paste from most recent used register in insert mode
" overrides built-in i_Ctrl-V behaviour which can be achieved by C-q, too
inoremap <C-v> <C-r>"

" interact with system clipboard 
" http://sts10.github.io/blog/2016/02/12/best-of-my-vimrc/
nnoremap <leader>p "+]p
nnoremap <leader>P "+]P
" copy current line
nnoremap <leader>y :y+<CR>
vnoremap <leader>y "+y

" open .vimrc in new tab
noremap <leader>v :tabnew ~/.vim/startup<CR>
" reload .vimrc and makes all changes active
noremap <silent> <leader>V :source $MYVIMRC<CR>:filetype detect<CR>:exe ":echo 'vimrc reloaded'"<CR>

" Prettily format json: https://stackoverflow.com/a/16625961/3865876
command! -range -nargs=0 -bar Jsonify <line1>,<line2>!python -m json.tool
" ... and XML
command! Xmlify %!xmllint --format %

nnoremap g= mmgg=G''

" Copy File to clipboard
nnoremap <leader>cf gg"+yG<CR>

" Substitute Umlaute in current buffer
nnoremap <leader>su :%S/oe/ö/ge<CR>:%S/ae/ä/ge<CR>:%S/ue/ü/ge<CR>:%S/eü/eue/ge<CR>:%S/aü/aue/ge<CR>:%S/aktüll/aktuell/ge<CR>:nohlsearch<CR>

" Delete trailing Whitespace (automatically done in Python/C++ files when saving)
nnoremap <leader>dw :call DeleteWhitespace()<CR>

" Open :h in new tab; https://stackoverflow.com/a/3132202/3865876
cnoreabbrev <expr> h getcmdtype() == ":" && getcmdline() == 'h' ? 'tab help' : 'h'

" Substitute First suggestion of badly spelled word
nnoremap <leader>sf 1z=

" Search and replace word under cursor/selection on current line...
nnoremap <space>sl :'{,'}s/\<<c-r><c-w>\>//g<left><left>
xnoremap <space>sl y:'{,'}s/<c-r><c-0>//g<left><left>
" ...and in entire buffer
nnoremap <space>sb :%s/\<<c-r><c-w>\>//g<left><left>
xnoremap <space>sb y:%s/<c-r><c-0>//g<left><left>

" Delete all buffers except the current one, https://stackoverflow.com/a/42071865/3865876
command! BufOnly silent! execute '%bd | e# | bd#'

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
