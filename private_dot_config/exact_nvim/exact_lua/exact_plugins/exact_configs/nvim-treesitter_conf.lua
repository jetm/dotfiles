return function(_, _)
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
      "diff",
      "dockerfile",
      "go",
      "json",
      "jsonc",
      "lua",
      "luadoc",
      "luap",
      "make",
      "markdown",
      "markdown_inline",
      "ninja",
      "python",
      "regex",
      "rust",
      "toml",
      "vim",
      "vimdoc",
      "yaml",
    },
    highlight = {
      enable = true,
      additional_vim_regex_highlighting = true,
      disable = function(_, bufnr)
        return vim.api.nvim_buf_line_count(bufnr) > 10000
      end,
    },
    indent = {
      enable = true,
      disable = { "gitcommit", "python" },
    },
    textobjects = {
      move = {
        enable = true,
        goto_next_start = { ["]f"] = "@function.outer", ["]c"] = "@class.outer" },
        goto_next_end = { ["]F"] = "@function.outer", ["]C"] = "@class.outer" },
        goto_previous_start = { ["[f"] = "@function.outer", ["[c"] = "@class.outer" },
        goto_previous_end = { ["[F"] = "@function.outer", ["[C"] = "@class.outer" },
      },
    },
  })
end
