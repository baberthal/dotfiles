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
let g:ale_echo_msg_format = '[%severity%]% (code) %%s (%linter%)'

" Don't fix on save by default. This is changed for certain filetypes.
let g:ale_fix_on_save = 0

" Use these fixers
let g:ale_fixers = {
\   'cpp': ['clangtidy'],
\   'css': ['prettier'],
\   'html': ['tidy'],
\   'javascript': ['prettier'],
\   'json': ['prettier'],
\   'python': ['yapf', 'isort'],
\   'ruby': ['rubocop'],
\   'scss': ['prettier'],
\   'sh': ['shfmt'],
\   'typescript': ['eslint', 'prettier'],
\   'typescriptreact': ['eslint', 'prettier'],
\   'vue': ['prettier']
\ }

" Disable for c, cpp and header files. YCM is better.
" Also disable for ruby, because YCM has an LSP completer that does it.
" FIXME: This could be one regex, but it would be UGLY
let g:ale_pattern_options = {
\   '\.c$': { 'ale_enabled': 0 },
\   '\.cpp$': { 'ale_enabled': 0 },
\   '\.cc$': { 'ale_enabled': 0 },
\   '\.m$': { 'ale_enabled': 0 },
\   '\.mm$': { 'ale_enabled': 0 },
\   '\.h$': { 'ale_enabled': 0 },
\   '\.hpp$': { 'ale_enabled': 0 },
\ }

let g:ale_linters = {
  \ 'css': ['stylelint'],
  \ 'eruby': ['erubis'],
  \ 'javascript': ['eslint'],
  \ 'python': ['pylint'],
  \ 'scss': ['stylelint'],
  \ 'typescript': [],
\ }

" Alias filetypes
let g:ale_linter_aliases = {
\ }

" 79, really?
" let g:ale_python_autopep8_options = '--max-line-length 80'

let g:ale_sh_shfmt_options = '-i 2 -ci'

let g:ale_sign_warning = 'W>'  " Sign in gutter to denote warning

" Don't warn about trailing whitespace. Autocommands take care of that.
let g:ale_warn_about_trailing_whitespace = 0

" Don't use ale's LSP integration. YCM is much better and faster. Also, talk
" about feature creep!
let g:ale_disable_lsp = 1

" }}} ALE (Asyncronous Lint Engine) "

" BufExplorer Settings {{{ "

" bufExplorer option
let g:bufExplorerShowRelativePath=1

" }}} BufExplorer Settings "

" coc.nvim settings {{{ "

source $HOME/.vim/config/coc-config.vim

" }}} coc.nvim settings "

" Closetag Settings {{{ "

let g:closetag_filenames = '*.html,*.xhtml,*.phtml,*.xml,*.modinfo'
let g:closetag_xhtml_filenames = '*.xml,*.xhtml,*.modinfo'
let g:closetag_filetypes = 'html,xhtml,phtml,xml'
let g:closetag_xhtml_filetypes = 'xhtml,xml'

" let g:closetag_

" }}} Closetag Settings "

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

" Gutentags Settings {{{ "

" Set up project info for gutentags
let g:gutentags_project_info = []
call add(g:gutentags_project_info, { 'type': 'typescript', 'file': 'tsconfig.json' })

" Tell gutentags how to list files
let g:gutentags_file_list_command = {
      \   'markers': {
      \     '.git': 'git ls-files',
      \   },
      \ }


" }}} Gutentags Settings "

" NERDTree Settings {{{ "
let g:NERDTreeCaseSensitiveSort = 1
let g:NERDTreeRespectWildIgnore = 1
" }}} NERDTree Settings "

" Taboo Settings {{{ "

let g:taboo_tabline = 0
let g:taboo_modified_tab_flag = "+"
let g:taboo_renamed_tab_format = "%lm"

" }}} Taboo Settings "

" Tagbar Settings {{{ "

nmap <F8> :TagbarToggle<CR>

if 0 " executable('ripper-tags')
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

let g:tagbar_type_typescript = {
    \ 'ctagstype': 'typescript',
    \ 'kinds': [
      \ 'c:class',
      \ 'n:namespace',
      \ 'f:function',
      \ 'G:generator',
      \ 'v:variable',
      \ 'm:method',
      \ 'p:property',
      \ 'i:interface',
      \ 'g:enum',
      \ 't:type',
      \ 'a:alias',
    \ ],
    \'sro': '.',
      \ 'kind2scope' : {
      \ 'c' : 'class',
      \ 'n' : 'namespace',
      \ 'i' : 'interface',
      \ 'f' : 'function',
      \ 'G' : 'generator',
      \ 'm' : 'method',
      \ 'p' : 'property',
      \},
\ }
" let g:tagbar_type_typescript = {
"   \ 'ctagstype': 'typescript',
"   \ 'kinds': [
"     \ 'c:classes',
"     \ 'n:modules',
"     \ 'f:functions',
"     \ 'v:variables',
"     \ 'v:varlambdas',
"     \ 'm:members',
"     \ 'i:interfaces',
"     \ 'e:enums',
"   \ ]
" \ }

" let g:tagbar_type_typescript = {
"       \  'ctagstype': 'typescript',
"       \  'kinds': [
"       \    'c:classes',
"       \    'a:abstract classes',
"       \    't:types',
"       \    'n:modules',
"       \    'f:functions',
"       \    'v:variables',
"       \    'l:varlambdas',
"       \    'm:members',
"       \    'i:interfaces',
"       \    'e:enums'
"       \  ],
"       \  'sro': '.',
"       \  'kind2scope': {
"       \    'c': 'classes',
"       \    'a': 'abstract classes',
"       \    't': 'types',
"       \    'f': 'functions',
"       \    'v': 'variables',
"       \    'l': 'varlambdas',
"       \    'm': 'members',
"       \    'i': 'interfaces',
"       \    'e': 'enums'
"       \  },
"       \  'scope2kind': {
"       \    'classes': 'c',
"       \    'abstract classes': 'a',
"       \    'types': 't',
"       \    'functions': 'f',
"       \    'variables': 'v',
"       \    'varlambdas': 'l',
"       \    'members': 'm',
"       \    'interfaces': 'i',
"       \    'enums': 'e'
"       \  }
"       \ }

" }}} Tagbar Settings "

" Ruby Heredoc Syntax Settings (Highlights other languages in heredoc) {{{ "

let g:ruby_heredoc_syntax_filetypes = {
\   "c": { "start": "C" },
\   "ruby": { "start": "RUBY" },
\   "sh": { "start": "SHELL" },
\   "graphql": { "start": "GQL" },
\   "vim": { "start": "VIM" },
\}

" }}} Ruby Heredoc Syntax Settings (Highlights other languages in heredoc) "

" SuperTab Settings {{{ "

let g:SuperTabDefaultCompletionType = '<C-j>'

" }}} SuperTab Settings "

" Ultisnips Settings {{{ "

" :UltiSnipsEdit opens a horizontal split
let g:UltiSnipsEditSplit = "context"

" Automatically parse any snipmate snippets found
let g:UltiSnipsEnableSnipMate = 0

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

" Default settings for javascript

let g:ultisnips_javascript = {
      \ 'keyword-spacing': 'always',
      \ 'semi': 'always',
      \ 'space-before-function-paren': 'never'
      \ }

" }}} Ultisnips Settings "

" Vim Multiple Cursors Settings {{{ "

let g:multi_cursor_use_default_mapping = 0 " clear defaults
let g:multi_cursor_start_key = '<F7>'  " F7 to start
let g:multi_cursor_next_key = '<c-n>'
let g:multi_cursor_prev_key = '<c-p>'
let g:multi_cursor_skip_key = '<c-x>'
let g:multi_cursor_quit_key = '<Esc>'

" }}} Vim Multiple Cursors Settings "

" Vue Settings {{{ "

let g:vue_pre_processors = ['typescript', 'scss']

" }}} Vue Settings "

" YouCompleteMe Settings {{{ "

" Autoclose the preview window after we leave insert mode. We don't need to
" know the function signature after we call it.
let g:ycm_autoclose_preview_window_after_insertion = 1
let g:ycm_autoclose_preview_window_after_completion = 1

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
let g:ycm_server_log_level = 'debug'  " Log at 'info' level

" Path to the clangd executable
let g:ycm_clangd_binary_path = '/usr/local/opt/llvm@12/bin/clangd'

" Path to the tsserver executable
"
" First, check if there is a locally-installed version
let s:yarn_tsserver_bin = trim(system('yarn bin tsserver'))
" If there is one and it's executable, use it
if executable(s:yarn_tsserver_bin)
  let g:ycm_tsserver_binary_path = s:yarn_tsserver_bin
else
  " Otherwise, fall back to yarn global bin
  let s:yarn_global_bin = trim(system('yarn global bin'))
  let s:tsserver_path = s:yarn_global_bin . '/tsserver'
  if executable(s:tsserver_path)
    let g:ycm_tsserver_binary_path = s:tsserver_path
  endif
endif


" Path to the solargraph executable
if executable("solargraph")
  let g:rbenv_solargraph_path = exepath("solargraph")

  let g:ycm_language_server = [
        \ {
        \   'name': 'ruby',
        \   'cmdline': [expand(g:rbenv_solargraph_path), 'stdio'],
        \   'filetypes': ['ruby'],
        \   'project_root_files': ['Gemfile']
        \ },
        \ ]
endif

" }}} YouCompleteMe Settings "
