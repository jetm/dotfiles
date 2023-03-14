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

  local ok2, icons = pcall(require, "nvim-nonicons")
  if not ok2 then
    error("Loading nvim-nonicons")
    return
  end

  local fn = vim.fn

  local function lsp_servers_status()
    local clients = vim.lsp.buf_get_clients(0)
    if vim.tbl_isempty(clients) then
      return ""
    end

    local client_names = {}
    for _, client in pairs(clients) do
      table.insert(client_names, client.name)
    end

    return icons.get("zap") .. " " .. table.concat(client_names, "|")
  end

  local function lsp_messages()
    local msgs = {}

    for _, msg in ipairs(vim.lsp.util.get_progress_messages()) do
      local content
      if msg.progress then
        content = msg.title
        if msg.message then
          content = content .. " " .. msg.message
        end
        if msg.percentage then
          content = content .. " (" .. msg.percentage .. "%%)"
        end
      elseif msg.status then
        content = msg.content
        if msg.uri then
          local filename = vim.uri_to_fname(msg.uri)
          filename = fn.fnamemodify(filename, ":~:.")
          local space = math.min(60, math.floor(0.6 * fn.winwidth(0)))
          if #filename > space then
            filename = fn.pathshorten(filename)
          end

          content = "(" .. filename .. ") " .. content
        end
      else
        content = msg.content
      end

      table.insert(msgs, "[" .. msg.name .. "] " .. content)
    end

    return table.concat(msgs, " | ")
  end

  lualine.setup({
    options = {
      theme = "auto",
      component_separators = { "", "" },
      section_separators = { "", "" },
      -- enable global statusline (have a single statusline at bottom of
      -- neovim instead of one for  every window)
      globalstatus = true,
    },
    sections = {
      lualine_a = { "mode" },
      lualine_b = { { "branch", icon = "" }, { "filename", path = 1 } },
      lualine_c = {},
      lualine_x = {},
      lualine_y = {
        {
          lsp_messages,
          {
            "diagnostics",
            symbols = {
              error = icons.get("x-circle") .. " ",
              warn = icons.get("alert") .. " ",
              info = icons.get("info") .. " ",
            },
            sources = { "nvim_lsp" },
          },
        },
        { lsp_servers_status },
        {
          "encoding",
          condition = function()
            -- when filencoding="" lualine would otherwise report utf-8 anyways
            return vim.bo.fileencoding
              and #vim.bo.fileencoding > 0
              and vim.bo.fileencoding ~= "utf-8"
          end,
        },
        {
          "fileformat",
          condition = function()
            return vim.bo.fileformat ~= "unix"
          end,
          icons_enabled = false,
        },
        { "filetype", icons_enabled = true },
        { "progress" },
      },
      lualine_z = { { "location" } },
    },
    extensions = { "nvim-tree" },
  })
end

return M
