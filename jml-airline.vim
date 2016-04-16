let g:airline#themes#jml#palette = {}

" Color palette
let s:gui_base03     =  '#002b36'
let s:cterm_base03   =  8
let s:gui_base02     =  '#073642'
let s:cterm_base02   =  '0'
let s:gui_base01     =  '#586e75'
let s:cterm_base01   =  10
let s:gui_base00     =  '#657b83'
let s:cterm_base00   =  11
let s:gui_base0      =  '#839496'
let s:cterm_base0    =  12
let s:gui_base1      =  '#93a1a1'
let s:cterm_base1    =  14
let s:gui_base2      =  '#eee8d5'
let s:cterm_base2    =  7
let s:gui_base3      =  '#fdf6e3'
let s:cterm_base3    =  15
let s:gui_yellow     =  '#b58900'
let s:cterm_yellow   =  3
let s:gui_orange     =  '#cb4b16'
let s:cterm_orange   =  9
let s:gui_red        =  '#dc322f'
let s:cterm_red      =  160
let s:gui_magenta    =  '#d33682'
let s:cterm_magenta  =  5
let s:gui_violet     =  '#6c71c4'
let s:cterm_violet   =  13
let s:gui_blue       =  '#268bd2'
let s:cterm_blue     =  4
let s:gui_cyan       =  '#2aa198'
let s:cterm_cyan     =  37
let s:gui_green      =  '#859900'
let s:cterm_green    =  2

" Normal mode
let s:N1 = [s:gui_base2, s:gui_blue, s:cterm_base2, s:cterm_blue]
let s:N2 = [s:gui_base01, s:gui_base01, s:cterm_base3, s:cterm_base01]
let s:N3 = [s:gui_base01, s:gui_base02, s:cterm_base01, s:cterm_base02]
let g:airline#themes#jml#palette.normal = airline#themes#generate_color_map(s:N1, s:N2, s:N3)
let g:airline#themes#jml#palette.normal_modified = {
      \ 'airline_c': [s:gui_yellow, s:gui_base02, s:cterm_yellow, s:cterm_base02, ''],
      \ }

" Insert mode
let s:I1 = [s:gui_base02, s:gui_cyan, s:cterm_base02, s:cterm_cyan]
let s:I3 = [s:gui_cyan, s:gui_base02, s:cterm_cyan, s:cterm_base02]
let g:airline#themes#jml#palette.insert = airline#themes#generate_color_map(s:I1, s:N2, s:I3)
let g:airline#themes#jml#palette.insert_modified = copy(g:airline#themes#jml#palette.normal_modified)
let g:airline#themes#jml#palette.insert_paste = {
      \ 'airline_a': [s:gui_base03, s:gui_orange, s:cterm_base03, s:cterm_orange, ''],
      \ }

" Replace mode
let g:airline#themes#jml#palette.replace = {
      \ 'airline_a': [s:gui_base2, s:gui_red, s:cterm_base2, s:cterm_red, ''],
      \ 'airline_c': [s:gui_red, s:gui_base02, s:cterm_red, s:cterm_base02, ''],
      \ }
let g:airline#themes#jml#palette.replace_modified = copy(g:airline#themes#jml#palette.insert_modified)

" Visual mode
let s:V1 = [s:gui_base03, s:gui_violet, s:cterm_base03, s:cterm_violet]
let s:V3 = [s:gui_violet, s:gui_base02, s:cterm_violet, s:cterm_base02]
let g:airline#themes#jml#palette.visual = airline#themes#generate_color_map(s:V1, s:N2, s:V3)
let g:airline#themes#jml#palette.visual_modified = copy(g:airline#themes#jml#palette.insert_modified)

" Inactive window
let s:IA = [s:gui_base1, s:gui_base00, s:cterm_base1, s:cterm_base00, '']
let g:airline#themes#jml#palette.inactive = airline#themes#generate_color_map(s:IA, s:IA, s:IA)
let g:airline#themes#jml#palette.inactive_modified = {
      \ 'airline_c': [s:gui_orange, '', s:cterm_orange, '', ''],
      \ }
