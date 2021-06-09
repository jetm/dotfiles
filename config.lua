local nvim_lsp = require("lspconfig")

local on_attach = function(client, bufnr)
    -- LSP completion icons {{{
    require("vim.lsp.protocol").CompletionItemKind = {
        -- https://github.com/hrsh7th/nvim-compe/issues/135#issuecomment-773522031
        "", -- Text          = 1;
        "", -- Method        = 2;
        "ƒ", -- Function      = 3;
        "", -- Constructor   = 4;
        "識", -- Field         = 5;
        "勇", -- Variable      = 6;
        "", -- Class         = 7;
        "ﰮ", -- Interface     = 8;
        "", -- Module        = 9;
        "", -- Property      = 10;
        "", -- Unit          = 11;
        "", -- Value         = 12;
        "了", -- Enum          = 13;
        "", -- Keyword       = 14;
        "﬌", -- Snippet       = 15;
        "", -- Color         = 16;
        "", -- File          = 17;
        "渚", -- Reference     = 18;
        "", -- Folder        = 19;
        "", -- EnumMember    = 20;
        "", -- Constant      = 21;
        "", -- Struct        = 22;
        "鬒", -- Event         = 23;
        "Ψ", -- Operator      = 24;
        "", -- TypeParameter = 25;
    }
end

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
    vim.lsp.diagnostic.on_publish_diagnostics, {
        virtual_text = {
            spacing = 2,
            prefix = " ■",
            severity_limit = "Warning",
        },
        severity_sort = true,
    }
)

local lua_settings = {
    runtime = {
        -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
        version = "LuaJIT",
        -- Setup your lua path
        path = vim.split(package.path, ";"),
    },
    diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = { "vim" },
    },
    workspace = {
        -- Make the server aware of Neovim runtime files
        library = {
            [vim.fn.expand("$VIMRUNTIME/lua")] = true,
            [vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true,
        },
    },
}

-- nvim-compe
vim.o.completeopt = "menuone,noselect"

require("compe").setup(
    {
        enabled = true,
        -- auto open popup
        autocomplete = true,
        debug = false,
        -- min chars to trigger completion on
        min_length = 3,
        preselect = "enable",
        throttle_time = 80,
        source_timeout = 200,
        incomplete_delay = 400,
        max_abbr_width = 100,
        max_kind_width = 100,
        max_menu_width = 100,
        documentation = true,

        source = {
            path = true,
            buffer = {kind = "﬘", true},
            nvim_lsp = true,
            nvim_lua = true,
            ultisnips = {kind = "﬌", true},
            vsnip = {kind = "﬌", true},
            tabnine = {
                max_line = 1000,
                max_num_results = 6,
                sort = false,
                priority = 1,
                show_prediction_strength = false,
            },
        },
    }
)

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
-- nvim-treesitter
--
require("nvim-treesitter.configs").setup(
    {
        highlight = { enable = true },
        incremental_selection = {
            enable = true,
            keymaps = {
                init_selection = "gnn",
                node_incremental = "gnn",
                scope_incremental = "gns",
                node_decremental = "gnN",
            },
        },
        indent = { enable = true },
    }
)

-- telescope
local actions = require("telescope.actions")
require("telescope").setup(
    {
        set_env = { ['COLORTERM'] = 'truecolor' }
    }
)

-- autopairs
require("nvim-autopairs").setup()

local remap = vim.api.nvim_set_keymap
local npairs = require('nvim-autopairs')

-- skip it, if you use another global object
_G.MUtils= {}

vim.g.completion_confirm_key = ""
MUtils.completion_confirm=function()
  if vim.fn.pumvisible() ~= 0  then
    if vim.fn.complete_info()["selected"] ~= -1 then
      return vim.fn["compe#confirm"](npairs.esc("<cr>"))
    else
      return npairs.esc("<cr>")
    end
  else
    return npairs.autopairs_cr()
  end
end

remap('i' , '<CR>','v:lua.MUtils.completion_confirm()', {expr = true , noremap = true})

-- colorizer
-- Attaches to every FileType mode
require("colorizer").setup()

-- barbar
vim.g.bufferline = {
    icons = 'both'
}

-- galaxyline
local gl = require("galaxyline")
local gls = gl.section
local condition = require("galaxyline.condition")

gl.short_line_list = {" "}

local colors = {
    bg = "#22262e",
    fg = "#abb2bf",
    green = "#97C378",
    red = "#d47d85",
    lightbg = "#2d3139",
    lightbg2 = "#262a32",
    blue = "#81A1C1",
    yellow = "#e0c080",
    grey = "#6f737b"
}

gls.left[2] = {
    statusIcon = {
        provider = function()
            return "   "
        end,
        highlight = {colors.bg, colors.blue},
        separator = "  ",
        separator_highlight = {colors.blue, colors.lightbg}
    }
}

gls.left[3] = {
    FileIcon = {
        provider = "FileIcon",
        condition = condition.buffer_not_empty,
        highlight = {colors.fg, colors.lightbg}
    }
}

gls.left[4] = {
    FileName = {
        provider = {"FileName"},
        condition = condition.buffer_not_empty,
        highlight = {colors.fg, colors.lightbg},
        separator = " ",
        separator_highlight = {colors.lightbg, colors.lightbg2}
    }
}

gls.left[5] = {
    current_dir = {
        provider = function()
            local dir_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":t")
            return "  " .. dir_name .. " "
        end,
        highlight = {colors.grey, colors.lightbg2},
        separator = " ",
        separator_highlight = {colors.lightbg2, colors.bg}
    }
}

local checkwidth = function()
    local squeeze_width = vim.fn.winwidth(0) / 2
    if squeeze_width > 30 then
        return true
    end
    return false
end

gls.left[6] = {
    DiffAdd = {
        provider = "DiffAdd",
        condition = checkwidth,
        icon = "  ",
        highlight = {colors.fg, colors.bg}
    }
}

gls.left[7] = {
    DiffModified = {
        provider = "DiffModified",
        condition = checkwidth,
        icon = "   ",
        highlight = {colors.grey, colors.bg}
    }
}

gls.left[8] = {
    DiffRemove = {
        provider = "DiffRemove",
        condition = checkwidth,
        icon = "  ",
        highlight = {colors.grey, colors.bg}
    }
}

gls.left[9] = {
    DiagnosticError = {
        provider = "DiagnosticError",
        icon = "  ",
        highlight = {colors.red, colors.bg}
    }
}

gls.left[10] = {
    DiagnosticWarn = {
        provider = "DiagnosticWarn",
        icon = "  ",
        highlight = {colors.yellow, colors.bg}
    }
}

gls.right[1] = {
    lsp_status = {
        provider = function(msg)
            msg = msg or "No Active Lsp"
            local clients = vim.lsp.get_active_clients()
            if next(clients) ~= nil then
                return " " .. "  " .. " active "
            else
                return ""
            end
        end,
        highlight = {colors.grey, colors.bg}
    }
}

gls.right[2] = {
    GitIcon = {
        provider = function()
            return " "
        end,
        condition = require("galaxyline.provider_vcs").check_git_workspace,
        highlight = {colors.grey, colors.lightbg},
        separator = "",
        separator_highlight = {colors.lightbg, colors.bg}
    }
}

gls.right[3] = {
    GitBranch = {
        provider = "GitBranch",
        condition = require("galaxyline.provider_vcs").check_git_workspace,
        highlight = {colors.grey, colors.lightbg}
    }
}

gls.right[4] = {
    viMode_icon = {
        provider = function()
            return " "
        end,
        highlight = {colors.bg, colors.red},
        separator = " ",
        separator_highlight = {colors.red, colors.lightbg}
    }
}

gls.right[5] = {
    ViMode = {
        provider = function()
            local alias = {
                n = "Normal",
                i = "Insert",
                c = "Command",
                V = "Visual",
                [""] = "Visual",
                v = "Visual",
                R = "Replace"
            }
            local current_Mode = alias[vim.fn.mode()]

            if current_Mode == nil then
                return "  Terminal "
            else
                return "  " .. current_Mode .. " "
            end
        end,
        highlight = {colors.red, colors.lightbg}
    }
}

gls.right[6] = {
    some_icon = {
        provider = function()
            return " "
        end,
        separator = "",
        separator_highlight = {colors.green, colors.lightbg},
        highlight = {colors.lightbg, colors.green}
    }
}

gls.right[7] = {
    line_percentage = {
        provider = function()
            local current_line = vim.fn.line(".")
            local total_line = vim.fn.line("$")

            if current_line == 1 then
                return "  Top "
            elseif current_line == vim.fn.line("$") then
                return "  Bot "
            end
            local result, _ = math.modf((current_line / total_line) * 100)
            return "  " .. result .. "% "
        end,
        highlight = {colors.green, colors.lightbg}
    }
}

-- git
require('gitsigns').setup()

-- Neoscroll
require('neoscroll').setup()
