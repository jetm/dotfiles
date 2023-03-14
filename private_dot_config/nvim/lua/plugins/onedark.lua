local M = {
  "navarasu/onedark.nvim",
  -- make sure we load this during startup if it is your main colorscheme
  priority = 1000,
}

function M.config()
  local ok, onedark = pcall(require, "onedark")
  if not ok then
    error("Loading onedark")
    return
  end

  onedark.setup({
    style = "dark",
  })

  onedark.load()
end

return M
