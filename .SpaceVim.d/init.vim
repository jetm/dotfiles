" If you want to add some custom plugins, use these options:
let g:spacevim_custom_plugins = [
  \ ['sheerun/vim-polyglot'],
  \ ['vitalk/vim-shebang'],
  \ ]

" Here are some basic customizations, please refer to the
" ~/.SpaceVim.d/init.vim
" file for all possible options:
let g:spacevim_default_indent = 3
let g:spacevim_max_column     = 80

" use space as `<Leader>`
let mapleader = "\<space>"

if has("gui_running")
  let g:spacevim_guifont = 'Input\ Mono\ Narrow\ Semi-Condensed\ 11'
end

" Set Atom colorscheme
let g:spacevim_colorscheme = 'onedark'

 " Disable vimfile in welcome window
let g:spacevim_enable_vimfiler_welcome = 0

" Disable plugins
"let g:spacevim_disabled_plugins = ['vim-foo', 'vim-bar']

