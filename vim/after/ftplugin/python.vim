if exists('b:custom_python')
    finish
endif
let b:custom_python=1

if &textwidth==0
    setlocal textwidth=88
endif

" highlight long lines
highlight ColorColumn ctermfg=DarkYellow
let s:pattern='\%' . string(&textwidth+1) . 'v'
call matchadd('ColorColumn', s:pattern, 100)

" Alternate between module and corresponding test
if exists('g:loaded_altr')
    call altr#define('%/*/%.py', '%/test/test_%.py')
endif
