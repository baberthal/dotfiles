" File: skel.vim
" Author: J. Morgan Lieberthal
" Description: Skeleton Utility Functions
" Last Modified: February 12, 2018

function! s:TryInsert(skel)
  execute "normal! i_" . a:skel . "\<C-r>=UltiSnips#ExpandSnippet()\r"
  if g:ulti_expand_res == 0
    silent! undo
  endif

  return g:ulti_expand_res
endf

function! skel#InsertSkeleton() abort
  let l:filename = expand('%')

  " Abort on non-empty buffer
  if filereadable(filename)
    if !(line('$') == 1 && getline('$') == '')
      echom 'File readable and has contents, aborting skeleton.'
      return
    endif
  endif

  if line('$') != 1
    echom 'abort: line("$") != 1'
    return
  endif

  if getline('$') != ''
    echom 'abort: getline("$") != ""'
  endif
  " if !(line('$') == 1 && getline('$') == '')
  "   echom "Aborting Skeleton..."
  "   return
  " endif

  if !empty('b:projectionist')
    for [root, value] in projectionist#query('skeleton')
      if s:TryInsert(value)
        return
      endif
    endfor
  endif

  call s:TryInsert('skel')
endf
