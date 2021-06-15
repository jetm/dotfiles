local lsp = require('feline.providers.lsp')
local vi_mode_utils = require('feline.providers.vi_mode')

local properties = {
    force_inactive = {
        filetypes = {},
        buftypes = {},
        bufnames = {}
    }
}

local components = {
    left = {active = {}, inactive = {}},
    mid = {active = {}, inactive = {}},
    right = {active = {}, inactive = {}}
}

local colors = {
    black       = "#282c34",
    white       = "#abb2bf",
    red         = "#e06c75",
    maroon      = "#be5046",
    green       = "#98c379",
    yellow      = "#e5c07b",
    orange      = "#d19a66",
    blue        = "#61afef",
    magenta     = "#c678dd",
    cyan        = "#56b6c2",
    grey        = "#5c6370",
    gutter_grey = "#3f4952",
    light_grey  = "#2C323C",
}

local vi_mode_colors = {
    NORMAL = 'green',
    OP = 'green',
    INSERT = 'red',
    VISUAL = 'skyblue',
    BLOCK = 'skyblue',
    REPLACE = 'violet',
    ['V-REPLACE'] = 'violet',
    ENTER = 'cyan',
    MORE = 'cyan',
    SELECT = 'orange',
    COMMAND = 'green',
    SHELL = 'green',
    TERM = 'green',
    NONE = 'yellow'
}

local vi_mode_text = {
    NORMAL = '<|',
    OP = '<|',
    INSERT = '|>',
    VISUAL = '<>',
    BLOCK = '<>',
    REPLACE = '<>',
    ['V-REPLACE'] = '<>',
    ENTER = '<>',
    MORE = '<>',
    SELECT = '<>',
    COMMAND = '<|',
    SHELL = '<|',
    TERM = '<|',
    NONE = '<>'
}

local buffer_not_empty = function()
    if vim.fn.empty(vim.fn.expand('%:t')) ~= 1 then
        return true
    end
    return false
end

local checkwidth = function()
    local squeeze_width  = vim.fn.winwidth(0) / 2
    if squeeze_width > 40 then
        return true
    end
    return false
end

properties.force_inactive.filetypes = {
    'NvimTree',
    'dbui',
}

properties.force_inactive.buftypes = {
    'terminal'
}

-- LEFT

-- vi-symbol
components.left.active[1] = {
    provider = function()
        return vi_mode_text[vi_mode_utils.get_vim_mode()]
    end,
    hl = function()
        local val = {}
        val.fg = vi_mode_utils.get_mode_color()
        val.bg = 'bg'
        val.style = 'bold'
        return val
    end,
    right_sep = {
        str = ' ',
        hl = { bg = 'gutter_gray' },
    },
}

local function file_readonly()
    if vim.bo.filetype == 'help' then
        return ''
    end

    if vim.bo.readonly == true then
        return '  '
    end

    return ''
end

local function get_current_file_name()
    local file = vim.api.nvim_exec([[
        if winwidth(0) < 50
            echo expand('%:t')
        elseif winwidth(0) > 150
            echo expand('%')
        else
            echo pathshorten(expand('%'))
        endif
    ]], true)

    if vim.fn.empty(file) == 1 then
        return ''
    end

    if string.len(file_readonly()) ~= 0 then
        return file .. file_readonly()
    end

    if vim.bo.modifiable then
        if vim.bo.modified then
            return file .. '  '
        end
    end

    return file .. ' '
end

components.left.active[2] = {
    provider = get_current_file_name,
    hl = {
        fg = 'white',
        bg = 'bg',
        style = 'bold'
    },
    right_sep = {
        str = ' ',
        hl = { bg = 'gutter_gray' },
    },
}
-- gitBranch
components.left.active[3] = {
    provider = 'git_branch',
    hl = {
        fg = 'yellow',
        bg = 'bg',
        style = 'bold'
    }
}
-- diffAdd
components.left.active[4] = {
    provider = 'git_diff_added',
    hl = {
        fg = 'green',
        bg = 'bg',
        style = 'bold'
    }
}
-- diffModfified
components.left.active[5] = {
    provider = 'git_diff_changed',
    hl = {
        fg = 'orange',
        bg = 'bg',
        style = 'bold'
    }
}
-- diffRemove
components.left.active[6] = {
    provider = 'git_diff_removed',
    hl = {
        fg = 'red',
        bg = 'bg',
        style = 'bold'
    }
}

-- MID

-- LspName
components.mid.active[1] = {
    provider = 'lsp_client_names',
    hl = {
        fg = 'yellow',
        bg = 'bg',
        style = 'bold'
    },
    right_sep = {
        str = ' ',
        hl = { bg = 'gutter_gray' },
    },
}
-- diagnosticErrors
components.mid.active[2] = {
    provider = 'diagnostic_errors',
    enabled = function() return lsp.diagnostics_exist('Error') end,
    hl = {
        fg = 'red',
        bg = 'bg',
        style = 'bold'
    }
}
-- diagnosticWarn
components.mid.active[3] = {
    provider = 'diagnostic_warnings',
    enabled = function() return lsp.diagnostics_exist('Warning') end,
    hl = {
        fg = 'yellow',
        bg = 'bg',
        style = 'bold'
    }
}
-- diagnosticHint
components.mid.active[4] = {
    provider = 'diagnostic_hints',
    enabled = function() return lsp.diagnostics_exist('Hint') end,
    hl = {
        fg = 'cyan',
        bg = 'bg',
        style = 'bold'
    }
}
-- diagnosticInfo
components.mid.active[5] = {
    provider = 'diagnostic_info',
    enabled = function() return lsp.diagnostics_exist('Information') end,
    hl = {
        fg = 'skyblue',
        bg = 'bg',
        style = 'bold'
    }
}

-- RIGHT

-- fileIcon
components.right.active[1] = {
    provider = function()
        local filename = vim.fn.expand('%:t')
        local extension = vim.fn.expand('%:e')
        local icon  = require'nvim-web-devicons'.get_icon(filename, extension)
        if icon == nil then
            icon = ''
        end
        return icon
    end,
    hl = function()
        local val = {}
        local filename = vim.fn.expand('%:t')
        local extension = vim.fn.expand('%:e')
        local icon, name  = require'nvim-web-devicons'.get_icon(filename, extension)
        if icon ~= nil then
            val.fg = vim.fn.synIDattr(vim.fn.hlID(name), 'fg')
        else
            val.fg = 'white'
        end
        val.bg = 'bg'
        val.style = 'bold'
        return val
    end,
    right_sep = {
        str = ' ',
        hl = { bg = 'gutter_gray' },
    },
}
-- fileType
components.right.active[2] = {
    provider = 'file_type',
    hl = function()
        local val = {}
        local filename = vim.fn.expand('%:t')
        local extension = vim.fn.expand('%:e')
        local icon, name  = require'nvim-web-devicons'.get_icon(filename, extension)
        if icon ~= nil then
            val.fg = vim.fn.synIDattr(vim.fn.hlID(name), 'fg')
        else
            val.fg = 'white'
        end
        val.bg = 'bg'
        val.style = 'bold'
        return val
    end,
    right_sep = {
        str = ' ',
        hl = { bg = 'gutter_gray' },
    },
}

local function file_osinfo()
    local os = vim.bo.fileformat:upper()
    local icon
    if os == 'UNIX' then
        icon = ' '
    elseif os == 'MAC' then
        icon = ' '
    else
        icon = ' '
    end
    return icon .. os
end

-- fileFormat
components.right.active[3] = {
    provider = file_osinfo,
    hl = {
        fg = 'white',
        bg = 'bg',
        style = 'bold'
    },
    right_sep = {
        str = ' ',
        hl = { bg = 'gutter_gray' },
    },
}
-- fileEncode
components.right.active[4] = {
    provider = 'file_encoding',
    hl = {
        fg = 'white',
        bg = 'bg',
        style = 'bold'
    },
    right_sep = {
        str = ' ',
        hl = { bg = 'gutter_gray' },
    },
}
-- lineInfo
components.right.active[5] = {
    provider = 'position',
    hl = {
        fg = 'white',
        bg = 'bg',
        style = 'bold'
    },
    right_sep = {
        str = ' ',
        hl = { bg = 'gutter_gray' },
    },
}
-- linePercent
components.right.active[6] = {
    provider = 'line_percentage',
    hl = {
        fg = 'white',
        bg = 'bg',
        style = 'bold'
    },
    right_sep = {
        str = ' ',
        hl = { bg = 'gutter_gray' },
    },
}
-- scrollBar
components.right.active[7] = {
    provider = 'scroll_bar',
    hl = {
        fg = 'yellow',
        bg = 'bg',
    },
}

-- INACTIVE

-- fileType
components.left.inactive[1] = {
    provider = 'file_type',
    hl = {
        fg = 'black',
        bg = 'cyan',
        style = 'bold'
    },
    left_sep = {
        str = ' ',
        hl = {
            fg = 'NONE',
            bg = 'cyan'
        }
    },
    right_sep = {
        {
            str = ' ',
            hl = {
                fg = 'NONE',
                bg = 'cyan'
            }
        },
        ' '
    }
}

require('feline').setup({
    default_fg = 'white',
    default_bg = 'gutter_grey',
    colors = colors,
    vi_mode_colors = vi_mode_colors,
    components = components,
    properties = properties,
})
