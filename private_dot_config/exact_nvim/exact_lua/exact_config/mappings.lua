--
-- Misc mappings
--
-- quitting mapping
yet.map({ "n", "x" }, "q", ":BufDel<CR>", { silent = true })
yet.map({ "n", "x" }, "Q", ":qa<CR>", { silent = true })

-- Visual shifting (does not exit Visual mode)
yet.map({ "v" }, "<", "<gv", { silent = true })
yet.map({ "v" }, ">", ">gv", { silent = true })
yet.map({ "n" }, "<", "<<_", { silent = true })
yet.map({ "n" }, ">", ">>_", { silent = true })

-- increment/decrement anything
yet.map({ "n", "v" }, "+", "<Plug>(dial-increment)")
yet.map({ "n", "v" }, "-", "<Plug>(dial-increment)")

-- formatter
yet.map(
  { "n" },
  "<leader>f",
  "<cmd>lua vim.lsp.buf.format()<CR>",
  { silent = true }
)

-- Comments
-- Ctrl-/ as VSCode and Jetbrain
yet.map({ "n", "v" }, "<c-_>", "<Plug>NERDCommenterToggle", { silent = true })

--
-- bufferline
--
yet.map({ "n" }, "<leader>1", ":BufferLineGoToBuffer 1<CR>", { silent = true })
yet.map({ "n" }, "<leader>2", ":BufferLineGoToBuffer 2<CR>", { silent = true })
yet.map({ "n" }, "<leader>3", ":BufferLineGoToBuffer 3<CR>", { silent = true })
yet.map({ "n" }, "<leader>4", ":BufferLineGoToBuffer 4<CR>", { silent = true })
yet.map({ "n" }, "<leader>5", ":BufferLineGoToBuffer 5<CR>", { silent = true })
yet.map({ "n" }, "<leader>6", ":BufferLineGoToBuffer 6<CR>", { silent = true })
yet.map({ "n" }, "<leader>7", ":BufferLineGoToBuffer 7<CR>", { silent = true })
yet.map({ "n" }, "<leader>8", ":BufferLineGoToBuffer 8<CR>", { silent = true })
yet.map({ "n" }, "<leader>9", ":BufferLineGoToBuffer 9<CR>", { silent = true })

--
-- Ctrl <C-> Mappings
--
--  Helper for saving file
yet.map({ "n" }, "<C-s>", ":update<CR>", { silent = true })
yet.map({ "v" }, "<C-s>", "<C-c>:update<CR>", { silent = true })
yet.map({ "i" }, "<C-s>", "<C-o>:update<CR>", { silent = true })

yet.map("n", "_", require("oil").open, { desc = "Open parent directory" })

--
-- <F1>..<F12> Mappings
--

-- F5 shows a diagnostics
yet.map({ "n" }, "<F5>", ":TroubleToggle<CR>", { silent = true })
