local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

-- yank to system clipboard
-- keymap({"n", "v"}, "y", '"+y', opts)

-- paste from system clipboard
-- keymap({"n", "v"}, "<leader>p", '"+p', opts)

-- move text up and down
keymap("v", "<M-j>"," :m .+1<CR>==", opts)
keymap("v", "<M-k>", ":m .-2<CR>==", opts)
keymap("x", "<M-j>", ":move '>+1<CR>gv-gv", opts)
keymap("x", "<M-k>", ":move '<-2<CR>gv-gv", opts)

-- paste preserves primal yanked piece
keymap("v", "p", '"_dP', opts)

keymap({"n", "v"}, "<leader>f", "<cmd>lua require('vscode').action('editor.action.formatDocument')<CR>")
keymap({"n", "v"}, "gq", "<cmd>lua require('vscode').action('rewrap.rewrapComment')<CR>")

-- VSCode-specific keymaps for search and navigation
keymap("n", "<leader><space>", "<cmd>Find<cr>")
keymap("n", "<leader>/", [[<cmd>lua require('vscode').action('workbench.action.findInFiles')<CR>]])
keymap("n", "<leader>ss", [[<cmd>lua require('vscode').action('workbench.action.gotoSymbol')<CR>]])

-- Keep undo/redo lists in sync with VsCode
keymap("n", "u", "<Cmd>call VSCodeNotify('undo')<CR>")
keymap("n", "<C-r>", "<Cmd>call VSCodeNotify('redo')<CR>")

-- Navigate VSCode tabs
keymap("n", "<M-h>", "<Cmd>call VSCodeNotify('workbench.action.previousEditor')<CR>")
keymap("n", "<M-l>", "<Cmd>call VSCodeNotify('workbench.action.nextEditor')<CR>")
