runtime bundle/vim-pathogen/autoload/pathogen.vim
execute pathogen#infect()
syntax on
filetype plugin indent on

" Basics {{{ "
set ruler
set number
set colorcolumn=81
set sw=2
set et
set modeline
let mapleader="\<Space>"
set mouse=nih

set splitright

" Colors, fonts, encoding, and background setting
syntax enable
colorscheme solarized
set background=dark
let g:solarized_termtrans = 1
set laststatus=2
set noshowmode
call togglebg#map("<F5>")

hi Search ctermfg=6 ctermbg=15 cterm=bold,reverse
hi CursorLineNr term=bold ctermfg=2

set guifont=Inconsolata\ for\ Powerline
set encoding=utf-8
let g:airline_powerline_fonts = 1
set t_Co=256
set fillchars+=stl:\ ,stlnc:\
set term=xterm-256color
set termencoding=utf-8
set tags=./tags,./.git/tags,./build/tags,./.git/bundler.tags,./.git/stdlib.tags;

" No scroll bars in gvim mode
set guioptions-=r
set guioptions-=l
set guioptions-=L

" Silly hack for gvim... who uses that anyway?
if has('gui_running')
    let s:uname = system("uname")
    if s:uname == "Darwin\n"
        set guifont=Inconsolata\ for\ Powerline:h14
    endif
endif

" Preview window
set pvh=20

set fdm=marker
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*.png,*/node_modules/*,.DS_Store
set shell=/bin/sh

set undodir=~/.vim/undo
if (v:version >= 703)
  set undofile
  set undolevels=1000
  set undoreload=10000
endif

" Hack for vertical line cursor when in insert mode while running in tmux
let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"

" }}} Basics "

" Airline Config {{{ "
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#taboo#enabled = 1
let g:airline#extensions#windowswap#enabled = 1
let g:airline#extensions#syntastic#enabled = 1
let g:airline_theme = 'jml'

" function! RvmStatusLine(...)
"   if &filetype == 'ruby'
"     let w:airline_section_x = '%{rvm#statusline()}'
"   endif
" endfunction

" if !exists('g:rvm_statusline_added_to_airline')
"   let g:rvm_statusline_added_to_airline = 1
"   call airline#add_statusline_func('RvmStatusLine')
" endif
" }}} Airline Config "

" Remaps {{{ "
nmap <Leader>s :source $MYVIMRC<CR>
nmap <Leader>v :vs $MYVIMRC<CR>
nmap <Leader>w :w<CR>
map <F6> :NERDTreeToggle<CR>
map <Leader>rn :TabooRename
nmap <silent> <Leader>= :tabmove +1<CR>
nmap <silent> <Leader>- :tabmove -1<CR>
nmap <silent> <Leader>] :tabnext<CR>
nmap <silent> <Leader>[ :tabprevious<CR>
nnoremap <silent> <C-K> <C-T>
nmap <Leader>gst :Gstatus<CR>
nmap <Leader>gc :Gcommit<CR>

" Yank text to the OS X Clipboard
noremap <leader>y "*y
noremap <leader>yy "*Y

" Preserve indentation while pasting text from OS X Clipboard
noremap <leader>p :set paste<CR>:put *<CR>:set nopaste<CR>

" Use Dash instead of man for K
nnoremap <silent><buffer> K <Esc>:Dash <C-R><C-W><CR>

nmap <silent> <leader>hl :set hlsearch! hlsearch?<CR>
nmap <leader>vs :vsplit<CR>
nmap <leader>hs :split<CR>

nmap <F9> :YcmCompleter FixIt<CR>

map <F10> :echo "hi<"
      \ . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
      \ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
      \ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>

" }}} Remaps "

" One-Off Plugin Settings {{{ "
" vim-ruby complete
let g:rubycomplete_buffer_loading = 1
let g:rubycomplete_classes_in_global = 1

" bufExplorer options
let g:bufExplorerShowRelativePath=1
let g:VimuxUseNearest = 0

" ----EASY ALIGN SETTINGS----
vnoremap <silent> <Enter> :EasyAlign<CR>
vmap <Enter> <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)

" Taboo.vim settings
let g:taboo_tabline = 0
let g:taboo_modified_tab_flag = "+"
let g:taboo_renamed_tab_format = "%l %m"

let g:closetag_filenames = "*.html,*.xhtml,*.xml,*.plist"

let g:EclimFileTypeValidate = 0
let g:js_indent_flat_switch = 1
let g:js_indent_logging = 1
" }}} One-Off Plugin Settings "

" Javascript {{{ "
let g:used_javascript_libs = 'jquery,jasmine,underscore,angularjs,angularui,angularuirouter,react'
" }}} Javascript "

" Dart {{{ "
let g:dart_style_guide = 1
" }}} Dart "

" User-Defined Functions {{{ "
"Toggle numbers from relative to absolute
function! NumberToggle()
  if(&relativenumber == 1)
    set norelativenumber
    set number
  else
    set relativenumber
    highlight LineNr term=bold ctermfg=10
  endif
endfunc
nnoremap <silent><leader>\ :call NumberToggle() <CR>

" Append modeline after last line in buffer.
function! AppendModeline()
  let l:modeline = printf(" vim: set ts=%d sw=%d tw=%d ft=%s %set :",
        \ &tabstop, &shiftwidth, &textwidth, &filetype, &expandtab ? '' : 'no')
  let l:modeline = substitute(&commentstring, "%s", l:modeline, "")
  call append(line("$"), l:modeline)
endfunction
nnoremap <silent> <Leader>ml :call AppendModeline()<CR>

" Add js lint and use strict to nodejs files
function! AppendJSLint()
  call append(line("0"), "'use strict';")
  call append(line("0"), "/* eslint node: true */")
endfunction
nnoremap <silent> <Leader>js :call AppendJSLint()<CR>

" Fix ugly tabs and inconsistent tab/spaces in a file
command! Fixtab :set tabstop=2 | :set expandtab | :retab | :set tabstop=2

" Remap pathogen#helptags() because it is clobbered by fzf.vim
command! MakeHelptags :call pathogen#helptags()

" Edit the most recent migration created in a rails project
function! EditLastMigration()
  :call RailsDetect()
  if exists('b:rails_root')
    let b:migrations = split(globpath(b:rails_root, 'db/migrate/*'), '\n')
    let b:last_migration = b:migrations[-1]
    execute 'edit' b:last_migration
  endif
endfunction
nnoremap <Leader>lm :call EditLastMigration()<CR>

command! EditLastMigration :call EditLastMigration()

" Zoom / Restore window
function! s:ZoomToggle() abort
  if exists('t:zoomed') && t:zoomed
    execute t:zoom_winrestcmd
    let t:zoomed = 0
  else
    let t:zoom_winrestcmd = winrestcmd()
    resize
    vertical resize
    let t:zoomed = 1
  endif
endfunction

command! ZoomToggle call s:ZoomToggle()
nnoremap <silent> <leader>oo :ZoomToggle<CR>

function! s:Breakout() abort
  let l:breakout = expand('%')
  q | execute 'tabedit' l:breakout
endfunction

command! Breakout call s:Breakout()

" Explore files with Ranger
function! RangerExplorer()
  exec "silent !ranger --choosefile=/tmp/vim_ranger_current_file " . expand("%:p:h")
  if filereadable('/tmp/vim_ranger_current_file')
    exec 'edit ' . system('cat /tmp/vim_ranger_current_file')
    call system('rm /tmp/vim_ranger_current_file')
  endif
  redraw!
endfunction

map <Leader>x :call RangerExplorer()<CR>

" Oops! Forgot to open vim with sudo? Just use Sw !
command! Sw :w !sudo tee %

function! SynStack()
  if !exists("*synstack")
    return
  endif
  echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunction

function! s:Format()
  if !exists("g:clang_format_py")
    let g:clang_format_py = "/usr/local/opt/llvm/share/clang/clang-format.py"
  endif

  exec "pyf " . g:clang_format_py
endfunction

command! Format call s:Format()
"
" }}} User-Defined Functions "

" Autocommands {{{ "
augroup defaults
  au!
  " Relative line numbers in INSERT mode, absolute line numbers in NORMAL mode
  autocmd InsertEnter * silent! :call NumberToggle()
  autocmd InsertLeave,BufNewFile,VimEnter * silent! :call NumberToggle()
  " Automatically delete trailing whitespace during :w
  autocmd BufWritePre * :%s/\s\+$//e
  autocmd StdinReadPre * let s:std_in=1
  autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
  " autocmd BufEnter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
  autocmd BufEnter * filetype detect
  au BufNewFile,BufEnter .clang-format set ft=yaml
augroup END

augroup comment_overrides
  au!
  au FileType coffee set commentstring=#\ %s
  au FileType dosini set commentstring=#\ %s
augroup END
" }}} Autocommands "

" Vim-Tmux-Navigator {{{ "
let g:tmux_navigator_no_mappings = 1
nnoremap <silent> <C-h> :TmuxNavigateLeft<cr>
nnoremap <silent> <C-j> :TmuxNavigateDown<cr>
nnoremap <silent> <C-k> :TmuxNavigateUp<cr>
nnoremap <silent> <C-l> :TmuxNavigateRight<cr>
nnoremap <silent> <C-\> :TmuxNavigatePrevious<cr>

" }}} Vim-Tmux-Navigator "

" Syntastic {{{ "
" No warnings for ng- directives, haml bs
let g:syntastic_html_tidy_ignore_errors =[ " proprietary attribute ",
      \"is not recognized!", "discarding unexpected",
      \"trimming empty <", "unescaped &",
      \ "lacks \"action"]

let g:syntastic_javascript_checkers = ['eslint']
let g:syntastic_haml_checkers = ['haml_lint']
let g:syntastic_ruby_checkers = ['mri', 'rubocop']
let g:systastic_ruby_exec = $rvm_path . "/rubies/" . $RUBY_VERSION . "/bin/ruby"

let g:syntastic_c_checkers = ['clang_check', 'make']
let g:syntastic_c_clang_check_post_args = ""

let g:syntastic_scss_checkers = ['sass-lint']

let g:tsuquyomi_disable_quickfix = 1
let g:syntastic_typescript_checkers = ['tsuquyomi', 'tslint']

" }}} Syntastic "

" YouCompleteMe / Ultisnips {{{ "
let g:ycm_server_keep_logfiles = 0
let g:ycm_server_log_level = 'critical'

let g:ycm_path_to_python_interpreter = '/usr/local/bin/python'
let g:ycm_complete_in_comments = 1
let g:ycm_seed_identifiers_with_syntax = 1
let g:ycm_collect_identifiers_from_comments_and_strings = 1
let g:ycm_autoclose_preview_window_after_insertion = 1

let g:ycm_rust_source_path = '/opt/src/rust'

let g:ycm_key_list_select_completion = ['<C-j>', '<Down>']
let g:ycm_key_list_previous_completion = ['<C-p>', '<Up>']
let g:SuperTabDefaultCompletionType = '<C-j>'

let g:UltiSnipsEnableSnipMate = 1
let g:UltiSnipsExpandTrigger = "<tab>"
let g:UltiSnipsJumpForwardTrigger = "<tab>"
let g:UltiSnipsJumpBackwardTrigger = "<s-tab>"

let g:UltiSnipsEditSplit = "horizontal"
let g:UltiSnipsListSnippets = "<c-l>"
let g:UltiSnipsListSnippetsDir = "~/.vim/UltiSnips"

let g:EclimCompletionMethod = 'omnifunc'

" }}} YouCompleteMe / UltiSnips "

" Ruby Heredoc Syntax {{{ "
let g:ruby_heredoc_syntax_filetypes = {
      \ "c": {
      \   "start": "C",
      \ },
      \ "ruby": {
      \   "start": "RUBY",
      \ },
      \}
" }}} Ruby Heredoc Syntax "

" Clang {{{ "
let g:clang_format#command = "/usr/local/bin/clang-format"
let g:clang_format#detect_style_file = 1
let g:clang_format#auto_format = 1
" }}} Clang "

" Vim Multiple Cursors {{{ "
let g:multi_cursor_use_default_mapping = 0
let g:multi_cursor_start_key = '<F7>'
let g:multi_cursor_next_key = '<c-n>'
let g:multi_cursor_prev_key = '<c-p>'
let g:multi_cursor_skip_key = '<c-x>'
let g:multi_cursor_quit_key = '<Esc>'
" }}} Vim Multiple Cursors "
