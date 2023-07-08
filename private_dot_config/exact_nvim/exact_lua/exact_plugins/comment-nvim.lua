-- Vim plugin for intensely nerdy commenting powers
local M = {
  'numToStr/Comment.nvim',
  event = {"BufRead", "BufNewFile"},
}

function M.config()
  local ok, comment = pcall(require, "Comment")
  if not ok then
    error("Loading comment")
    return
  end

  comment.setup({
    mappings = {
        basic = false,
        extra = false,
    },
  })
end

return M
