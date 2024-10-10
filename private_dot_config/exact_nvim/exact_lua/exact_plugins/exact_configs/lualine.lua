return function(_, _)
  local indent_size = function()
    local bufnr = vim.api.nvim_get_current_buf()
    local indent_type = vim.api.nvim_get_option_value("expandtab", {buf = bufnr}) and "spaces" or "tab"
    local indent_size = vim.api.nvim("tabstop", {buf = bufnr})
    return ("%s: %s"):format(indent_type, indent_size)
  end

  local lualine_require = require("lualine_require")
  lualine_require.require = require

  vim.o.laststatus = vim.g.lualine_laststatus

  return {
    options = {
      theme = "auto",
      globalstatus = true,
      disabled_filetypes = { statusline = { "dashboard", "alpha", "starter", "neo-tree" } },
    },
    sections = {
      lualine_a = { { "fancy_mode", width = 3 } },
      lualine_b = { { "branch" } },

      lualine_c = {
        { "fancy_lsp_servers" },
        { "fancy_diagnostics" },
        { "fancy_filetype" },
        { "ex.cwd" },
        {
          "ex.relative_filename",
          shorten = {
            -- count of letters, which will be taken from every part of the path
            lenght = 1,
          },
        },
      },

      lualine_x = {
        {
          "fancy_diff",
          source = function()
            local gitsigns = vim.b.gitsigns_status_dict
            if gitsigns then
              return {
                added = gitsigns.added,
                modified = gitsigns.changed,
                removed = gitsigns.removed,
              }
            end
          end,
        },
        {
          -- 'encoding': Don't display if encoding is UTF-8
          function()
            local ret, _ = (vim.bo.fenc or vim.go.enc):gsub("^utf%-8$", "")
            return ret
          end,
        },
        {
          -- fileformat: Don't display if unix
          function()
            local ret, _ = vim.bo.fileformat:gsub("^unix$", "")
            return ret
          end,
        },
      },

      lualine_y = {
        indent_size,
      },

      lualine_z = {
        { "ex.progress" },
        { "ex.location", pattern = "%3L:%-2C" },
      },
    },
    extensions = { "neo-tree" },
  }
end
