return function(_, _)
  local indent_size = function()
    local indent_type = vim.api.nvim_buf_get_option(0, "expandtab") and "spaces" or "tab"
    local indent_size = vim.api.nvim_buf_get_option(0, "tabstop")
    return ("%s: %s"):format(indent_type, indent_size)
  end

  local function root_dir()
    local rootdir
    for dir in vim.fs.parents(vim.api.nvim_buf_get_name(0)) do
      if vim.fn.isdirectory(dir .. "/.git") == 1 then
        rootdir = dir
        break
      end
    end

    if rootdir then
      return "󰉖 /" .. vim.fs.basename(rootdir)
    else
      return ""
    end
  end

  local lualine_require = require("lualine_require")
  lualine_require.require = require

  vim.o.laststatus = vim.g.lualine_laststatus

  local util_lualine = require("config.lualine")

  return {
    options = {
      theme = "auto",
      globalstatus = true,
      disabled_filetypes = { statusline = { "dashboard", "alpha", "starter", "neo-tree" } },
    },
    sections = {
      lualine_a = { { "fancy_mode", width = 3 } },
      lualine_b = { { "fancy_branch" } },

      lualine_c = {
        { "fancy_lsp_servers" },
        root_dir,
        { "fancy_diagnostics" },
        { "fancy_filetype" },
        { util_lualine.pretty_path() },
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
          padding = { left = 0, right = 1 },
        },
        {
          -- fileformat: Don't display if unix
          function()
            local ret, _ = vim.bo.fileformat:gsub("^unix$", "")
            return ret
          end,
          padding = { left = 0, right = 1 },
        },
      },

      lualine_y = {
        indent_size,
        { "progress", separator = " ", padding = { left = 1, right = 0 } },
        { "fancy_location", padding = { left = 0, right = 1 } },
      },
    },
    extensions = { "neo-tree" },
  }
end
