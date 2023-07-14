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

-- formatter
yet.map(
  { "n" },
  "<leader>f",
  "<cmd>lua vim.lsp.buf.format()<CR>",
  { silent = true }
)

--
-- Ctrl <C-> Mappings
--
--  Helper for saving file
yet.map({ "n" }, "<C-s>", ":update<CR>", { silent = true })
yet.map({ "v" }, "<C-s>", "<C-c>:update<CR>", { silent = true })
yet.map({ "i" }, "<C-s>", "<C-o>:update<CR>", { silent = true })

function ClipboardPaste()
  vim.cmd("let @@ = system('cb paste')")
end

-- Clipboard Paste
yet.map("i", "<C-V>", ":lua ClipboardPaste()<cr>p", { silent = true })
yet.map("c", "<C-V>", "<C-R>+")
vim.cmd("exe 'inoremap <script> <C-V>' paste#paste_cmd['i']")

-- Replace
