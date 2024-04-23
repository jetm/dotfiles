return function(_, _)
  local ok, nvim_treesitter = pcall(require, "nvim-treesitter.configs")
  if not ok then
    error("Loading nvim-treesitter.configs")
    return
  end

  require("nvim-treesitter.install").prefer_git = true
  -- require("nvim-treesitter.install").compilers = { "gcc" }

  nvim_treesitter.setup({
    ensure_installed = {
      "cmake",
      "comment",
      "devicetree",
      "diff",
      "dockerfile",
      "git_rebase",
      "gitcommit",
      "go",
      "json",
      "jsonc",
      "kconfig",
      "luadoc",
      "luap",
      "make",
      "markdown_inline",
      "ninja",
      "regex",
      "rust",
      "ssh_config",
      "toml",
      "vim",
      "yaml",
    },
    highlight = {
      -- Getting problem with colors
      enable = false,
      disable = function(_, bufnr)
        return vim.api.nvim_buf_line_count(bufnr) > 10000
      end,
    },
    indent = {
      enable = true,
    },
  })
end
