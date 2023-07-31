local g = vim.g -- Global set options
g.mapleader = " " -- set leader key

local o = vim.opt -- to set options

--
-- moving around, search and patterns
--
o.ignorecase = true -- Case insensitive searching
o.smartcase = true -- Case sensitivie searching

--
-- displaying text
--
o.breakindent = true -- Wrap indent to match line start
o.linebreak = true -- Wrap lines at 'breakat'. Do not break words
o.list = true -- Display whitespace characters
o.listchars = { tab = "→ ", trail = "·" }
o.number = true -- Show numberline
o.relativenumber = true -- Show relative numberline
o.scrolloff = 16 -- Number of lines to keep above and below the cursor
o.sidescrolloff = 8 -- Number of columns to keep at the sides of the cursor

--
-- syntax, highlighting and spelling
--
o.cursorline = true -- Highlight the text line of the cursor
o.termguicolors = true -- Enable 24-bit RGB color in the TUI

--
-- multiple windows
--
o.splitbelow = true -- Splitting a new window below the current one
o.splitright = true -- Splitting a new window at the right of the current one

--
-- using the mouse
--
o.mouse = "a" -- Enable mouse support

--
-- message and info
--
o.shortmess:append({ s = true, I = true }) -- disable startup message

--
-- selecting clipboard
--
o.clipboard = "unnamedplus" -- Connection to the system clipboard

--
-- editing text
--
o.backspace:append({ "nostop" }) -- Don't stop backspace at insert
o.completeopt = { "menu", "menuone", "noselect" } -- Options for insert mode completion
o.infercase = true -- Infer cases in keyword completion
o.pumheight = 10 -- Height of the pop up menu
o.undodir = os.getenv("HOME") .. "/.vim_data/undofile" -- Where to save undofile
o.undofile = true -- Enable persistent undo

--
-- tabs and indenting
--
o.copyindent = true -- Copy the previous indentation on autoindenting
o.expandtab = true -- Enable the use of space in tab
o.fillchars = { eob = " " } -- Disable `~` on nonexistent lines
o.preserveindent = true -- Preserve indent structure as much as possible
o.shiftwidth = 4 -- Number of space inserted for indentation
o.smartindent = true -- Smarter autoindentation
o.softtabstop = 4
o.tabstop = 4 -- Tab width

--
-- multi-byte characters
--
o.fileencoding = "utf-8" -- File content encoding for the buffer

--
-- multiple windows
--
o.laststatus = 3 -- globalstatus

--
-- swap file
--
o.updatetime = 300 -- Length of time to wait before triggering the plugin

--
-- reading and writing files
--
o.writebackup = false -- Disable making a backup before overwriting a file

--
-- diff mode
--
o.diffopt:append("linematch:60") -- enable linematch diff algorithm

--
-- various
--
o.signcolumn = "yes" -- Always show the sign column
o.viewoptions:remove("curdir") -- disable saving current directory with views
o.virtualedit = "block" -- allow going past end of line in visual block mode
