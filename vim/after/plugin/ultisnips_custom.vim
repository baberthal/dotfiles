" File: ultisnips_custom.vim
" Author: J. Morgan Lieberthal
" Description: UltiSnips Custom Hooks
" Last Modified: February 12, 2018

if !exists('did_plugin_ultisnips')
  echohl ErrorMsg | echom 'did_plugin_ultisnips does not exist!' | echohl None
  finish
endif

augroup UltiSnips_Custom
  " this one is which you're most likely to use?
  autocmd BufNewFile * silent! call skel#InsertSkeleton()
augroup end
