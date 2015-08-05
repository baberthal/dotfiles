set nocompatible
filetype off

" Vundle Plugins {{{1
" Runtime Path and Vundle plugin settings
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" Vundle manages itself
Plugin 'gmarik/Vundle.vim'

" Pretty colors & some syntax highlighting
Plugin 'altercation/vim-colors-solarized'
Plugin 'scrooloose/syntastic'
Plugin 'rodjek/vim-puppet'
Plugin 'rdnetto/YCM-Generator'

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

" Vanilla JS
Plugin 'othree/yajs.vim'
Plugin 'othree/javascript-libraries-syntax.vim'
Plugin 'claco/jasmine.vim'
Plugin 'kchmck/vim-coffee-script'
Plugin 'walm/jshint.vim'

" Node.js
Plugin 'moll/vim-node'

" AngularJS stuff
Plugin 'burnettk/vim-angular'
Plugin 'matthewsimo/angular-vim-snippets'

" C Family
Plugin 'Rip-Rip/clang_complete'
Plugin 'b4winckler/vim-objc'

" Window / pane management
Plugin 'wesQ3/vim-windowswap'
Plugin 'vim-scripts/ZoomWin'

" File search, other good stuff
Plugin 'kien/ctrlp.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'jlanzarotta/bufexplorer'
Plugin 'terryma/vim-multiple-cursors'
Plugin 'tpope/vim-commentary'
Plugin 'mattn/gist-vim'
Plugin 'gcmt/taboo.vim'
Plugin 'rizzatti/dash.vim'

" snipmate
" Plugin 'MarcWeber/vim-addon-mw-utils'
" Plugin 'tomtom/tlib_vim'
" Plugin 'garbas/vim-snipmate'
Plugin 'SirVer/ultisnips'
Plugin 'honza/vim-snippets'
Plugin 'Valloric/YouCompleteMe'
Plugin 'ervandew/supertab'
Plugin 'chrisgillis/vim-bootstrap3-snippets'

" Statusline
Plugin 'bling/vim-airline'

call vundle#end()
filetype plugin indent on
" 1}}} "

" Basics {{{ "
set ruler
set number
set colorcolumn=82
set modeline
highlight ColorColumn ctermbg=37 guibg=cyan
let mapleader="\<Space>"
set mouse=nih

" Colors, fonts, encoding, and background setting
syntax enable
colorscheme solarized
set background=dark
let g:solarized_termtrans = 1
set laststatus=2
set noshowmode
call togglebg#map("<F5>")

set guifont=Inconsolata\ for\ Powerline
set encoding=utf-8
let g:airline_powerline_fonts = 1
set t_Co=256
set fillchars+=stl:\ ,stlnc:\
set term=xterm-256color
set termencoding=utf-8
set tags=./tags;

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

" }}} Basics "

" Airline Config {{{ "
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#taboo#enabled = 1
let g:airline#extensions#windowswap#enabled = 1
let g:airline#extensions#syntastic#enabled = 1
let g:airline_theme = 'jml'
" }}} Airline Config "

" Remaps {{{ "
nmap <Leader>s :source $MYVIMRC<CR>
nmap <Leader>v :e $MYVIMRC<CR>
nmap <Leader>w :w<CR>
map <F6> :NERDTreeToggle<CR>
map <Leader>rn :TabooRename
map <silent> <Leader>= :tabmove +1<CR>
map <silent> <Leader>- :tabmove -1<CR>
map <silent> <Leader>] :tabnext<CR>
map <silent> <Leader>[ :tabprevious<CR>

" Yank text to the OS X Clipboard
noremap <leader>y "*y
noremap <leader>yy "*Y

" Preserve indentation while pasting text from OS X Clipboard
noremap <leader>p :set paste<CR>:put *<CR>:set nopaste<CR>
" }}} Remaps "

" One-Off Plugin Settings {{{ "
" JS Library syntax highlighting
let g:used_javascript_libs = 'jquery, angularjs, angularui, jasmine, chai, underscore'

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
function! NumberToggle()
  if(&relativenumber == 1)
    set norelativenumber
    set number
    highlight CursorLineNr term=bold ctermfg=4
  else
    set relativenumber
    highlight LineNr term=bold ctermfg=10
    highlight CursorLineNr term=bold ctermfg=2
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

function! AppendJSLint()
  call append(line("0"), "'use strict';")
  call append(line("0"), "/* jslint node: true */")
endfunction
nnoremap <silent> <Leader>js :call AppendJSLint()<CR>

command! Fixtab :set tabstop=2 | :set expandtab | :retab | :set tabstop=2
" }}} User-Defined Functions "

" Autocommands {{{ "
augroup defaults
  " Relative and absolute line numbers
  autocmd InsertEnter * silent! :call NumberToggle()
  autocmd InsertLeave,BufNewFile,VimEnter * silent! :call NumberToggle()
  " Automatically delete trailing whitespace during :w
  autocmd BufWritePre * :%s/\s\+$//e
  autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
  autocmd BufEnter * filetype detect
augroup END

autocmd FileType coffee set commentstring=#\ %s
" }}} Autocommands "

" Syntastic {{{ "
" No warnings for ng- directives, haml bs
let g:syntastic_html_tidy_ignore_errors =[ " proprietary attribute \"ng-",
      \"is not recognized!", "discarding unexpected",
      \"trimming empty <", "unescaped &",
      \ "lacks \"action"]

let g:syntastic_objc_config_file = '.clang_complete'
let g:syntastic_objc_checker = 'clang'

" }}} Syntastic "

" Ultisnips / YCM / Supertab {{{ "
let g:ycm_key_list_select_completion = ['<C-n>', '<Down>']
let g:ycm_key_list_previous_completion = ['<C-p>', '<Up>']
let g:ycm_path_to_python_interpreter = '/usr/local/bin/python'

let g:SuperTabDefaultCompletionType = '<C-n>'
let g:UltiSnipsEnableSnipMate = 1
let g:UltiSnipsExpandTrigger = "<tab>"
let g:UltiSnipsJumpForwardTrigger = "<tab>"
let g:UltiSnipsJumpBackwardTrigger = "<s-tab>"
" }}} Ultisnips / YCM / Supertab "

" Vim Multiple Cursors {{{ "
let g:multi_cursor_use_default_mapping = 0
let g:multi_cursor_start_key = '<F7>'
let g:multi_cursor_next_key = '<c-n>'
let g:multi_cursor_prev_key = '<c-p>'
let g:multi_cursor_skip_key = '<c-x>'
let g:multi_cursor_quit_key = '<Esc>'
" }}} Vim Multiple Cursors "

" Clang_Complete {{{ "
let g:clang_complete_auto = 0
let g:clang_use_library =1
let g:clang_periodic_quickfix = 0
let g:clang_close_preview = 1

let g:clang_snippets = 1

let g:clang_snippets_engine = 'ultisnips'

let g:clang_exec = '/usr/local/opt/llvm/bin/clang'
let g:clang_library_path = '/usr/local/opt/llvm/lib/libclang.dylib'
" }}} Clang_Complete "
