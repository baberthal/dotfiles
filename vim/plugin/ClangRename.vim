if exists('g:did_plugin_clang_rename') || &cp
    finish
endif
let g:did_plugin_clang_rename = 1

if !exists("g:ClangRenameUsePythonVersion")
   let g:_crpy=":py3 "
   if !has("python3")
       if !has("python")
           if !exists("g:ClangRenameNoPythonWarning")
               echohl WarningMsg
               echom  "ClangRename requires py >= 2.7 or py3"
               echohl None
           endif
           unlet g:_crpy
           finish
       endif
       let g:_crpy=":py "
   endif
else
   " Use user-provided value, but check if it's available.
   " This uses `has()`, because e.g. `exists(":python3")` is always 2.
   if g:ClangRenameUsePythonVersion == 2 && has('python')
       let g:_crpy=":python "
   elseif g:ClangRenameUsePythonVersion == 3 && has('python3')
       let g:_crpy=":python3 "
   endif
   if !exists('g:_crpy')
       echohl WarningMsg
       echom  "ClangRename: the Python version from g:ClangRenameUsePythonVersion (".g:ClangRenameUsePythonVersion.") is not available."
       echohl None
       finish
   endif
endif

" The commands we define
command! -nargs=? ClangRename :call ClangRename#Rename(<q-args>)
