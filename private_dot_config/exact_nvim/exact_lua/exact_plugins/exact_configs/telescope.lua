return function (_,_)
  dofile(vim.g.base46_cache .. "telescope")

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
      path_display = {},
      prompt_prefix = "   ",
      selection_caret = " ",
      entry_prefix = " ",
      sorting_strategy = "ascending",
      initial_mode = "insert",
      layout_config = {
        prompt_position = "top",
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

  telescope.load_extension("fzf")
  -- telescope.load_extension("notify")
end
