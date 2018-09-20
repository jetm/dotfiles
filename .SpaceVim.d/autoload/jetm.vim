"
" Extra neodark theme options
"
let g:neodark#terminal_transparent = 1
let g:neodark#background = '#282C34'
let g:neodark#solid_vertsplit = 1
let g:lightline = {}
let g:lightline.colorscheme = 'neodark'

"
" fzf configuration
"
" Use ripgrep with fzf for grepping
if executable('rg')
  let g:rg_command = '
    \ rg --column --line-number --no-heading --fixed-strings --ignore-case
    \ --hidden --follow --color "always"
    \ -g "*.{js,json,php,md,styl,jade,html,config,py,cpp,c,go,hs,rb,conf}"
    \ -g "!{.git,node_modules,vendor}/*" '
  command! -bang -nargs=* Rg
    \ call fzf#vim#grep(
    \   g:rg_command. shellescape(<q-args>).'| tr -d "\017"', 1,
    \   <bang>0 ? fzf#vim#with_preview('up:60%')
    \           : fzf#vim#with_preview('right:50%:hidden', '?'),
    \   <bang>0
    \ )
endif

" Use fd instead of default tool from fzf
if executable('fd')
  let $FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
endif

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
noremap <silent> <F4> :silent Neoformat<CR>

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
