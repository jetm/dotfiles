-- Must be set before Lazy
vim.g.mapleader = " "
vim.g.maplocalleader = " "

O = vim.opt -- to set options

--
-- moving around, search and patterns
--
O.ignorecase = true -- Case insensitive searching
O.smartcase = true -- Case sensitivie searching

--
-- displaying text
--
O.linebreak = true -- Wrap lines at 'breakat'. Do not break words
O.list = true -- Display whitespace characters
O.listchars = { tab = "├ ", trail = "·" }
O.number = true -- Show numberline
O.relativenumber = true -- Show relative numberline
O.scrolloff = 16 -- Number of lines to keep above and below the cursor
O.sidescrolloff = 8 -- Number of columns to keep at the sides of the cursor

if vim.fn.has("nvim-0.10") == 1 then
  O.smoothscroll = true
end

--
-- syntax, highlighting and spelling
--
O.cursorline = true -- Highlight the text line of the cursor
O.termguicolors = true -- Enable 24-bit RGB color in the TUI

--
-- multiple windows
--
O.splitbelow = true -- Splitting a new window below the current one
O.splitright = true -- Splitting a new window at the right of the current one

--
-- using the mouse
--
O.mouse = "a" -- Enable mouse support

--
-- message and info
--
O.shortmess:append({ I = true }) -- disable startup message

--
-- selecting clipboard
--
O.clipboard = "unnamedplus" -- Connection to the system clipboard

--
-- editing text
--
O.backspace:append({ "nostop" }) -- Don't stop backspace at insert
O.completeopt = { "menu", "menuone", "noselect" } -- Options for insert mode completion
O.infercase = true -- Infer cases in keyword completion
O.pumheight = 10 -- Height of the pop up menu
O.undodir = os.getenv("HOME") .. "/.vim_data/undofile" -- Where to save undofile
O.undofile = true -- Enable persistent undo

--
-- tabs and indenting
--
O.breakindent = true -- Wrap indent to match line start
O.copyindent = true -- Copy the previous indentation on autoindenting
O.expandtab = true -- Enable the use of space in tab
O.preserveindent = true -- Preserve indent structure as much as possible
O.shiftwidth = 4 -- Number of space inserted for indentation
O.smartindent = true -- Smarter autoindentation
O.softtabstop = 2
O.tabstop = 2 -- Tab width

--
-- multi-byte characters
--
O.fileencoding = "utf-8" -- File content encoding for the buffer

--
-- multiple windows
--
O.laststatus = 3 -- globalstatus

--
-- swap file
--
O.updatetime = 300 -- Length of time to wait before triggering the plugin

--
-- reading and writing files
--
O.writebackup = false -- Disable making a backup before overwriting a file

--
-- diff mode
--
O.diffopt:append("linematch:60") -- enable linematch diff algorithm

--
-- various
--
O.signcolumn = "yes" -- Always show the sign column
O.viewoptions:remove("curdir") -- disable saving current directory with views
O.virtualedit = "block" -- allow going past end of line in visual block mode
