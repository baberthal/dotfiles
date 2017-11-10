syn keyword jmlBuiltInOperator typedef struct void enum case switch extern static const NULL
hi link jmlBuiltInOperator Statement
hi link MacroInstantiation Underlined
hi link MacroDefinition PreProc
syn region cBlockBlock start="\^{" end="}" contains=TOP,cBadBlock,cCurlyError,@cParenGroup,cErrInParen,cCppParen,cErrInBracket,cCppBracket,@cStringGroup,@Spell fold

source $VIMRUNTIME/syntax/doxygen.vim
