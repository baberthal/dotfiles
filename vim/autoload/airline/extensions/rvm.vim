" MIT License. Copyright (c) 2017 J. Morgan Lieberthal
" vim: et ts=2 sts=2 sw=2

scriptencoding utf-8

" we don't actually want this loaded :P
if !exists('g:loaded_rvm')
  finish
endif

" Due to some potential rendering issues, the use of the `space` variable is
" recommended.
let s:spc = g:airline_symbols.space

" First we define an init function that will be invoked from extensions.vim
function! airline#extensions#rvm#init(ext)
  " Here we define a new part for the plugin.  This allows users to place this
  " extension in arbitrary locations.
  call airline#parts#define_raw('rvm_version', '%{airline#extensions#rvm#get_version()}')
  call airline#parts#define_accent('rvm_version', 'red')
  call airline#parts#define_raw('rvm_gemset', '%{airline#extensions#rvm#get_gemset()}')
  call airline#parts#define_accent('rvm_gemset', 'blue')

  " Next up we add a funcref so that we can run some code prior to the
  " statusline getting modifed.
  call a:ext.add_statusline_func('airline#extensions#rvm#apply')

  " You can also add a funcref for inactive statuslines.
  " call a:ext.add_inactive_statusline_func('airline#extensions#rvm#unapply')
endfunction

" This function will be invoked just prior to the statusline getting modified.
function! airline#extensions#rvm#apply(...)
  " First we check for the filetype.
  if &filetype == "ruby"
    let w:airline_section_x = get(w:, 'airline_section_x', g:airline_section_x)

    let w:airline_section_x .= s:spc . g:airline_right_alt_sep . s:spc .
          \ '%{airline#extensions#rvm#get_version()}' .
          \ '@' .
          \ '%{airline#extensions#rvm#get_gemset()}'
  endif
endfunction

" Finally, this function will be invoked from the statusline.
function! airline#extensions#rvm#get_version()
  return get(s:getparts(), 0, 'ruby')
endfunction

function! airline#extensions#rvm#get_gemset()
  return get(s:getparts(), 1, 'default')
endfunction

" Helper functions

function! s:getparts()
  return split(rvm#string(), '@')
endf
