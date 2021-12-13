" Other Yaml FileTypes (Usually config files)

" support functions {{{ "
function! s:setf(filetype)
  if &filetype !=# a:filetype
    let &filetype = a:filetype
  endif
endf
" }}} support functions "

" Clang Format

au BufNewFile,BufRead,BufEnter .clang-format,_clang-format,.clang-tidy call s:setf('yaml')
