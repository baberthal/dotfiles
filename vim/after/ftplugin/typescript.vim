set sw=2
set et
setl colorcolumn=82
setl tw=81

augroup JMLtypescriptExtras
  autocmd BufEnter * :syntax sync fromstart
augroup end
let g:ale_javascript_prettier_options = ""
hi link typescriptReserved Macro
