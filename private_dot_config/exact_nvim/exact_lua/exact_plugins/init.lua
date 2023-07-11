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
    event = { "BufReadPre", "BufNewFile" },
    config = true,
  },

  -- Enable repeating supported plugin maps with '.'
  { "tpope/vim-repeat", lazy = true },

  -- enhanced increment/decrement plugin for Neovim
  -- { "monaqa/dial.nvim", lazy = true },

  -- Removes trailing whitespace from *modified* lines on save
  { "cappyzawa/trim.nvim", event = "BufWritePre", config = true },

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
  -- {
  --   "Darazaki/indent-o-matic",
  --   event = { "BufReadPre", "BufNewFile" },
  --   config = true,
  -- },

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
    lazy = true,
  },

  -- alternative to matchparen neovim plugin
  {
    "monkoose/matchparen.nvim",
    config = true,
  },

  -- An alternative to sudo.vim
  {
    -- Suda
    "lambdalisue/suda.vim",
    config = vim.api.nvim_set_var("suda_smart_edit", 1),
    cmd = { "SudaRead", "SudaWrite" },
  },

  -- { "petertriho/nvim-scrollbar" },

  {
    "rcarriga/nvim-notify",
    opts = {
      stages = "static",
      timeout = 2000,
    },
    config = function()
      vim.notify = require("notify")
    end,
  },

  -- File explorer
  {
    "stevearc/oil.nvim",
    cmd = "Oil",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
      -- Oil will take over directory buffers (e.g. `vim .` or `:e src/`
      -- Conflict with pathogen
      default_file_explorer = false,
      columns = {
        "icon",
        "permissions",
        "size",
        "mtime",
      },
    },
  },

  -- Neovim UI Enhancer
  {
    "stevearc/dressing.nvim",
    lazy = true,
    opts = {
      input = {
        default_prompt = "➤ ",
        win_options = { winhighlight = "Normal:Normal,NormalNC:Normal" },
      },
      select = {
        backend = { "telescope", "builtin" },
        builtin = {
          win_options = { winhighlight = "Normal:Normal,NormalNC:Normal" },
        },
      },
    },
  },

  {
    "olimorris/onedarkpro.nvim",
    lazy = false,
    -- make sure we load this during startup if it is your main colorscheme
    priority = 1000,
    opts = {
      caching = true,
    },
    config = function()
      vim.cmd.colorscheme("onedark")
    end,
  },

  {
    "ojroques/nvim-bufdel",
    opts = {
      -- or 'cycle, 'alternate'
      next = "tabs",
      -- quit Neovim when last buffer is closed
      quit = true,
    },
  },

  -- move and duplicate blocks and lines, with complete fold handling,
  -- reindent, and undone in one go
  {
    "booperlv/nvim-gomove",
    opts = {
      -- whether or not to map default key bindings, (true/false)
      map_defaults = true,
      -- whether or not to reindent lines moved vertically (true/false)
      reindent = true,
      -- whether or not to undojoin same direction moves (true/false)
      undojoin = true,
      -- whether to not to move past end column when moving blocks horizontally, (true/false)
      move_past_end_col = false,
    },
  },

  {
    "NvChad/nvim-colorizer.lua",
    lazy = true,
    opts = { "*" },
  },

  -- Go to the last edited place
  {
    "ethanholz/nvim-lastplace",
    opts = {
      lastplace_ignore_buftype = { "quickfix", "nofile", "help" },
      lastplace_ignore_filetype = {
        "gitcommit",
        "gitrebase",
        "svn",
        "hgcommit",
      },
      lastplace_open_folds = true,
    },
  },

  {
    "akinsho/bufferline.nvim",
    event = "VeryLazy",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
      options = {
        tab_size = 20,
        diagnostics = false,
        color_icons = true,
        show_buffer_icons = true,
        show_buffer_close_icons = true,
        show_close_icon = true,
        show_tab_indicators = true,
        separator_style = "thin",
        enforce_regular_tabs = false,
        always_show_bufferline = true,
      },
    },
  },

  -- Indent guides on blank lines for Neovim
  {
    "lukas-reineke/indent-blankline.nvim",
    event = { "BufReadPost", "BufNewFile" },
    opts = {
      show_current_context = true,
      show_current_context_start = true,
    },
  },

  -- Align text interactively
  -- keys: gas and gAs (preview)
  {
    "echasnovski/mini.align",
    version = false,
    event = "InsertEnter",
    config = true,
  },
}
