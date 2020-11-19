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
" Plug 'justinmk/vim-sneak'

" Vim motions on speed! Untested
Plug 'easymotion/vim-easymotion'

"Improved incremental searching for Vim
Plug 'haya14busa/incsearch.vim'
Plug 'haya14busa/incsearch-easymotion.vim'

" Allows alignment of several lines around vim text objs
" Plug 'junegunn/vim-easy-align'

" Adds file type icons to Vim plugins such as: NERDTree, vim-airline, CtrlP,
" unite, Denite, lightline, vim-startify and many more
Plug 'ryanoasis/vim-devicons'

" Modern performant generic finder and dispatcher for Vim and NeoVim
Plug 'liuchengxu/vim-clap', { 'do': ':Clap install-binary' }

" Fuzzy searching of files using FZF
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'yuki-ycino/fzf-preview.vim'

" Plugin for vim to enabling opening a file in a given line
Plug 'bogado/file-line'

" An ack.vim alternative mimics Ctrl-Shift-F on Sublime Text 2
Plug 'dyng/ctrlsf.vim'

" Smooth scroll
Plug 'yuttie/comfortable-motion.vim'

" substitute preview
Plug 'osyo-manga/vim-over'

" Intelligently reopen files at your last edit position in Vim
Plug 'farmergreg/vim-lastplace'

" unimpaired.vim: Pairs of handy bracket mappings
Plug 'tpope/vim-unimpaired'

"
"========= Text manipulation =========
"
" Needed by vim-expand-region
Plug 'kana/vim-textobj-user'
Plug 'kana/vim-textobj-indent'
Plug 'kana/vim-textobj-line'
" Plug 'kana/vim-textobj-entire'
" Plug 'kana/vim-textobj-syntax'
" Plug 'kana/vim-textobj-datetime'
" Plug 'kana/vim-operator-replace'
" Plug 'kana/vim-operator-user'
"
" Plug 'thinca/vim-textobj-comment'
" Plug 'thinca/vim-textobj-between'
" Plug 'rhysd/vim-textobj-anyblock'

" Expand selection
Plug 'terryma/vim-expand-region'
xmap v <Plug>(expand_region_expand)
xmap V <Plug>(expand_region_shrink)
let g:expand_region_text_objects = {
    \ 'iw'  :0,
    \ 'iW'  :0,
    \ 'i"'  :0,
    \ 'i''' :0,
    \ 'i]'  :1,
    \ 'ib'  :1,
    \ 'iB'  :1,
    \ 'il'  :1,
    \ 'ii'  :1,
    \ 'ip'  :0,
    \ 'ie'  :0,
    \ }

" Vim plugin, insert or delete brackets, parens, quotes in pair
Plug 'jiangmiao/auto-pairs'

" Quoting/parenthesizing made simple
" Plug 'tpope/vim-surround'
Plug 'machakann/vim-sandwich'

" Enable repeating supported plugin maps with "."
Plug 'tpope/vim-repeat'

" Vim comment plugin: supported operator/non-operator mappings, repeatable by
" dot-command, 300+ filetypes. Errors with git rebase
" Plug 'tyru/caw.vim'

" Vim plugin for intensely nerdy commenting powers
Plug 'preservim/nerdcommenter' , { 'on' : '<Plug>NERDCommenterToggle' }

" Find And Replace plugin options
" Plug 'brooth/far.vim'

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
endif
let g:deoplete#enable_at_startup = 1

Plug 'tbodt/deoplete-tabnine', { 'do': './install.sh' }

" Check syntax in Vim asynchronously and fix files, with Language Server
" Protocol (LSP) support
let g:ale_completion_enabled = 0
Plug 'dense-analysis/ale'
Plug 'maximbaz/lightline-ale'

" Tame the quickfix window
" Plug 'romainl/vim-qf'

" LSP language server
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
" [x and ]x mappings are defined as default
Plug 'rhysd/conflict-marker.vim'

" Generate table of contents for Markdown files
Plug 'mzlogin/vim-markdown-toc'

" A lightweight Vim/Neovim plugin to display buffers and tabs in the tabline
Plug 'pacha/vem-tabline'

" Builtin terminal in the floating/popup window
Plug 'voldikss/vim-floaterm'
let g:floaterm_keymap_toggle = '<F11>'
let g:floaterm_width = 0.9
let g:floaterm_height = 0.9

Plug 'tpope/vim-endwise'

" A powerful grammar checker for Vim using LanguageTool
" Plug 'rhysd/vim-grammarous'
" let g:grammarous#use_location_list = 1
" let g:grammarous#show_first_error = 1
" map <space>rr <Plug>(grammarous-open-info-window)

" Plug 'Yggdroot/LeaderF', { 'do': './install.sh' }
" let g:Lf_ShortcutF = '<c-p>'
" noremap <Leader>lm :LeaderfMru<cr>
" noremap <Leader>lf :LeaderfFunctionAll!<cr>
" noremap <Leader>ll :LeaderfLineAll<cr>
"
" let g:Lf_StlSeparator = { 'left': '', 'right': '', 'font': '' }
"
" let g:Lf_RootMarkers = ['.project', '.root', '.svn', '.git']
" let g:Lf_WorkingDirectoryMode = 'Ac'
" let g:Lf_WindowHeight = 0.30
" let g:Lf_CacheDirectory = expand('~/.vim/cache')
" let g:Lf_HideHelp = 1
" let g:Lf_StlColorscheme = 'powerline'
" let g:Lf_PreviewResult = {'Function':0, 'BufTag':0}
" let g:Lf_WindowPosition = 'popup'
" let g:Lf_PreviewInPopup = 1

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

" Visual shifting (does not exit Visual mode)
vnoremap < <gv
vnoremap > >gv|

" Allow using the repeat operator with a visual selection (!)
" http://stackoverflow.com/a/8064607/127816
" in Visual mode, hitting . applies the same action to all lines
vnoremap . :normal .<CR>

" Move between vim panes with Ctrl-J
nnoremap <C-J> <C-W>j
nnoremap <C-K> <C-W>k
nnoremap <C-L> <C-W>l
nnoremap <C-H> <C-W>h

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

nnoremap <leader><leader> :Clap<CR>
nnoremap <leader>b :Clap buffers<CR>

nmap <leader>c <Plug>NERDCommenterToggle
vmap <leader>c <Plug>NERDCommenterToggle

" C-r: Easier search and replace
nnoremap <leader>r :<C-u>call <SID>VSetSearch()<CR>:,$s/<C-R>=@/<CR>//gc<left><left><left>
function! s:VSetSearch() abort
    let temp = @s
    norm! gv"sy
    let @/ = '\V' . substitute(escape(@s, '/\'), '\n', '\\n', 'g')
    let @s = temp
endfunction

" remove search highlighting
nnoremap <silent><C-L> :noh<CR>

noremap <leader>q :bdelete<cr>

" Search in files with ripgrep
nmap <leader>g <Plug>CtrlSFPrompt
vmap <leader>gw <Plug>CtrlSFVwordPath

map <leader>W :w suda://%

" You can use other keymappings like <C-l> instead of <CR> if you want to
" use these mappings as default search and sometimes want to move cursor with
" EasyMotion.
function! s:incsearch_config(...) abort
  return incsearch#util#deepextend(deepcopy({
  \   'modules': [incsearch#config#easymotion#module({'overwin': 1})],
  \   'keymap': {
  \     "\<CR>": '<Over>(easymotion)'
  \   },
  \   'is_expr': 0
  \ }), get(a:, 1, {}))
endfunction

noremap <silent><expr> /  incsearch#go(<SID>incsearch_config())

" Jump to anywhere you want with minimal keystrokes, with just two keys
" binding
map <leader>f <Plug>(easymotion-overwin-f2)

" Disable default mappings
let g:EasyMotion_do_mapping = 0

" Turn on case-insensitive feature
let g:EasyMotion_smartcase = 1

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

let g:NERDCreateDefaultMappings = 0

" Use compact syntax for prettified multi-line comments
let g:NERDCompactSexyComs = 1

" Align line-wise comment delimiters flush left instead of following code
" indentation
let g:NERDDefaultAlign = 'left'

" Enable trimming of trailing whitespace when uncommenting
let g:NERDTrimTrailingWhitespace = 1

" Allow commenting and inverting empty lines (useful when commenting a region)
let g:NERDCommentEmptyLines = 1

" Enable NERDCommenterToggle to check all selected lines is commented or not
let g:NERDToggleCheckAllLines = 1

let g:lastplace_ignore = "gitcommit,gitrebase,svn,hgcommit"
let g:lastplace_ignore_buftype = "quickfix"

let g:comfortable_motion_scroll_down_key = "j"
let g:comfortable_motion_scroll_up_key = "k"

let g:comfortable_motion_friction = 80.0
let g:comfortable_motion_air_drag = 2.0

"
" Ale settings
"
let g:ale_fixers = {
  \ '*': ['remove_trailing_lines', 'trim_whitespace'],
  \ 'sh': ['shfmt'],
  \ 'gitcommit': [],
  \ 'diff': [],
  \ 'gitsendemail': [],
  \ }

let g:ale_linters = {
  \ 'sh': ['shellcheck'],
  \ 'gitcommit': ['proselint', 'write-good', 'gitlint'],
  \ }

let g:ale_sign_error = "\uf05e"
let g:ale_sign_warning = "\uf071"
let g:ale_fix_on_save = 1
let g:ale_sign_info = '➟'
let g:ale_sign_column_always = 1
let g:ale_warn_about_trailing_blank_lines = 1
let g:ale_warn_about_trailing_whitespace = 1

" language server
" ----------
" LanguageClient-neovim
let g:LanguageClient_serverCommands = {
  \ 'sh': ['bash-language-server', 'start']
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

let g:clap_theme = 'material_design_dark'
