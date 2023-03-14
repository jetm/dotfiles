-- Indent guides on blank lines for Neovim
local M = {
  "lukas-reineke/indent-blankline.nvim",
  dependencies = { "nvim-treesitter/nvim-treesitter" },
}

function M.config()
  local ok, indent_blankline = pcall(require, "indent_blankline")
  if not ok then
    error("Loading indent_blankline")
    return
  end

  indent_blankline.setup({
    show_current_context = true,
    use_treesitter = true,
    filetype_exclude = { "help", "make", "terminal" },
    context_patterns = {
      "class",
      "function",
      "method",
      "while",
      "closure",
      "for",
    },
    viewport_buffer = 50,
  })
end

return M
