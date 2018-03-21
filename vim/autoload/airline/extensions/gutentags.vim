" MIT License. Copyright (c) 2018 J. Morgan Lieberthal
" vim: et ts=2 sts=2 sw=2

scriptencoding utf-8

" Finish unless gutentags is enabled
if !exists('g:loaded_gutentags')
  finish
endif

" Due to some potential rendering issues, the use of the `space` variable is
" recommended.
let s:spc = g:airline_symbols.space

" Extension-specific variables
if !exists('g:airline#extensions#gutentags#message')
  let g:airline#extensions#gutentags#message = '[Generating tags...]'
endif

" First we define an init function that will be invoked from extensions.vim
function! airline#extensions#gutentags#init(ext)
  " Here we define a new part for the plugin.  This allows users to place this
  " extension in arbitrary locations.
  call airline#parts#define_raw('gutentags', '%{airline#extensions#gutentags#get_status()}')

  " Next up we add a funcref so that we can run some code prior to the
  " statusline getting modifed.
  call a:ext.add_statusline_func('airline#extensions#gutentags#apply')

  " You can also add a funcref for inactive statuslines.
  " call a:ext.add_inactive_statusline_func('airline#extensions#gutentags#unapply')
endf

" This function will be invoked just prior to the statusline getting modified.
function! airline#extensions#gutentags#apply(...)
  " We want to append to section_x. First we check if there's
  " already a window-local override, and if not, create it off of the global
  " section_x.
  let w:airline_section_x = get(w:, 'airline_section_x', g:airline_section_x)

  " Then we just append this extenion to it, optionally using separators.
  let w:airline_section_x .= s:spc . '%{airline#extensions#gutentags#get_status()}'
endf

function! airline#extensions#gutentags#get_status()
  return gutentags#statusline()
endf
