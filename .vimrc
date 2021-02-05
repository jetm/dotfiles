if !has('nvim')
  " Stop sourcing here if regular vim is sourcing this file
  finish
endif

let g:vimrc_author='Javier Tia'
let g:vimrc_email='javier.tia@hpe.com'

call plug#begin('~/.vim/plugged')

" Defaults everyone can agree on
Plug 'tpope/vim-sensible'

" An alternative sudo.vim
Plug 'lambdalisue/suda.vim'

"
" UI
"
Plug 'joshdick/onedark.vim'

" vim statusline like spacemacs, lightline replacement
Plug 'glepnir/spaceline.vim'

" Shows indent guides with columns
Plug 'Yggdroot/indentLine'

" Indent guides on blank lines for Neovim
Plug 'lukas-reineke/indent-blankline.nvim'

" A Vim plugin for visually displaying indent levels in code
Plug 'nathanaelkane/vim-indent-guides'

" Simpler Rainbow Parentheses
Plug 'junegunn/rainbow_parentheses.vim'

" Make the yanked region apparent!
Plug 'machakann/vim-highlightedyank'

" Vim motions on speed! Untested
Plug 'easymotion/vim-easymotion'

" Lightning fast left-right movement in Vim
Plug 'unblevable/quick-scope'

"Improved incremental searching for Vim
Plug 'haya14busa/incsearch.vim'
Plug 'haya14busa/incsearch-easymotion.vim'

" Adds file type icons to Vim plugins such as: NERDTree, vim-airline, CtrlP,
" unite, Denite, lightline, vim-startify and many more Lua `fork` of
" vim-devicons for neovim
Plug 'kyazdani42/nvim-web-devicons'

" Modern performant generic finder and dispatcher for Vim and NeoVim
Plug 'liuchengxu/vim-clap', { 'do': ':Clap install-binary' }
Plug 'Yggdroot/LeaderF', { 'do': ':LeaderfInstallCExtension' }

" Fuzzy searching of files using FZF
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'

" Plugin for vim to enabling opening a file in a given line
Plug 'bogado/file-line'

" substitute preview
Plug 'osyo-manga/vim-over'

" Intelligently reopen files at your last edit position in Vim
Plug 'farmergreg/vim-lastplace'

" unimpaired.vim: Pairs of handy bracket mappings
Plug 'tpope/vim-unimpaired'

" Weapon to fight against conflicts in Vim
" [x and ]x mappings are defined as default
Plug 'rhysd/conflict-marker.vim'

"
" Text manipulation
"
" Needed by vim-expand-region
Plug 'kana/vim-textobj-user'
Plug 'kana/vim-textobj-indent'
Plug 'kana/vim-textobj-line'

" Expand selection
Plug 'terryma/vim-expand-region'

" Vim plugin, insert or delete brackets, parens, quotes in pair
Plug 'jiangmiao/auto-pairs'

" Quoting/parenthesizing made simple
Plug 'machakann/vim-sandwich'

" Enable repeating supported plugin maps with "."
Plug 'tpope/vim-repeat'

" Vim plugin for intensely nerdy commenting powers
Plug 'preservim/nerdcommenter' , { 'on' : '<Plug>NERDCommenterToggle' }

" Multiple cursors plugin for vim/neovim
Plug 'mg979/vim-visual-multi', {'branch': 'master'}

" Make terminal vim and tmux work better together
Plug 'tmux-plugins/vim-tmux-focus-events'

" Seamless integration for vim and tmux's clipboard
Plug 'roxma/vim-tmux-clipboard'

"
" Languages
"

" Asychronous Lint Engine, on the fly linting of files
" Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }

" Tabnine
" Plug 'tbodt/deoplete-tabnine', { 'do': './install.sh' }

" Nodejs extension host for vim & neovim, load extensions like VSCode and host
" language servers
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Check syntax in Vim asynchronously and fix files, with Language Server
" Protocol (LSP) support
Plug 'dense-analysis/ale'

" LSP language server
Plug 'autozimu/LanguageClient-neovim', {
  \ 'branch': 'next',
  \ 'do': 'bash install.sh',
\}

" LSP bash
Plug 'WolfgangMehner/bash-support'

" Go development plugin for Vim
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }

" Track the Snippets engine
Plug 'SirVer/ultisnips'

" Snippets are separated from the engine
Plug 'honza/vim-snippets'

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

" Pasting in Vim with indentation adjusted to destination context
Plug 'sickill/vim-pasta'

" Add support to bitbake
Plug 'kergoth/vim-bitbake'

" YAML support
Plug 'avakhov/vim-yaml'

" Dockerfile support
Plug 'ekalinin/Dockerfile.vim'

" Rainbow Parentheses Improved, shorter code, no level limit, smooth and fast,
" powerful configuration
Plug 'luochen1990/rainbow'

" A lightweight Vim/Neovim plugin to display buffers and tabs in the tabline
" Better looking, but has issues with buffers numbers
" Plug 'pacha/vem-tabline'
"
" Forget Vim tabs – now you can have buffer tabs
Plug 'ap/vim-buftabline'

" Builtin terminal in the floating/popup window
Plug 'voldikss/vim-floaterm'

" Wisely add 'end' in ruby, endfunction/endif/more in vim script
Plug 'tpope/vim-endwise'

" Generate table of contents for Markdown files
Plug 'mzlogin/vim-markdown-toc'

" Delete buffers and close files in Vim without closing your windows or
" messing up your layout. Like Bclose.vim, but rewritten and well maintained
Plug 'moll/vim-bbye'

" Very small plugin to easily stage lines
Plug 'neworld/vim-git-hunk-editor'

" Provide operator motions to quickly replace text
Plug 'svermeulen/vim-subversive'

" Perform all your vim insert mode completions with Tab
Plug 'ervandew/supertab'
let g:SuperTabDefaultCompletionType = "<c-n>"

" Plugin to move lines and selections up and down
" With Alt-hjkl
Plug 'matze/vim-move'

" Switch between single-line and multiline forms of code
" gS to split a one-liner into multiple lines
" gJ (with the cursor on the first line of a block) to join a block into a single-line statement
Plug 'AndrewRadev/splitjoin.vim'

call plug#end()

"
" Colours & UI settings
"
scriptencoding utf-8

set t_Co=256 " Explicitly tell vim that the terminal supports 256 colors
" switch cursor to line when in insert mode, and block when not
set guicursor=n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50
  \,a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor
  \,sm:block-blinkwait175-blinkoff150-blinkon175

if &term =~ '256color'
  " disable background color erase
  set t_ut=
endif

" highlight conflicts
match ErrorMsg '^\(<\|=\|>\)\{7\}\([^=].\+\)\?$'

" enable 24 bit color support if supported
if (has("termguicolors"))
  if (!(has("nvim")))
    let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
    let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
  endif
  set termguicolors
endif

if (has('nvim'))
  " show results of substition as they're happening
  " but don't open a split
  set inccommand=nosplit
endif

set background=dark
colorscheme onedark

highlight clear SignColumn  " SignColumn should match background

set autowrite                               " Automatically write a file when leaving a modified buffer
set cursorline                              " Highlight current line
set emoji                                   " enable emojis
set expandtab smarttab                      " tab key actions
set hidden                                  " Allow buffer switching without saving
set ignorecase smartcase                    " Case insensitive search, but case sensitive when uc present
set linebreak                               " do not break words
set linespace=0                             " No extra spaces between rows
set matchtime=0                             " Hide matching time
set mouse=a                                 " enable mouse scrolling
set mousehide                               " Hide the mouse cursor while typing
set nojoinspaces                            " Prevents inserting two spaces after punctuation on a join (J)
set nolazyredraw                            " don't redraw while executing macros
set nowrap                                  " Do not wrap long lines
set number relativenumber                   " enable numbers on the left, current line is 0
set regexpengine=1                          "  Use the old engine, new is for debugging
set ruler                                   " Show the ruler
set shiftround                              " Round indent to multiple of 'shiftwidth'
set shortmess=atOI                          " No help Uganda information, and overwrite read messages to avoid PRESS ENTER prompts
set showcmd                                 " Show partial commands in status line and Selected characters/lines in visual mode
set showmatch                               " Show matching brackets/parentthesis
set showmode                                " Show current mode in command-line
set showtabline=2                           " always show tabline
set smartindent autoindent                  " Do smart autoindenting when starting a new line
set tabstop=4 softtabstop=4 shiftwidth=4    " tab width
set ttyfast                                 " faster redrawing

" Display whitespace characters
set list
set listchars=tab:→\ ,trail:·,extends:↷,precedes:↶,nbsp:␣
set fillchars=vert:│,fold:·

set winminheight=0
set wildmode=list:longest,full
set wildignore+=*swp,*.class,*.pyc,*.png,*.jpg,*.gif,*.zip
set wildignore+=*/tmp/*,*.o,*.obj,*.so

" Allow backspace and cursor keys to cross line boundaries
set whichwrap+=<,>,h,l

set termencoding=utf-8
set fileencoding=utf-8
set fileencodings=utf-8,ucs-bom,gb18030,gbk,gb2312,cp936

"
" Backup
"
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
" Key mapping
"

" moving up and down work as you would expect
nnoremap <silent> j gj
nnoremap <silent> k gk
nnoremap <silent> ^ g^
nnoremap <silent> $ g$

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

" CtrlP compatibility
nnoremap <C-p> :Files<cr>

" Use <C-l> to clear the highlighting of :set hlsearch.
nnoremap <silent><C-l> :nohlsearch<C-R>=has('diff')?'<Bar>diffupdate':''<CR><CR><C-L>

"
" Leader key shortcuts
"
let mapleader = "\<Space>"

nnoremap <leader><leader> :Clap<CR>
nnoremap <leader>b :Clap buffers<CR>

nmap <leader>c <Plug>NERDCommenterToggle
vmap <leader>c <Plug>NERDCommenterToggle

nnoremap <silent> <leader>q :Bwipeout<CR>

" Search in files with ripgrep
nmap <leader>g :Leaderf! rg -e
nmap <leader>gw :<C-U><C-R>=printf("Leaderf! rg -e %s ", expand("<cword>"))<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

"
" EasyMotion
"

" Jump to anywhere you want with minimal keystrokes, with just two keys
" binding
nmap <leader>f <Plug>(easymotion-overwin-f2)

" Disable default mappings
let g:EasyMotion_do_mapping = 0

" Turn on case-insensitive feature
let g:EasyMotion_smartcase = 1

"
" vem-tabline settings
" It has issues with buffer numbering
" nmap <leader>1 :VemTablineGo 1<CR>
" nmap <leader>2 :VemTablineGo 2<CR>
" nmap <leader>3 :VemTablineGo 3<CR>
" nmap <leader>4 :VemTablineGo 4<CR>
" nmap <leader>5 :VemTablineGo 5<CR>
"
" let g:vem_tabline_show_number = 'buffnr'

"
" vim-buftabline settings
"
let g:buftabline_show = 1
let g:buftabline_indicators = 1
let g:buftabline_separators = 1
" 0 - none, 1 - buffer, 2 - ordinal
let g:buftabline_numbers = 2
nmap <leader>1 <Plug>BufTabLine.Go(1)
nmap <leader>2 <Plug>BufTabLine.Go(2)
nmap <leader>3 <Plug>BufTabLine.Go(3)
nmap <leader>4 <Plug>BufTabLine.Go(4)
nmap <leader>5 <Plug>BufTabLine.Go(5)

" vim-subversive - s for substitute
nmap s <plug>(SubversiveSubstitute)
nmap ss <plug>(SubversiveSubstituteLine)
nmap S <plug>(SubversiveSubstituteToEndOfLine)
nmap <leader>s <plug>(SubversiveSubstituteRange)
xmap <leader>s <plug>(SubversiveSubstituteRange)
nmap <leader>ss <plug>(SubversiveSubstituteWordRange)

"
" shellharden
"
nmap <silent> <F7> :%!shellharden --replace ''<CR>

"
" YAML files
"
" two space tabs for YAML
au FileType yaml setlocal ts=2 sts=2 sw=2 expandtab

"
" Comments
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

"
" Ale settings
"
let g:ale_completion_enabled = 0

let g:ale_fixers = {
  \ '*': ['remove_trailing_lines', 'trim_whitespace'],
  \ 'sh': ['shfmt'],
  \ 'diff': [],
  \ 'gitcommit': [],
  \ 'gitsendemail': [],
  \}

autocmd BufNewFile,BufRead /ws/tiamarin/halon*/*
  \ let g:ale_fixers = {
  \   '*': ['remove_trailing_lines', 'trim_whitespace'],
  \   'sh': [],
  \   'diff': [],
  \   'gitcommit': [],
  \   'gitsendemail': []
  \}

let g:ale_linters = {
  \ 'sh': ['shellcheck'],
  \ 'gitcommit': ['git-lint'],
  \ 'go': ['gopls'],
  \}

let g:ale_sign_error = "\uf05e"
let g:ale_sign_warning = "\uf071"
let g:ale_fix_on_save = 1
let g:ale_sign_info = '➟'
let g:ale_sign_column_always = 1
let g:ale_warn_about_trailing_blank_lines = 1
let g:ale_warn_about_trailing_whitespace = 1

"
" Language Server
"
" LanguageClient-neovim
let g:LanguageClient_serverCommands = {
  \ 'sh': ['bash-language-server', 'start']
  \}

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
  \}

"
" spaceline statusline
"
let g:spaceline_seperate_style = 'curve'
let g:spaceline_diagnostic_tool = 'ale'
let g:spaceline_colorscheme = 'one'

"
" vim-indent-guides
"
let g:indent_guides_start_level = 2

" It has an effect over fillchars due to Yggdroot/indentLine plugin
let g:indentLine_char = '│'

"
" LeaderF settings
"
" Behaviour
let g:Lf_DefaultExternalTool = 'rg'
let g:Lf_WorkingDirectoryMode = "Ac"
let g:Lf_NoChdir = 1
let g:Lf_HideHelp = 1

" Statusline
let g:Lf_StlColorscheme = 'gruvbox_material'
let g:Lf_StlSeparator = { 'left': '', 'right': '' }

" Popup windows
let g:Lf_WindowPosition = 'popup'
let g:Lf_PreviewInPopup = 1
let g:Lf_PopupPreviewPosition = 'bottom'
let g:Lf_PopupColorscheme = 'gruvbox_material'
let g:Lf_PopupPosition = [10, 0]
let g:Lf_PopupWidth = 0.85
let g:Lf_PopupHeight = 0.4
let g:Lf_PreviewPopupWidth = 10

" Enable preview for specific types
let g:Lf_PreviewResult = {
  \ 'File': 0,
  \ 'Buffer': 0,
  \ 'Mru': 0,
  \ 'Tag': 0,
  \ 'BufTag': 1,
  \ 'Function': 1,
  \ 'Line': 0,
  \ 'Colorscheme': 0,
  \ 'Rg': 1,
  \ 'Gtags': 0
  \}

" Disable default bindings
let g:Lf_ShortcutF = 0
let g:Lf_ShortcutB = 0

let g:Lf_WildIgnore = {
  \ 'dir': ['.svn','.git','.hg', '.idea', '.project'],
  \ 'file': ['*.sw?','~$*','*.bak', '*.tmp', '*.temp', 'tags']
  \}

let g:Lf_RgConfig = [
  \ "--glob=!git/*",
  \ "--glob=!tags",
  \ "--glob=!.svn/",
  \ "--glob=!.idea/*",
  \]

"
" vim-floaterm
"
let g:floaterm_open_command = 'tabe'
let g:floaterm_keymap_toggle = "<Leader>'"
let g:floaterm_width = 0.98
let g:floaterm_height = 0.4

let g:comfortable_motion_scroll_down_key = "j"
let g:comfortable_motion_scroll_up_key = "k"

let g:comfortable_motion_friction = 80.0
let g:comfortable_motion_air_drag = 2.0

"
" Text expantion
"
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

" Set to 0 if you want to enable it later via :RainbowToggle
let g:rainbow_active = 1

let g:suda_smart_edit = 1

"
" quick-scope
"
" Trigger a highlight in the appropriate direction when pressing these keys:
let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']

"
" Clap
"
let g:clap_theme = 'material_design_dark'

"
" vim-go
"
" Show by default 4 spaces for a tab
autocmd BufNewFile,BufRead *.go setlocal noexpandtab tabstop=4 shiftwidth=4

" Disable mappings
let g:go_def_mapping_enabled = 0


"
" deoplete
"
" let g:deoplete#enable_at_startup = 1
"
" call deoplete#custom#option({
"   \   'auto_complete_delay': 100,
"   \   'smart_case': v:false,
"   \   'ignore_case': v:true,
"   \ })
"
" Enable autocompletion
" call deoplete#custom#option('omni_patterns', { 'go': '[^. *\t]\.\w*' })
"
"
" tabnine
"
" call deoplete#custom#var('tabnine', {
"   \ 'max_num_results': 5,
"   \})
"
" call deoplete#custom#option('prev_completion_mode', 'mirror')

"
" coc
"
let g:coc_global_extensions = [
  \ 'coc-cmake',
  \ 'coc-yaml',
  \ 'coc-pairs',
  \ 'coc-sh',
  \ 'coc-vimlsp',
  \ 'coc-ultisnips',
  \ 'coc-explorer',
  \ 'coc-diagnostic',
  \ 'coc-floaterm',
  \ 'coc-tabnine'
  \ ]

" Highlight the symbol and its references when holding the cursor
autocmd CursorHold * silent call CocActionAsync('highlight')

" Add (Neo)Vim's native statusline support
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

inoremap <silent><expr> <c-space> coc#refresh()

"
" ultisnips
"
let g:UltiSnipsExpandTrigger = "<tab>"
let g:UltiSnipsJumpForwardTrigger = "<c-b>"
let g:UltiSnipsJumpBackwardTrigger = "<c-z>"

let g:python3_host_prog = "/usr/bin/python3.7"

" vim:set ts=2 sw=2 et:
