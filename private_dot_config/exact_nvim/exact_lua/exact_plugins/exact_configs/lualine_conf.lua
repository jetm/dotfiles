return function(_, opts)
  local diagnostics = {
    "diagnostics",
    sources = { "nvim_diagnostic" },
    sections = { "error", "warn" },
    symbols = { error = " ", warn = " " },
    colored = false,
    always_visible = true,
  }

  local location = {
    "location",
    padding = 0,
  }

  local spaces = function()
    return "spaces: " .. vim.api.nvim_buf_get_option(0, "shiftwidth")
  end

  require("lualine").setup({
    options = {
      icons_enabled = true,
      theme = "onedark",
      component_separators = { left = "", right = "" },
      section_separators = { left = "", right = "" },
      -- enable global statusline (have a single statusline at bottom of
      -- neovim instead of one for every window)
      globalstatus = true,
      always_divide_middle = true,
    },
    sections = {
      lualine_a = { "mode" },
      lualine_b = { "diff" },
      -- lualine_b = { "branch", "diff" },
      lualine_c = { diagnostics },
      lualine_x = { spaces, "encoding", "filetype", "fileformat" },
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
