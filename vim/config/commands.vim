"=============================================================================="
" Custom Command Mappings
"=============================================================================="
"
" Most of these commands simply call functions that are autoloaded and under
" autoload/jml.vim
"
"=============================================================================="

" Remap pathogen#helptags() because it can be clobbered by fzf.vim
command! MakeHelptags :call pathogen#helptags()

" Oops! Forgot to open vim with sudo? Just use Sw !
command! Sw :w !sudo tee %

" Zooms the current window (i.e. Pane) to max, or toggles back. See the
" function in autoload/jml.vim
command! ZoomToggle :call jml#ZoomToggle()

command! DeleteTrailingWhitespace :call jml#DeleteTrailingWhitespace()
