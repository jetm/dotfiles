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
yet.map({ "n" }, "<c-_>", function()
  return vim.v.count == 0 and "<Plug>(comment_toggle_linewise_current)"
    or "<Plug>(comment_toggle_linewise_count)"
end, { expr = true })

-- Toggle in VISUAL mode
yet.map("x", "<c-_>", "<Plug>(comment_toggle_linewise_visual)")

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

function ClipboardYank()
  vim.cmd('call system("echo\'". @@,"\' | cb copy")')
end

function ClipboardPaste()
  vim.cmd("let @@ = system('cb paste')")
end

-- Clipboard Copy
yet.map("v", "<C-C>", "y:lua ClipboardYank()<cr>gv", { silent = true })
yet.map("n", "<C-C>", "yy:lua ClipboardYank()<cr>", { silent = true })
yet.map("i", "<C-C>", "<c-o>yy<c-o>:lua ClipboardYank()<cr>", { silent = true })

-- Clipboard Cut
yet.map("v", "<C-X>", "x:lua ClipboardYank()<cr>", { silent = true })
yet.map("n", "<C-X>", "dd:lua ClipboardYank()<cr>", { silent = true })
yet.map("i", "<C-X>", "<c-o>dd<c-o>:lua ClipboardYank()<cr>", { silent = true })

-- Clipboard Paste
yet.map("i", "<C-V>", ":lua ClipboardPaste()<cr>p", { silent = true })
yet.map("c", "<C-V>", "<C-R>+")
vim.cmd("exe 'inoremap <script> <C-V>' paste#paste_cmd['i']")
vim.cmd("exe 'vnoremap <script> <C-V>' paste#paste_cmd['v']")

-- Replace
yet.map("i", "<c-l>", "<ESC>:SearchBoxReplace confirm=native<CR>")
yet.map("n", "<c-l>", ":SearchBoxReplace confirm=native<CR>")
yet.map("v", "<c-l>", ":SearchBoxReplace confirm=native<CR>")
