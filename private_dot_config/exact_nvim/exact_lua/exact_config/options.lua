if vim.g.vscode then
  return
end

local O = vim.opt
local G = vim.g

-- disable some default providers
G.loaded_perl_provider = 0
G.loaded_ruby_provider = 0
G.root_spec = { "lsp", { ".git", "lua" }, "cwd" }

-- Set filetype to `bigfile` for files larger than 1.5 MB
-- Only vim syntax will be enabled (with the correct filetype)
-- LSP, treesitter and other ft plugins will be disabled.
-- mini.animate will also be disabled.
G.bigfile_size = 1024 * 1024 * 1.5 -- 1.5 MB

--
-- moving around, search and patterns
--
O.ignorecase = true -- Case insensitive searching
O.smartcase = true -- Case sensitivie searching
O.inccommand = "split" -- "for incsearch while sub

--
-- displaying text
--
O.linebreak = true -- Wrap lines at 'breakat'. Do not break words
O.list = true -- Display whitespace characters
-- O.listchars = { tab = "├ ", trail = "·" }
O.listchars = { tab = "› ", trail = "·", extends = "»", precedes = "«", nbsp = "␣" }
O.fillchars = {
  foldopen = "",
  foldclose = "",
  fold = "•",
  foldsep = " ",
  diff = "╱",
  eob = " ",
  msgsep = " ",
  vert = "│",
}
O.number = true -- Show numberline
O.relativenumber = true -- Show relative numberline
O.scrolloff = 16 -- Number of lines to keep above and below the cursor
O.sidescrolloff = 8 -- Number of columns to keep at the sides of the cursor

O.smoothscroll = true

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
-- only set clipboard if not in ssh, to make sure the OSC 52
-- integration works automatically. Requires Neovim >= 0.10.0
O.clipboard = vim.env.SSH_TTY and "" or "unnamedplus" -- Sync with system clipboard

--
-- editing text
--
O.backspace:append({ "nostop" }) -- Don't stop backspace at insert
O.completeopt = "menu,menuone,noselect"
O.infercase = true -- Infer cases in keyword completion
O.pumblend = 10 -- Popup blend
O.pumheight = 10 -- Height of the pop up menu

-- Enable swap, backup, and persistant undo
O.directory = os.getenv("HOME") .. "/.nvim/swap" -- Where to save undofile
O.backupdir = os.getenv("HOME") .. "/.nvim/backup" -- Where to save undofile
O.undodir = os.getenv("HOME") .. "/.nvim/undofile" -- Where to save undofile
O.swapfile = true
O.backup = true
O.undofile = true

-- interval for writing swap file to disk, also used by gitsigns
O.updatetime = 250

-- go to previous/next line with h,l,left arrow and right arrow
-- when cursor reaches end/beginning of line
O.whichwrap:append("<>[]hl")

-- Append backup files with timestamp
vim.api.nvim_create_autocmd("BufWritePre", {
  callback = function()
    local extension = "~" .. vim.fn.strftime("%Y-%m-%d-%H%M%S")
    vim.o.backupext = extension
  end,
})

--
-- tabs and indenting
--
O.expandtab = true -- Enable the use of space in tab
O.softtabstop = 4
O.tabstop = 4 -- Tab width
O.shiftwidth = 4 -- Number of space inserted for indentation
O.breakindent = true -- Wrap indent to match line start
O.copyindent = true -- Copy the previous indentation on autoindenting
O.preserveindent = true -- Preserve indent structure as much as possible
O.smartindent = true -- Smarter autoindentation
O.shiftround = true

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
O.diffopt:append("linematch:200") -- enable linematch diff algorithm
O.diffopt:append("internal")
O.diffopt:append("context:12")
O.diffopt:append("filler")
O.diffopt:append("closeoff")
O.diffopt:append("indent-heuristic")
O.diffopt:append("algorithm:histogram")

--
-- various
--
O.signcolumn = "yes" -- Always show the sign column
O.statuscolumn = [[%!v:lua.require'snacks.statuscolumn'.get()]]
O.viewoptions:remove("curdir") -- disable saving current directory with views
O.virtualedit = "block" -- allow going past end of line in visual block mode
O.smoothscroll = true

O.wildmode = "longest:full,full" -- for : Completion
O.wildignore:append({ "node_modules", "*.pyc" })
O.wildignore:append({
  ".o",
  ".obj",
  ".so",
  ".a",
  ".lib",
  ".pyc",
  ".pyo",
  ".pyd",
  ".swp",
  ".swo",
  ".git",
  ".orig",
})

--
-- fold
--
---@diagnostic disable-next-line: unused-local
local M = {}

-- optimized treesitter foldexpr for Neovim >= 0.10.0
---@diagnostic disable-next-line: unused-function
---@diagnostic disable-next-line: unused-local
function M.foldexpr()
  local buf = vim.api.nvim_get_current_buf()
  if vim.b[buf].ts_folds == nil then
    -- as long as we don't have a filetype, don't bother
    -- checking if treesitter is available (it won't)
    if vim.bo[buf].filetype == "" then
      return "0"
    end
    vim.b[buf].ts_folds = pcall(vim.treesitter.get_parser, buf)
  end
  return vim.b[buf].ts_folds and vim.treesitter.foldexpr() or "0"
end

O.foldcolumn = "1"
O.foldmethod = "expr"
O.foldtext = ""
O.foldexpr = "v:lua.M.foldexpr()"

-- Required by Obisidian-nvim
O.conceallevel = 2

O.sessionoptions = { "buffers", "curdir", "tabpages", "winsize", "help", "globals", "skiprtp", "folds" }

O.formatoptions = "jcroqlnt" -- tcqj
