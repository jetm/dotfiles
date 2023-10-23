local function map(mode, lhs, rhs, opts)
  local keys = require("lazy.core.handler").handlers.keys
  local modes = type(mode) == "string" and { mode } or mode

  modes = vim.tbl_filter(function(m)
    return not (keys.have and keys:have(lhs, m))
  end, modes)

  -- do not create the keymap if a lazy keys handler exists
  if #modes > 0 then
    opts = opts or {}
    opts.silent = opts.silent ~= false
    if opts.remap and not vim.g.vscode then
      ---@diagnostic disable-next-line: no-unknown
      opts.remap = nil
    end
    vim.keymap.set(modes, lhs, rhs, opts)
  end
end

-- Helper save file
map({ "i", "x", "n", "s" }, "<C-s>", "<CMD>w<CR><ESC>", { desc = "Save file" })

-- Clipboard Paste
map("i", "<C-V>", "<CMD>p", { desc = "Clipboard Paste" })

---
-- Movement
---
-- https://github.com/mhinz/vim-galore#saner-behavior-of-n-and-n
-- stylua: off
map("n", "n", "'Nn'[v:searchforward].'zv'", { expr = true, desc = "Next search result" })
map({ "x", "o" }, "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next search result" })
map("n", "N", "'nN'[v:searchforward].'zv'", { expr = true, desc = "Prev search result" })
map({ "x", "o" }, "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev search result" })

-- Allow to use <Ctrl-z> in insert mode to move in the background
map({ "i" }, "<C-z>", "<CMD><C-z>", { desc = "Close editor to background" })

-- Telescope mapping
map("n", "<leader>g", ":Telescope pathogen live_grep<CR>", { desc = "Live Grep" })
map("n", "<C-p>", ":Telescope pathogen find_files<CR>", { desc = "Find files" })

-- BufferLine mapping
for i = 1, 9 do
  map("n", ("<Leader>%s"):format(i), (":BufferLineGoToBuffer %s<CR>"):format(i))
end

-- Visual shifting (does not exit Visual mode)
map({ "v" }, "<", "<gv")
map({ "v" }, ">", ">gv")
map({ "n" }, "<", "<<_")
map({ "n" }, ">", ">>_")

---
-- Buffers
---
-- BufDel/Quitting mapping
map({ "n", "x" }, "q", ":BufDel<CR>", { desc = "Close buffer or Quit" })
map({ "n", "x" }, "Q", "<CMD>qa<CR>", { desc = "Close all buffers and Quit" })

map("n", "<leader>`", "<CMD>e #<CR>", { desc = "Switch to other buffer" })

---
-- Windows
---
-- Resize window using <ctrl> arrow keys
map("n", "<C-Up>", "<CMD>resize +2<CR>", { desc = "Increase window height" })
map("n", "<C-Down>", "<CMD>resize -2<CR>", { desc = "Decrease window height" })
map("n", "<C-Left>", "<CMD>vertical resize -2<CR>", { desc = "Decrease window width" })
map("n", "<C-Right>", "<CMD>vertical resize +2<CR>", { desc = "Increase window width" })

---
-- Search
---
-- Clear search with <ESC>
map({ "i", "n" }, "<ESC>", "<CMD>noh<CR><ESC>", { desc = "Escape and clear hlsearch" })

-- Clear search, diff update and redraw
-- taken from runtime/lua/_editor.lua
map(
  "n",
  "<C-L>",
  "<CMD>nohlsearch<Bar>diffupdate<Bar>normal! <C-L><CR>",
  { desc = "Redraw / clear hlsearch / diff update" }
)

---
-- Diagnostic
---
map({ "n" }, "<leader>l", function()
  require("lint").try_lint()
end, { desc = "Lint Current Buffer" })

map("n", "<leader>d", vim.diagnostic.open_float, { desc = "Line Diagnostics" })

map("n", "<leader>D", "<CMD>lua vim.diagnostic.reset()<CR>", { desc = "clear diagnostics" })
