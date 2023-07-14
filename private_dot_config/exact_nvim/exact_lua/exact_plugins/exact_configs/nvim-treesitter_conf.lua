return function (_, _)
  local ok, nvim_treesitter = pcall(require, "nvim-treesitter.configs")
  if not ok then
    error("Loading nvim-treesitter.configs")
    return
  end

  require("nvim-treesitter.install").prefer_git = true
  -- require("nvim-treesitter.install").compilers = { "gcc" }

  nvim_treesitter.setup({
    version = false,
    ensure_installed = {
      "bash",
      "c",
      "cmake",
      "comment",
      "dockerfile",
      "go",
      "json",
      "lua",
      "make",
      "ninja",
      "python",
      "regex",
      "rust",
      "toml",
      "vim",
      "yaml",
    },
    highlight = {
      enable = true,
      additional_vim_regex_highlighting = true,
      disable = function(_, bufnr)
        return vim.api.nvim_buf_line_count(bufnr) > 10000
      end,
    },
    indent = { enable = true, disable = { "gitcommit", "python" } },
    context_commentstring = { enable = true, enable_autocmd = false },
    incremental_selection = { enable = true },
    matchup = {
      enable = true,
      enable_quotes = true,
    },
  })
end
