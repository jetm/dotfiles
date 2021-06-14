local icons = require("nvim-nonicons")

--
-- LSP
--
require('lsp-settings')

--
-- nvim-compe
--
vim.o.completeopt = "menuone,noselect"

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
        spell = true,
        tags = true,
        tmux = true
    }
})

local t = function(str)
    return vim.api.nvim_replace_termcodes(str, true, true, true)
end

local check_back_space = function()
    local col = vim.fn.col(".") - 1
    if col == 0 or vim.fn.getline("."):sub(col, col):match("%s") then
        return true
    else
        return false
    end
end

-- tab completion

_G.tab_complete = function()
    if vim.fn.pumvisible() == 1 then
        return t "<C-n>"
    elseif check_back_space() then
        return t "<Tab>"
    else
        return vim.fn["compe#complete"]()
    end
end
_G.s_tab_complete = function()
    if vim.fn.pumvisible() == 1 then
        return t "<C-p>"
    elseif vim.fn.call("vsnip#jumpable", {-1}) == 1 then
        return t "<Plug>(vsnip-jump-prev)"
    else
        return t "<S-Tab>"
    end
end

--  mappings

vim.api.nvim_set_keymap("i", "<Tab>", "v:lua.tab_complete()", {expr = true})
vim.api.nvim_set_keymap("s", "<Tab>", "v:lua.tab_complete()", {expr = true})
vim.api.nvim_set_keymap("i", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})
vim.api.nvim_set_keymap("s", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})

function _G.completions()
    local npairs = require("nvim-autopairs")
    if vim.fn.pumvisible() == 1 then
        if vim.fn.complete_info()["selected"] ~= -1 then
            return vim.fn["compe#confirm"]("<CR>")
        end
    end
    return npairs.check_break_line_char()
end

vim.api.nvim_set_keymap("i", "<CR>", "v:lua.completions()", {expr = true})

--
-- tmux-complete
--
do
    local compe = require "compe"
    local Source = {}

    function Source.get_metadata(_)
        return {priority = 10, dup = 0, menu = "[Tmux]"}
    end

    function Source.determine(_, context)
        return compe.helper.determine(context)
    end

    function Source.complete(_, context)
        vim.fn["tmuxcomplete#async#gather_candidates"](function(items)
            context.callback({items = items})
        end)
    end

    compe.register_source("tmux", Source)
end

--
-- nvim-treesitter
--
require("nvim-treesitter.configs").setup({
    -- highlight = {enable = true}, -- problems with onedark
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

vim.g.completion_confirm_key = ""
MUtils.completion_confirm = function()
    if vim.fn.pumvisible() ~= 0 then
        if vim.fn.complete_info()["selected"] ~= -1 then
            return vim.fn["compe#confirm"](npairs.esc("<cr>"))
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
require("colorizer").setup()

--
-- barbar
--
vim.g.bufferline = {icons = 'both'}

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
vim.cmd [[command! -nargs=0 LspReinstallAll call v:lua.lsp_reinstall_all()]]

--
-- nvim-tree
--

vim.g.nvim_tree_icons = {
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
vim.g.nvim_tree_group_empty = 1

-- shows indent markers when folders are open
vim.g.nvim_tree_indent_markers = 1

-- allows the cursor to be updated when entering a buffer
vim.g.nvim_tree_follow = 1

-- closes the tree when it's the last window
vim.g.nvim_tree_auto_close = true

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
                filename = vim.fn.fnamemodify(filename, ":~:.")
                local space = math.min(60, math.floor(0.6 * vim.fn.winwidth(0)))
                if #filename > space then
                    filename = vim.fn.pathshorten(filename)
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
vim.api.nvim_exec([[
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
        zsh = {shfmt},
        lua = {luaformat}
    }
})

--
-- nvim-comment
--
-- require('nvim_comment').setup({create_mappings = false})

--
-- hop
--
require'hop'.setup({term_seq_bias = 0.5})
