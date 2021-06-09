if !has('nvim')
  " Stop sourcing here if regular vim is sourcing this file
  finish
endif

call plug#begin('~/.vim/plugged')

" Defaults everyone can agree on
Plug 'tpope/vim-sensible'

" An alternative sudo.vim
Plug 'lambdalisue/suda.vim'

"
" UI
"
Plug 'joshdick/onedark.vim'

" treesitter
Plug 'nvim-treesitter/nvim-treesitter'
Plug 'nvim-treesitter/nvim-treesitter-textobjects'
Plug 'romgrk/nvim-treesitter-context'

" Apply fast colors
Plug 'norcalli/nvim-colorizer.lua'

" Replace fzf
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'

" vim statusline like spacemacs, lightline replacement
" Plug 'glepnir/spaceline.vim'
Plug 'glepnir/galaxyline.nvim', {'branch': 'main'}

" Icons in completation mode
Plug 'onsails/lspkind-nvim'

" Git
Plug 'lewis6991/gitsigns.nvim'

" Smooth scroll
Plug 'karb94/neoscroll.nvim'

" Indent guides on blank lines for Neovim
Plug 'lukas-reineke/indent-blankline.nvim', { 'branch': 'lua' }

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

" Fuzzy searching of files using FZF
Plug 'junegunn/vim-peekaboo'

" Plugin for vim to enabling opening a file in a given line
Plug 'wsdjeg/vim-fetch'

" substitute preview
Plug 'osyo-manga/vim-over'

" Intelligently reopen files at your last edit position in Vim
Plug 'farmergreg/vim-lastplace'

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
Plug 'windwp/nvim-autopairs'

" Quoting/parenthesizing made simple
Plug 'machakann/vim-sandwich'

" Enable repeating supported plugin maps with "."
Plug 'tpope/vim-repeat'

" Vim plugin for intensely nerdy commenting powers
Plug 'preservim/nerdcommenter' , { 'on' : '<Plug>NERDCommenterToggle' }

" Multiple cursors plugin for vim/neovim
Plug 'mg979/vim-visual-multi', {'branch': 'master'}

" Make terminal vim and tmux work better together
" Plug 'tmux-plugins/vim-tmux-focus-events'

" Seamless integration for vim and tmux's clipboard
Plug 'roxma/vim-tmux-clipboard'

"
" Languages
"

" Quickstart configurations for the Nvim LSP client
Plug 'neovim/nvim-lspconfig'

" Neovim completion
Plug 'hrsh7th/nvim-compe'

" tabnine using nvim-compe
Plug 'tzachar/compe-tabnine', { 'do': './install.sh' }

" Fix files
Plug 'dense-analysis/ale'

" Linter to replace ale
Plug 'mfussenegger/nvim-lint'

" Go development plugin for Vim
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }

" Track the Snippets engine
" Plug 'SirVer/ultisnips'
Plug 'rafamadriz/friendly-snippets'
Plug 'hrsh7th/vim-vsnip'
Plug 'hrsh7th/vim-vsnip-integ'

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

" Neovim tabline plugin
Plug 'romgrk/barbar.nvim'

" Wisely add 'end' in ruby, endfunction/endif/more in vim script
Plug 'tpope/vim-endwise'

" Generate table of contents for Markdown files
Plug 'mzlogin/vim-markdown-toc'

" Very small plugin to easily stage lines
Plug 'neworld/vim-git-hunk-editor'

" Provide operator motions to quickly replace text
Plug 'svermeulen/vim-subversive'

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
set emoji                                   " Enable emojis
set expandtab smarttab                      " Tab key actions
set hidden                                  " Allow buffer switching without saving
set ignorecase smartcase                    " Case insensitive search, but case sensitive when uc present
set linebreak                               " Do not break words
set linespace=0                             " No extra spaces between rows
set matchtime=0                             " Hide matching time
set mouse=a                                 " Enable mouse scrolling
set mousehide                               " Hide the mouse cursor while typing
set nojoinspaces                            " Prevents inserting two spaces after punctuation on a join (J)
set nolazyredraw                            " Don't redraw while executing macros
set nowrap                                  " Do not wrap long lines
set number relativenumber                   " Enable numbers on the left, current line is 0
set regexpengine=1                          " Use the old engine, new is for debugging
set ruler                                   " Show the ruler
set shiftround                              " Round indent to multiple of 'shiftwidth'
set shortmess=atOI                          " No help Uganda information, and overwrite read messages to avoid PRESS ENTER prompts
set showcmd                                 " Show partial commands in status line and Selected characters/lines in visual mode
set showmatch                               " Show matching brackets/parentthesis
set showmode                                " Show current mode in command-line
set showtabline=2                           " Always show tabline
set smartindent autoindent                  " Do smart autoindenting when starting a new line
set tabstop=4 softtabstop=4 shiftwidth=4    " Tab width
set ttyfast                                 " Faster redrawing

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
" fzf.vim is quicker than fzf.preview
nnoremap <silent> <C-p> :Telescope find_files find_command=fd,--hidden,--follow,--type,file<CR>

" Use <C-l> to clear the highlighting of :set hlsearch.
nnoremap <silent><C-l> :nohlsearch<C-R>=has('diff')?'<Bar>diffupdate':''<CR><CR><C-L>

"
" Leader key shortcuts
"
let mapleader = "\<Space>"

nnoremap <leader>b :Telescope buffers<CR>

nmap <leader>c <Plug>NERDCommenterToggle
vmap <leader>c <Plug>NERDCommenterToggle

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
" barbar
"
nnoremap <silent> <leader>1 :BufferGoto 1<CR>
nnoremap <silent> <leader>2 :BufferGoto 2<CR>
nnoremap <silent> <leader>3 :BufferGoto 3<CR>
nnoremap <silent> <leader>4 :BufferGoto 4<CR>
nnoremap <silent> <leader>5 :BufferGoto 5<CR>
nnoremap <silent> <leader>6 :BufferGoto 6<CR>
nnoremap <silent> <leader>7 :BufferGoto 7<CR>
nnoremap <silent> <leader>8 :BufferGoto 8<CR>
nnoremap <silent> <leader>9 :BufferGoto 9<CR>

" nnoremap <silent> <leader>q :Bwipeout<CR>
nnoremap <silent> <leader>q :BufferClose<CR>

"
" vim-subversive - s for substitute
"
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
let g:ale_disable_lsp = 1
let g:ale_fix_on_save = 1

let g:ale_fixers = {
  \ '*': ['remove_trailing_lines', 'trim_whitespace'],
  \ 'sh': ['shfmt'],
  \ 'diff': [],
  \ 'gitcommit': [],
  \ 'gitsendemail': [],
  \}

autocmd BufNewFile,BufRead /ws/tiamarin/halon*/*
  \ let g:ale_fixers = {
  \ '*': ['remove_trailing_lines', 'trim_whitespace'],
  \ 'sh': [],
  \ 'diff': [],
  \ 'gitcommit': [],
  \ 'gitsendemail': []
  \}

"
" indent-blankline
"
let g:indent_blankline_char = '│'
let g:indent_blankline_use_treesitter = v:true
let g:indent_blankline_filetype_exclude = ['help']
let g:indent_blankline_show_current_context = v:true
let g:indent_blankline_context_patterns = ['class', 'function', 'method', 'while', 'closure', 'for']
let g:indent_blankline_viewport_buffer = 50

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

"
" Smartedit
"
let g:suda_smart_edit = 1

"
" quick-scope
"
" Trigger a highlight in the appropriate direction when pressing these keys:
let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']

"
" vim-go
"
" Show by default 4 spaces for a tab
autocmd BufNewFile,BufRead *.go setlocal noexpandtab tabstop=4 shiftwidth=4

" Disable mappings
let g:go_def_mapping_enabled = 0

"
" peekaboo
"
let g:peekaboo_window = 'vert bo 50new'

"
" VM settings
"
let g:python3_host_prog = "/usr/bin/python3.7"

let g:vimrc_author='Javier Tia'
let g:vimrc_email='javier.tia@hpe.com'

"
" Colorizer
"
" enable plugin despite file having no extension
autocmd FileType * ColorizerAttachToBuffer

" Expand
imap <expr> <C-j> vsnip#expandable() ? '<Plug>(vsnip-expand)' : '<C-j>'
smap <expr> <C-j> vsnip#expandable() ? '<Plug>(vsnip-expand)' : '<C-j>'

"
" spaceline statusline
"
" let g:spaceline_seperate_style = 'curve'
" let g:spaceline_colorscheme = 'one'

"
" Lua config
"
lua require('config')

" vim:set ts=2 sw=2 et:
