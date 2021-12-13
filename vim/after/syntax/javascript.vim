syn keyword jsGlobalNodeObjectsSpecial module

syntax region  jsString           matchgroup=jsStringDelimiter start=+\z(["']\)+  skip=+\\\%(\z1\|$\)+  end=+\z1+ end=+$+  contains=jsSpecial extend
syntax region  jsTemplateString   matchgroup=jsStringDelimiter start=+`+  skip=+\\`+  end=+`+     contains=jsTemplateExpression,jsSpecial extend

hi link jsObjectKey Constant
hi link jsGlobalNodeObjectsSpecial Type
hi link jsObjectBraces Identifier
hi link jsStringDelimiter Delimiter
hi link jsTemplateBraces Label
hi link jsStorageClass Identifier
hi link jsFuncCall NONE
hi link jsBrackets Identifier
hi link jsDestructuringBraces Identifier

runtime after/syntax/javascript/graphql.vim
