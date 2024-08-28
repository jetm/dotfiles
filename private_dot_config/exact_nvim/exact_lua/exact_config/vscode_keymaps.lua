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
