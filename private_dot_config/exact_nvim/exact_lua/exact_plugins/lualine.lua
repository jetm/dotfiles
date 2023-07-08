-- Status line
-- spaceline is slower
-- Galaxyline lacks of nice configurations, like feline has
-- lualine has better structure and theme, it's more like spaceline
-- heirline lacks of OneDark Color scheme
local M = {
  "nvim-lualine/lualine.nvim",
  event = "VeryLazy",
  dependencies = { "nvim-tree/nvim-web-devicons", "navarasu/onedark.nvim" },
}

function M.config()
  local ok, lualine = pcall(require, "lualine")
  if not ok then
    error("Loading lualine")
    return
  end

  local hide_in_width = function()
    return vim.fn.winwidth(0) > 80
  end

  local diagnostics = {
    "diagnostics",
    sources = { "nvim_diagnostic" },
    sections = { "error", "warn" },
    symbols = { error = " ", warn = " " },
    colored = false,
    always_visible = true,
  }

  local diff = {
    "diff",
    colored = false,
    symbols = { added = " ", modified = " ", removed = " " }, -- changes diff symbols
    cond = hide_in_width,
  }

  local filetype = {
    "filetype",
  }

  local location = {
    "location",
    padding = 0,
  }

  local spaces = function()
    return "spaces: " .. vim.api.nvim_buf_get_option(0, "shiftwidth")
  end

  lualine.setup({
    options = {
      icons_enabled = true,
      theme = "onedark",
      component_separators = { left = "", right = "" },
      section_separators = { left = "", right = "" },
      -- enable global statusline (have a single statusline at bottom of
      -- neovim instead of one for  every window)
      globalstatus = true,
      always_divide_middle = true,
    },
    sections = {
      lualine_a = { "mode" },
      lualine_b = { { "branch", icon = "" } },
      lualine_c = { diagnostics },
      lualine_x = { diff, spaces, "encoding", filetype, "fileformat" },
      lualine_y = { location },
      lualine_z = { "progress" },
    },
    inactive_sections = {
      lualine_a = {},
      lualine_b = {},
      lualine_c = { "filename" },
      lualine_x = { "location" },
      lualine_y = {},
      lualine_z = {},
    },
  })
end

return M
