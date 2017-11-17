"=============================================================================="
" Additional Highlight Groups and Colors
"=============================================================================="
"
" This file sets up some custom highlight settings
"
"=============================================================================="

" Highlight NB, N.B. as TODO
syn match jmlExtraTODO /\vN\.?B\.?/ contained
syn cluster cCommentGroup add=jmlExtraTODO
hi def link jmlExtraTODO TODO

" Highlight Search
hi Search ctermfg=6 ctermbg=15 cterm=bold,reverse
      \ guifg=DarkYellow guibg=Black gui=bold,reverse

" Highlight Cursors Line Number
hi CursorLineNr term=bold ctermfg=2 guifg=Green

" Highlight NERDTreeClosable and NERDTreeOpenable as PreProc
hi link NERDTreeOpenable PreProc
hi link NERDTreeClosable PreProc

" Some links in the json syntax file are non-standard
hi link JsonNumber Number
hi link jsonBoolean Constant
hi link jsonBraces  Function
hi link jsonQuote   Delimiter
