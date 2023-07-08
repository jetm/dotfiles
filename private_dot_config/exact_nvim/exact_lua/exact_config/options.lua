local o = vim.opt -- to set options

-- Display whitespace characters
o.list = true
o.listchars = { tab = "→ ", trail = "·" }

o.viewoptions:remove("curdir") -- disable saving current directory with views
o.shortmess:append({ s = true, I = true }) -- disable startup message
o.backspace:append({ "nostop" }) -- Don't stop backspace at insert

if vim.fn.has("nvim-0.9") == 1 then
  o.diffopt:append("linematch:60") -- enable linematch diff algorithm
end

o.breakindent = true -- Wrap indent to match  line start
o.clipboard = "unnamedplus" -- Connection to the system clipboard
o.completeopt = { "menu", "menuone", "noselect" } -- Options for insert mode completion
o.copyindent = true -- Copy the previous indentation on autoindenting
o.cursorline = true -- Highlight the text line of the cursor
o.fileencoding = "utf-8" -- File content encoding for the buffer
o.fillchars = { eob = " " } -- Disable `~` on nonexistent lines
o.ignorecase = true -- Case insensitive searching
o.infercase = true -- Infer cases in keyword completion
o.laststatus = 3 -- globalstatus
o.linebreak = true -- Wrap lines at 'breakat'. Do not break words
o.mouse = "a" -- Enable mouse support
o.number = true -- Show numberline
o.relativenumber = true -- Show relative numberline
o.preserveindent = true -- Preserve indent structure as much as possible
o.pumheight = 10 -- Height of the pop up menu
o.scrolloff = 8 -- Number of lines to keep above and below the cursor
o.showtabline = 2 -- always display tabline
o.sidescrolloff = 8 -- Number of columns to keep at the sides of the cursor
o.signcolumn = "yes" -- Always show the sign column
o.smartcase = true -- Case sensitivie searching
o.smartindent = true -- Smarter autoindentation
o.splitbelow = true -- Splitting a new window below the current one
o.splitright = true -- Splitting a new window at the right of the current one
o.expandtab = true -- Enable the use of space in tab
o.shiftwidth = 4 -- Number of space inserted for indentation
o.tabstop = 4 -- Tab width
o.softtabstop = 4
o.termguicolors = true -- Enable 24-bit RGB color in the TUI
o.undofile = true -- Enable persistent undo
o.updatetime = 300 -- Length of time to wait before triggering the plugin
o.virtualedit = "block" -- allow going past end of line in visual block mode
o.wrap = false -- Disable wrapping of lines longer than the width of window
o.writebackup = false -- Disable making a backup before overwriting a file

local g = vim.g -- Global set options
g.mapleader = " " -- set leader key
g.maplocalleader = "," -- set default local leader key
