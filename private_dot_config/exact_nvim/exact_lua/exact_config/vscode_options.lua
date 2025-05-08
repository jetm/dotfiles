local O = vim.opt

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
O.smoothscroll = true
O.laststatus = 2

--
-- syntax, highlighting and spelling
--
O.cursorline = true -- Highlight the text line of the cursor

--
-- multiple windows
--
O.splitbelow = true -- Splitting a new window below the current one
O.splitright = true -- Splitting a new window at the right of the current one

--
-- message and info
--
O.shortmess:append({ I = true }) -- disable startup message

--
-- selecting clipboard
--
vim.g.clipboard = vim.g.vscode_clipboard
O.clipboard:append "unnamedplus"

-- go to previous/next line with h,l,left arrow and right arrow
-- when cursor reaches end/beginning of line
O.wrap = true
O.whichwrap:append("<>[]hl")

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
-- various
--
O.virtualedit = "block" -- allow going past end of line in visual block mode

O.undofile = true
O.undolevels = 1000
O.undolevels = 10000
O.virtualedit = 'block'
O.wildmode = 'longest:full,full'
O.scrolloff = 5

vim.cmd([[
  augroup YankHighlight
    autocmd!
    autocmd TextYankPost * silent! lua vim.highlight.on_yank()
  augroup end
]])
