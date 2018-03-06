" Other JSON FileTypes (Usually config files)

" support functions {{{ "
function! s:setf(filetype)
  if &filetype !=# a:filetype
    let &filetype = a:filetype
  endif
endf
" }}} support functions "

" Babel
au BufNewFile,BufRead .babelrc call s:setf('json')

" ESLint
au BufNewFile,BufRead .eslintrc call s:setf('json')
