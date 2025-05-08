--
-- Plugins
--

local lazypath = vim.fn.stdpath("data") .. "/lazy-vscode/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end

vim.opt.rtp:prepend(lazypath)

local plugins = {
  { "tpope/vim-repeat" },
  { "echasnovski/mini.move", config = true },
  { "echasnovski/mini.pairs", config = true },
  { "echasnovski/mini.surround", opts = { mappings = { add = "ys" } }, config = true },
}

local lazy_opts = {
  root = vim.fn.stdpath("data") .. "/lazy-vscode",
  lockfile = vim.fn.stdpath("config") .. "/lazy-lock-vscode.json",
  pkg = {
    cache = vim.fn.stdpath("state") .. "/pkg-cache-vscode.lua",
  },
  state = vim.fn.stdpath("state") .. "/state-vscode.json",
}

-- Only load minimal plugin set that works well with VSCode
require("lazy").setup(plugins, lazy_opts)

local keymap = vim.keymap.set
local vscode = require("vscode")
local opts = { noremap = true, silent = true }

-- move text up and down
-- keymap({ "n", "v" }, "<M-j>", function()
--   vscode.action("editor.action.moveLinesDownAction")
-- end)
-- keymap({ "n", "v" }, "<M-k>", function()
--   vscode.action("editor.action.moveLinesUpAction")
-- end)

-- paste preserves primal yanked piece
keymap("v", "p", "\"_dP", opts)

keymap("n", "q", function()
  vscode.action("workbench.action.closeActiveEditor")
end)

keymap({ "n", "x" }, "s", function()
  vscode.call("metaGo.gotoSmart")
end)

keymap({ "n" }, "<leader>RE", function()
  vscode.call("workbench.action.reloadWindow")
end)

-- Format code
keymap({ "n" }, "<leader>f", function()
  vscode.action("editor.action.formatDocument")
end, opts)
keymap({ "n", "v" }, "gq", function()
  vscode.action("rewrap.rewrapComment")
end)
keymap({ "n", "v" }, "=", function()
  vscode.action("editor.action.formatSelection")
end)

keymap("n", "/", function()
  vscode.action("action.Find")
end)

keymap("n", "<C-s>", function()
  vscode.action("workbench.action.files.save")
end)

-- Visual shifting (does not exit Visual mode)
keymap("v", "<", "<gv")
keymap("v", ">", ">gv")
keymap("n", "<", "<<_")
keymap("n", ">", ">>_")

-- Keep cursor at the bottom of visual selection after yanking
keymap("v", "y", "ygv<Esc>", opts)
keymap("n", "Y", "y$", opts)

-- Keep cursor position when joining lines
keymap("n", "J", ":let p=getpos('.')<CR>:join<CR>:call setpos('.', p)<CR>", opts)

-- Keep undo/redo lists in sync with VsCode
keymap("n", "u", "<Cmd>call VSCodeNotify('undo')<CR>")
keymap("n", "<C-r>", "<Cmd>call VSCodeNotify('redo')<CR>")

--
-- Navigation
--
keymap({ "n", "v" }, "<C-j>", function()
  vscode.action("workbench.action.navigateDown")
end)
keymap({ "n", "v" }, "<C-k>", function()
  vscode.action("workbench.action.navigateUp")
end)
keymap({ "n", "v" }, "<C-h>", function()
  vscode.action("workbench.action.navigateLeft")
end)
keymap({ "n", "v" }, "<C-l>", function()
  vscode.action("workbench.action.navigateRight")
end)

--
-- Window Management
--
keymap("n", "<C-w>s", function()
  vscode.action("workbench.action.splitEditorDown")
end)
keymap("n", "<C-w>v", function()
  vscode.action("workbench.action.splitEditorRight")
end)
keymap("n", "<C-w>c", function()
  vscode.action("workbench.action.closeActiveEditor")
end)
keymap("n", "<C-w>=", function()
  vscode.action("workbench.action.evenEditorWidths")
end)

--
-- File Navigation
--
keymap({ "n", "v" }, "<c-p>", function()
  vscode.action("workbench.action.quickOpen")
end)

keymap({ "n", "v" }, "<Leader>ff", function()
  vscode.action("workbench.action.findInFiles")
end)

keymap({ "n", "v" }, "<Leader>e", function()
  vscode.action("workbench.files.action.focusFilesExplorer")
end)

keymap({ "n", "v" }, "gd", function()
  vscode.action("editor.action.revealDefinition")
end)

keymap({ "n", "v" }, "gr", function()
  vscode.action("editor.action.goToReferences")
end)

keymap({ "n", "v" }, "gD", function()
  vscode.action("editor.action.peekDefinition")
end)

keymap({ "n", "v" }, "gi", function()
  vscode.action("editor.action.goToImplementation")
end)

--
-- Tab navigation
--
keymap("n", "<leader>1", function()
  vscode.call("workbench.action.openEditorAtIndex1")
end)
keymap("n", "<leader>2", function()
  vscode.call("workbench.action.openEditorAtIndex2")
end)
keymap("n", "<leader>3", function()
  vscode.call("workbench.action.openEditorAtIndex3")
end)
keymap("n", "<leader>4", function()
  vscode.call("workbench.action.openEditorAtIndex4")
end)
keymap("n", "<leader>5", function()
  vscode.call("workbench.action.openEditorAtIndex5")
end)
keymap("n", "<leader>6", function()
  vscode.call("workbench.action.openEditorAtIndex6")
end)

-- Navigate VSCode tabs like lazyvim buffers
keymap("n", "<S-h>", "<Cmd>call VSCodeNotify('workbench.action.previousEditor')<CR>")
keymap("n", "<S-l>", "<Cmd>call VSCodeNotify('workbench.action.nextEditor')<CR>")

-- Code Actions
keymap({ "n", "v" }, "<Leader>ca", function()
  vscode.action("editor.action.quickFix")
end)

keymap({ "n", "v" }, "<Leader>rn", function()
  vscode.action("editor.action.rename")
end)

keymap({ "n", "v" }, "<Leader>.", function()
  vscode.action("editor.action.quickFix")
end)

keymap({ "n" }, "K", function()
  vscode.action("editor.action.showHover")
end)

-- Search improvements
keymap("n", "<Esc>", "<Esc>:noh<CR>", opts)

-- Problems/Diagnostics
keymap("n", "<Leader>d", function()
  vscode.action("workbench.actions.view.problems")
end)

keymap("n", "<Leader>a", function()
  vscode.action("cody.chat.toggle")
end)
