"=============================================================================="
" Status Line Configuration
"=============================================================================="
"
" Configuration of the status line
"
"=============================================================================="

let g:airline#extensions#tabline#enabled = 1 " Tabline Integration

let g:airline#extensions#taboo#enabled = 1 " Taboo Integration

let g:airline#extensions#windowswap#enabled = 1 " Windowswap Integration

let g:airline#extensions#ycm#enabled = 1 " YCM Integration

let g:airline_theme = 'jml' " Use custom airline theme

let g:airline_powerline_fonts = 1 " Use patched symbol fonts

let g:airline_skip_empty_sections = 1 " Don't show a section when empty

if !exists('g:airline_symbols')
  let g:airline_symbols = {} " Default to empty symbols dict
endif

