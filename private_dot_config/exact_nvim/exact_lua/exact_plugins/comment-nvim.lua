-- Vim plugin for intensely nerdy commenting powers
M = {
  "numToStr/Comment.nvim",
  event = { "BufRead", "BufNewFile" },
  opts = {
    mappings = {
      basic = false,
      extra = false,
    },
  }
}

return M
