# Vim tips

### Search and replace via text object

Search for `<term>` in buffer: `/<term><CR>`
Change (or delete with `d`) the found text object: `cgn<new><Esc>`
Repeat if desired: `.`

### [Replay macro for entire buffer](http://stackoverflow.com/questions/1291962/replay-a-vim-macro-until-end-of-buffer)

Say the macro is stored in register `x`: `:%normal @x`

### [Delete text objects](http://blog.carbonfive.com/2011/10/17/vim-text-objects-the-definitive-guide/)

Cursor positioned inside the text object.

- Word: `diw daw` (leave/remove trailing whitespace)
- Sentence: `dis das`
- Paragraph: `dip dap`

### Suspend vim, return to shell

- :sus
- return using by fg

### Open/close fold

- zo
- zc

### Open/close all folds
- zM
- zR

### Move current line to

- top of screen:    zt
- center of screen: zz
- bottom of screen: zb

### Jump to last edited position

- g;

### Correct indentation of code block

- =iB
- =aB (includes brackets)

### Write to protected file without reopening Vim (https://til.hashrocket.com/posts/7eac005efb-write-into-a-protected-file-without-reopening-vim)

- :w !sudo tee %

### Native Vim file tree view mode (https://til.hashrocket.com/posts/ddb7a2c4b9-vim-tree-view-mode)

- start with `:Explore`
- help via F1

### Open buffer in horizontal/vertical split

- :sbuffer N
- :vert sb N

### Intelligent expression deletion (http://www.viemu.com/a-why-vi-vim.html)

- c% or d%

### Paste in insert mode (http://www.viemu.com/a-why-vi-vim.html)

- C-r <register>
- C-r = will prompt you to enter an expression (:help i_ctrl-r)

### Open http link in browser

- gx

### Open file under cursor

- gf

### Context-aware line completion (https://www.youtube.com/watch?v=3TX3kV3TICU)

- C-x C-l
- C-x C-p
- C-x C-k (dictionary completion)

### Read shell output into current file (https://www.reddit.com/r/vim/comments/4sls0w/macro_practice_formatting_images_filenames_into/)

- :r !ls *.py 
- :.ls .py

### Execute normal command during insert mode 

- C-o <command> 

### Run and evaluate python2/3 commands

- :python import datetime
- :put= pyeval('str(datetime.date.today())')
- :pyfile <script.py>

### Vim spell check,  https://robots.thoughtbot.com/vim-spell-checking and http://vimcasts.org/episodes/spell-checking/

- zg: add word under cursor to dictionary
- zw: remove word from dictionary
- z=: correct suggestions for word under cursor
- [s, ]s: navigate to previous/next spell error
