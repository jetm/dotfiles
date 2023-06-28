-- Neovim UI Enhancer
local M = {
  "stevearc/dressing.nvim",
  lazy = true,
}

function M.config()
  local status_ok, dressing = pcall(require, "dressing")
  if not status_ok then
    return
  end

  dressing.setup({})
end

return M
