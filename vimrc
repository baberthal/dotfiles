set nocompatible
filetype off

" Runtime Path and Vundle plugin settings
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" Vundle manages itself
Plugin 'gmarik/Vundle.vim'

" Pretty colors & some syntax highlighting
Plugin 'altercation/vim-colors-solarized'
Plugin 'scrooloose/syntastic'
Plugin 'rodjek/vim-puppet'
Plugin 'kchmck/vim-coffee-script'

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
Plugin 'tpope/vim-rvm.git'
Plugin 'vim-ruby/vim-ruby.git'
Plugin 'Keithbsmiley/rspec.vim'
Plugin 'tpope/vim-fugitive'
Plugin 'ecomba/vim-ruby-refactoring'
Plugin 'tpope/vim-bundler'

" Window / pane management
Plugin 'wesQ3/vim-windowswap'
Plugin 'gcmt/taboo.vim'
Plugin 'vim-scripts/ZoomWin'

" File search, other good stuff
Plugin 'kien/ctrlp.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'jlanzarotta/bufexplorer'
Plugin 'terryma/vim-multiple-cursors'
Plugin 'tpope/vim-commentary'

" snipmate
Plugin 'MarcWeber/vim-addon-mw-utils'
Plugin 'tomtom/tlib_vim'
Plugin 'garbas/vim-snipmate'
Plugin 'honza/vim-snippets'

" Statusline
Plugin 'bling/vim-airline'

call vundle#end()
filetype plugin indent on

set number
set nuw=3
set ruler
set colorcolumn=82
highlight ColorColumn ctermbg=cyan guibg=cyan
let mapleader="\<Space>"

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

if has('gui_running')
    let s:uname = system("uname")
    if s:uname == "Darwin\n"
        set guifont=Inconsolata\ for\ Powerline:h14
    endif
endif

" Some leader remaps
nmap <Leader>s :source $MYVIMRC<CR>
nmap <Leader>v :e $MYVIMRC<CR>
nmap <Leader>w :w<CR>
map <F6> :NERDTreeToggle<CR>

" No scroll bars in gvim mode
set guioptions-=r
set guioptions-=l
set guioptions-=L

set tags=./tags;

" Utilisnips configuration
" let g:UltiSnipsExpandTrigger="<tab>"
" let g:UltiSnipsJumpForwardTrigger="<tab>"
" let g:UltiSnipsJumpBackwardTrigger="<c-z>"
" let g:UltiSnipsEditSplit="horizontal"
" let g:UltiSnipsEnableSnipMate=1

" ----EASY ALIGN SETTINGS----
vnoremap <silent> <Enter> :EasyAlign<cr>
vmap <Enter> <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)

let g:session_autosave = 'no'

" Yank text to the OS X Clipboard
noremap <leader>y "*y
noremap <leader>yy "*Y

" Preserve indentation while pasting text from OS X Clipboard
noremap <leader>p :set paste<CR>:put *<CR>:set nopaste<CR>

" Automatically delete trailing whitespace during :w
autocmd BufWritePre * :%s/\s\+$//e

" Fix ugly tabstops and retab, all in one command
command Fixtab :set tabstop=2 | :set expandtab | :retab

" NERDTree settings, but only if we open in a project where we want it

function ShouldNerdTree()
    let projects_list = ['puck_by_numbers', 'mlb_terminal', 'uber_widgets', 'hangups']
    if(index(projects_list, split(getcwd(),"/")[-1]) >=0 )
        return 1
    endif
endfunction

if ShouldNerdTree()
    autocmd vimenter * NERDTree
endif

" Allow mouse mode in console, but only for normal mode (everything in help)
set mouse=nih

" tmuxline settings
let g:tmuxline_preset = 'tmux'
