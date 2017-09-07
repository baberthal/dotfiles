set sw=2
set et
setl colorcolumn=82
setl tw=81

augroup ts_locals
    autocmd!
    autocmd BufWritePre *.ts :TsuGeterr
augroup end
