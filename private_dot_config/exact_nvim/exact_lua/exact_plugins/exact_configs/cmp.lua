-- Must setup `cmp` after lsp-zero
dofile(vim.g.base46_cache .. "cmp")
local cmp = require("cmp")

local has_words_before = function()
  local line, col = (table.unpack)(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end
local function is_visible(_cmp)
  return _cmp.core.view:visible() or vim.fn.pumvisible() == 1
end

-- local get_icon_provider = function()
--   local _, mini_icons = pcall(require, "mini.icons")
--   if _G.MiniIcons then
--     return function(kind)
--       return mini_icons.get("lsp", kind)
--     end
--   end
-- end
-- local icon_provider = get_icon_provider()

-- local format = function(entry, item)
--   local highlight_colors_avail, highlight_colors = pcall(require, "nvim-highlight-colors")
--   local color_item = highlight_colors_avail and highlight_colors.format(entry, { kind = item.kind })
--   if icon_provider then
--     local icon = icon_provider(item.kind)
--     if icon then
--       item.kind = icon
--     end
--   end
--   if color_item and color_item.abbr_hl_group then
--     item.kind, item.kind_hl_group = color_item.abbr, color_item.abbr_hl_group
--   end
--   return item
-- end

local options = {
  completion = {
    -- this is important
    -- @see https://github.com/hrsh7th/nvim-cmp/discussions/1411
    completeopt = "menuone,noinsert,noselect",
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
      elseif has_words_before() then
        cmp.complete()
      else
        fallback()
      end
    end, { "i", "s" }),
  },
  sources = cmp.config.sources({
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
  -- formatting = { fields = { "kind", "abbr", "menu" }, format = format },
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
