" Basics
setlocal et
setlocal sw=2
setlocal tw=80
setlocal colorcolumn=81

" Rubycomplete
" let g:rubycomplete_buffer_loading = 1
" let g:rubycomplete_classes_in_global = 1

hi link rubyCapitalizedMethod	rubyConstant

if exists('g:loaded_custom_ruby_ftplugin') || &cp
  finish
endif

let g:loaded_custom_ruby_ftplugin = 1

let s:save_cpo = &cpo
set cpo&vim

function! s:BracketsToDoEnd() " {{{1
  let char = getline('.')[col('.')-1]
  if char=='}'
    norm %
  endif
  norm h
  " Bracket touching previous word
  if getline('.')[col('.')-1] =~ '[^ ;]'
    exe "norm! a "
  endif
  norm l
  let begin_pos = getpos('.')
  let begin_num = line('.')
  let begin_line = getline('.')
  norm %
  let end_pos = getpos('.')
  let end_num = line('.')

  call setpos('.', begin_pos)
  norm! sdo
  call setpos('.', end_pos)

  if begin_num == end_num " Was a one-liner
    if getline('.')[col('.')-1] == ' '
      norm! x
    else
      norm! l
      let end_pos = getpos('.')
    endif
    set paste
    norm! send
    set nopaste
    call setpos('.', begin_pos)

    " Has block parameters
    if search('\vdo *\|', 'c', begin_num)
      let end_of_line = '2f|'
    else
      let end_of_line = 'e'
    endif
    call setpos('.', end_pos)
    exe "norm! i\<cr>"
    call setpos('.', begin_pos)
    exe "norm! ".end_of_line."a\<cr>"
    call setpos('.', begin_pos)
    if search('do|', 'c', begin_num)
      :.s/do|/do |/
      call setpos('.', begin_pos)
    endif
  else
    norm! send
    call setpos('.', begin_pos)
  endif
endfunction " 1}}}

function! s:DoEndToBrackets() " {{{1
  let char = getline('.')[col('.')-1]
  let w = expand('<cword>')
  if w=='end'
    norm %
  elseif char == 'o'
    norm! h
  endif
  let do_pos = getpos('.')
  let begin_num = line('.')
  norm %
  let try_again = 10
  while try_again && expand('<cword>') !=# 'end'
    let try_again = try_again - 1
    norm %
  endwhile
  let lines = (line('.')-begin_num+1)

  norm ciw}
  call setpos('.', do_pos)
  norm de

  let line = getline(begin_num)
  let before_do_str = strpart(line, 0, do_pos[2] - 1)
  let after_do_str  = strpart(line, do_pos[2] - 1)

  call setline(begin_num, before_do_str . "{" . after_do_str)

  if lines == 3
    norm! JJ
    " Remove extraneous spaces
    " if search('  \+', 'c', begin_num) | :.s/\([^ ]\)  \+/\1 /g | endif
    call setpos('.', do_pos)
  endif
endfunction " 1}}}

function! s:FindNearestBlockBounds() " {{{1
  let char = getline('.')[col('.')-1]
  if char == '{' || char == '}'
    return char
  endif
  let word = expand('<cword>')
  if (word == 'do' || word == 'end') && char != ' '
    return word
  elseif searchpair('{', '', '}', 'bcW') > 0
    return getline('.')[col('.')-1]
  elseif searchpair('\<do\>', '', '\<end\>\zs', 'bcW',
	\ 'synIDattr(synID(line("."), col("."), 0), "name") =~? "string"') > 0
    return expand('<cword>')
  endif

  return ''
endfunction " 1}}}

function! s:ToggleBlockStyle() " {{{1
  " Save anonymous register and clipboard settings
  let reg = getreg('"', 1)
  let regtype = getregtype('"')
  let cb_save = &clipboard
  set clipboard-=unnamed
  let paste_mode = &paste

  let block_bound = s:FindNearestBlockBounds()
  if block_bound =='{' || block_bound == '}'
    call s:BracketsToDoEnd()
  elseif block_bound ==# 'do' || block_bound ==# 'end'
    call s:DoEndToBrackets()
  else
    echo 'Cannot toggle block: cursor is not on {, }, do or end'
  endif

  " Restore anonymous register and clipboard settings
  call setreg('"', reg, regtype)
  let &clipboard = cb_save
  let &paste = paste_mode

  silent! call repeat#set("\<Plug>BlockToggle", -1)
endfunction " 1}}}

" nnoremap <silent> <Plug>BlockToggle :<C-U>call <SID>ToggleBlockStyle()<CR>
command! BlockToggle silent call s:ToggleBlockStyle()<CR>
if !exists('g:blocktoggle_mapping')
  let g:blocktoggle_mapping = '<leader>b'
endif

augroup rbs
  autocmd!
  exec 'autocmd FileType ruby map <buffer> ' . g:blocktoggle_mapping . ' <Plug>BlockToggle'
augroup END

function! s:HashRocketsTo19Syntax()
endfunction

function! s:Ruby19ToHashRockets()
endfunction

function! s:ToggleHashStyle()
endfunction

function! s:GetRubyLoadPath()
ruby << EOF
load_path = $:.map { |p| File.expand_path(p) }.uniq.join(',')
::Vim.set_option "path+=#{load_path}"
::Vim.command 'return 1'
EOF
return 0
endf

command! -range=% RemoveRockets silent execute <line1>.','.<line2>.'s/:\(\w\+\)\s*=>\s*/\1: /g'

let &cpo = s:save_cpo
