local M = {
  "NvChad/nvim-colorizer.lua",
  lazy = true,
}

function M.config()
  local ok, colorizer = pcall(require, "colorizer")
  if not ok then
    error("Loading colorizer")
    return
  end

  -- Attaches to every FileType mode
  colorizer.setup({ "*" })
end

return M
