"=============================================================================="
" Custom Autocommands
"=============================================================================="
"
" Custom autocommand definitions. Some of these autocommands call autoloaded
" functions in autoload/jml.vim. See that file for details.
"
"=============================================================================="

augroup JML_DEFAULTS
  au! " Clear the group if already loaded
  " These next two commands switch between relativenumber and norelativenumber
  " when entering and leaving insert mode. We want relativenumber in Normal
  " mode, but we don't care in insert mode.
  au InsertEnter * silent :call jml#NumberToggle()
  au InsertLeave,BufNewFile * silent! :call jml#NumberToggle()
  " Automatically deletes trailing whitespace. See the function definition in
  " autoload/jml.vim for details.
  au BufWritePre * :call jml#DeleteTrailingWhitespace()
  " The next two commands stop NERDTree from automatically opening when vim
  " reads a file through stdin
  au StdinReadPre * let s:read_from_stdin = 1
  au VimEnter * if argc() == 0 && !exists('s:read_from_stdin') | NERDTree | endif
  " TODO: Figure out a better solution for this
  " autocmd BufEnter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
  " Detect filetype on BufEnter
  au BufEnter * filetype detect
augroup END

" This group sets filetypes with non-standard extensions
augroup JML_FILETYPES
  au! " Clear
  au BufRead,BufNewFile,BufEnter .clang-format set ft=yaml
  au BufRead,BufNewFile,BufEnter .babelrc set ft=json

  " Broken built-in commentstring settings
  au FileType coffee set commentstring=#\ %s
  au FileType dosini set commentstring=#\ %s

  " Enable clang-format in c and c++
  au FileType c,cpp :ClangFormatAutoEnable
  " But not in .in files
  au BufNewFile,BufEnter *.h.in :ClangFormatAutoDisable

  " Tabs are syntactic in makefiles
  au FileType make set noexpandtab
augroup END
