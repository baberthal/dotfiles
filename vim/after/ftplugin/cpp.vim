hi link cppStructure cppStatement

if exists('g:llvm_install_root')
    let s:llvm_install_root = g:llvm_install_root
else
    let s:llvm_install_root = '/usr/local/opt/llvm'
endif

" Setup path to clang-rename executable file
if !exists('g:clang_rename_path')
    let g:clang_rename_path = s:llvm_install_root . '/bin/clang-rename'
endif

let s:builddir = getcwd() . '/build'
if isdirectory(s:builddir)
    let b:compilation_db_path = s:builddir
    let g:clang_rename_extra_args = ['-p', s:builddir]
endif


" We remove the // comment setting, so we can add ///, and _then_ add //.
set comments-=://
set comments+=:///,://

set commentstring=//\ %s
