local M = {
  "olimorris/onedarkpro.nvim",
  lazy = false,
  -- make sure we load this during startup if it is your main colorscheme
  priority = 1000,
}

function M.config()
  local ok, onedarkpro = pcall(require, "onedarkpro")
  if not ok then
    error("Loading onedarkpro")
    return
  end

  onedarkpro.setup({ caching = true })
  vim.cmd.colorscheme("onedark")
end

return M
