-- move and duplicate blocks and lines, with complete fold handling,
-- reindent, and undone in one go
local M = {
  "booperlv/nvim-gomove",
}

function M.config()
  local ok, gomove = pcall(require, "gomove")
  if not ok then
    error("Loading gomove")
    return
  end

  gomove.setup({
    -- whether or not to map default key bindings, (true/false)
    map_defaults = true,
    -- whether or not to reindent lines moved vertically (true/false)
    reindent = true,
    -- whether or not to undojoin same direction moves (true/false)
    undojoin = true,
    -- whether to not to move past end column when moving blocks horizontally, (true/false)
    move_past_end_col = false,
  })
end

return M
