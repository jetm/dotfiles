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
  \ ['vivien/vim-linux-coding-style'],
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
" Syntastic plugin settings
"
" Load Syntatic
"let g:spacevim_enable_neomake = 0

" Disable syntastic
let g:syntastic_always_populate_loc_list = 0
let g:syntastic_auto_loc_list = 0
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 0

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
" Apply Linux coding style to specific paths
"
let g:linuxsty_patterns = [
  \ "/home/tiamarin/repos/linux-stable",
  \ "/home/javier/repos/linux-stable"
  \ ]

"
" Set Python X version to 3
" pythonx looks for python3, instead of python3/dyn
" (Arch Linux python version)
"
if has('python3') || has('python3/dyn')
  set pyx=3
endif

"
" Misc
"

" vim:tw=78:ts=2:sw=2
