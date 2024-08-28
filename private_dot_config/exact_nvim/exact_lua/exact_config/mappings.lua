-- Must be set before Lazy
-- remap leader key
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
    vim.api.nvim_err_writeln("Failed to load config.vscode_keymaps" .. fault)
  end
else
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
        opts.remap = nil
      end
      vim.keymap.set(modes, lhs, rhs, opts)
    end
  end

  -- Clipboard Paste
  -- map("i", "<C-v>", "<Esc>p", { desc = "Clipboard Paste" })

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

  -- Telescope mapping
  map("n", "<C-p>", "<CMD>Telescope find_files<CR>", { desc = "Find files" })
  map("n", "<C-S-p>", "<CMD>Telescope frecency workspace=CWD<CR>", { desc = "Find files" })

  local telescope = require("telescope")
  telescope.load_extension("chezmoi")
  map("n", "<C-c>", telescope.extensions.chezmoi.find_files, { desc = "Find chezmoi files" })

  map("n", "<Leader>b", "<CMD>BufferLinePick<CR>")

  ---
  -- Buffers
  ---
  -- Quitting
  map({ "n", "x" }, "q", "<CMD>BufDel<CR>", { desc = "Close buffer or Quit" })
  map({ "n", "x" }, "Q", "<CMD>qa<CR>", { desc = "Close all buffers and Quit" })

  -- Switching
  map("n", "<leader>`", "<CMD>e #<CR>", { desc = "Switch to other buffer" })

  -- BufferLine mapping
  for i = 1, 9 do
    map("n", ("<Leader>%s"):format(i), ("<CMD>lua require('bufferline').go_to(%s, true)<CR>"):format(i))
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

  ---
  -- Diagnostic
  ---
  map("n", "<leader>l", function()
    require("lint").try_lint()
  end, { desc = "Lint Current Buffer" })

  map("n", "<leader>d", vim.diagnostic.open_float, { desc = "Line Diagnostics" })

  map("n", "<leader>D", "<CMD>lua vim.diagnostic.reset()<CR>", { desc = "clear diagnostics" })
end
