"=============================================================================="
" External Program Settings
"=============================================================================="
"
" This file configures external programs used by vim and various plugins
"
"=============================================================================="

if executable('ag')
  set grepprg=ag\ --nogroup\ --nocolor
endif

if executable('rg') " ripgrep
  set grepprg=rg\ --vimgrep\ --no-heading\ --color=never
endif
