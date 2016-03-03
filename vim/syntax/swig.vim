" Vim Syntax File
" Language: SWIG
" Maintainer: J. Morgan Lieberthal <j.morgan.lieberthal@gmail.com>
" Last Change: 2016 March 01
"

if exists("b:current_syntax")
  finish
endif

runtime! syntax/cpp.vim
unlet b:current_syntax

syn keyword swigDirective %typemap %define %apply %fragment %include %enddef %extend %newobject %name
syn keyword swigDirective %rename %ignore %keyword %typemap %define %apply %fragment %include
syn keyword swigDirective %enddef %extend %newobject %name %rename %ignore %template %module %constant
syn match swigVerbatimDelim "%\({\|}\)"
syn match swigUserDef "%[-_a-zA-Z0-9]\+"

if !exists("did_swig_syntax_inits")
  hi link swigDirective Exception
  hi link swigUserDef PreProc
  hi link swigVerbatimDelim PreProc
endif

let b:current_syntax = "swig"
