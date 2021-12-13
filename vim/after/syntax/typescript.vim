syntax case ignore

" syntax coloring for JSDoc comments (HTML)
syntax region typescriptDocComment start="/\*\*\s*$" end="\*/" contains=typescriptDocTags,typescriptCommentTodo,typescriptCvsTag,@typescriptHtml,@Spell fold extend
syntax match typescriptDocTags contained "@\(param\|argument\|requires\|exception\|throws\|type\|class\|extends\|see\|link\|member\|module\|method\|title\|namespace\|optional\|default\|base\|file\|returns\=\)\>" nextgroup=typescriptDocParam,typescriptDocSeeTag skipwhite
syntax match typescriptDocTags contained "@\(beta\|deprecated\|description\|fileoverview\|author\|license\|version\|constructor\|private\|protected\|final\|ignore\|addon\|exec\)\>"
syntax match typescriptDocParam contained "\%(#\|\w\|\.\|:\|\/\)\+"
syntax region typescriptDocSeeTag contained matchgroup=typescriptDocSeeTag start="{" end="}" contains=typescriptDocTags

syntax case match

syntax region  typescriptString
  \ matchgroup=typescriptStringDelimiter
  \ start=+\z(["']\)+  skip=+\\\%(\z1\|$\)+  end=+\z1+ end=+$+
  \ contains=typescriptSpecial,@Spell
  \ extend

syn region typescriptInterpolation matchgroup=typescriptInterpolationDelimiter
      \ start=/${/ end=/}/ contained
      \ contains=@typescriptExpression

syn match typescriptSpecial "\\\d\d\d\|\\x\x\{2\}\|\\u\x\{4\}" contained containedin=typescriptStringD,typescriptStringS,typescriptStringB display
syn region typescriptStringD matchgroup=typescriptStringDelimiter start=+"+ skip=+\\\\\|\\"+ end=+"\|$+  contains=typescriptSpecial,@htmlPreproc extend
syn region typescriptStringS matchgroup=typescriptStringDelimiter start=+'+ skip=+\\\\\|\\'+ end=+'\|$+  contains=typescriptSpecial,@htmlPreproc extend
syn region typescriptStringB matchgroup=typescriptStringDelimiter start=+`+ skip=+\\\\\|\\`+ end=+`+  contains=typescriptInterpolation,typescriptSpecial,@htmlPreproc extend

syntax keyword typescriptGlobalNodeObjects  module exports global process __dirname __filename

hi link typescriptReserved Macro
hi link typescriptStorageClass Identifier
hi link typescriptGlobalNodeObjects Constant
hi link typescriptObjectLabel Constant
hi link typescriptStringDelimiter Delimiter
hi link typescriptStringD String
hi link typescriptStringS String
hi link typescriptStringB String
