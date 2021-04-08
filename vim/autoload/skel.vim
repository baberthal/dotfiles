" File: skel.vim
" Author: J. Morgan Lieberthal
" Description: Skeleton Utility Functions
" Last Modified: February 12, 2018

function! s:TryInsert(skel)
  execute "normal! i_" . a:skel . "\<C-r>=UltiSnips#ExpandSnippet()\<CR>"
  if g:ulti_expand_res == 0
    silent! undo
  endif

  return g:ulti_expand_res
endf

" Make u undo twice (temporarily) to work around UltiSnips's undo-breaking
" anti-feature
function! s:InstallUndoWorkaround() abort
  nnoremap <silent><buffer> u :call <SID>UndoWorkaround()<CR>
endf

function! s:UndoWorkaround() abort
  normal! 2u
  nunmap <buffer> u
endf

function! skel#InsertSkeleton() abort
  " Abort on non-empty buffer or extant file
  if !exists('g:did_plugin_ultisnips') || !(line('$') ==# 1 && getline('$') ==# '') || filereadable(expand('%:p'))
    return
  endif

  if !empty('b:projectionist')
    " Loop through projections with 'skeleton' key and try each one until it
    " works.
    for [root, value] in projectionist#query('skeleton')
      if s:TryInsert(value)
        call s:InstallUndoWorkaround()
        return
      endif
    endfor
  endif

  " Try the generic _skel template as last resort.
  if s:TryInsert('skel')
    call s:InstallUndoWorkaround()
  endif
endf
