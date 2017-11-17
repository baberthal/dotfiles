"=============================================================================="
" Generalized Vim Settings
"=============================================================================="
"
" This file configures general vim settings
"
"=============================================================================="

"================"
" Basic Settings "
"================"

set belloff=all                 " Don't ring the bell, yo!
set breakindent                 " best patch ever
set colorcolumn=81
set expandtab                   " SPACES ALWAYS (queue flame war...)
set exrc                        " Source local (i.e. project-specific) vimrc files
set fileencoding=utf-8          " UTF-8 Always FIXME: Check the macvim docs re: this
set foldenable                  " Folding on by default
set foldlevel=0                 " Fold everything by default
set foldmethod=marker           " Fold by markers
set fillchars+=stl:\ ,stlnc:\ ,vert:\|,fold:=,diff:-
set history=9999                " big history
set incsearch                   " incsearch
set laststatus=2                " always show status line
set modeline                    " Dangerous, but useful
set mouse=nih
set noautoread                  " Don't autoread
set noautowrite                 " Don't autowrite
set noautowriteall              " Don't autowrite
set nocursorcolumn              " Don't highlight cursor column, but do highlight line
set nohlsearch
set noshowmode                  " Current mode is shown in statusline
set noshowmatch                 " So annoying
set novisualbell                " Just stop with the bell already
set number
set relativenumber              " See jml#NumberToggle() in autoload/jml.vim
set ruler                       " show cursor position
set path+=./include,include,
set previewheight=20            " 20 rows in preview window
set secure                      " Don't allow Autocommands in the project-specific vimrc
set shiftround                  " Rounds up shift to nearest multiple of 'sw'
set shiftwidth=2                " 2 spaces in every language
let &showbreak = '>>> '         " We do it like this to avoid fuckups with the trailing space
set showcmd
set smartcase
set softtabstop=-1              " use 'shiftwidth'
set nospell
set spelllang=en_us
set splitright                  " Split on RHS
set tags=./tags,tags,.git/tags; " Look in .git/ for tags files as well
set tags+=.git/bundler.tags,.git/stdlib.tags;
set termencoding=utf-8
set textwidth=80                " Pedantic, but worth it
set title                       " mess with title
set t_vb=                       " Seriously, that fucking bell
set undodir=~/.vim/undo         " put undo files here
set undofile
set undolevels=1000             " persistent undo
set undoreload=10000            " Undo forced reload with :e!
set virtualedit=block

"=========="
" WildMenu "
"=========="

set wildmenu                                         " turn on command-line completion wild style
set wildignore+=*.a,*.o,*.obj,*.exe,*.dll,*.manifest " Object Files
set wildignore+=*.DS_Store                           " OSX Shit
set wildignore+=*.jpg,*.bmp,*.gif,*.png,*.jpeg       " Binary Images
set wildignore+=*.pdf,*.zip,*.so,*.dylib             " Binary Files
set wildignore+=*.pyc,*.pyo                          " Python bytecode files
set wildignore+=*.swp,*.bak                          " Vim Turds
set wildignore+=*.sw?                                " More vim turds
set wildignore+=*/tmp/*                              " Ignore tmp directory
set wildmode=list:full                               " show list with more than one, but complete full

"================"
" Format Options "
"================"

set formatoptions=q  " allow gq to work in comments
set formatoptions+=r " enter extends comments
set formatoptions+=n " format numbered lists using 'formatlistpat'
set formatoptions+=1 " don't break after one-letter words
set formatoptions+=j " Remove comment leader when joining comments

"==========="
" ShortMess "
"==========="

set shortmess=a   " filmnrwx
set shortmess+=O  " File read message overwrites previous
set shortmess+=s  " Don't warn about 'search hit bottom'
set shortmess+=f  " Though this should be included with the 'a' option above
set shortmess+=t  " Truncate at the start
set shortmess+=T  " Truncate in the middle
set shortmess+=I  " No intro message
set shortmess+=c  " Don't show ins-completion message
