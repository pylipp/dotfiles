fun! RenameFile() " Thanks to Gary Bernhardt & Ben Orenstein
    let old_name = expand('%')
    let new_name = input('New file name: ', expand('%'), 'file')
    if new_name != '' && new_name != old_name
        exec ':saveas ' . new_name
        exec ':silent !rm ' . old_name
        redraw!
    endif
endfun

fun! DeleteWhitespace()
    " remember current cursor position
    let l:l = line(".")
    let l:c = col(".")
    " substitute all trailing whitespace, ignore errors (i.e. no matches)
    %s/\s\+$//e
    call cursor(l:l, l:c)
endfun
