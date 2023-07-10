local M = {
  -- File explorer
  "stevearc/oil.nvim",
  cmd = "Oil",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  opts = {
    -- Oil will take over directory buffers (e.g. `vim .` or `:e src/`
    -- Conflict with pathogen
    default_file_explorer = false,
    columns = {
      "icon",
      "permissions",
      "size",
      "mtime",
    },
  },
}

return M
