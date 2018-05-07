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
  \ ['ConradIrwin/vim-bracketed-paste'],
  \ ['jetm/vim-bitbake'],
  \ ['joshdick/onedark.vim', {'loadconf': 1, 'merged': 0}],
  \ ]

"
" Neo dark colorscheme settings
"
" Set Atom colorscheme
let g:spacevim_colorscheme = 'onedark'

" let g:spacevim_colorscheme = 'one'
" Alternative one dark scheme
" \ ['rakr/vim-one'],

let g:neodark#terminal_transparent = 1
let g:neodark#background = '#282C34'
let g:neodark#solid_vertsplit = 1
let g:lightline = {}
let g:lightline.colorscheme = 'neodark'

" Change the max number of columns for SpaceVim
let g:spacevim_max_column = 80

let guifont = 'Input\ Mono\ Narrow\ Semi-Condensed\ 11'

" Disable vimfile in welcome window
let g:spacevim_enable_vimfiler_welcome = 0

" Set default indent to 4 spaces
let g:spacevim_default_indent = 4

" Disable expanding tab in spaces
" let g:spacevim_expand_tab = 0

" Enable Version Control layer
call SpaceVim#layers#load('VersionControl')

" Enable search file layer, add CtrlP
call SpaceVim#layers#load('denite')

"
" Checker settings
"

" Enable ale, instead of syntastic
let g:spacevim_enable_neomake = 0
let g:spacevim_enable_ale = 1

" Enable lint on the fly
let g:spacevim_lint_on_the_fly = 1

" + keymap for quicker move to any character
nmap + <Plug>(easymotion-prefix)s

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
" Misc
"

" Set Python X version to 3
" pythonx looks for python3, instead of python3/dyn
" (Arch Linux python version)
if has('python3') || has('python3/dyn')
  set pyx=3
endif

" Make visible special characters as tab, spaces, eol
set list
set listchars=tab:»\ ,extends:›,precedes:‹,nbsp:␣,trail:·,
set fillchars=vert:│,fold:·
set showbreak=↪\ 
" eol:↲,

" vim:tw=78:ts=2:sw=2
