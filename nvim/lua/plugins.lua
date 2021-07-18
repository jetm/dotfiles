local vim = vim
local api = vim.api
local cmd = vim.cmd -- to execute Vim commands e.g. cmd('pwd')
local fn = vim.fn -- to call Vim functions e.g. fn.bufnr()
local g = vim.g -- a table to access global variables
local o = vim.o -- to set options

--
-- Colors
--
-- Putting here before onedar plugin is downloaded. I should be using setup and
-- config, but it seems packer has issues
if fn.exists('+termguicolors') == 1 then
    cmd [[
        let &t_8f = "\\<Esc>[38;2;%lu;%lu;%lum"
        let &t_8b = "\\<Esc>[48;2;%lu;%lu;%lum"
    ]]
    o.termguicolors = true
end
cmd [[colorscheme onedark]]

require('packer').startup(function(use)
    -- Packer can manage itself
    use {'wbthomason/packer.nvim'}

    use {'ii14/onedark.nvim'}
    -- use 'joshdick/onedark.vim'

    -- Neovim plugin that allows you to easily write your .vimrc in lua or any lua based language
    use {'svermeulen/vimpeccable'}

    -- Apply fast colors
    use {'norcalli/nvim-colorizer.lua'}

    -- Neovim tabline plugin
    use {'romgrk/barbar.nvim'}

    -- Icons collections
    use 'kyazdani42/nvim-web-devicons'
    -- Icon set using nonicons for neovim plugins and settings
    use {'yamatsum/nvim-nonicons'}

    -- We recommend updating the parsers on update
    use {'nvim-treesitter/nvim-treesitter', run = ':TSUpdate'}
    use {'nvim-treesitter/nvim-treesitter-textobjects'}
    use {"romgrk/nvim-treesitter-context"}

    -- Replace fzf
    use {'nvim-lua/popup.nvim'}
    use {'nvim-lua/plenary.nvim'}
    use {'nvim-telescope/telescope.nvim'}
    -- use {'camspiers/snap'}

    -- spaceline is slower
    -- Galaxyline lacks of nice configurations, like feline has
    -- lualine has better structure and theme, it's more like spaceline
    use {'hoob3rt/lualine.nvim'}

    -- Smooth scroll
    use {'karb94/neoscroll.nvim'}

    -- Indent guides on blank lines for Neovim
    use {'lukas-reineke/indent-blankline.nvim'}

    -- Rainbow Parentheses Improved, shorter code, no level limit, smooth and fast,
    -- powerful configuration
    use {'p00f/nvim-ts-rainbow'}

    --
    -- Motions
    --
    -- Next-generation motion plugin for incredibly fast on-screen navigation.
    -- Replace hop.nvim and quick-scope
    use {'ggandor/lightspeed.nvim'}

    -- usein for vim to enabling opening a file in a given line
    use {'wsdjeg/vim-fetch'}

    -- Go to the last edited place
    use {
        'ethanholz/nvim-lastplace',
        config = function()
            require'nvim-lastplace'.setup {
                lastplace_ignore_buftype = {"quickfix", "nofile", "help"},
                lastplace_ignore_filetype = {
                    "gitcommit", "gitrebase", "svn", "hgcommit"
                },
                lastplace_open_folds = true
            }
        end
    }

    --
    -- Search/Replace
    --
    -- Hlsearch Lens for Neovim. Replace incsearch.vim
    use {'kevinhwang91/nvim-hlslens'}

    -- Substitute preview
    use {'osyo-manga/vim-over'}

    --
    -- Copy/Paste
    --
    -- Dynamically show content of vim registers
    use {'gennaro-tedesco/nvim-peekup'}

    -- Handles bracketed-paste-mode in vim (aka. automatic `:set paste`)
    use {'ConradIrwin/vim-bracketed-paste'}

    -- Pasting in Vim with indentation adjusted to destination context
    use {'sickill/vim-pasta'}

    -- seamless integration for vim and tmux's clipboard
    -- Allows to copy between multiple neovim instances
    -- tmux.nvim needs a lot configuration
    use {'roxma/vim-tmux-clipboard'}

    --
    -- Diff/Git
    --
    -- Weapon to fight against conflicts in Vim
    -- [x and ]x mappings are defined as default
    use {'rhysd/conflict-marker.vim'}

    -- Git features and provider for feline
    use {"lewis6991/gitsigns.nvim"}

    --
    -- Text manipulation
    --
    -- Expand selection
    use {'terryma/vim-expand-region'}

    -- Vim plugin, insert or delete brackets, parens, quotes in pair
    use {"windwp/nvim-autopairs"}

    -- Quoting/parenthesizing made simple
    use {'machakann/vim-sandwich'}

    -- Enable repeating supported plugin maps with '.'
    use {'tpope/vim-repeat'}

    -- Vim plugin for intensely nerdy commenting powers
    use {'preservim/nerdcommenter'}

    -- Switch between single-line and multiline forms of code
    -- gS to split a one-liner into multiple lines
    -- gJ (with the cursor on the first line of a block) to join a block into a single-line statement
    -- use 'AndrewRadev/splitjoin.vim'

    --
    -- Completion/LSP
    --
    use {"ray-x/lsp_signature.nvim"}

    -- window for showing LSP detected issues in code
    use {
        "folke/lsp-trouble.nvim",
        config = function() require("plugins.trouble") end,
        cmd = {"LspTrouble"},
        event = "BufRead",
        requires = "kyazdani42/nvim-web-devicons"
    }
    -- lsp status
    use {
        "nvim-lua/lsp-status.nvim",
        config = function() require("plugins.lspStatus") end
    }

    -- fancy popups lsp
    use {"glepnir/lspsaga.nvim", config = require("plugins.lspsaga")}

    -- lsp extensions stuff
    use {
        "onsails/lspkind-nvim",
        config = require("lspkind").init({File = " "})
    }

    -- default configs for lsp and setup lsp
    use {
        "neovim/nvim-lspconfig",
        config = require("plugins.lspconfig").init,
        requires = {
            "nvim-lua/lsp-status.nvim",
            after = {"neovim/nvim-lspconfig"}
        }
    }

    -- completion engine
    use {
        "hrsh7th/nvim-compe",
        event = "InsertEnter",
        config = require("plugins.compe").init
    }

    use {
        "tzachar/compe-tabnine",
        after = "nvim-compe",
        run = "./install.sh",
        requires = "hrsh7th/nvim-compe"
    }

    use {
        "tamago324/compe-zsh",
        after = "nvim-compe",
        requires = "hrsh7th/nvim-compe"
    }

    -- Quickstart configurations for the Nvim LSP client
    -- use {'kabouzeid/nvim-lspinstall'}

    -- Replacing ale, as it's big for just removing whitespaces and do formatting
    use {'ntpeters/vim-better-whitespace'}
    use {'mhartington/formatter.nvim'}

    --
    -- Languages support
    --
    -- lua nvim setup
    use {"folke/lua-dev.nvim"}
    use {'sheerun/vim-polyglot'}

    -- Wisely add if/fi, for/end in several languages
    use {'tpope/vim-endwise'}

    -- bitbake support
    use {'kergoth/vim-bitbake'}

    -- Markdown support
    -- Generate table of contents for Markdown files
    use {'mzlogin/vim-markdown-toc', opt = true}

    --
    -- Snippets
    --
    use {
        "L3MON4D3/LuaSnip",
        config = function() require("plugins.compe.luasnip") end
    }

    --
    -- File modifications
    --
    -- An alternative sudo.vim
    use {'lambdalisue/suda.vim'}

    -- New files created with a shebang line are automatically made executable
    use {'tpope/vim-eunuch'}

    -- File manager
    use {"kyazdani42/nvim-tree.lua"}

    -- A neovim lua plugin to help easily manage multiple terminal windows
    use {'akinsho/nvim-toggleterm.lua'}
end)

--
-- Icons
--
local icons = require("nvim-nonicons")

--
-- nvim-treesitter
--
require("nvim-treesitter.configs").setup({
    ensure_installed = {
        "bash", "c", "comment", "cpp", "dockerfile", "go", "json", "jsonc",
        "lua", "python", "regex", "yaml"
    },
    -- Disabling highlight. Still has problems with shell and other languages
    -- highlight = {enable = false, use_languagetree = true},
    -- indent = {enable = true},
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
        entry_prefix = " ",
        previewer = false,
        set_env = {['COLORTERM'] = 'truecolor'} -- default = nil,
    },
    pickers = {find_files = {previewer = false}}
})

--
-- autopairs
--
require("nvim-autopairs").setup()

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
-- nvim-tree
--

-- 0 by default, will not resize the tree when opening a file
g.nvim_tree_width_allow_resize = 1

g.nvim_tree_icons = {
    default = icons.get("file"),
    symlink = icons.get("file-symlink"),
    git = {
        unstaged = "✗",
        staged = "✓",
        unmerged = "",
        renamed = "➜",
        untracked = "★",
        deleted = "",
        ignored = "◌"
    },
    folder = {
        arrow_open = "",
        arrow_closed = "",
        default = icons.get("file-directory"),
        open = icons.get("file-directory"),
        empty = icons.get("file-directory-outline"),
        empty_open = icons.get("file-directory-outline"),
        symlink = icons.get("file-submodule"),
        symlink_open = icons.get("file-submodule")
    }
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
        lualine_b = {{"branch", icon = ""}, {'filename', path = 1}},
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

local function shfmt()
    return {exe = "shfmt", args = {'-sr', '-i 4', '-ci', '-s'}, stdin = true}
end

local function luaformat() return {exe = 'lua-format', stdin = true} end

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
-- nvim-peekup
--
g.peekup_open = '"'
require('nvim-peekup.config').on_keystroke["paste_reg"] = "\""
require('nvim-peekup.config').on_keystroke["delay"] = ''

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
g.indent_blankline_show_current_context = true
g.indent_blankline_filetype_exclude = {'help', 'make'}
g.indent_blankline_context_patterns = {
    'class', 'function', 'method', 'while', 'closure', 'for'
}
g.indent_blankline_viewport_buffer = 50

--
-- Smartedit
--
g.suda_smart_edit = 1

--
-- snap
--
-- local snap = require("snap")
--
-- local git_file = snap.get"producer.git.file".args {
--     "--cached", "--others", "--exclude-standard"
-- }
--
-- local smart_file =
--     snap.get "consumer.try"(git_file, snap.get "producer.fd.file")
--
-- -- Defaults
-- local function create(config)
--     return snap.create(config, {
--         reverse = true,
--         mappings = {
--             ["next-page"] = {"<C-f>", "<PageDown>"},
--             ["prev-page"] = {"<C-b>", "<PageUp>"}
--         }
--     })
-- end

-- Files
-- snap.register.map("n", "<Space><Space>", create(function()
--     return {
--         producer = snap.get "consumer.fzf"(smart_file),
--         select = snap.get"select.file".select,
--         multiselect = snap.get"select.file".multiselect
--     }
-- end))

-- Grep
-- snap.register.map("n", "<Space>g", create(function()
--     return {
--         producer = snap.get "consumer.limit"(10000,
--                                              snap.get "producer.ripgrep.vimgrep"),
--         select = snap.get"select.vimgrep".select,
--         multiselect = snap.get"select.vimgrep".multiselect,
--         views = {snap.get "preview.vimgrep"}
--     }
-- end))

-- Old files
-- snap.register.map("n", "<Space>of", create(function()
--     return {
--         producer = snap.get "consumer.fzf"(snap.get "producer.vim.oldfile"),
--         select = snap.get"select.file".select,
--         multiselect = snap.get"select.file".multiselect,
--         views = {snap.get "preview.file"}
--     }
-- end))

-- Grep with post-filtering
-- Have missing files issues
-- snap.register.map("n", "<Space>g", create(function()
--     return {
--         producer = snap.get "consumer.limit"(10000,
--                                              snap.get "producer.ripgrep.vimgrep"),
--         steps = {
--             {consumer = snap.get "consumer.fzf", config = {prompt = "FZF>"}}
--         },
--         select = snap.get"select.file".select,
--         multiselect = snap.get"select.file".multiselect,
--         views = {snap.get "preview.file"}
--     }
-- end))

-- Vim help
-- snap.register.map("n", "<Space>h", create(function ()
--   return {
--     prompt = "Help>",
--     producer = snap.get"consumer.fzf"(snap.get"producer.vim.help"),
--     select = snap.get"select.help".select,
--     views = {snap.get"preview.help"},
--   }
-- end))
