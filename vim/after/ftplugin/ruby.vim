if exists('g:loaded_vim_rbformat') || &cp
    finish
endif

let g:loaded_vim_rbformat = 1

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

let &cpo = s:save_cpo
