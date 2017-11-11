if exists('b:did_autoload_clang_rename') || !exists('g:_crpy')
  finish
endif

let b:did_autoload_clang_rename = 1

" import vim as we expect it to be imported in many places
exec g:_crpy 'import vim'
exec g:_crpy 'import clang_rename'

fun! ClangRename#Rename(...)
  if a:0 == 1 && a:1 != ''
    let l:newname = '"' . a:1 . '"'
  else
    let l:newname = 'None'
  endif

  update  " save the files

  echo 'Newname: ' . l:newname
  exec g:_crpy 'clang_rename.Main(' . l:newname . ')'
  " code
endf
