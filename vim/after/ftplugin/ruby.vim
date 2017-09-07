setlocal sw=2
setlocal et
setlocal tw=80
setlocal colorcolumn=81

if exists('g:loaded_custom_ftplugin') || &cp
  finish
endif

let g:loaded_custom_ftplugin = 1

let s:save_cpo = &cpo
set cpo&vim

if !exists('g:rbformat_rubocop_cmd')
    let g:rbformat_rubocop_cmd = 'rubocop '
endif

if !exists('g:rbformat_config')
    let g:rbformat_config = ''
endif

if !exists('g:rbformat_rubocop_extra_args')
    let g:rbformat_rubocop_extra_args = ''
endif

let s:rbformat_rubocop_switches = ['-l', '--lint', '-R', '--rails', '-f', '--format']

function! s:RubocopSwitches(...)
    return join(s:rbformat_rubocop_switches, "\n")
endfunction

function! s:RbFormat(current_args)
    let l:extra_args = g:rbformat_rubocop_extra_args
    let l:filename   = @%
    echom "Filename is ".l:filename
    let l:rubocop_cmd = g:rbformat_rubocop_cmd
    echom "Rubocop cmd is ".g:rbformat_rubocop_cmd
    let l:rubocop_opts = ' '.a:current_args.' '.l:extra_args.' --auto-correct'
    echom "Running rubocop with ".l:rubocop_opts
    if g:rbformat_config != ''
        let l:rubocop_opts = ' '.l:rubocop_opts.' --config '.g:rbformat_config
    endif

    let l:rubocop_output = system(l:rubocop_cmd.l:rubocop_opts.' '.l:filename)
    edit
endfunction

command! -complete=custom,s:RubocopSwitches -nargs=? RbFormat :call <SID>RbFormat(<q-args>)

function! s:BracketsToDoEnd()
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
endfunction

function! s:DoEndToBrackets()
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
endfunction

function! s:FindNearestBlockBounds()
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
endfunction

function! s:ToggleBlockStyle()
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
endfunction

nnoremap <silent> <Plug>BlockToggle :<C-U>call <SID>ToggleBlockStyle()<CR>
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


command! -range=% RemoveRockets silent execute <line1>.','.<line2>.'s/:\(\w\+\)\s*=>\s*/\1: /g'

let w:airline_section_x = '%{rvm#statusline()}'

if match(expand('%:t'), '_spec\.rb') != -1
  if !exists('did_plugin_ultisnips')
    runtime! plugin/UltiSnips.vim
    call UltiSnips#AddFiletypes('rspec')
  endif
endif

let &cpo = s:save_cpo
