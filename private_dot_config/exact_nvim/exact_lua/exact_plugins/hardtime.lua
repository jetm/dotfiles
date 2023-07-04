-- Neovim UI Enhancer
local M = {
  "m4xshen/hardtime.nvim",
  dependencies = "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
}

function M.config()
  local status_ok, hardtime = pcall(require, "hardtime")
  if not status_ok then
    return
  end

  hardtime.setup({
    disable_mouse = false,
    restricted_keys = {
      ["h"] = { "n", "v" },
      ["j"] = { "n", "v" },
      ["k"] = { "n", "v" },
      ["l"] = { "n", "v" },
      ["gj"] = { "n", "v" },
      ["gk"] = { "n", "v" },
      ["<CR>"] = { "n", "v" },
    },
  })

  vim.cmd("Hardtime enable")
end

return M
