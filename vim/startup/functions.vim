fun! DeleteWhitespace()
    " remember current cursor position
    let l:l = line(".")
    let l:c = col(".")
    " substitute all trailing whitespace, ignore errors (i.e. no matches)
    %s/\s\+$//e
    call cursor(l:l, l:c)
endfun
