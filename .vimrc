let g:vimrc_author='Javier Tia'
let g:vimrc_email='javier.tia@hpe.com'

call plug#begin('~/.vim/plugged')

" Sensible vim defaults
Plug 'tpope/vim-sensible'

"
"========= UI =========
"
Plug 'joshdick/onedark.vim'

Plug 'itchyny/lightline.vim'
Plug 'taohexxx/lightline-buffer'

" Shows indent guides
Plug 'Yggdroot/indentLine'

Plug 'junegunn/rainbow_parentheses.vim'

Plug 'machakann/vim-highlightedyank'

" Motion plugin - jump to a location based on two characters
Plug 'justinmk/vim-sneak'
Plug 'easymotion/vim-easymotion'

" Allows alignment of several lines around vim text objs
Plug 'junegunn/vim-easy-align'

Plug 'nathanaelkane/vim-indent-guides'

Plug 'ryanoasis/vim-devicons'

Plug 'zefei/vim-wintabs'

Plug 'mhinz/vim-startify'

"Fuzzy searching of files using FZF
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'yuki-ycino/fzf-preview.vim'

Plug 'bogado/file-line'
Plug 't9md/vim-choosewin'

Plug 'dyng/ctrlsf.vim'
Plug 'kamykn/spelunker.vim'

" Smooth scroll
Plug 'yuttie/comfortable-motion.vim'
" Plug 'vim-ctrlspace/vim-ctrlspace'

Plug 'tmhedberg/matchit'
Plug 'haya14busa/incsearch.vim'
Plug 'osyo-manga/vim-over'
Plug 'farmergreg/vim-lastplace'

"
"========= Text manipulation =========
"
Plug 'kana/vim-textobj-user'
Plug 'kana/vim-textobj-indent'
Plug 'kana/vim-textobj-entire'
Plug 'kana/vim-textobj-syntax'
Plug 'kana/vim-textobj-datetime'
Plug 'kana/vim-textobj-indent'
Plug 'kana/vim-operator-user'
Plug 'kana/vim-operator-replace'

Plug 'thinca/vim-textobj-comment'
Plug 'thinca/vim-textobj-between'

Plug 'rhysd/vim-textobj-anyblock'

Plug 'kana/vim-smartinput'

Plug 'tpope/vim-surround'

Plug 'tpope/vim-repeat'
Plug 'scrooloose/nerdcommenter'

Plug 'brooth/far.vim'

" Allows sorting via `gs` motion
Plug 'christoomey/vim-sort-motion'

Plug 'terryma/vim-multiple-cursors'

Plug 'tmux-plugins/vim-tmux-focus-events'

"========= Languages =========

"Asychronous Lint Engine, on the fly linting of files
if has('nvim')
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
else
  Plug 'Shougo/deoplete.nvim'
  Plug 'roxma/nvim-yarp'
  Plug 'roxma/vim-hug-neovim-rpc'
endif
let g:deoplete#enable_at_startup = 1

Plug 'dense-analysis/ale'
Plug 'maximbaz/lightline-ale'

Plug 'romainl/vim-qf'

" language server
Plug 'autozimu/LanguageClient-neovim', {
    \ 'branch': 'next',
    \ 'do': 'bash install.sh',
    \ }

Plug 'WolfgangMehner/bash-support'

"Formats a file using formatter defined for its filetype
Plug 'sbdchd/neoformat'

" Better diffing
Plug 'chrisbra/vim-diff-enhanced'

Plug 'tpope/vim-eunuch'

" Better paste
Plug 'ConradIrwin/vim-bracketed-paste'

Plug 'kergoth/vim-bitbake'

" Conflict with many plugins
"Plug 'sheerun/vim-polyglot'
Plug 'avakhov/vim-yaml'
Plug 'ekalinin/Dockerfile.vim'
Plug 'luochen1990/rainbow'
let g:rainbow_active = 1 "set to 0 if you want to enable it later via :RainbowToggle

"========= SCM/Git =========
Plug 'tpope/vim-fugitive'
Plug 'mhinz/vim-signify'
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

set statusline+=%{fugitive#statusline()} " Git Hotness

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

" For when you forget to sudo. Really Write the file
cmap w!! w !sudo tee % >/dev/null

nmap <leader>c <Plug>NERDCommenterToggle

"move between vim panes with Ctrl-J
nnoremap <C-J> <C-W>j
nnoremap <C-K> <C-W>k
nnoremap <C-L> <C-W>l
nnoremap <C-H> <C-W>h

xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)

nmap - <Plug>(choosewin)

map <C-H> <Plug>(wintabs_previous)
map <C-L> <Plug>(wintabs_next)

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

nmap <leader>c <Plug>NERDCommenterToggle

" C-r: Easier search and replace
nnoremap <leader>r :<C-u>call <SID>VSetSearch()<CR>:,$s/<C-R>=@/<CR>//gc<left><left><left>
function! s:VSetSearch() abort
    let temp = @s
    norm! gv"sy
    let @/ = '\V' . substitute(escape(@s, '/\'), '\n', '\\n', 'g')
    let @s = temp
endfunction

" Find merge conflict markers
noremap <SID>FindMergeConflictMarker /\v^[<\|=>]{7}( .*\|$)<CR>
map <leader>fx <SID>FindMergeConflictMarker

" Search in files with ripgrep
nmap     <leader>sf <Plug>CtrlSFPrompt
vmap     <leader>sf <Plug>CtrlSFVwordPath
vmap     <leader>sF <Plug>CtrlSFVwordExec
nmap     <leader>sn <Plug>CtrlSFCwordPath
nmap     <leader>sp <Plug>CtrlSFPwordPath
nnoremap <leader>so :CtrlSFOpen<CR>
nnoremap <leader>st :CtrlSFToggle<CR>

" Search filenames with FZF
noremap <leader>f :Files<cr>

map f <Plug>Sneak_f
map F <Plug>Sneak_F
map t <Plug>Sneak_t
map T <Plug>Sneak_T
nnoremap <leader>w <Plug>(easymotion-prefix)s

" Search marks
noremap <leader>m :Marks<cr>

" Yank & put from clipboard register
noremap <leader>y "+y
noremap <leader>p "+p

" Splits vertical & horizontal
noremap <leader>= :vsp<cr><C-W>l<cr>
noremap <leader>- :sp<cr><C-W>j<cr>

" write & quit
noremap <leader>Q :q!<cr>
noremap <leader>q :q<cr>
noremap <leader>x :x<cr>
noremap <leader>z :xall<cr>

" remove search highlighting
nnoremap <leader><space> :noh<cr>

" Reload vimr configuration file
nnoremap <leader>vr :source $MYVIMRC<cr>

nnoremap <silent> <leader>gs :Gstatus<CR>
nnoremap <silent> <leader>gd :Gdiff<CR>
nnoremap <silent> <leader>gc :Gcommit<CR>
nnoremap <silent> <leader>gia :Git add -p %<CR>
nnoremap <silent> <leader>gfm :Gpull<CR>

map <leader>tc <Plug>(wintabs_close)
map <leader>tu <Plug>(wintabs_undo)
map <leader>wc <Plug>(wintabs_close_window)
command! Tabc WintabsCloseVimtab
command! Tabo WintabsOnlyVimtab

"
" ================================= Searching =================================
"
let g:fzf_preview_gitfiles_command = "git status --short --untracked-files=all | awk '{if (substr($0,2,1) !~ / /) print $2}'"
let g:fzf_layout = { 'down': '~40%' }

autocmd! User FzfStatusLine call lightline#update_once()

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

" Add spaces after comment delimiters by default
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

if has('clipboard')
  if has('unnamedplus')  " When possible use + register for copy-paste
    set clipboard=unnamed,unnamedplus
  endif
endif

" Instead of reverting the cursor to the last position in the buffer, we
" set it to the first line when editing a git commit message
au FileType gitcommit au! BufEnter COMMIT_EDITMSG call setpos('.', [0, 1, 1, 0])

let g:lightline = {
\ 'colorscheme': 'onedark',
\ 'active': {
\   'left': [
\              ['mode', 'paste'],
\              ['fugitive', 'readonly', 'filename', 'modified'],
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
\   'fugitive':   'LightlineFugitive',
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

" fugitive
function! LightlineFugitive()
  if exists('*fugitive#head')
    let l:branch = fugitive#head()
    return l:branch !=# '' ? "\ue0a0 ".l:branch : ''
  endif
  return ''
endfunction

" vim-indent-guides
let g:indent_guides_start_level = 2
" It has an effect over fillchars due to Yggdroot/indentLine plugin
let g:indentLine_char = '│'

" Enable spelunker.vim. (default: 1)
" 1: enable
" 0: disable
let g:enable_spelunker_vim = 1

" Enable spelunker.vim on readonly files or buffer. (default: 0)
" 1: enable
" 0: disable
let g:enable_spelunker_vim_on_readonly = 0

" Check spelling for words longer than set characters. (default: 4)
let g:spelunker_target_min_char_len = 4

" Max amount of word suggestions. (default: 15)
let g:spelunker_max_suggest_words = 15

" Max amount of highlighted words in buffer. (default: 100)
let g:spelunker_max_hi_words_each_buf = 100

" Spellcheck type: (default: 1)
" 1: File is checked for spelling mistakes when opening and saving. This
" may take a bit of time on large files.
" 2: Spellcheck displayed words in buffer. Fast and dynamic. The waiting time
" depends on the setting of CursorHold `set updatetime=1000`.
let g:spelunker_check_type = 1

" Highlight type: (default: 1)
" 1: Highlight all types (SpellBad, SpellCap, SpellRare, SpellLocal).
" 2: Highlight only SpellBad.
" FYI: https://vim-jp.org/vimdoc-en/spell.html#spell-quickstart
let g:spelunker_highlight_type = 1

" Disable default autogroup. (default: 0)
let g:spelunker_disable_auto_group = 1

" Create own custom autogroup to enable spelunker.vim for specific filetypes.
augroup spelunker
  autocmd!
  " Setting for g:spelunker_check_type = 1:
  autocmd FileType gitcommit call spelunker#check()
augroup END

" Override highlight group name of complex or compound words. (default:
" 'SpelunkerComplexOrCompoundWord')
let g:spelunker_complex_or_compound_word_group = 'SpelunkerComplexOrCompoundWord'

nmap <leader>ew <Plug>(spelunker-correct-from-list)

" Far options
set lazyredraw
set regexpengine=1
