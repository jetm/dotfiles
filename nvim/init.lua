local vim = vim
local cmd = vim.cmd -- to execute Vim commands e.g. cmd('pwd')
local g = vim.g -- a table to access global variables
local opt = vim.opt -- to set options

--
-- Colors
--
cmd [[
if exists('+termguicolors')
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
  set termguicolors
endif
]]

opt.background = 'dark'
cmd [[colorscheme onedark]]

--
-- Plugins settings
--
require('plugins')

--
-- General settings
--
opt.autoindent = true -- Do smart autoindenting when starting a new line
opt.autowrite = true -- Automatically write a file when leaving a modified buffer
opt.cursorline = true -- Highlight current line
opt.emoji = true -- Enable emojis
opt.hidden = true -- Allow buffer switching without saving
opt.ignorecase = true
opt.linebreak = true -- Do not break words
opt.linespace = 0 -- No extra spaces between rows
opt.matchtime = 0 -- Hide matching time
opt.mouse = 'a' -- Enable mouse scrolling
opt.number = true
opt.regexpengine = 1 -- Use the old engine, new is for debugging
opt.relativenumber = true -- Enable numbers on the left, current line is 0
opt.ruler = true -- Show the ruler
opt.shiftround = true -- Round indent to multiple of 'shiftwidth'
opt.shiftwidth = 4
opt.shortmess = 'atOI' -- No help Uganda information, and overwrite read messages to avoid PRESS ENTER prompts
opt.showcmd = true -- Show partial commands in status line and Selected characters/lines in visual mode
opt.showmatch = true -- Show matching brackets/parentthesis
opt.showmode = true -- Show current mode in command-line
opt.showtabline = 2 -- Always show tabline
opt.smartcase = true -- Case insensitive search, but case sensitive when uc present
opt.smartindent = true
opt.smarttab = true -- Tab key actions
opt.expandtab = true
opt.softtabstop = 4
opt.tabstop = 4 -- Tab width

-- Display whitespace characters
opt.list = true
opt.listchars = {tab = '→ ', trail = '·', nbsp = '␣'}

-- I like to include the end newline
-- cmd 'set clipboard+=unnamedplus' -- Copy paste between vim and everything else

-- Highlight when it yanks
cmd 'au TextYankPost * lua vim.highlight.on_yank {higroup="IncSearch", timeout=200, on_visual = false}'

--
-- Backup
--
cmd [[
    set backup
    set undofile
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
]]

--
-- Key Mappings
--
g.mapleader = ' '

local opts = {expr = true}

-- local utils = require('utils')
local mp = require('utils.map')
-- local inoremap = mp.inoremap
local nmap, vmap, xmap, imap, smap, nnoremap = mp.nmap, mp.vmap, mp.xmap,
                                               mp.imap, mp.smap, mp.nnoremap

--  Helper for saving file
nmap('<C-s>', ':update<CR>')
vmap('<C-s>', '<C-c>:update<CR>')
imap('<C-s>', '<C-o>:update<CR>')

--
-- moving up and down work as you would expect
nnoremap('j', 'gj', {silent = true})
nnoremap('k', 'gk', {silent = true})

-- move one line up and one line down
nnoremap('<M-j>', ':move +1<CR>', {silent = true})
nnoremap('<M-k>', ':move -2<CR>', {silent = true})

nnoremap('Q', ':q<CR>', {silent = true})

-- Stop being so lazy - remove arrow key config
nmap('<UP>', '<Nop>')
nmap('<Down>', '<Nop>')
nmap('<Left>', '<Nop>')
nmap('<Right>', '<Nop>')
imap('<UP>', '<Nop>')
imap('<Down>', '<Nop>')
imap('<Left>', '<Nop>')
imap('<Right>', '<Nop>')

-- copy until the end
nnoremap('Y', 'y$', {silent = true})

-- Keep the cursor in place while joining lines
nnoremap('J', 'mzJ`z', {silent = true})

-- Visual shifting (does not exit Visual mode)
vmap('<', '<gv')
vmap('>', '>gv')

-- Move between vim panes with Ctrl-J
nnoremap('<C-J>', '<C-W>j', {silent = true})
nnoremap('<C-K>', '<C-W>k', {silent = true})
nnoremap('<C-L>', '<C-W>l', {silent = true})
nnoremap('<C-H>', '<C-W>h', {silent = true})

-- CtrlP compatibility
-- fzf.vim is quicker than fzf.preview
nnoremap('<C-p>',
         ':Telescope find_files find_command=fd,--hidden,--exclude,.git<CR>',
         {silent = true})

-- Use <Alt-l> to clear the highlighting of :set hlsearch.
nnoremap('<M-l>',
         ':nohlsearch<CR>:diffupdate<CR>:syntax sync fromstart<CR><C-l>',
         {silent = true})

-- Comments
nmap('<leader>c', '<Plug>NERDCommenterToggle')
vmap('<leader>c', '<Plug>NERDCommenterToggle')

--
-- barbar
--
nnoremap('<leader>1', ':BufferGoto1<CR>', {silent = true})
nnoremap('<leader>2', ':BufferGoto2<CR>', {silent = true})
nnoremap('<leader>3', ':BufferGoto3<CR>', {silent = true})
nnoremap('<leader>4', ':BufferGoto4<CR>', {silent = true})
nnoremap('<leader>5', ':BufferGoto5<CR>', {silent = true})
nnoremap('<leader>6', ':BufferGoto6<CR>', {silent = true})
nnoremap('<leader>7', ':BufferGoto7<CR>', {silent = true})
nnoremap('<leader>8', ':BufferGoto8<CR>', {silent = true})
nnoremap('<leader>9', ':BufferGoto9<CR>', {silent = true})

-- barbar buffer close still has some issues. Try later
nnoremap('<leader>q', ':BufferClose<CR>', {silent = true})
-- nnoremap <silent> <leader>q :Bwipeout<CR>

--
-- NvimTree
--
nnoremap('<leader>tt', ':NvimTreeToggle<CR>', {silent = true})
nnoremap('<leader>tf', ':NvimTreeFindFile<CR>', {silent = true})

--
-- shellharden
--
-- nmap <silent> <F7> :%!shellharden --replace ''<CR>

--
-- vsnip
--
-- Expand
imap('<C-j>', "vsnip#expandable() ? '<Plug>(vsnip-expand)' : '<C-j>'", opts)
smap('<C-j>', "vsnip#expandable() ? '<Plug>(vsnip-expand)' : '<C-j>'", opts)

--
-- expand_region
--
xmap("v", "<Plug>(expand_region_expand)")
xmap("V", "<Plug>(expand_region_shrink)")

--
-- hlslens
--
nnoremap("n",
         "<cmd>execute('normal! ' . v:count1 . 'n')<CR><cmd>lua require('hlslens').start()<CR>",
         {silent = true})
nnoremap("N",
         "<cmd>execute('normal! ' . v:count1 . 'N')<CR><cmd>lua require('hlslens').start()<CR>",
         {silent = true})
nnoremap("*", "*<cmd>lua require('hlslens').start()<CR>")
nnoremap("#", "#<cmd>lua require('hlslens').start()<CR>")
nnoremap("g*", "g*<cmd>lua require('hlslens').start()<CR>")
nnoremap("g#", "g#<cmd>lua require('hlslens').start()<CR>")

--
-- Specific Language settings
--
-- YAML files
-- two space tabs for YAML
cmd 'au FileType yaml setlocal ts=2 sts=2 sw=2 expandtab'

-- Go files
-- Show by default 4 spaces for a tab
cmd 'autocmd BufNewFile,BufRead *.go setlocal noexpandtab tabstop=4 shiftwidth=4'

--
-- VM settings
--
g.python3_host_prog = "/usr/bin/python3.7"
