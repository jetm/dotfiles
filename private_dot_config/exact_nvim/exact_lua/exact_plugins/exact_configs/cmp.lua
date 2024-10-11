-- Must setup `cmp` after lsp-zero
dofile(vim.g.base46_cache .. "cmp")
local cmp = require("cmp")

local function is_visible(_cmp)
  return _cmp.core.view:visible() or vim.fn.pumvisible() == 1
end

local options = {
  -- Avoid preselecting one item in completion menu
  -- @see https://github.com/hrsh7th/nvim-cmp/discussions/1411
  preselect = cmp.PreselectMode.None,
  completion = {
    completeopt = "menu,menuone,noselect",
  },
  mapping = {
    ["<Up>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),
    ["<Down>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),

    -- `Enter` key to confirm completion
    ["<CR>"] = cmp.mapping(cmp.mapping.confirm({ select = false }), { "i", "c" }),

    ["<Tab>"] = cmp.mapping(function(fallback)
      if is_visible(cmp) then
        cmp.select_next_item()
      elseif vim.api.nvim_get_mode().mode ~= "c" and vim.snippet and vim.snippet.active({ direction = 1 }) then
        vim.schedule(function()
          vim.snippet.jump(1)
        end)
      else
        fallback()
      end
    end, { "i", "s" }),
  },
  sources = cmp.config.sources({
    { name = "codeium", priority = 80, max_item_count = 3 },
    { name = "nvim_lsp", priority = 70, max_item_count = 3 },
    { name = "luasnip", priority = 60, max_item_count = 3 },
    { name = "buffer", priority = 50, max_item_count = 2 },
    { name = "kitty", priority = 40, max_item_count = 2 },
    {
      name = "rg",
      priority = 30,
      keyword_length = 3,
      max_item_count = 3,
      option = {
        additional_arguments = "--smart-case",
      },
    },
    { name = "async_path", priority = 20, max_item_count = 2 },
  }),
  confirm_opts = {
    behavior = cmp.ConfirmBehavior.Replace,
    select = false,
  },
}

cmp.setup.filetype("gitcommit", {
  sources = cmp.config.sources({
    { name = "spell", max_item_count = 5 },
    { name = "git", max_item_count = 3 },
    {
      name = "buffer",
      max_item_count = 3,
      option = {
        get_bufnrs = function()
          local LIMIT = 1024 * 1024 -- 1 Megabyte max
          local bufs = {}

          for _, buf in ipairs(vim.api.nvim_list_bufs()) do
            local line_count = vim.api.nvim_buf_line_count(buf)
            local byte_size = vim.api.nvim_buf_get_offset(buf, line_count)

            if byte_size < LIMIT then
              bufs[buf] = true
            end
          end

          return vim.tbl_keys(bufs)
        end,
      },
    },
  }),
})

return vim.tbl_deep_extend("force", options, require("nvchad.cmp"))
