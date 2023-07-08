-- Indent guides on blank lines for Neovim
local M = {
  "lukas-reineke/indent-blankline.nvim",
  event = { "BufReadPost", "BufNewFile" },
}

function M.config()
  local ok, indent_blankline = pcall(require, "indent_blankline")
  if not ok then
    error("Loading indent_blankline")
    return
  end

  indent_blankline.setup({
    show_current_context = true,
    show_current_context_start = true,
  })
end

return M
