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

runtime bundle/vim-pathogen/autoload/pathogen.vim
execute pathogen#infect()

filetype plugin indent on
syntax enable

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
nnoremap <F9> :YcmCompleter FixIt<CR>

" Plugin Mappings
vnoremap <silent> <CR> :EasyAlign<CR>
vmap <CR> <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)
nnoremap <silent><buffer> K <Esc>:Dash <C-R><C-W><CR>

" FIXME: What the fuck does this do?
nnoremap <silent> <C-K> <C-T>

"=============="
" Color Scheme "
"=============="

colorscheme solarized
set background=dark
let g:solarized_termtrans = 1
call togglebg#map("<F5>")

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
source $HOME/.vim/config/programs.vim
source $HOME/.vim/config/statusline.vim

" One-Off Plugin Settings {{{ "
" bufExplorer option
let g:bufExplorerShowRelativePath=1

" Taboo.vim settings
let g:taboo_tabline = 0
let g:taboo_modified_tab_flag = "+"
let g:taboo_renamed_tab_format = "%lm"

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
" }}} Ruby "

" Javascript/JSON {{{ "
let g:used_javascript_libs = 'jquery,jasmine,underscore,angularjs,angularui,angularuirouter,react'
let g:vim_json_syntax_conceal = 0

" }}} Javascript/JSON "

" Dart {{{ "
let g:dart_style_guide = 1
" }}} Dart "

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

function! s:Format()
  if !exists("g:clang_format_py")
    let g:clang_format_py = "/usr/local/opt/llvm/share/clang/clang-format.py"
  endif

  exec "pyf " . g:clang_format_py
endfunction

command! Format call s:Format()

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

" Legacy Syntastic Settings (Unused for now) {{{ "

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 0

let g:syntastic_javascript_checkers = ['eslint']
let g:syntastic_haml_checkers = ['haml_lint']
let g:syntastic_ruby_checkers = ['mri', 'rubocop']
let g:systastic_ruby_exec = $rvm_path . "/rubies/" . $RUBY_VERSION . "/bin/ruby"

let g:syntastic_c_checkers = ['clang_check', 'make']
let g:syntastic_c_clang_check_post_args = ""

let g:syntastic_scss_checkers = ['sass_lint']

let g:tsuquyomi_disable_quickfix = 1
let g:syntastic_typescript_checkers = ['tsuquyomi', 'tslint']

let g:syntastic_swift_checkers = ['swiftpm']
let g:syntastic_swift_swiftpm_executable = '/Library/Developer/Toolchains/swift-latest.xctoolchain/usr/bin/swift'

" }}} Legacy Syntastic Settings (Unused for now) "

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
