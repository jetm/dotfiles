local M = {
  "ojroques/nvim-bufdel",
}

function M.config()
  local ok, bufdel = pcall(require, "bufdel")
  if not ok then
    error("Loading bufdel")
    return
  end

  bufdel.setup({
    -- or 'cycle, 'alternate'
    next = "tabs",
    -- quit Neovim when last buffer is closed
    quit = true,
  })
end

return M
