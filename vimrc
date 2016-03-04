set nocompatible
filetype off

" Vundle Plugins {{{1
" Runtime Path and Vundle plugin settings
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" Vundle manages itself
Plugin 'VundleVim/Vundle.vim'

" Pretty colors & some syntax highlighting
Plugin 'baberthal/vim-colors-solarized'
Plugin 'scrooloose/syntastic'
Plugin 'rdnetto/YCM-Generator'
Plugin 'vim-scripts/bats.vim'
Plugin 'baberthal/chefspec.vim'

" HTML and various pre-processors
Plugin 'othree/html5.vim'
Plugin 'digitaltoad/vim-jade'
Plugin 'tpope/vim-haml'
Plugin 'curist/vim-angular-template'

" Useful tmux integration
Plugin 'tmux-plugins/vim-tmux'
Plugin 'christoomey/vim-tmux-navigator'

" Alignment and autocomplete
Plugin 'godlygeek/tabular'
Plugin 'L9'
Plugin 'junegunn/vim-easy-align'
Plugin 'tpope/vim-endwise'
Plugin 'Raimondi/delimitMate'
Plugin 'edsono/vim-matchit'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-sleuth'
Plugin 'tpope/vim-repeat'

" Ruby (on rails) development plugins
Plugin 'tpope/vim-rails.git'
Plugin 'tpope/vim-bundler.git'
Plugin 'vim-ruby/vim-ruby.git'
Plugin 'keith/rspec.vim'
Plugin 'tpope/vim-fugitive'
Plugin 'ecomba/vim-ruby-refactoring'
Plugin 'tpope/vim-rvm'

" Vanilla JS
Plugin 'kchmck/vim-coffee-script'
Plugin 'walm/jshint.vim'
Plugin 'mustache/vim-mustache-handlebars'

" Node.js
Plugin 'moll/vim-node'
Plugin 'jelera/vim-javascript-syntax'

" Rust
Plugin 'rust-lang/rust.vim'

" Window / pane management
Plugin 'wesQ3/vim-windowswap'

" File search, other good stuff
Plugin 'kien/ctrlp.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'Xuyuanp/nerdtree-git-plugin'
Plugin 'jlanzarotta/bufexplorer'
Plugin 'terryma/vim-multiple-cursors'
Plugin 'tpope/vim-commentary'
Plugin 'mattn/webapi-vim'
Plugin 'mattn/gist-vim'
Plugin 'gcmt/taboo.vim'
Plugin 'rizzatti/dash.vim'

" C
Plugin 'baberthal/vim-syntax-extra'
Plugin 'rhysd/vim-clang-format'
" Plugin 'jeaye/color_coded'
Plugin 'bbchung/clighter'

" snipmate
" Plugin 'MarcWeber/vim-addon-mw-utils'
" Plugin 'tomtom/tlib_vim'
" Plugin 'garbas/vim-snipmate'
Plugin 'SirVer/ultisnips'
Plugin 'honza/vim-snippets'
Plugin 'Valloric/YouCompleteMe'
Plugin 'ervandew/supertab'

" Statusline
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'

call vundle#end()
filetype plugin indent on
" 1}}} "

" Basics {{{ "
set ruler
set number
set colorcolumn=81
set modeline
let mapleader="\<Space>"
set mouse=nih

set splitbelow
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
set tags=./tags,./.git/tags;

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

set fdm=marker
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*.png,*/node_modules/*
set pvh=20
set shell=/bin/sh

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

function! RvmStatusLine(...)
  if &filetype == 'ruby'
    let w:airline_section_x = '%{rvm#statusline()}'
  endif
endfunction

call airline#add_statusline_func('RvmStatusLine')
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

" }}} Remaps "

" One-Off Plugin Settings {{{ "
" JS Library syntax highlighting
let g:used_javascript_libs = 'jquery, angularjs, angularui, jasmine, chai, underscore angularuirouter'

" bufExplorer options
let g:bufExplorerShowRelativePath=1


" ----EASY ALIGN SETTINGS----
vnoremap <silent> <Enter> :EasyAlign<CR>
vmap <Enter> <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)

" Taboo.vim settings
let g:taboo_tabline = 0
let g:taboo_modified_tab_flag = "+"
let g:taboo_renamed_tab_format = "%l %m"

" }}} One-Off Plugin Settings "

" User-Defined Functions {{{ "
"Toggle numbers from relative to absolute
function! FindRubocopYml()
  if filereadable(".rubocop.yml")
  endif
endfunction

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
  call append(line("0"), "/* jslint node: true */")
endfunction
nnoremap <silent> <Leader>js :call AppendJSLint()<CR>

" Fix ugly tabs and inconsistent tab/spaces in a file
command! Fixtab :set tabstop=2 | :set expandtab | :retab | :set tabstop=2

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
  autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
  autocmd BufEnter * filetype detect
augroup END

autocmd FileType coffee set commentstring=#\ %s
" }}} Autocommands "

" Vim-Tmux-Navigator {{{ "
let g:tmux_navigator_no_mappings = 1
nnoremap <silent> <C-S-h> :TmuxNavigateLeft<cr>
nnoremap <silent> <C-S-j> :TmuxNavigateDown<cr>
nnoremap <silent> <C-S-k> :TmuxNavigateUp<cr>
nnoremap <silent> <C-S-l> :TmuxNavigateRight<cr>
nnoremap <silent> <C-S-\> :TmuxNavigatePrevious<cr>

" }}} Vim-Tmux-Navigator "

" Syntastic {{{ "
" No warnings for ng- directives, haml bs
let g:syntastic_html_tidy_ignore_errors =[ " proprietary attribute \"ng-",
      \"is not recognized!", "discarding unexpected",
      \"trimming empty <", "unescaped &",
      \ "lacks \"action"]

let g:syntastic_javascript_checkers = ['jshint']
let g:syntastic_haml_checkers = ['haml_lint']
let g:syntastic_ruby_checkers = ['mri', 'rubocop']
let g:systastic_ruby_exec = $rvm_path . "/rubies/" . $RUBY_VERSION . "/bin/ruby"

let g:syntastic_c_checkers = ['clang_check', 'make']
let g:syntastic_c_clang_check_post_args = ""



" }}} Syntastic "

" YouCompleteMe {{{ "
let g:ycm_server_keep_logfiles = 0

let g:ycm_key_list_select_completion = ['<C-n>', '<Down>']
let g:ycm_key_list_previous_completion = ['<C-p>', '<Up>']

let g:ycm_path_to_python_interpreter = '/usr/bin/python2.7'
let g:ycm_complete_in_comments = 1
let g:ycm_seed_identifiers_with_syntax = 1
let g:ycm_collect_identifiers_from_comments_and_strings = 1

" }}} YouCompleteMe "

" UltiSnips Completion Function Hacks {{{ "
function! g:UltiSnips_Complete()
  call UltiSnips#ExpandSnippet()
  if g:ulti_expand_res == 0
    if pumvisible()
      return "\<C-n>"
    else
      call UltiSnips#JumpForwards()
      if g:ulti_jump_forwards_res == 0
        return "\<TAB>"
      endif
    endif
  endif
  return ""
endfunction

function! g:UltiSnips_Reverse()
  call UltiSnips#JumpBackwards()
  if g:ulti_jump_backwards_res == 0
    return "\<C-P>"
  endif

  return ""
endfunction

if !exists("g:UltiSnipsJumpForwardTrigger")
  let g:UltiSnipsJumpForwardTrigger = "<tab>"
endif

if !exists("g:UltiSnipsJumpBackwardTrigger")
  let g:UltiSnipsJumpBackwardTrigger = "<s-tab>"
endif

" }}} UltiSnips Completion Function Hacks "

" UltiSnips Configuration {{{ "
let g:SuperTabDefaultCompletionType = '<C-n>'
let g:UltiSnipsEnableSnipMate = 1
let g:UltiSnipsExpandTrigger = "<tab>"

let g:UltiSnipsEditSplit = "horizontal"

au InsertEnter * exec "inoremap <silent> " . g:UltiSnipsExpandTrigger . " <C-R>=g:UltiSnips_Complete()<cr>"
au InsertEnter * exec "inoremap <silent> " . g:UltiSnipsJumpBackwardTrigger . " <C-R>=g:UltiSnips_Reverse()<cr>"

" }}} UltiSnips Configuration "

" Clang {{{ "
let g:clang_format#command = "/usr/local/Cellar/llvm/3.8.0/bin/clang-format"
let g:clang_format#detect_style_file = 1

let g:clighter_libclang_file = '/usr/local/Cellar/llvm/3.8.0/lib/libclang.dylib'
" }}} Clang "

" Vim Multiple Cursors {{{ "
let g:multi_cursor_use_default_mapping = 0
let g:multi_cursor_start_key = '<F7>'
let g:multi_cursor_next_key = '<c-n>'
let g:multi_cursor_prev_key = '<c-p>'
let g:multi_cursor_skip_key = '<c-x>'
let g:multi_cursor_quit_key = '<Esc>'
" }}} Vim Multiple Cursors "
