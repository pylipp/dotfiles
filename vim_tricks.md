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

### Move current line to

- top of screen:    zt
- center of screen: zz
- bottom of screen: zb

### Jump to last edited position

- g;

### Correct indentation of code block

- =iB
- =aB (includes brackets)
