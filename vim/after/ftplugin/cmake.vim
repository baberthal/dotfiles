setlocal commentstring=#\ %s
setlocal comments=:#
setlocal sw=2
setlocal et
setlocal formatoptions=croql

nmap ,hc :call OpenCmakeHelp()<CR>

function! OpenCmakeHelp()
    let s = getline( '.' )
    let i = col( '.' ) - 1
    while i > 0 && strpart( s, i, 1 ) =~ '[A-Za-z0-9_]'
        let i = i - 1
    endwhile
    while i < col('$') && strpart( s, i, 1 ) !~ '[A-Za-z0-9_]'
        let i = i + 1
    endwhile
    let start = match( s, '[A-Za-z0-9_]\+', i )
    let end = matchend( s, '[A-Za-z0-9_]\+', i )
    let ident = strpart( s, start, end - start )
    execute "vertical new"
    execute "%!cmake --help-command ".ident
    set nomodified
    set readonly
endfunction

autocmd FileType cmake nmap <F1> :call OpenCmakeHelp()<CR>

let b:match_words = '\<if\>:\<elseif\>:\<else\>:\<endif\>,'
            \ . '\<foreach\>:\<endwhile\>:\<break\>:\<endforeach\>,'
            \ . '\<while\>:\<continue\>:\<break\>:\<endwhile\>,'
            \ . '\<function\>:\<endfunction\>,'
            \ . '\<macro\>:\<endmacro\>'

let b:match_ignorecase = 1
