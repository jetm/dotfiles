local vim = vim
local cmd = vim.cmd -- to execute Vim commands e.g. cmd('pwd')
local g = vim.g -- a table to access global variables
local o = vim.o -- to set options
local fn = vim.fn -- to call Vim functions e.g. fn.bufnr()
local api = vim.api

local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'

if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({
        'git', 'clone', 'https://github.com/wbthomason/packer.nvim',
        install_path
    })
    api.nvim_command 'packadd packer.nvim'
end

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

o.background = 'dark'
cmd [[colorscheme onedark]]

--
-- Plugins settings
--
require('plugins')

--
-- General settings
--
o.autoindent = true -- Do smart autoindenting when starting a new line
o.autowrite = true -- Automatically write a file when leaving a modified buffer
o.cursorline = true -- Highlight current line
o.emoji = true -- Enable emojis
o.hidden = true -- Allow buffer switching without saving
o.ignorecase = true
o.linebreak = true -- Do not break words
o.linespace = 0 -- No extra spaces between rows
o.matchtime = 0 -- Hide matching time
o.mouse = 'a' -- Enable mouse scrolling
o.number = true
o.regexpengine = 1 -- Use the old engine, new is for debugging
o.relativenumber = true -- Enable numbers on the left, current line is 0
o.ruler = true -- Show the ruler
o.shiftround = true -- Round indent to multiple of 'shiftwidth'
o.shortmess = 'atOI' -- No help Uganda information, and overwrite read messages to avoid PRESS ENTER prompts
o.showcmd = true -- Show partial commands in status line and Selected characters/lines in visual mode
o.showmatch = true -- Show matching brackets/parentthesis
o.showmode = true -- Show current mode in command-line
o.showtabline = 2 -- Always show tabline
o.smartcase = true -- Case insensitive search, but case sensitive when uc present
o.smartindent = true
o.smarttab = true -- Tab key actions
o.expandtab = true
o.softtabstop = 4
o.shiftwidth = o.softtabstop
o.tabstop = o.softtabstop -- Tab width

-- Display whitespace characters
o.list = true
vim.opt.listchars = {tab = '→ ', trail = '·', nbsp = '␣'}

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

local vimp = require('vimp')

--  Helper for saving file
vimp.nmap('<C-s>', ':update<CR>')
vimp.vmap('<C-s>', '<C-c>:update<CR>')
vimp.imap('<C-s>', '<C-o>:update<CR>')

--
-- moving up and down work as you would expect
vimp.nnoremap('j', 'gj')
vimp.nnoremap('k', 'gk')

-- move one line up and one line down
vimp.nnoremap('<M-j>', ':move +1<CR>')
vimp.nnoremap('<M-k>', ':move -2<CR>')

vimp.nnoremap('Q', ':q<CR>')

-- Stop being so lazy - remove arrow key config
vimp.nmap('<UP>', '<Nop>')
vimp.nmap('<Down>', '<Nop>')
vimp.nmap('<Left>', '<Nop>')
vimp.nmap('<Right>', '<Nop>')
vimp.imap('<UP>', '<Nop>')
vimp.imap('<Down>', '<Nop>')
vimp.imap('<Left>', '<Nop>')
vimp.imap('<Right>', '<Nop>')

-- copy until the end
vimp.nnoremap('Y', 'y$')

-- Keep the cursor in place while joining lines
vimp.nnoremap('J', 'mzJ`z')

-- Visual shifting (does not exit Visual mode)
vimp.vmap('<', '<gv')
vimp.vmap('>', '>gv')

-- Move between vim panes with Ctrl-J
vimp.nnoremap('<C-J>', '<C-W>j')
vimp.nnoremap('<C-K>', '<C-W>k')
vimp.nnoremap('<C-L>', '<C-W>l')
vimp.nnoremap('<C-H>', '<C-W>h')

-- CtrlP compatibility
-- fzf.vim is quicker than fzf.preview
vimp.nnoremap('<C-p>',
              ':Telescope find_files find_command=fd,--hidden,--exclude,.git<CR>')

-- Use <Alt-l> to clear the highlighting of :set hlsearch.
vimp.nnoremap('<M-l>',
              ':nohlsearch<CR>:diffupdate<CR>:syntax sync fromstart<CR><C-l>')

-- Comments
vimp.nmap('<leader>c', '<Plug>NERDCommenterToggle')
vimp.vmap('<leader>c', '<Plug>NERDCommenterToggle')

--
-- barbar
--
vimp.nnoremap('<leader>1', ':BufferGoto1<CR>')
vimp.nnoremap('<leader>2', ':BufferGoto2<CR>')
vimp.nnoremap('<leader>3', ':BufferGoto3<CR>')
vimp.nnoremap('<leader>4', ':BufferGoto4<CR>')
vimp.nnoremap('<leader>5', ':BufferGoto5<CR>')
vimp.nnoremap('<leader>6', ':BufferGoto6<CR>')
vimp.nnoremap('<leader>7', ':BufferGoto7<CR>')
vimp.nnoremap('<leader>8', ':BufferGoto8<CR>')
vimp.nnoremap('<leader>9', ':BufferGoto9<CR>')

-- barbar buffer close still has some issues. Try later
vimp.nnoremap('<leader>q', ':BufferClose<CR>')
-- nnoremap <silent> <leader>q :Bwipeout<CR>

--
-- NvimTree
--
vimp.nnoremap('<leader>tt', ':NvimTreeToggle<CR>')
vimp.nnoremap('<leader>tf', ':NvimTreeFindFile<CR>')

--
-- shellharden
--
-- nmap <silent> <F7> :%!shellharden --replace ''<CR>

--
-- vsnip
--
-- Expand
-- imap('<C-j>', "vsnip#expandable() ? '<Plug>(vsnip-expand)' : '<C-j>'", opts)
-- smap('<C-j>', "vsnip#expandable() ? '<Plug>(vsnip-expand)' : '<C-j>'", opts)

--
-- expand_region
--
vimp.xmap("v", "<Plug>(expand_region_expand)")
vimp.xmap("V", "<Plug>(expand_region_shrink)")

--
-- hlslens
--
vimp.nnoremap("n",
              "<cmd>execute('normal! ' . v:count1 . 'n')<CR><cmd>lua require('hlslens').start()<CR>")
vimp.nnoremap("N",
              "<cmd>execute('normal! ' . v:count1 . 'N')<CR><cmd>lua require('hlslens').start()<CR>")
vimp.nnoremap("*", "*<cmd>lua require('hlslens').start()<CR>")
vimp.nnoremap("#", "#<cmd>lua require('hlslens').start()<CR>")
vimp.nnoremap("g*", "g*<cmd>lua require('hlslens').start()<CR>")
vimp.nnoremap("g#", "g#<cmd>lua require('hlslens').start()<CR>")

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
