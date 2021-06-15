"
" UI
"
" if has('nvim-0.5.0')
"   Plug 'ii14/onedark.nvim'
" else
Plug 'joshdick/onedark.vim'
" endif


"
" Buffers
"
" Delete buffers and close files in Vim without closing your windows or
" messing up your layout. Like Bclose.vim, but rewritten and well maintained
" Plug 'moll/vim-bbye'

call plug#end()

"
" Lua init configuration
"
lua require('config')

" vim:set ts=2 sw=2 et:
