return {
  -- Icon set using nonicons for neovim plugins and settings
  {
    "yamatsum/nvim-nonicons",
    lazy = true,
    dependencies = { "nvim-tree/nvim-web-devicons", lazy = true },
  },

  -- Enable opening a file in a given line
  { "wsdjeg/vim-fetch" },
  -- { "lewis6991/fileline.nvim" },

  -- Visualise and resolve merge conflicts in neovim
  -- ]x - move to previous conflict
  -- [x - move to next conflict
  -- co - choose ours
  -- ct - choose theirs
  -- cb - choose both
  -- c0 - choose none
  {
    "akinsho/git-conflict.nvim",
    lazy = false,
    config = function()
      require("git-conflict").setup({
        default_mappings = true,
        disable_diagnostics = true,
      })
    end,
  },

  -- Add/change/delete surrounding delimiter pairs with ease
  {
    "kylechui/nvim-surround",
    event = "VeryLazy",
    config = true,
  },

  -- Enable repeating supported plugin maps with '.'
  { "tpope/vim-repeat", lazy = true },

  -- enhanced increment/decrement plugin for Neovim
  { "monaqa/dial.nvim", lazy = true },

  -- Removes trailing whitespace from *modified* lines on save
  { "cappyzawa/trim.nvim", lazy = true, config = true },

  -- Disabled. Overwritten autocmds. Need more work
  -- { "sheerun/vim-polyglot" },

  -- Wisely add if/fi, for/end in several languages
  { "tpope/vim-endwise" },

  -- bitbake support
  { "kergoth/vim-bitbake", lazy = true },

  -- Markdown support
  -- Generate table of contents for Markdown files
  -- { "mzlogin/vim-markdown-toc" },

  -- New files created with a shebang line are automatically made executable
  { "tpope/vim-eunuch" },

  -- YAML syntax support
  {
    "cuducos/yaml.nvim",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
    },
  },

  -- Jinja2 syntax support
  {
    "glench/vim-jinja2-syntax",
    event = { "BufReadPre", "BufNewFile" },
  },

  -- A pretty diagnostics, references, telescope results, quickfix and location
  -- list to help you solve all the trouble your code is causing.
  {
    "folke/trouble.nvim",
    cmd = { "TroubleToggle", "Trouble" },
    dependencies = "nvim-tree/nvim-web-devicons",
    config = true,
    lazy = true,
  },

  -- Automatically manage hlsearch setting
  { "asiryk/auto-hlsearch.nvim", config = true, lazy = true },

  -- Automatic indentation style detection for Neovim
  { "nmac427/guess-indent.nvim", config = true },

  -- add neovim in browser
  {
    "glacambre/firenvim",

    -- Lazy load firenvim
    -- Explanation: https://github.com/folke/lazy.nvim/discussions/463#discussioncomment-4819297
    cond = not not vim.g.started_by_firenvim,
    build = function()
      require("lazy").load({ plugins = "firenvim", wait = true })
      vim.fn["firenvim#install"](0)
    end,
    config = function()
      vim.g.firenvim_config = {
        globalSettigs = {
          alt = "all",
        },
        localSettings = {
          [".*"] = {
            cmdline = "neovim",
            content = "text",
            priority = 0,
            selector = "div",
            takeover = "never",
          },
        },
      }
    end,
  },

  -- Peek lines just when you intend
  {
    "nacro90/numb.nvim",
    config = true,
  },

  -- Search and Replace
  {
    "Usuim/searchbox.nvim",
    dependencies = {
      "MunifTanjim/nui.nvim",
    },
  },
}
