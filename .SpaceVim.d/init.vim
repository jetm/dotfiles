"
" SpaceVim settings:
"

" Disable plugins
let g:spacevim_disabled_plugins = [
  \ ]

" If you want to add some custom plugins, use these options:
let g:spacevim_custom_plugins = [
  \ ['sheerun/vim-polyglot', {'merged' : 0}],
  \ ['vitalk/vim-shebang'],
  \ ['octol/vim-cpp-enhanced-highlight', {'on_ft':'c'}],
  \ ['igankevich/mesonic'],
  \ ['benmills/vimux'],
  \ ['junegunn/fzf.vim'],
  \ ['kergoth/vim-bitbake'],
  \ ]

" Change the max number of columns for SpaceVim
let g:spacevim_max_column = 80

if has("gui_running")
  let g:spacevim_guifont = 'Input\ Mono\ Narrow\ Semi-Condensed\ 11'
end

" Disable vimfile in welcome window
let g:spacevim_enable_vimfiler_welcome = 0

"
" Neo dark colorscheme settings
"
" Set Atom colorscheme
let g:spacevim_colorscheme = 'onedark'
let g:neodark#terminal_transparent = 1
let g:neodark#background = '#282C34'
let g:neodark#solid_vertsplit = 1
let g:lightline = {}
let g:lightline.colorscheme = 'neodark'

"
" Checker settings
"

" Enable ale, instead of syntastic
let g:spacevim_enable_neomake = 0
let g:spacevim_enable_ale = 1

" Enable lint on the fly
let g:spacevim_lint_on_the_fly = 1

"
" YouCompleteMe plugin settings
"

" Enable YCM as C/C++ completer
let g:spacevim_enable_ycm = 0

" Diagnostics error symbol
let g:ycm_error_symbol = '✗'

" Diagnostics warning symbol
let g:ycm_warning_symbol = '⚠'

" Force the use of Python 3 interpreter for ycmd. YCM is built for Python 3
let g:ycm_python_binary_path = '/usr/bin/python3'

"
" Enable check C++11 syntax in neomake
"
" Use clang
"let g:neomake_cpp_enable_markers=['clang']
"let g:neomake_cpp_clang_args = ["-std=c++11"]

" Use gcc
"let g:neomake_cpp_enable_markers=['g++']
"let g:neomake_cpp_clang_args = ["-std=c++11"]

"
" Syntastic plugin settings
"
" Load Syntatic
"let g:spacevim_enable_neomake = 0

" Disable syntastic
let g:syntastic_always_populate_loc_list = 0
let g:syntastic_auto_loc_list = 0
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 0

" Diagnostics error symbol
"let g:syntastic_error_symbol = '✗'

" Diagnostics warning symbol
"let g:syntastic_warning_symbol = '⚠'

"
" Code Formatting
"
" Configure clang-format
let g:neoformat_c_clangformat = {
    \ 'exe': 'clang-format',
    \ 'args': ['-style=file'],
    \ 'stdin': 1,
    \ 'no_append': 1,
    \ }

let g:neoformat_enabled_c = ['clangformat']

"
" lang#c configuration
"
call SpaceVim#layers#load('lang#c',
  \ {
  \   'enable_libclang' : 1,
  \   'libclang_path' : '/usr/lib/libclang.so',
  \ }
  \ )

"
" Misc
"

" vim:tw=78:ts=2:sw=2
