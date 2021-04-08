" ==============================================================================
" File: autoload/jml.vim
" Description: Lazily-Loaded Site-Local Functions
" ==============================================================================

scriptencoding utf-8

function! s:NumberToggleImpl()
endf

" If relative number is not set, set it. Otherwise, set number and
" no relativenumber.
"
" FIXME: There must be a more elegant way to do this
function! jml#NumberToggle()
  if &relativenumber == 1
    set norelativenumber
    set number
  else
    set relativenumber
  endif
endf

" Delete trailing whitespace, but not in binmode or diffmode
function! jml#DeleteTrailingWhitespace()
  " Only striop if the b:no_strip_whitespace variable isn't set
  if exists('b:no_strip_whitespace')
    return
  endif
  %s/\s\+$//e
endf

" Append modeline after last line in buffer.
function! jml#AppendModeline()
  let l:modeline = printf(" vim: set ts=%d sw=%d tw=%d ft=%s %set :",
        \ &tabstop, &shiftwidth, &textwidth, &filetype, &expandtab ? '' : 'no')
  let l:modeline = substitute(&commentstring, "%s", l:modeline, "")
  call append(line("$"), ["", l:modeline])
endf

" Zoom a window, or restore
function! jml#ZoomToggle() abort
  if exists('t:zoomed') && t:zoomed
    exec t:zoom_winrestcmd
    let t:zoomed = 0
  else
    let t:zoom_winrestcmd = winrestcmd()
    resize | vertical resize
    let t:zoomed = 1
  endif
endf

function! s:PrettierParserFor(filetype_name)
  return a:filetype_name
endf

function! jml#Prettier(...) abort range
  let l:invocation = '' . a:firstline . "," . a:lastline . "!prettier --stdin"
  for s in a:000
    let l:invocation .= ' ' . s
  endfor
  let l:invocation .= ' --parser ' . s:PrettierParserFor(&filetype)
  exec l:invocation
endf

" vim: set ts=8 sw=2 tw=80 ft=vim et :
