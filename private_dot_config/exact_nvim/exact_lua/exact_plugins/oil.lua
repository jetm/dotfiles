local M = {
  -- File explorer
  "stevearc/oil.nvim",
  cmd = "Oil",
  event = "BufEnter",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    require("oil").setup({
      -- Oil will take over directory buffers (e.g. `vim .` or `:e src/`
      -- Conflict with pathogen
      default_file_explorer = false,
      columns = {
        "icon",
        "permissions",
        "size",
        "mtime",
      },
    })
  end,
}

return M
