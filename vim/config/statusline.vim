"=============================================================================="
" Status Line Configuration
"=============================================================================="
"
" Configuration of the status line
"
"=============================================================================="

let g:airline#extensions#tabline#enabled = 1 " Tabline Integration

let g:airline#extensions#taboo#enabled = 1 " Taboo Integration

" let g:airline#extensions#windowswap#enabled = 1 " Windowswap Integration

" let g:airline#extensions#ycm#enabled = 1 " YCM Integration

let g:airline_theme = 'jml' " Use custom airline theme

let g:airline_powerline_fonts = 1 " Use patched symbol fonts

let g:airline_skip_empty_sections = 1 " Don't show a section when empty

if !exists('g:airline_symbols')
  let g:airline_symbols = {} " Default to empty symbols dict
endif

let g:airline_symbols.notexists = '¿'

" RVM Status Line {{{ "

" function! GetRVMInfo()
"   return split(rvm#string(), '@')
" endf

" function! GetRVMRubyVersion()
"   let l:info = GetRVMInfo()
"   return get(l:info, 0, 'ruby')
" endf

" function! GetRVMGemset()
"   let l:info = GetRVMInfo()
"   return get(l:info, 1, 'NONE')
" endf

" function! AddRVMStatusLineParts(...)
"   if &filetype == 'ruby'
"     call airline#parts#define_function('rvm_v', 'GetRVMRubyVersion')
"     call airline#parts#define_accent('rvm_v', 'rvm_rubyversion')
"     call airline#parts#define_function('rvm_g', 'GetRVMGemset')
"     call airline#parts#define_accent('rvm_g', 'rvm_gemset')
"     let w:airline_section_x = airline#section#create_right([' ', 'rvm_v', '@', 'rvm_g'])
"   endif
" endf

" call airline#add_statusline_func('AddRVMStatusLineParts')

" }}} RVM Status Line "
