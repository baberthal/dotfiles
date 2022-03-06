"
" This is my personal and very opinionated vimrc. I don't recommend you copy
" it, just use what you want (and understand, but I'm not here to lecture).
"
" If you find an obvious mistake / typo, I can be found around the internet as
" `@baberthal` (twitter, github) or at <j.morgan.lieberthal@gmail.com>.
"
" This file is hosted on github at:
"   https://github.com/baberthal/dotfiles/vimrc
"
set encoding=utf-8
scriptencoding utf-8

" runtime bundle/vim-pathogen/autoload/pathogen.vim
runtime bundle/fzf/plugin/fzf.vim
execute pathogen#infect()

let g:sqlfmt_command = "sqlformat"
let g:sqlfmt_options = "-r -a -s -k upper --wrap_after 79"

filetype plugin indent on
syntax on

if $DEBUG
  echohl WarningMsg | echo "Debugging Startup" | echohl None
  echom 'Sourcing "' . expand('<sfile>') . '"'

  augroup JML_DEBUG
    au!
    au SourcePre * echom "Sourcing " . expand('<sfile>')
  augroup end
endif

"=========="
" Mappings "
"=========="

let mapleader="\<Space>"

" Leader Prefix Mappings (Normal Mode)
nnoremap <leader>f :CtrlPFunky<CR>
nnoremap <Leader>gc :Gcommit<CR>
nnoremap <Leader>gst :Gstatus<CR>
nnoremap <Leader>ml :AppendModeline<CR>
nnoremap <leader>p :set paste<CR>:put *<CR>:set nopaste<CR>
nmap <Leader>w :w<CR>
nnoremap <leader>y "*y
nnoremap <leader>yy "*Y
nnoremap <Leader>] :tabnext<CR>
nnoremap <Leader>[ :tabprevious<CR>
" V-Split with <space>|
nnoremap <Leader><Bar> :vsplit<CR>
nnoremap <Leader>% :split<CR>
nnoremap <silent><leader>\ :call jml#NumberToggle()<CR>

" Function Key Mappings
nnoremap <F6> :NERDTreeToggle<CR>
nnoremap <F9> :CocFix<CR>

" Plugin Mappings
vnoremap <silent> <CR> :EasyAlign<CR>
vmap <CR> <Plug>(EasyAlign)
" nnoremap <silent><buffer> K <Esc>:Dash <C-R><C-W><CR>

" FIXME: What the fuck does this do?
nnoremap <silent> <C-K> <C-T>

" Sync syntax using F12
noremap <F12> <Esc>:syntax sync fromstart<CR>
inoremap <F12> <C-o>:syntax sync fromstart<CR>

digraphs oh 629

"=============="
" Color Scheme "
"=============="

colorscheme solarized
set background=dark

" Don't show bold text (it looks a bit strange)
let g:solarized_bold = 0

" call togglebg#map("<F5>")

"==============="
" Projectionist "
"==============="

let g:projectionist_heuristics = {
      \   "include/*.h": {
      \     "type": "header",
      \     "skeleton": "header",
      \     "alternate": ["src/{}.cpp", "lib/{}.cpp"]
      \   },
      \   "lib/*.cpp": {
      \     "type": "source",
      \     "skeleton": "skel",
      \     "alternate": ["include/{}.h"]
      \   },
      \   "src/*.cpp": {
      \     "type": "source",
      \     "skeleton": "skel",
      \     "alternate": ["include/{}.h"]
      \   },
      \  "src/*.ts": {
      \     "type": "source",
      \     "skeleton": "skel",
      \  },
      \ }


let g:terminal_ansi_colors = [
      \ "#073642",
      \ "#dc322f",
      \ "#859900",
      \ "#b58900",
      \ "#268bd2",
      \ "#d33682",
      \ "#2aa198",
      \ "#eee8d5",
      \ "#002b36",
      \ "#cb4b16",
      \  "#586e75",
      \  "#657b83",
      \  "#839496",
      \  "#6c71c4",
      \  "#93a1a1",
      \  "#fdf6e3",
    \ ]

"==========="
" Sub Files "
"==========="

" This comes first, because it sets the most basic settings
source $HOME/.vim/config/settings.vim

" Please keep these in alphabetical order
source $HOME/.vim/config/autocmds.vim
source $HOME/.vim/config/commands.vim
source $HOME/.vim/config/highlights.vim
source $HOME/.vim/config/plugins.vim
source $HOME/.vim/config/statusline.vim

let g:pyindent_open_paren = '&sw'
let g:pyindent_nested_paren = '&sw'
let g:pyindent_continue = '&sw'
let g:no_google_python_recursive_indent = 1

let g:python_highlight_all = 1

" One-Off Plugin Settings {{{ "

let g:closetag_filenames = "*.html,*.xhtml,*.xml,*.plist"

let g:js_indent_flat_switch = 1
let g:js_indent_logging = 1
" }}} One-Off Plugin Settings "

" DoxygenToolkit Settings {{{ "
let g:DoxygenToolkit_commentType = 'C++'
let g:DoxygenToolkit_briefTag_pre = "\\brief "
let g:DoxygenToolkit_paramTag_pre = "\\param "
  let g:DoxygenToolkit_returnTag = "\\return "
" }}} DoxygenToolkit Settings "

" Ruby {{{ "
let g:ruby_indent_access_modifier_style = 'outdent'
let g:ruby_indent_assignment_style = 'variable'
let g:rubycomplete_buffer_loading = 0
let g:rubycomplete_use_bundler = 0
let g:rubycomplete_load_gemfile = 0
" }}} Ruby "

" Javascript/JSON {{{ "
let g:used_javascript_libs = ''
let g:vim_json_syntax_conceal = 0

" }}} Javascript/JSON "

" User-Defined Functions {{{ "

fun! FindConfig(prefix, what, where)
  let cfg = findfile(a:what, escape(a:where, ' ') . ';')
  return cfg !=# '' ? ' ' . a:prefix . ' ' . shellescape(cfg) : ''
endf

function! SynStack()
  if !exists("*synstack")
    return
  endif
  echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunction

"
" }}} User-Defined Functions "

" Vim-Tmux-Navigator {{{ "
let g:tmux_navigator_no_mappings = 1
nnoremap <silent> <C-h> :TmuxNavigateLeft<cr>
nnoremap <silent> <C-j> :TmuxNavigateDown<cr>
nnoremap <silent> <C-k> :TmuxNavigateUp<cr>
nnoremap <silent> <C-l> :TmuxNavigateRight<cr>
nnoremap <silent> <C-\> :TmuxNavigatePrevious<cr>

" }}} Vim-Tmux-Navigator "

nnoremap <leader>g :silent execute "grep! -R " . shellescape(expand("<cWORD>")) . " ."<cr>:copen<cr>

" YouCompleteMe / Ultisnips {{{ "

let g:snips_author = 'J. Morgan Lieberthal'
let g:snips_email = 'morgan@jmorgan.org'
let g:snips_github = 'https://github.com/baberthal'

" }}} YouCompleteMe / UltiSnips "

" Clang {{{ "
let g:clang_format#command = "/usr/local/bin/clang-format"
let g:clang_format#detect_style_file = 1
let g:clang_format#auto_format = 1
" }}} Clang "
