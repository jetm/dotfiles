yet.key(
  "n",
  "<leader>g",
  ":Telescope pathogen live_grep<CR>",
  { silent = true }
)

yet.key("n", "<C-p>", ":Telescope pathogen find_files<CR>", { silent = true })

-- load it here, otherwise it will fail in config
for i = 1, 5 do
  yet.key(
    "n",
    ("<Leader>%s"):format(i),
    (":BufferLineGoToBuffer %s<CR>"):format(i),
    { silent = true }
  )
end

-- Visual shifting (does not exit Visual mode)
yet.key({ "v" }, "<", "<gv", { silent = true })
yet.key({ "v" }, ">", ">gv", { silent = true })
yet.key({ "n" }, "<", "<<_", { silent = true })
yet.key({ "n" }, ">", ">>_", { silent = true })

-- using keys will not work because keys need to be loaded without
-- lazyness
yet.key({ "n", "x" }, "q", ":BufDel<CR>", { silent = true })
yet.key({ "n", "x" }, "Q", ":BufDelAll<CR>", { silent = true })

--
-- load rest of keymaps here until find a proper place
--
--  Helper for saving file
yet.key({ "n" }, "<C-s>", ":update<CR>", { silent = true })
yet.key({ "v" }, "<C-s>", "<C-c>:update<CR>", { silent = true })
yet.key({ "i" }, "<C-s>", "<C-o>:update<CR>", { silent = true })

-- Clipboard Paste
yet.key("i", "<C-V>", ":lua ClipboardPaste()<CR>p", { silent = true })
