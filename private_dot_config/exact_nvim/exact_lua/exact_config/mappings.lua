local function map(mode, lhs, rhs, opts)
  local keys = require("lazy.core.handler").handlers.keys
  ---@cast keys LazyKeysHandler
  -- do not create the keymap if a lazy keys handler exists
  if not keys.active[keys.parse({ lhs, mode = mode }).id] then
    opts = opts or {}
    opts.silent = opts.silent ~= false
    -- only remap keybinds when running in vscode
    if opts.remap and not vim.g.vscode then
      opts.remap = nil
    end
    vim.keymap.set(mode, lhs, rhs, opts)
  end
end

-- Telescope mapping
map("n", "<leader>g", ":Telescope pathogen live_grep<CR>", { silent = true })
map("n", "<C-p>", ":Telescope pathogen find_files<CR>", { silent = true })

-- BufferLine mapping
for i = 1, 5 do
  map(
    "n",
    ("<Leader>%s"):format(i),
    (":BufferLineGoToBuffer %s<CR>"):format(i),
    { silent = true }
  )
end

-- Visual shifting (does not exit Visual mode)
map({ "v" }, "<", "<gv", { silent = true })
map({ "v" }, ">", ">gv", { silent = true })
map({ "n" }, "<", "<<_", { silent = true })
map({ "n" }, ">", ">>_", { silent = true })

-- BufDel/Quitting mapping
map({ "n", "x" }, "q", ":BufDel<CR>", { silent = true })
map({ "n", "x" }, "Q", ":BufDelAll<CR>", { silent = true })

--  Helper for saving file
map({ "n" }, "<C-s>", ":update<CR>", { silent = true })
map({ "v" }, "<C-s>", "<C-c>:update<CR>", { silent = true })
map({ "i" }, "<C-s>", "<C-o>:update<CR>", { silent = true })

-- Clipboard Paste
map("i", "<C-V>", "<C-o>p", { silent = true })
