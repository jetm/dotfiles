let g:vimrc_author='Javier Tia'
let g:vimrc_email='javier.tia@hpe.com'

call plug#begin('~/.vim/plugged')

" Sensible vim defaults
Plug 'tpope/vim-sensible'

" An alternative sudo.vim
Plug 'lambdalisue/suda.vim'
let g:suda_smart_edit = 1

"
"========= UI =========
"
Plug 'joshdick/onedark.vim'

" Status UI
Plug 'itchyny/lightline.vim'
Plug 'taohexxx/lightline-buffer'

" Shows indent guides with columns
Plug 'Yggdroot/indentLine'

" A Vim plugin for visually displaying indent levels in code
Plug 'nathanaelkane/vim-indent-guides'

" Simpler Rainbow Parentheses
Plug 'junegunn/rainbow_parentheses.vim'

" Make the yanked region apparent!
Plug 'machakann/vim-highlightedyank'

" Sneak is invoked with s followed by exactly two characters
Plug 'justinmk/vim-sneak'

" Plug 'mhinz/vim-startify'
" Plug 't9md/vim-choosewin'

" Vim motions on speed! Untested
" Plug 'easymotion/vim-easymotion'

" Allows alignment of several lines around vim text objs
" Plug 'junegunn/vim-easy-align'

" Vim Space Controller
" Plug 'vim-ctrlspace/vim-ctrlspace'

" Adds file type icons to Vim plugins such as: NERDTree, vim-airline, CtrlP,
" unite, Denite, lightline, vim-startify and many more
Plug 'ryanoasis/vim-devicons'

" Plug 'jlanzarotta/bufexplorer'
" Modern performant generic finder and dispatcher for Vim and NeoVim
Plug 'liuchengxu/vim-clap', { 'do': ':Clap install-binary' }

" Fuzzy searching of files using FZF
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'yuki-ycino/fzf-preview.vim'

" Plugin for vim to enabling opening a file in a given line
Plug 'bogado/file-line'

" An ack.vim alternative mimics Ctrl-Shift-F on Sublime Text 2
Plug 'dyng/ctrlsf.vim'

" Improved vim spelling plugin
" Plug 'kamykn/spelunker.vim'

" Popup-menu for spelunker
" Plug 'kamykn/popup-menu.nvim'

" Smooth scroll
Plug 'yuttie/comfortable-motion.vim'

"Improved incremental searching for Vim
Plug 'haya14busa/incsearch.vim'

" substitute preview
Plug 'osyo-manga/vim-over'

" Intelligently reopen files at your last edit position in Vim
Plug 'farmergreg/vim-lastplace'

" vinegar.vim: Combine with netrw to create a delicious salad dressing
" Plug 'tpope/vim-vinegar'

" unimpaired.vim: Pairs of handy bracket mappings
Plug 'tpope/vim-unimpaired'

"
"========= Text manipulation =========
"
" Plug 'kana/vim-textobj-user'
" Plug 'kana/vim-textobj-indent'
" Plug 'kana/vim-textobj-entire'
" Plug 'kana/vim-textobj-syntax'
" Plug 'kana/vim-textobj-datetime'
" Plug 'kana/vim-textobj-indent'
" Plug 'kana/vim-operator-replace'
" Plug 'kana/vim-operator-user'
"
" Plug 'thinca/vim-textobj-comment'
" Plug 'thinca/vim-textobj-between'
"
" Plug 'rhysd/vim-textobj-anyblock'

" Vim plugin, insert or delete brackets, parens, quotes in pair
Plug 'jiangmiao/auto-pairs'

" Quoting/parenthesizing made simple
Plug 'tpope/vim-surround'

" Enable repeating supported plugin maps with "."
Plug 'tpope/vim-repeat'

" Vim comment plugin: supported operator/non-operator mappings, repeatable by
" dot-command, 300+ filetypes. Errors with git rebase
" Plug 'tyru/caw.vim'

" Vim plugin for intensely nerdy commenting powers
Plug 'preservim/nerdcommenter' , { 'on' : '<Plug>NERDCommenterToggle' }

" Find And Replace plugin options
Plug 'brooth/far.vim'

" Vim mapping for sorting a range of text
" Allows sorting via `gs` motion
" Plug 'christoomey/vim-sort-motion'

" Multiple cursors plugin for vim/neovim
Plug 'mg979/vim-visual-multi', {'branch': 'master'}

" Make terminal vim and tmux work better together
Plug 'tmux-plugins/vim-tmux-focus-events'

" Seamless integration for vim and tmux's clipboard
Plug 'roxma/vim-tmux-clipboard'

"========= Languages =========

" Asychronous Lint Engine, on the fly linting of files
if has('nvim')
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
else
  Plug 'Shougo/deoplete.nvim'
  Plug 'roxma/nvim-yarp'
  Plug 'roxma/vim-hug-neovim-rpc'
endif
let g:deoplete#enable_at_startup = 1

" Check syntax in Vim asynchronously and fix files, with Language Server
" Protocol (LSP) support
Plug 'dense-analysis/ale'
Plug 'maximbaz/lightline-ale'

" Tame the quickfix window
" Plug 'romainl/vim-qf'

" language server
Plug 'autozimu/LanguageClient-neovim', {
    \ 'branch': 'next',
    \ 'do': 'bash install.sh',
    \ }

Plug 'WolfgangMehner/bash-support'

" Formats a file using formatter defined for its filetype
Plug 'sbdchd/neoformat'

" Better Diff options for Vim
Plug 'chrisbra/vim-diff-enhanced'

" Helpers for UNIX
" :SudoWrite: Write a privileged file with sudo.
" :SudoEdit: Edit a privileged file with sudo.
" New files created with a shebang line are automatically made executable
Plug 'tpope/vim-eunuch'

" Handles bracketed-paste-mode in vim (aka. automatic `:set paste`)
Plug 'ConradIrwin/vim-bracketed-paste'

" Add support to bitbake
Plug 'kergoth/vim-bitbake'

" YAML support
Plug 'avakhov/vim-yaml'

" Dockerfile support
Plug 'ekalinin/Dockerfile.vim'

" Rainbow Parentheses Improved, shorter code, no level limit, smooth and fast,
" powerful configuration
Plug 'luochen1990/rainbow'
let g:rainbow_active = 1 "set to 0 if you want to enable it later via :RainbowToggle

" Weapon to fight against conflicts in Vim
Plug 'rhysd/conflict-marker.vim'

call plug#end()

"
"========================== Colours & UI settings ============================
"
scriptencoding utf-8

" shell
if has('filterpipe')
  set noshelltemp
endif
if !has('nvim') && has('patch-7.4.1770')
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
endif
if exists('+termguicolors')
  set termguicolors
elseif exists('+guicolors')
  set guicolors
endif

set background=dark
colorscheme onedark

"
"========================== Buffers & Files ============================
"
" indent
set autoindent
set smartindent
set cindent

" show wildmenu
set wildmenu

" do not break words
set linebreak

" Automatically read a file changed outside of vim
set autoread

set hidden

set incsearch
set hlsearch
set wildignorecase

set mouse=a

set matchtime=0
set ruler
set showmatch
set showmode

" Do not wrap lone lines
set nowrap

set tabstop=4     " default to tabs = 4 spaces (normally overridden by FileType settings)
set shiftwidth=4  " when shifting with <</>>, by default shift by this amount
set softtabstop=4 " control columns used when TAB is hit in insert mode
set expandtab     " Convert tabs to spaces

" When searching, ignore case if the search string is all lowercase, but make it
set smartcase
set ignorecase "case sensitive if there is an uppercase character

" Set "hybrid" line number mode - display the current line number, but relative
" line numbers for all other lines
:set relativenumber
:set number

" Highlight current line
:set cursorline

" Display whitespace characters
set list
set listchars=tab:→\ ,extends:↷,precedes:↶,nbsp:␣,trail:· " eol:↲,
set fillchars=vert:│,fold:·
set showbreak=↪\

" Prevents inserting two spaces after punctuation on a join (J)
set nojoinspaces


" Backup
set backup
set undofile
set undolevels=1000
set undodir=$HOME/.vim_data/undofile
set backupdir=$HOME/.vim_data/backup
set nowritebackup
let g:data_dir = $HOME . '/.vim_data/'
let g:backup_dir = g:data_dir . 'backup'
let g:swap_dir = g:data_dir . 'swap'
let g:undo_dir = g:data_dir . 'undofile'
let g:conf_dir = g:data_dir . 'conf'
if finddir(g:data_dir) ==# ''
    silent call mkdir(g:data_dir, 'p', 0700)
endif
if finddir(g:backup_dir) ==# ''
    silent call mkdir(g:backup_dir, 'p', 0700)
endif
if finddir(g:swap_dir) ==# ''
    silent call mkdir(g:swap_dir, 'p', 0700)
endif
if finddir(g:undo_dir) ==# ''
    silent call mkdir(g:undo_dir, 'p', 0700)
endif
if finddir(g:conf_dir) ==# ''
    silent call mkdir(g:conf_dir, 'p', 0700)
endif
unlet g:data_dir
unlet g:backup_dir
unlet g:swap_dir
unlet g:undo_dir
unlet g:conf_dir

"
"========================== Key mapping ============================
"

" Hit jj in insert mode to trigger ESC
inoremap jj <ESC>

" Wrapped lines goes down/up to next row, rather than next line in file.
noremap j gj
noremap k gk

" Remove keybinding for Ex Mode
nnoremap Q <nop>

" Yank from the cursor to the end of the line, to be consistent with C and D.
nnoremap Y y$

" Helper for saving file
noremap <C-S> :update<CR>
vnoremap <C-S> <C-C>:update<CR>
inoremap <C-S> <C-O>:update<CR>

" Stop being so lazy - remove arrow key config
noremap <Up>     <nop>
noremap <Down>   <nop>
noremap <Left>   <nop>
noremap <Right>  <nop>

inoremap <Up>    <nop>
inoremap <Down>  <nop>
inoremap <Left>  <nop>
inoremap <Right> <nop>

" Start new line
inoremap <S-Return> <C-o>o

" in Visual mode, hitting . applies the same action to all lines
vnoremap . :norm.<CR>

" Make TAB work in normal & visual modes
nnoremap <tab> %
vnoremap <tab> %

" Visual shifting (does not exit Visual mode)
vnoremap < <gv
vnoremap > >gv|

" Use tab for indenting in visual mode
xnoremap <Tab> >gv|
xnoremap <S-Tab> <gv
nnoremap > >>_
nnoremap < <<_

" Allow using the repeat operator with a visual selection (!)
" http://stackoverflow.com/a/8064607/127816
vnoremap . :normal .<CR>

"move between vim panes with Ctrl-J
nnoremap <C-J> <C-W>j
nnoremap <C-K> <C-W>k
nnoremap <C-L> <C-W>l
nnoremap <C-H> <C-W>h

" xmap ga <Plug>(EasyAlign)
" nmap ga <Plug>(EasyAlign)

" nmap - <Plug>(choosewin)

" Tab for next completion
inoremap <silent><expr> <Tab>
      \ pumvisible() ? "\<C-n>" : "\<TAB>"
" S-Tab for previous
inoremap <silent><expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-TAB>"
inoremap <silent><expr> <cr> pumvisible() ? "\<C-y>" : "\<cr>"

" CtrlP compatibility
nnoremap <C-p> :Files<cr>

"
" Leader key shortcuts
"

" leader key
let mapleader = "\<Space>"

let g:clap_theme = 'material_design_dark'
nnoremap <leader><Space> :Clap<CR>
nnoremap <leader>b :Clap buffers<CR>
" nnoremap <leader>B :Clap blines<CR>
" nnoremap <leader>f :Clap files<CR>
" nnoremap <leader>g :Clap git_files<CR>
" nnoremap <leader>l :Clap lines<CR>

" caw settings
" let g:caw_no_default_keymappings = 1
" nmap <leader>c <Plug>(caw:hatpos:toggle)
" vmap <leader>c <Plug>(caw:hatpos:toggle)

let g:NERDCreateDefaultMappings = 0

" Add spaces after comment delimiters by default
let g:NERDSpaceDelims = 1

" Use compact syntax for prettified multi-line comments
let g:NERDCompactSexyComs = 1

" Allow commenting and inverting empty lines (useful when commenting a region)
let g:NERDCommentEmptyLines = 1

" Enable trimming of trailing whitespace when uncommenting
let g:NERDTrimTrailingWhitespace = 1

" Enable NERDCommenterToggle to check all selected lines is commented or not
let g:NERDToggleCheckAllLines = 1

nmap <leader>c <Plug>NERDCommenterToggle
vmap <leader>c <Plug>NERDCommenterToggle

" Search filenames with FZF
noremap <leader>f :Files<cr>

" C-r: Easier search and replace
nnoremap <leader>r :<C-u>call <SID>VSetSearch()<CR>:,$s/<C-R>=@/<CR>//gc<left><left><left>
function! s:VSetSearch() abort
    let temp = @s
    norm! gv"sy
    let @/ = '\V' . substitute(escape(@s, '/\'), '\n', '\\n', 'g')
    let @s = temp
endfunction

map f <Plug>Sneak_f
map F <Plug>Sneak_F
map t <Plug>Sneak_t
map T <Plug>Sneak_T
nnoremap <leader>w <Plug>(easymotion-prefix)s

" Search marks
" noremap <leader>m :Marks<cr>

" Yank & put from clipboard register
noremap <leader>y "+y
noremap <leader>p "+p

" Splits vertical & horizontal
noremap <leader>= :vsp<cr><C-W>l<cr>
noremap <leader>- :sp<cr><C-W>j<cr>

" write & quit
noremap <leader>Q :q!<cr>
" noremap <leader>q :q<cr>
" noremap <leader>x :x<cr>
" noremap <leader>z :xall<cr>

" remove search highlighting
nnoremap <leader><space>n :noh<cr>

" Reload vimrc configuration file
" nnoremap <leader>vr :source $MYVIMRC<cr>

noremap <leader>q :bdelete<cr>

" nnoremap <silent> <leader>gs :Gstatus<CR>
" nnoremap <silent> <leader>gd :Gdiff<CR>
" nnoremap <silent> <leader>gc :Gcommit<CR>
" nnoremap <silent> <leader>gia :Git add -p %<CR>
" nnoremap <silent> <leader>gfm :Gpull<CR>

" map <leader>tc <Plug>(wintabs_close)
" map <leader>tu <Plug>(wintabs_undo)
" map <leader>wc <Plug>(wintabs_close_window)
" command! Tabc WintabsCloseVimtab
" command! Tabo WintabsOnlyVimtab

" Search in files with ripgrep
" nmap     <leader>sf <Plug>CtrlSFPrompt
vmap     <leader>sf <Plug>CtrlSFVwordPath
" vmap     <leader>sF <Plug>CtrlSFVwordExec
" nmap     <leader>sn <Plug>CtrlSFCwordPath
" nmap     <leader>sp <Plug>CtrlSFPwordPath
" nnoremap <leader>so :CtrlSFOpen<CR>
" nnoremap <leader>st :CtrlSFToggle<CR>

map <leader>W :w suda://%

"
" ================================= Searching =================================
"
let g:fzf_preview_gitfiles_command = "git status --short --untracked-files=all | awk '{if (substr($0,2,1) !~ / /) print $2}'"
let g:fzf_layout = { 'down': '~40%' }

autocmd! User FzfStatusLine call lightline#update()

" Command override (with preview)
command! -bang -nargs=? -complete=dir Files
            \ call fzf#vim#files(<q-args>, fzf#vim#with_preview(), <bang>0)

"
" =============================== Python files ===============================
"
au FileType python set autoindent
au FileType python set smartindent
au FileType python set tabstop=4 shiftwidth=4 expandtab
au FileType python set textwidth=79  " PEP-8

"
" =============================== YAML files ===============================
"
" two space tabs for YAML
au FileType yaml setlocal ts=2 sts=2 sw=2 expandtab

"
" =============================== Comments ===============================
"
" Add spaces after comment delimiters
let g:NERDSpaceDelims = 1

" Use compact syntax for prettified multi-line comments
let g:NERDCompactSexyComs = 1

" Align line-wise comment delimiters flush left instead of following code
" indentation
let g:NERDDefaultAlign = 'left'

" Allow commenting and inverting empty lines (useful when commenting a region)
let g:NERDCommentEmptyLines = 1

" Enable trimming of trailing whitespace when uncommenting
let g:NERDTrimTrailingWhitespace = 1

let g:comfortable_motion_scroll_down_key = "j"
let g:comfortable_motion_scroll_up_key = "k"

let g:lastplace_ignore = "gitcommit,gitrebase,svn,hgcommit"
let g:lastplace_ignore_buftype = "quickfix"

let g:sneak#label = 1

" if you want to use overlay feature
let g:choosewin_overlay_enable = 1

let g:comfortable_motion_friction = 80.0
let g:comfortable_motion_air_drag = 2.0

" Asynchronous Lint Engine
set completeopt-=preview
set omnifunc=ale#completion#OmniFunc

let g:ale_fixers = {
  \ '*': ['remove_trailing_lines', 'trim_whitespace'],
  \ 'sh': ['shfmt'],
  \ 'gitcommit': [],
  \ 'diff': [],
  \ 'gitsendemail': [],
  \ }

let g:ale_linters = {
  \ 'sh': ['shellcheck'],
  \ }

let g:ale_sign_error = "\uf05e"
let g:ale_sign_warning = "\uf071"
let g:ale_fix_on_save = 1
let g:ale_sign_info = '➟'
let g:ale_sign_column_always = 1
let g:ale_warn_about_trailing_blank_lines = 1
let g:ale_warn_about_trailing_whitespace = 1
let g:ale_close_preview_on_insert = 1
let g:ale_completion_max_suggestions = 10
let g:ale_completion_enabled = 0

" language server
" ----------
" LanguageClient-neovim
let g:LanguageClient_serverCommands = {
  \ 'sh': ['language_server'],
  \ }

let g:LanguageClient_diagnosticsDisplay = {
  \ 1: {
    \ 'name': 'Error',
    \ 'texthl': 'ALEError',
    \ 'signText':  "\uf05e",
    \ 'signTexthl': 'Error',
    \ },
  \ 2: {
    \ 'name': 'Warning',
    \ 'texthl': 'ALEWarning',
    \ 'signText':  "\uf071",
    \ 'signTexthl': 'ALEWarningSign',
    \ },
  \ 3: {
    \ 'name': 'Information',
    \ 'texthl': 'ALEInfo',
    \ 'signText': "\uf05a",
    \ 'signTexthl': 'ALEInfoSign',
    \ },
  \ 4: {
    \ 'name': 'Hint',
    \ 'texthl': 'ALEInfo',
    \ 'signText': "\uf05a",
    \ 'signTexthl': 'ALEInfoSign',
    \ },
  \ }

" Instead of reverting the cursor to the last position in the buffer, we
" set it to the first line when editing a git commit message
au FileType gitcommit au! BufEnter COMMIT_EDITMSG call setpos('.', [0, 1, 1, 0])

let g:lightline = {
\ 'colorscheme': 'onedark',
\ 'active': {
\   'left': [
\              ['mode', 'paste'],
\              ['readonly', 'filename', 'modified'],
\           ],
\   'right': [
\              ['linter_checking', 'linter_errors', 'linter_warnings', 'linter_ok'],
\              ['lineinfo'],
\              ['percent'],
\              ['fileformat', 'fileencoding', 'filetype', 'charvaluehex'],
\            ]
\ },
\ 'tabline': {
\   'left': [
\             ['bufferinfo'],
\             ['separator_tab'],
\             ['bufferbefore', 'buffercurrent', 'bufferafter']
\           ],
\   'right': [['close']],
\ },
\ 'component_expand': {
\   'buffercurrent': 'lightline#buffer#buffercurrent',
\   'bufferbefore': 'lightline#buffer#bufferbefore',
\   'bufferafter': 'lightline#buffer#bufferafter',
\   'linter_checking': 'lightline#ale#checking',
\   'linter_warnings': 'lightline#ale#warnings',
\   'linter_errors': 'lightline#ale#errors',
\   'linter_ok': 'lightline#ale#ok',
\ },
\ 'component_type': {
\   'buffercurrent': 'tabsel',
\   'bufferbefore': 'raw',
\   'bufferafter': 'raw',
\   'linter_checking': 'left',
\   'linter_warnings': 'warning',
\   'linter_errors': 'error',
\   'linter_ok': 'left',
\ },
\ 'component_function': {
\   'bufferinfo': 'lightline#buffer#bufferinfo',
\   'ale': 'LightlineALE',
\ },
\ 'component': {
\   'separator_tab': '',
\ },
\ 'separator': { 'left': "\ue0b0", 'right': "\ue0b2" },
\ 'subseparator': { 'left': "\ue0b1", 'right': "\ue0b3" }
\}

" lightline-buffer ui settings
" replace these symbols with ascii characters if your environment does not
" support unicode
" ---------------------------------------------------
let g:lightline_buffer_logo = "\ue62b "
let g:lightline_buffer_readonly_icon = "\ufafa"
let g:lightline_buffer_modified_icon = "\ufac1"
let g:lightline_buffer_git_icon = "\ue0a0 "
let g:lightline_buffer_ellipsis_icon = '..'
let g:lightline_buffer_expand_left_icon = '◀ '
let g:lightline_buffer_expand_right_icon = ' ▶'
let g:lightline_buffer_active_buffer_left_icon = ''
let g:lightline_buffer_active_buffer_right_icon = ''
let g:lightline_buffer_separator_icon = '  '

" lightline-buffer function settings
let g:lightline_buffer_show_bufnr = 1
let g:lightline_buffer_rotate = 0
let g:lightline_buffer_fname_mod = ':t'
let g:lightline_buffer_excludes = ['vimfiler']

let g:lightline_buffer_maxflen = 30
let g:lightline_buffer_maxfextlen = 3
let g:lightline_buffer_minflen = 16
let g:lightline_buffer_minfextlen = 3
let g:lightline_buffer_reservelen = 20

" lightline-ale
let g:lightline#ale#indicator_checking = " \uf110 "
let g:lightline#ale#indicator_warnings = "\uf071 "
let g:lightline#ale#indicator_errors = "\uf05e "
let g:lightline#ale#indicator_ok = "\uf00c "

" vim-indent-guides
let g:indent_guides_start_level = 2
" It has an effect over fillchars due to Yggdroot/indentLine plugin
let g:indentLine_char = '│'

" Find And Replace plugin options
set lazyredraw
set regexpengine=1

let g:clap_provider_dotfiles = {
      \ 'source': [
      \    '~/.vimrc',
      \    '~/.zsh/01-jetm-zpreztorc.zsh',
      \    '~/.zsh/02-jetm-prezto.zsh',
      \    '~/.zsh/03-vm-settings.zsh',
      \    '~/.zsh/04-hstr.zsh',
      \    '~/.zshrc',
      \    '~/.tmux.conf',
      \ ],
      \ 'sink': 'e',
      \ }
