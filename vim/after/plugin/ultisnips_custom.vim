" File: ultisnips_custom.vim
" Author: J. Morgan Lieberthal
" Description: UltiSnips Custom Hooks
" Last Modified: February 12, 2018

if !exists('did_plugin_ultisnips')
  echohl ErrorMsg | echom 'did_plugin_ultisnips does not exist!' | echohl None
  finish
endif

augroup UltiSnips_Custom
  au!
  au User ProjectionistActivate silent! call skel#InsertSkeleton()
  autocmd BufRead,BufNewFile * silent! call skel#InsertSkeleton()
augroup end
