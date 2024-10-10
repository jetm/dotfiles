-- This file needs to have same structure as nvconfig.lua
-- https://github.com/NvChad/ui/blob/v3.0/lua/nvconfig.lua
-- Please read that file to know all available options :(

local M = {}
M = {
  ui = {
    cmp = {
      icons_left = true, -- only for non-atom styles!
      lspkind_text = true,
      style = "default", -- default/flat_light/flat_dark/atom/atom_colored
      format_colors = {
        tailwind = false, -- will work for css lsp too
        icon = "󱓻",
      },
    },

    statusline = {
      enabled = true,
      theme = "default", -- default/vscode/vscode_colored/minimal
      -- default/round/block/arrow separators work only for default statusline theme
      -- round and block will work for minimal theme only
      separator_style = "round",
      -- modules = { "mode", "file", "git", "%=", "lsp_msg", "%=", "diagnostics", "lsp", "cwd", "cursor_position" },
      overriden_modules = function()
        local fn = vim.fn
        local sep_l = ""

        return {

          cursor_position = function()
            local line = fn.line(".")
            local col = fn.virtcol(".")

            local chad = string.format(" %d:%d", line, col) .. " │ "

            -- default cursor_position module
            local left_sep = "%#St_pos_sep#" .. sep_l .. "%#St_pos_icon#" .. " "

            local current_line = fn.line(".")
            local total_line = fn.line("$")
            local text = math.modf((current_line / total_line) * 100) .. tostring("%%")
            text = string.format("%4s", text)

            text = (current_line == 1 and "Top") or text
            text = (current_line == total_line and "Bot") or text

            return left_sep .. "%#St_pos_text#" .. chad .. text .. " "
          end,
        }
      end,
    },

    -- lazyload it when there are 1+ buffers
    tabufline = {
      enabled = true,
      lazyload = true,
      order = { "treeOffset", "buffers", "tabs", "btns" },
      modules = nil,
    },
  },

  lsp = { signature = true },

  colorify = {
    enabled = true,
    mode = "virtual", -- fg, bg, virtual
    virt_text = "󱓻 ",
    highlight = { hex = true, lspvars = true },
  },
}

return M
