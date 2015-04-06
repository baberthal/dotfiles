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
Plugin 'tmux-plugins/vim-tmux'

" Alignment and autocomplete
Plugin 'godlygeek/tabular'
Plugin 'L9'
Plugin 'junegunn/vim-easy-align'
Plugin 'tpope/vim-endwise'
Plugin 'Raimondi/delimitMate'
Plugin 'edsono/vim-matchit'
Plugin 'tpope/vim-surround'

" Ruby (on rails) development plugins
Plugin 'tpope/vim-rails.git'
Plugin 'tpope/vim-rvm.git'
Plugin 'vim-ruby/vim-ruby.git'
Plugin 'Keithbsmiley/rspec.vim'
Plugin 'tpope/vim-fugitive'
Plugin 'ecomba/vim-ruby-refactoring'

" IDE-ish plugins
Plugin 'kien/ctrlp.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'jistr/vim-nerdtree-tabs'
Plugin 'wesQ3/vim-windowswap'

" snipmate
Plugin 'MarcWeber/vim-addon-mw-utils'
Plugin 'tomtom/tlib_vim'
Plugin 'garbas/vim-snipmate'
Plugin 'honza/vim-snippets'

" Statusline
Plugin 'bling/vim-airline'

call vundle#end()
filetype plugin indent on

set bs=2
set ts=2
set sw=2
set number
set nuw=3
set ruler

" Colors, fonts, encoding, and background setting
syntax enable
colorscheme solarized
set background=dark
let g:solarized_termtrans = 1
set laststatus=2
set noshowmode

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

" No scroll bars in gvim mode
set guioptions-=r
set guioptions-=l
set guioptions-=L

set tags=./tags;

" Search a file in the filetree
nnoremap <space><space> :split<cr> :<C-u>Unite -start-insert file_rec/async<cr>


" ----EASY ALIGN SETTINGS----
vnoremap <silent> <Enter> :EasyAlign<cr>

let g:session_autosave = 'no'

" Yank text to the OS X Clipboard
noremap <leader>y "*y
noremap <leader>yy "*Y

" Preserve indentation while pasting text from OS X Clipboard
noremap <leader>p :set paste<CR>:put *<CR>:set nopaste<CR>

" Automatically delete trailing whitespace during :w
autocmd BufWritePre * :%s/\s\+$//e

" NERDTree settings
let g:nerdtree_tabs_open_on_console_startup=1

" Allow mouse mode in console
set mouse=a

" tmuxline settings
let g:tmuxline_preset = 'tmux'
