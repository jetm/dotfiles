-- Must be set before Lazy
-- remap leader key
-- Mapping for both env: CLI and VSCode
local keymap = vim.keymap.set
local keymap_opts = { noremap = true, silent = true }
keymap("n", "<Space>", "", keymap_opts)

-- removes highlighting after escaping vim search
keymap("n", "<Esc>", "<Esc><CMD>noh<CR>", keymap_opts)

-- Visual shifting (does not exit Visual mode)
keymap("v", "<", "<gv")
keymap("v", ">", ">gv")
keymap("n", "<", "<<_")
keymap("n", ">", ">>_")

-- Helper save file
keymap({ "i", "x", "n", "s" }, "<C-s>", "<CMD>w<CR><ESC>", { desc = "Save file" })

if vim.g.vscode then
  local status_ok, fault = pcall(require, "config.vscode_keymaps")
  if not status_ok then
    vim.notify("Failed to load config.vscode_keymaps" .. fault)
  end
else
  local function map(mode, lhs, rhs, opts)
    local modes = type(mode) == "string" and { mode } or mode

    -- do not create the keymap if a lazy keys handler exists
    if #modes > 0 then
      opts = opts or {}
      opts.silent = opts.silent ~= false
      if opts.remap and not vim.g.vscode then
        opts.remap = nil
      end
      vim.keymap.set(modes, lhs, rhs, opts)
    end
  end

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
  map("i", "<C-z>", "<Esc><C-z>", { desc = "Close editor to background" })

  ---
  -- Buffers
  ---
  -- Switching
  map("n", "<leader>`", "<CMD>e #<CR>", { desc = "Switch to previous buffer" })

  -- BufferLine mapping
  for i = 1, 9, 1 do
    map("n", string.format("<Leader>%s", i), function()
      vim.api.nvim_set_current_buf(vim.t.bufs[i])
    end)
  end

  ---
  -- Windows
  ---
  -- Change kitty windows
  map("n", "<C-h>", require("smart-splits").move_cursor_left)
  map("n", "<C-j>", require("smart-splits").move_cursor_down)
  map("n", "<C-k>", require("smart-splits").move_cursor_up)
  map("n", "<C-l>", require("smart-splits").move_cursor_right)

  ---
  -- Search
  ---
  -- Clear search with <ESC>
  map({ "i", "n" }, "<ESC>", "<CMD>noh<CR><ESC>", { desc = "Escape and clear hlsearch" })

  -- Clear search, diff update and redraw
  -- taken from runtime/lua/_editor.lua
  map(
    "n",
    "L",
    "<CMD>nohlsearch<Bar>diffupdate<Bar>normal! <C-L><CR>",
    { desc = "Redraw / clear hlsearch / diff update" }
  )

  -- substitute
  map({ "n", "x" }, "<Leader>s", require("substitute").operator, { noremap = true })
end
