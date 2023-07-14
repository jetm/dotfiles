local M = {
  "phaazon/hop.nvim",
  branch = "v2",
  cmd = { "HopChar2" },
  lazy = false,
}

function M.config()
  local ok, hop = pcall(require, "hop")
  if not ok then
    error("Loading hop")
    return
  end
  local mode = { "n", "x", "o" }
  local directions = require("hop.hint").HintDirection

  local echo = vim.api.nvim_echo
  local noop = function() end

  -- Behave equal to nvim f/F keybinding
  vim.keymap.set(mode, "f", function()
    --disable nvim_echo temporarily
    vim.api.nvim_echo = noop
    hop.hint_char1({
      direction = directions.AFTER_CURSOR,
      current_line_only = true,
    })
  end, { remap = true })

  vim.keymap.set(mode, "F", function()
    vim.api.nvim_echo = noop
    hop.hint_char1({
      direction = directions.BEFORE_CURSOR,
      current_line_only = true,
    })
  end, { remap = true })

  -- Search everywhere for two characters
  yet.map({ "n", "x", "o" }, "s", "<Cmd>HopChar2<CR>", { silent = true })

  hop.setup({})

  if vim.api.nvim_echo == noop then
    vim.api.nvim_echo = echo
  end
end

return M
