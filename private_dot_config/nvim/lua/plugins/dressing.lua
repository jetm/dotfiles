-- Neovim UI Enhancer
local M = {
  "stevearc/dressing.nvim",
}

function M.config()
  local status_ok, dressing = pcall(require, "dressing")
  if not status_ok then
    return
  end

  dressing.setup({
    input = {
      default_prompt = "➤ ",
      win_options = { winhighlight = "Normal:Normal,NormalNC:Normal" },
    },
    select = {
      backend = { "telescope", "builtin" },
      win_options = { winhighlight = "Normal:Normal,NormalNC:Normal" },
    },
  })
end

return M
