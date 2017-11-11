syn keyword jmlBuiltInOperator
      \ typedef
      \ struct
      \ void
      \ enum
      \ case
      \ switch
      \ extern
      \ static
      \ const
      \ NULL

" Always show the above list as a 'keyword'
hi link jmlBuiltInOperator Keyword

hi link MacroInstantiation Underlined
hi link MacroDefinition PreProc

hi link Member Identifier

syn region cBlockBlock start="\^{" end="}" contains=TOP,cBadBlock,cCurlyError,@cParenGroup,cErrInParen,cCppParen,cErrInBracket,cCppBracket,@cStringGroup,@Spell fold

source $VIMRUNTIME/syntax/doxygen.vim
