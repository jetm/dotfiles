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
" SpaceVim keybinding
"
" Default is \ key
" let mapleader = "\<space>"

"
" Spacevim colorscheme settings
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

if has("gui-running")
  let guifont = 'Input\ Mono\ Narrow\ Semi-Condensed\ 11'
end

" Disable vimfile in welcome window
let g:spacevim_enable_vimfiler_welcome = 0

" Set default indent to 4 spaces
let g:spacevim_default_indent = 4

" Disable expanding tab in spaces
" Commented until is reforced again
" let g:spacevim_expand_tab = 0

" Enable Version Control layer
call SpaceVim#layers#load('VersionControl')

" Enable searching file layer, add CtrlP keybind.
" Use fzf instead of Unite (fails sometimes)
call SpaceVim#layers#load('fzf')

" fzf use ripgrep for grep
let g:rg_command = '
  \ rg --column --line-number --no-heading --fixed-strings --ignore-case --no-ignore --hidden --follow --color "always"
  \ -g "*.{js,json,php,md,styl,jade,html,config,py,cpp,c,go,hs,rb,conf}"
  \ -g "!{.git,node_modules,vendor}/*" '

command! -bang -nargs=* F call fzf#vim#grep(g:rg_command .shellescape(<q-args>), 1, <bang>0)

" Enable cscope
call SpaceVim#layers#load('cscope')

" Allow cscope behave like ctags(C-] and g])
set cscopetag

" Autoloading Cscope Database
function! LoadCscope()
  let db = findfile("cscope.out", ".;")
  if (!empty(db))
    let path = strpart(db, 0, match(db, "/cscope.out$"))
    set nocscopeverbose " suppress 'duplicate connection' error
    exe "cs add " . db . " " . path
    set cscopeverbose
  " else add the database pointed to by environment variable
  elseif $CSCOPE_DB != ""
    cs add $CSCOPE_DB
  endif
endfunction
au BufEnter /* call LoadCscope()

" @TODO: test more or use cscope or global instead
" call SpaceVim#layers#load('tags')

"
" SpaceVim Checker settings
"

" Enable ale, instead of syntastic
let g:spacevim_enable_neomake = 0
let g:spacevim_enable_ale = 1

" Enable lint on the fly
let g:spacevim_lint_on_the_fly = 1

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

" Run Neoformat on Save
" doesn't works well with YCM
" augroup fmt
  " autocmd!
  " autocmd BufWritePre * undojoin | Neoformat
" augroup END
nnoremap F2 :Neoformat<CR>

"
" Indentation settings
"
" Make visible special characters as tab, spaces, eol
set list
set listchars=tab:»\ ,extends:›,precedes:‹,nbsp:␣,trail:·,
" eol:↲,
set fillchars=vert:│,fold:·
set showbreak=↪\ 

" Specify a character to be used as indent line. From SpaceVim ui is '┊'
" It has an effect over fillchars due to Yggdroot/indentLine plugin
let g:indentLine_char = '│'

"
" Movement and keymaps
"
" + keymap for quicker move to any character
nmap + <Plug>(easymotion-prefix)s

" Next/Prev buffer
nnoremap L :bnext<CR>
nnoremap H :bprev<CR>

nnoremap <C-n> :noh<CR>


"
" Misc
"

" Set Python X version to 3
" pythonx looks for python3, instead of python3/dyn
" (Arch Linux python version)
if has('python3') || has('python3/dyn')
  set pyx=3
endif

" vim:tw=78:ts=2:sw=2
