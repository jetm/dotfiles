"
" Extra neodark theme options
"
let g:neodark#terminal_transparent = 1
let g:neodark#background = '#282C34'
let g:neodark#solid_vertsplit = 1
let g:lightline = {}
let g:lightline.colorscheme = 'neodark'

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
set list lcs=tab:\|\

" Specify a character to be used as indent line. From SpaceVim ui is '┊'
" It has an effect over fillchars due to Yggdroot/indentLine plugin
let g:indentLine_char = '│'
IndentLinesReset

"
" Movement and keymaps
"
" + keymap for quicker move to any character
nmap <Leader>w <Plug>(easymotion-prefix)s

" Next/Prev buffer
nnoremap L :bnext<CR>
nnoremap H :bprev<CR>

autocmd BufWritePre * %s/\s\+$//e

"
" CtrlSpace plugin
"
" if executable("ag")
  " let g:CtrlSpaceGlobCommand = 'fd --hidden --follow --type f '
" endif
" nnoremap <silent><C-p> :CtrlSpace O<CR>

"
" fzf
"

" CtrlP compatibility
nnoremap <silent><C-p>:ProjectFilesPreview<CR>
let g:fzf_preview_command = "bat --style=numbers --color=always {-1}"
let g:fzf_preview_layout = 'belowright'
let g:fzf_preview_filelist_command = 'rg --files --hidden --follow --glob "!.git/*" --glob "!vendor/"'

"Uses ripgrep to recursively search files under the current directory
" --column: Show column number
" --line-number: Show line number
" --no-heading: Do not show file headings in results
" --fixed-strings: Search term as a literal string
" --ignore-case: Case insensitive search
" --no-ignore: Do not respect .gitignore, etc...
" --hidden: Search hidden files and folders
" --follow: Follow symlinks
" --glob: Additional conditions for search (in this case ignore everything in the .git/ folder)
" --color: Search color options
command! -bang -nargs=* Find call fzf#vim#grep('rg --column --line-number --no-heading --fixed-strings --ignore-case --no-ignore --hidden --follow --glob "!.git/*" --color "always" '.shellescape(<q-args>), 1, <bang>0)


" fzf window layout
let g:fzf_preview_layout = ''

" vim:tw=78:ts=2:sw=2
