local vim = vim
local cmd = vim.cmd -- to execute Vim commands e.g. cmd('pwd')
local fn = vim.fn -- to call Vim functions e.g. fn.bufnr()
local g = vim.g -- a table to access global variables
local opt = vim.opt -- to set options
local api = vim.api
local wo = vim.wo

require('plugins')

-- run :PackerCompile whenever plugins.lua is updated
vim.cmd('autocmd BufWritePost plugins.lua PackerCompile')

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

-- Highlight when it yanks
cmd 'au TextYankPost * lua vim.highlight.on_yank {higroup="IncSearch", timeout=200, on_visual = false}'

--
-- General settings
--
opt.autoindent = true -- Do smart autoindenting when starting a new line
opt.autowrite = true -- Automatically write a file when leaving a modified buffer
opt.cursorline = true -- Highlight current line
opt.clipboard = "unnamedplus" -- Copy paste between vim and everything else
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

wo.list = true
opt.listchars = 'tab:→ ,trail:·'

--
-- Backup
--
api.nvim_exec([[
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
]], '')

--
-- Key Mappings
--
g.mapleader = ' '

local opts = {expr = true}

-- local utils = require('utils')
local mp = require('utils.map')
local nmap, vmap, xmap, imap, smap, nnoremap, inoremap = mp.nmap, mp.vmap,
                                                         mp.xmap, mp.imap,
                                                         mp.smap, mp.nnoremap,
                                                         mp.inoremap
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

nnoremap('Y', 'y$', {silent = true})

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
         ':Telescope find_files find_command=fd,--hidden,--follow,--type,file,--exclude,.git<CR>',
         {silent = true})

-- Use <Alt-l> to clear the highlighting of :set hlsearch.
nnoremap('<M-l>',
         ':nohlsearch<CR>:diffupdate<CR>:syntax sync fromstart<CR><C-l>')

-- Comments
nmap('<leader>c', '<Plug>NERDCommenterToggle')
vmap('<leader>c', '<Plug>NERDCommenterToggle')

--
-- Hop
--
nmap('<leader>s', ':HopChar2<CR>')

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
         "<cmd>execute('normal! ' . v:count1 . 'n')<cr><cmd>lua require('hlslens').start()<cr>",
         {silent = true})
nnoremap("N",
         "<cmd>execute('normal! ' . v:count1 . 'N')<cr><cmd>lua require('hlslens').start()<cr>",
         {silent = true})
nnoremap("*", "*<cmd>lua require('hlslens').start()<cr>")
nnoremap("#", "#<cmd>lua require('hlslens').start()<cr>")
nnoremap("g*", "g*<cmd>lua require('hlslens').start()<cr>")
nnoremap("g#", "g#<cmd>lua require('hlslens').start()<cr>")

--
-- Icons
--
local icons = require("nvim-nonicons")

--
-- LSP
--
require('lsp-settings')

--
-- nvim-compe
--
opt.completeopt = "menuone,noinsert,noselect"

require("compe").setup({
    enabled = true,
    -- auto open popup
    autocomplete = true,
    debug = false,
    -- min chars to trigger completion on
    min_length = 1,
    preselect = "enable",
    throttle_time = 80,
    source_timeout = 200,
    incomplete_delay = 400,
    max_abbr_width = 100,
    max_kind_width = 100,
    max_menu_width = 100,
    documentation = true,

    tabnine = {
        max_line = 1000,
        max_num_results = 6,
        sort = false,
        priority = 1,
        show_prediction_strength = false
    },
    source = {
        path = true,
        buffer = {kind = "﬘", true},
        nvim_lsp = true,
        nvim_lua = true,
        ultisnips = {kind = "﬌", true},
        vsnip = {kind = "﬌", true},
        spell = false,
        tags = true
    }
})

local t = function(str)
    return vim.api.nvim_replace_termcodes(str, true, true, true)
end

local check_back_space = function()
    local col = fn.col(".") - 1
    if col == 0 or fn.getline("."):sub(col, col):match("%s") then
        return true
    else
        return false
    end
end

-- tab completion

_G.tab_complete = function()
    if fn.pumvisible() == 1 then
        return t "<C-n>"
    elseif check_back_space() then
        return t "<Tab>"
    else
        return fn["compe#complete"]()
    end
end
_G.s_tab_complete = function()
    if fn.pumvisible() == 1 then
        return t "<C-p>"
    elseif fn.call("vsnip#jumpable", {-1}) == 1 then
        return t "<Plug>(vsnip-jump-prev)"
    else
        return t "<S-Tab>"
    end
end

--
-- completions mappings
--
api.nvim_set_keymap("i", "<Tab>", "v:lua.tab_complete()", {expr = true})
api.nvim_set_keymap("s", "<Tab>", "v:lua.tab_complete()", {expr = true})
api.nvim_set_keymap("i", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})
api.nvim_set_keymap("s", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})

function _G.completions()
    local npairs = require("nvim-autopairs")
    if fn.pumvisible() == 1 then
        if fn.complete_info()["selected"] ~= -1 then
            return fn["compe#confirm"]("<CR>")
        end
    end
    return npairs.check_break_line_char()
end

api.nvim_set_keymap("i", "<CR>", "v:lua.completions()", {expr = true})

--
-- nvim-treesitter
--
require("nvim-treesitter.configs").setup({
    ensure_installed = {
        "bash", "c", "comment", "cpp", "dockerfile", "go", "json", "jsonc",
        "lua", "python", "regex", "yaml"
    },
    -- Disabling highlight. Still has problems with shell and other languages
    highlight = {enable = false, use_languagetree = true},
    indent = {enable = true},
    rainbow = {
        enable = true,
        extended_mode = true -- Highlight also non-parentheses delimiters, boolean or table: lang -> boolean
    }
})

--
-- telescope
--
local actions = require("telescope.actions")
require("telescope").setup({
    defaults = {
        mappings = {i = {["<esc>"] = actions.close}},
        prompt_prefix = "🔍 ",
        selection_caret = " ",
        entry_prefix = "  ",
        set_env = {['COLORTERM'] = 'truecolor'} -- default = nil,
    }
})

--
-- autopairs
--
require("nvim-autopairs").setup()

local remap = vim.api.nvim_set_keymap
local npairs = require('nvim-autopairs')

-- skip it, if you use another global object
_G.MUtils = {}

g.completion_confirm_key = ""
MUtils.completion_confirm = function()
    if fn.pumvisible() ~= 0 then
        if fn.complete_info()["selected"] ~= -1 then
            return fn["compe#confirm"](npairs.esc("<cr>"))
        else
            return npairs.esc("<cr>")
        end
    else
        return npairs.autopairs_cr()
    end
end

remap('i', '<CR>', 'v:lua.MUtils.completion_confirm()',
      {expr = true, noremap = true})

--
-- colorizer
--
-- Attaches to every FileType mode
require("colorizer").setup({'*'}, {
    RGB = true, -- #RGB hex codes
    RRGGBB = true, -- #RRGGBB hex codes
    RRGGBBAA = true, -- #RRGGBBAA hex codes
    rgb_fn = true, -- CSS rgb() and rgba() functions
    hsl_fn = true, -- CSS hsl() and hsla() functions
    css = true, -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
    css_fn = true -- Enable all CSS *functions*: rgb_fn, hsl_fn
})

--
-- barbar
--
g.bufferline = {icons = 'both'}

--
-- nvim-lspinstall
--

function _G.lsp_reinstall_all()
    local lspinstall = require "lspinstall"
    for _, server in ipairs(lspinstall.installed_servers()) do
        lspinstall.install_server(server)
    end
end

-- Add LspReinstallAll command
cmd [[command! -nargs=0 LspReinstallAll call v:lua.lsp_reinstall_all()]]

--
-- nvim-tree
--

g.nvim_tree_icons = {
    default = icons.get("file"),
    symlink = icons.get("file-symlink"),
    git = {
        unstaged = "M",
        staged = "S",
        unmerged = icons.get("git-merge"),
        renamed = "R",
        untracked = "U",
        deleted = "D",
        ignored = "I"
    },
    folder = {
        default = icons.get("file-directory"),
        open = icons.get("file-directory"),
        empty = icons.get("file-directory-outline"),
        empty_open = icons.get("file-directory-outline"),
        symlink = icons.get("file-submodule"),
        symlink_open = icons.get("file-submodule")
    },
    lsp = {error = "", warning = "", info = "", hint = ""}
}

-- compact folders that only contain a single folder into one node in the file
-- tree
g.nvim_tree_group_empty = 1

-- shows indent markers when folders are open
g.nvim_tree_indent_markers = 1

-- allows the cursor to be updated when entering a buffer
g.nvim_tree_follow = 1

-- closes the tree when it's the last window
g.nvim_tree_auto_close = true

--
-- Neoscroll
--
require('neoscroll').setup()

--
-- git
--
require('gitsigns').setup()

--
-- lualine
--
local function lsp_servers_status()
    local clients = vim.lsp.buf_get_clients(0)
    if vim.tbl_isempty(clients) then return "" end

    local client_names = {}
    for _, client in pairs(clients) do
        table.insert(client_names, client.name)
    end

    return icons.get("zap") .. " " .. table.concat(client_names, "|")
end

local function lsp_messages()
    local msgs = {}

    for _, msg in ipairs(vim.lsp.util.get_progress_messages()) do
        local content
        if msg.progress then
            content = msg.title
            if msg.message then
                content = content .. " " .. msg.message
            end
            if msg.percentage then
                content = content .. " (" .. msg.percentage .. "%%)"
            end
        elseif msg.status then
            content = msg.content
            if msg.uri then
                local filename = vim.uri_to_fname(msg.uri)
                filename = fn.fnamemodify(filename, ":~:.")
                local space = math.min(60, math.floor(0.6 * fn.winwidth(0)))
                if #filename > space then
                    filename = fn.pathshorten(filename)
                end

                content = "(" .. filename .. ") " .. content
            end
        else
            content = msg.content
        end

        table.insert(msgs, "[" .. msg.name .. "] " .. content)
    end

    return table.concat(msgs, " | ")
end

local custom_onedark = require 'lualine.themes.onedark'
-- Change the background of lualine_c section for normal mode
custom_onedark.normal.b.bg = '#282c34' -- rgb colors are supported
custom_onedark.normal.c.bg = '#282c34' -- rgb colors are supported

require'lualine'.setup {
    options = {
        theme = custom_onedark,
        component_separators = {'', ''},
        section_separators = {'', ''}
    },
    sections = {
        lualine_a = {'mode'},
        lualine_b = {
            {"branch", icon = icons.get("git-branch")}, {'filename', path = 1}
        },
        lualine_c = {},
        lualine_x = {},
        lualine_y = {
            {
                lsp_messages, {
                    "diagnostics",
                    symbols = {
                        error = icons.get("x-circle") .. " ",
                        warn = icons.get("alert") .. " ",
                        info = icons.get("info") .. " "
                    },
                    sources = {"nvim_lsp"}
                }
            }, {lsp_servers_status}, {
                'encoding',
                condition = function()
                    -- when filencoding="" lualine would otherwise report utf-8 anyways
                    return vim.bo.fileencoding and #vim.bo.fileencoding > 0 and
                               vim.bo.fileencoding ~= 'utf-8'
                end
            }, {
                'fileformat',
                condition = function()
                    return vim.bo.fileformat ~= 'unix'
                end,
                icons_enabled = false
            }, {'filetype', icons_enabled = true}, {'progress'}
        },
        lualine_z = {{'location'}}
    },
    extensions = {"nvim-tree"}
}

--
-- toggleterm
--
require("toggleterm").setup {
    open_mapping = [[<F11>]],
    shade_terminals = false,
    hide_numbers = true
}

--
-- formatter
--

local function prettier()
    return {
        exe = 'prettier',
        args = {
            '--stdin-filepath', vim.api.nvim_buf_get_name(0), '--single-quote'
        },
        stdin = true
    }
end

local function shfmt() return {exe = "shfmt", args = {"-"}, stdin = true} end

local function luaformat() return {exe = 'lua-format', stdin = true} end

-- Format on Save
api.nvim_exec([[
augroup FormatAutogroup
  autocmd!
  autocmd BufWritePost * FormatWrite
augroup END
]], true)

-- FIME: monkey patch over the print function, to silent all prints
require('formatter.util').print = function() end

require"formatter".setup({
    logging = false,
    filetype = {
        markdown = {prettier},
        json = {prettier},
        yaml = {prettier},
        sh = {shfmt},
        bash = {shfmt},
        lua = {luaformat}
    }
})

--
-- hop
--
require'hop'.setup({term_seq_bias = 0.5})

--
-- Shade
--
require'shade'.setup({overlay_opacity = 50, opacity_step = 1})

--
-- nvim-peekup
--
g.peekup_open = '"'
require('nvim-peekup.config').on_keystroke["paste_reg"] = "\""
require('nvim-peekup.config').on_keystroke["delay"] = ''

-- "
-- " YAML files
-- "
-- " two space tabs for YAML
cmd 'au FileType yaml setlocal ts=2 sts=2 sw=2 expandtab'

--
-- Comments
--
-- Add spaces after comment delimiters
g.NERDSpaceDelims = 1

g.NERDCreateDefaultMappings = 0

-- Use compact syntax for prettified multi-line comments
g.NERDCompactSexyComs = 1

-- Align line-wise comment delimiters flush left instead of following code
-- indentation
g.NERDDefaultAlign = 'left'

-- Enable trimming of trailing whitespace when uncommenting
g.NERDTrimTrailingWhitespace = 1

-- Allow commenting and inverting empty lines (useful when commenting a region)
g.NERDCommentEmptyLines = 1

-- Enable NERDCommenterToggle to check all selected lines is commented or not
g.NERDToggleCheckAllLines = 1

--
-- vim-better-whitespace
--
g.better_whitespace_ctermcolor = ""
g.better_whitespace_guicolor = ""
g.better_whitespace_enabled = 0
g.strip_only_modified_lines = 1
g.strip_whitespace_confirm = 0
g.strip_whitespace_on_save = 1

--
-- indent-blankline
--
g.indent_blankline_char = '│'
g.indent_blankline_use_treesitter = true
g.indent_blankline_filetype_exclude = {'help'}
g.indent_blankline_show_current_context = true
g.indent_blankline_context_patterns = {
    'class', 'function', 'method', 'while', 'closure', 'for'
}
g.indent_blankline_viewport_buffer = 50

--
--
-- Smartedit
--
g.suda_smart_edit = 1

--
-- quick-scope
--
-- Trigger a highlight in the appropriate direction when pressing these keys:
g.qs_highlight_on_keys = {'f', 'F', 't', 'T'}

--
-- vim-go
--
-- Show by default 4 spaces for a tab
cmd 'autocmd BufNewFile,BufRead *.go setlocal noexpandtab tabstop=4 shiftwidth=4'

--
-- VM settings
--
g.python3_host_prog = "/usr/bin/python3.7"
