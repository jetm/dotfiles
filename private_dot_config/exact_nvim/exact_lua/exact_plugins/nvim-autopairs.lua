-- Vim plugin, insert or delete brackets, parens, quotes in pair
local M = {
  "windwp/nvim-autopairs",
  event = "InsertEnter",
  dependencies = { "nvim-treesitter/nvim-treesitter" },
}

function M.config()
  local ok, nvim_autopairs = pcall(require, "nvim-autopairs")
  if not ok then
    error("Loading nvim-autopairs")
    return
  end

  nvim_autopairs.setup({})

  local ok2, nvim_treesitter_configs = pcall(require, "nvim-treesitter.configs")
  if not ok2 then
    error("Loading nvim-treesitter.configs")
    return
  end

  -- If you want insert `(` after select function or method item
  local cmp_autopairs = require("nvim-autopairs.completion.cmp")
  local cmp = require("cmp")
  cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
end

return M
