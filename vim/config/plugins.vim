"=============================================================================="
" Plugin Settings
"=============================================================================="
"
" This file simply sources the files in the ./plugins/ directory. It is here to
" ease sourcing of files in my vimrc, so I only have to do
"
"   source ~/.vim/config/plugins.vim
"
" and not source every single file in the directory.
"
"=============================================================================="

" ALE (Asyncronous Lint Engine) {{{ "

if !executable('clang-tidy')
  let g:ale_c_clangtidy_executable = '/usr/local/opt/llvm/bin/clang-tidy'
  let g:ale_cpp_clangtidy_executable = '/usr/local/opt/llvm/bin/clang-tidy'
endif

if !executable('clang-check')
  let g:ale_cpp_clangcheck_executable = '/usr/local/opt/llvm/bin/clang-check'
endif

" Let clang-tidy configure itself with the .clang-tidy file
let g:ale_cpp_clangtidy_checks = []

" Show the linter in the message so we know how to disable it if it is a stupid
" rule. Stupid rules include, but are not limited to:
"   * Python textwidth of 79 vs 80
"   * Ruby no assignment in conditional
let g:ale_echo_msg_format = '[%severity%] %s (%linter%)'

" Don't fix on save by default. This is changed for certain filetypes.
let g:ale_fix_on_save = 0

" Use these fixers
let g:ale_fixers = {
\   'python': [
\       'yapf',
\       'isort'
\   ],
\
\   'ruby': [
\       'remove_trailing_lines',
\       'rubocop'
\   ],
\
\   'css': [ 'prettier' ],
\   'scss': [ 'prettier' ],
\   'javascript': [ 'prettier' ],
\   'json': [ 'prettier' ],
\   'typescript': [ 'prettier' ],
\ }

" Disable for c, cpp and header files. YCM is better.
" FIXME: This could be one regex, but it would be UGLY
let g:ale_pattern_options = {
\   '\.c$': { 'ale_enabled': 0 },
\   '\.cpp$': { 'ale_enabled': 0 },
\   '\.cc$': { 'ale_enabled': 0 },
\   '\.h$': { 'ale_enabled': 0 },
\   '\.hpp$': { 'ale_enabled': 0 },
\ }

let g:ale_linters = {
  \ 'css': ['stylelint'],
  \ 'scss': ['stylelint'],
  \ 'eruby': ['erubis'],
  \ 'typescript': ['tslint', 'tsserver'],
  \ 'javascript': ['eslint'],
\ }

" 79, really?
" let g:ale_python_autopep8_options = '--max-line-length 80'

let g:ale_sign_warning = 'W>'  " Sign in gutter to denote warning

" Don't warn about trailing whitespace. Autocommands take care of that.
let g:ale_warn_about_trailing_whitespace = 0

" }}} ALE (Asyncronous Lint Engine) "

" CtrlP Settings {{{ "

if executable('rg')
  let g:ctrlp_user_command = 'rg %s --files --color=never --glob ""' " Use RipGrep
endif
let g:ctrlp_use_caching = 0 " RipGrep is so fast, caching slows it down
let g:ctrlp_match_func = {'match': 'cpsm#CtrlPMatch'} " Better matches with CPSM
let g:ctrlp_funky_syntax_highlight = 1 " Simple highlights w/o ctags

" }}} CtrlP Settings "

" Dash Integration {{{ "

" This disables dash from autofocusing when searching (saves lots of <Cmd>-Tab)
let g:dash_activate = 0

" }}} Dash Integration "

" Tagbar Settings {{{ "

nmap <F8> :TagbarToggle<CR>

if executable('ripper-tags')
  let g:tagbar_type_ruby = {
        \   'kinds': [
        \     'm:modules',
        \     'c:classes',
        \     'C:constants',
        \     'F:singleton methods',
        \     'f:methods',
        \     'a:aliases'
        \   ],
        \   'kind2scope': {
        \     'c': 'class',
        \     'm': 'class'
        \   },
        \   'scope2kind': { 'class' : 'c' },
        \   'ctagsbin': 'ripper-tags',
        \   'ctagsargs': ['-f', '-']
        \ }
else
  let g:tagbar_type_ruby = {
        \   'kinds': [
        \     'm:modules',
        \     'c:classes',
        \     'd:describes',
        \     'C:contexts',
        \     'f:methods',
        \     'F:singleton methods'
        \   ]
        \ }
endif

" }}} Tagbar Settings "

" Ruby Heredoc Syntax Settings (Highlights other languages in heredoc) {{{ "

let g:ruby_heredoc_syntax_filetypes = {
\   "c": { "start": "C" },
\   "ruby": { "start": "RUBY" },
\   "sh": { "start": "SHELL" },
\   "vim": { "start": "VIM" },
\}

" }}} Ruby Heredoc Syntax Settings (Highlights other languages in heredoc) "

" SuperTab Settings {{{ "

let g:SuperTabDefaultCompletionType = '<C-j>'

" }}} SuperTab Settings "

" Ultisnips Settings {{{ "

" :UltiSnipsEdit opens a horizontal split
let g:UltiSnipsEditSplit = "context"

" Also parse any snipmate snippets found
let g:UltiSnipsEnableSnipMate = 1

" Expand snippets with <tab>
let g:UltiSnipsExpandTrigger = "<tab>"

" Jump to next placeholder with <tab>
let g:UltiSnipsJumpForwardTrigger = "<tab>"

" Jump to previous placeholder with <tab>
let g:UltiSnipsJumpBackwardTrigger = "<s-tab>"

" List snippets with <C-l> (insert mode only)
let g:UltiSnipsListSnippets = "<C-l>"

" Load custom snippets from ~/.vim/UltiSnips
let g:UltiSnipsSnippetsDir = "~/.vim/UltiSnips"

" Use jedi-style docstrings for python
let g:ultisnips_python_style = 'jedi'

" }}} Ultisnips Settings "

" Vim Multiple Cursors Settings {{{ "

let g:multi_cursor_use_default_mapping = 0 " clear defaults
let g:multi_cursor_start_key = '<F7>'  " F7 to start
let g:multi_cursor_next_key = '<c-n>'
let g:multi_cursor_prev_key = '<c-p>'
let g:multi_cursor_skip_key = '<c-x>'
let g:multi_cursor_quit_key = '<Esc>'

" }}} Vim Multiple Cursors Settings "

" YouCompleteMe Settings {{{ "

" Autoclose the preview window after we leave insert mode. We don't need to
" know the function signature after we call it.
let g:ycm_autoclose_preview_window_after_insertion = 1

" Collect autocomplete suggestions from comments and strings
let g:ycm_collect_identifiers_from_comments_and_strings = 1

" Complete in comments
let g:ycm_complete_in_comments = 1

" And in strings
let g:ycm_complete_in_strings = 1

" TODO: Set up the global config to be smarter
let g:ycm_global_ycm_extra_conf = '~/.vim/ycm_extra_conf.py'

" Use <C-j>, <C-n> or <Down> to move to next selection in autocomplete menu
let g:ycm_key_list_select_completion = ['<C-j>', '<C-n>, <Down>']

" Use <C-k>, <C-p> or <Up> to select previous entry in completion menu
let g:ycm_key_list_previous_completion = ['<C-k>', '<C-p>', '<Up>']

" Use system python for YCM server
let g:ycm_path_to_python_interpreter = '/usr/local/bin/python3'

" But use python3 for jedi
let g:ycm_python_binary_path = 'python'

" Path to rust source, for rust stdlib completions
let g:ycm_rust_source_path = '/opt/src/rust'

" Automatically add syntax keywords to the autocomplete menu
let g:ycm_seed_identifiers_with_syntax = 0

" Don't keep logfiles after we quit vim
let g:ycm_server_keep_logfiles = 0   " Don't keep logs after we quit

" Log at 'info' level always
let g:ycm_server_log_level = 'info'  " Log at 'info' level

" }}} YouCompleteMe Settings "
