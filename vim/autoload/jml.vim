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
function jml#DeleteTrailingWhitespace()
  " FIXME: Figure out how to get back to where we started. Marks maybe?
  if !&binary && &filetype !=? 'diff'
    %s/\s\+%//e
  endif
endf

" Append modeline after last line in buffer.
function! jml#AppendModeline() abort
  let l:modeline = printf(" vim: set ts=%d sw=%d tw=%d ft=%s %set :",
        \ &tabstop, &shiftwidth, &textwidth, &filetype, &expandtab ? '' : 'no')
  let l:modeline = substitute(&commentstring, "%s", l:modeline, "")
  call append(line("$"), l:modeline)
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

" vim: set ts=8 sw=2 tw=80 ft=vim et :
