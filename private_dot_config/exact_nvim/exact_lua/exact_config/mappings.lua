--
-- Misc mappings
--

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
