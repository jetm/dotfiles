local M = {
  "nvim-telescope/telescope.nvim",
  cmd = "Telescope",
  version = false,
  dependencies = {
    {
      "nvim-telescope/telescope-fzf-native.nvim",
      enabled = vim.fn.executable("make") == 1,
      build = "make",
    },
    { "yamatsum/nvim-nonicons" },
    { "nvim-lua/popup.nvim" },
    { "nvim-lua/plenary.nvim" },
    { "brookhong/telescope-pathogen.nvim" },
    { "rcarriga/nvim-notify" },
  },
  keys = {
    { "<space>g", ":Telescope pathogen live_grep<CR>", silent = true },
    { "<C-p>", ":Telescope pathogen find_files<CR>", silent = true },
  },
}

function M.config()
  local ok, telescope = pcall(require, "telescope")
  if not ok then
    error("Loading telescope")
    return
  end

  local ok2, telescope_actions = pcall(require, "telescope.actions")
  if not ok2 then
    error("Loading telescope.actions")
    return
  end

  telescope.setup({
    defaults = {
      mappings = {
        n = { q = telescope_actions.close },
      },
      prompt_prefix = "🔍 ",
      selection_caret = "  ",
      initial_mode = "insert",
      path_display = {},
      layout_config = {
        horizontal = { preview_width = 0.55 },
        vertical = { mirror = false },
        height = 0.95,
        width = 0.95,
      },
      color_devicons = true,
      use_less = true,
      set_env = { ["COLORTERM"] = "truecolor" }, -- default = nil,
    },
  })

  telescope.load_extension("pathogen")
  vim.keymap.set(
    "v",
    "<space>g",
    require("telescope").extensions["pathogen"].live_grep
  )

  telescope.load_extension("fzf")
  telescope.load_extension("notify")
end

return M
