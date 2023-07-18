return {
  -- Enable opening a file in a given line
  {
    "wsdjeg/vim-fetch",
    lazy = false,
  },
  -- { "lewis6991/fileline.nvim" },

  -- Enable repeating supported plugin maps with '.'
  {
    "tpope/vim-repeat",
    lazy = true,
  },

  -- bitbake support
  {
    "kergoth/vim-bitbake",
    ft = "bitbake",
  },

  -- New files created with a shebang line are automatically made executable
  {
    "tpope/vim-eunuch",
    event = { "BufReadPre", "BufNewFile" },
  },

  -- Jinja2 syntax support
  {
    "glench/vim-jinja2-syntax",
    event = { "BufReadPre", "BufNewFile" },
  },

  -- measure startuptime
  {
    "dstein64/vim-startuptime",
    cmd = "StartupTime",
    config = function()
      vim.g.startuptime_tries = 10
    end,
  },

  -- Markdown support
  -- Generate table of contents for Markdown files
  -- { "mzlogin/vim-markdown-toc" },

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

  -- improve buffer deletion
  {
    "ojroques/nvim-bufdel",
    lazy = false,
    opts = {
      -- quit Neovim when last buffer is closed
      quit = true,
    },
  },

  -- Go to the last edited place
  {
    "ethanholz/nvim-lastplace",
    lazy = false,
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

  -- Neovim setup for init.lua and plugin development with full signature help,
  -- docs and completion for the nvim lua API
  -- Enable to get more get help from Lua API
  -- {
  --   "folke/neodev.nvim",
  --   config = true,
  --   lazy = true,
  --   ft = "lua",
  -- },

  {
    "HiPhish/rainbow-delimiters.nvim",
    event = { "BufReadPre", "BufNewFile" },
  },

  -- Visualise and resolve merge conflicts in neovim
  -- ]x - move to previous conflict
  -- [x - move to next conflict
  -- co - choose ours
  -- ct - choose theirs
  -- cb - choose both
  -- c0 - choose none
  {
    "akinsho/git-conflict.nvim",
    event = "VeryLazy",
    config = function()
      require("git-conflict").setup({
        default_mappings = true,
        disable_diagnostics = true,
      })
    end,
  },

  -- Provide Icons
  -- Required by telescope and others
  {
    "nvim-tree/nvim-web-devicons",
    lazy = true,
  },

  -- Add/change/delete surrounding delimiter pairs with ease
  {
    "kylechui/nvim-surround",
    event = { "BufReadPre", "BufNewFile" },
    config = true,
  },

  -- enhanced increment/decrement plugin for Neovim
  -- { "monaqa/dial.nvim", lazy = true },

  -- Removes trailing whitespace from *modified* lines on save
  {
    "cappyzawa/trim.nvim",
    event = "BufWritePre",
    config = true,
    opts = {
      ft_blocklist = { "gitsendemail", "gitcommit" },
    },
  },

  -- YAML syntax support
  {
    "cuducos/yaml.nvim",
    ft = { "yaml" },
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
    },
  },

  -- A pretty diagnostics, references, telescope results, quickfix and location
  -- list to help you solve all the trouble your code is causing.
  {
    "folke/trouble.nvim",
    cmd = { "TroubleToggle", "Trouble" },
    opts = { use_diagnostic_signs = true },
    dependencies = "nvim-tree/nvim-web-devicons",
    config = true,
    keys = {
      {
        "<F5>",
        "<cmd>TroubleToggle document_diagnostics<CR>",
        mode = { "n" },
        desc = "Open diagnostics",
      },
    },
  },

  -- Automatically manage hlsearch setting
  {
    "asiryk/auto-hlsearch.nvim",
    lazy = true,
    config = true,
  },

  -- Automatic indentation style detection for Neovim
  {
    "nmac427/guess-indent.nvim",
    event = { "BufReadPre", "BufNewFile" },
    config = true,
  },
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
    event = { "BufRead", "BufNewFile" },
    config = true,
  },

  -- Search and Replace
  {
    "Usuim/searchbox.nvim",
    lazy = true,
    dependencies = {
      "MunifTanjim/nui.nvim",
    },

    keys = {
      {
        "<c-l>",
        ":SearchBoxReplace confirm=native<CR>",
        mode = { "n" },
      },
      {
        "<c-l>",
        "<ESC>:SearchBoxReplace confirm=native<CR>",
        mode = { "i" },
      },
      {
        "<c-l>",
        ":SearchBoxReplace confirm=native<CR>",
        mode = { "v" },
      },
    },
  },

  -- Alternative to matchparen neovim plugin
  {
    "monkoose/matchparen.nvim",
    event = { "BufRead", "BufNewFile" },
    config = true,
  },

  -- An alternative to sudo.vim
  {
    -- Suda
    "lambdalisue/suda.vim",
    event = 'BufRead',
    config = vim.api.nvim_set_var("suda_smart_edit", 1),
  },

  -- {
  --   "rcarriga/nvim-notify",
  --   opts = {
  --     stages = "static",
  --     timeout = 2000,
  --   },
  --   config = function()
  --     vim.notify = require("notify")
  --   end,
  -- },

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
    keys = {
      {
        "_",
        function()
          require("oil").open()
        end,
        mode = { "n" },
        desc = "Open Parent Directory",
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

  -- move and duplicate blocks and lines, with complete fold handling,
  -- reindent, and undone in one go
  {
    "booperlv/nvim-gomove",
    event = { "BufReadPre", "BufNewFile" },
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

  -- A snazzy bufferline for neovim
  -- bufferline is faster than nvim-cokeline and barbar
  {
    "akinsho/bufferline.nvim",
    event = "VeryLazy",
    opts = {
      options = {
        show_buffer_icons = false,
        show_buffer_close_icons = false,
        always_show_bufferline = false,
      },
    },
  },

  -- status line
  -- lualine has better structure and theme, it's more like spaceline
  -- heirline lacks of onedark color scheme
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = require("plugins.configs.lualine_conf"),
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
    event = "InsertEnter",
    version = false,
    config = true,
  },

  -- Navigate your code with search labels, enhanced character motions and
  -- Treesitter integration
  {
    "folke/flash.nvim",
    lazy = true,
    -- event = "VeryLazy",
    opts = {
      modes = {
        char = {
          jump_labels = true,
        },
      },
    },
    keys = {
      {
        "s",
        function()
          require("flash").treesitter()
        end,
        mode = { "n", "o", "x" },
        desc = "Flash Treesitter",
      },
    },
  },

  -- Comment lines
  {
    "numToStr/Comment.nvim",
    event = { "BufRead", "BufNewFile" },
    opts = {
      mappings = {
        basic = false,
        extra = false,
      },
    },
    keys = {
      {
        -- Ctrl-/ as VSCode and Jetbrain
        "<c-_>",
        function()
          return vim.v.count == 0 and "<Plug>(comment_toggle_linewise_current)"
            or "<Plug>(comment_toggle_linewise_count)"
        end,
        mode = { "n" },
        expr = true,
      },
      {
        "<c-_>",
        "<Plug>(comment_toggle_linewise_visual)",
        mode = { "x" },
      },
    },
  },

  {
    "m4xshen/hardtime.nvim",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = "neovim/nvim-lspconfig",
    opts = {
      disable_mouse = false,
      restricted_keys = {
        ["h"] = { "n", "v" },
        ["j"] = { "n", "v" },
        ["k"] = { "n", "v" },
        ["l"] = { "n", "v" },
        ["gj"] = { "n", "v" },
        ["gk"] = { "n", "v" },
        ["<CR>"] = { "n", "v" },
      },
    },
  },

  -- Vim plugin, insert or delete brackets, parens, quotes in pair
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    dependencies = {
      { "hrsh7th/nvim-cmp" },
    },
    config = require("plugins.configs.nvim-autopairs_conf"),
  },

  {
    "nvim-telescope/telescope.nvim",
    cmd = "Telescope",
    version = false,
    dependencies = {
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        enabled = vim.fn.executable("make") == 1,
        build = "make",
      },
      { "nvim-lua/popup.nvim" },
      { "nvim-lua/plenary.nvim" },
      { "brookhong/telescope-pathogen.nvim" },
      -- { "rcarriga/nvim-notify" },
    },
    config = require("plugins.configs.telescope_conf"),
  },

  {
    "nvim-treesitter/nvim-treesitter",
    event = { "BufReadPost", "BufNewFile" },
    version = false,
    dependencies = {
      {
        "nvim-treesitter/nvim-treesitter-context",
        config = true,
      },
    },
    build = ":TSUpdate",
    config = require("plugins.configs.nvim-treesitter_conf"),
  },

  -- LSP setup
  {
    "VonHeikemen/lsp-zero.nvim",
    event = { "BufReadPre", "BufNewFile" },
    branch = "v2.x",
    dependencies = {
      { "neovim/nvim-lspconfig" },
      { "williamboman/mason-lspconfig.nvim" },
      {
        "williamboman/mason.nvim",
        cmd = {
          "Mason",
          "MasonInstall",
          "MasonUninstall",
          "MasonUninstallAll",
          "MasonUpdate",
          "MasonUpdateAll",
        },
        opts = {
          ui = {
            icons = {
              package_installed = "✓",
              package_uninstalled = "✗",
              package_pending = "⟳",
            },
          },
        },
        build = ":MasonUpdate", -- :MasonUpdate updates registry contents
      },

      -- Completation engine
      { "hrsh7th/nvim-cmp" },

      -- Completation sources
      { "hrsh7th/cmp-buffer" },
      { "hrsh7th/cmp-path" },
      { "hrsh7th/cmp-nvim-lsp" },
      {
        "f3fora/cmp-spell",
        ft = { "gitcommit", "markdown" },
      },

      -- Vim Snippets engine [snippet engine] + [snippet templates]
      {
        "L3MON4D3/LuaSnip",
        version = "2.*",
        dependencies = {
          "rafamadriz/friendly-snippets",
        },
        -- opts = {
        --   loaders_store_source = true,
        -- },
        config = function()
          require("luasnip.loaders.from_vscode").lazy_load()
        end,
      },

      -- linter + formatter
      "jose-elias-alvarez/null-ls.nvim",

      -- brigde between mason and null-ls for linters and formatter
      {
        "jay-babu/mason-null-ls.nvim",
        event = { "BufReadPre", "BufNewFile" },
      },

      -- UI
      { "onsails/lspkind.nvim" },
    },
    keys = {
      -- formatter
      { "<leader>f", "<Cmd>lua vim.lsp.buf.format()<CR>", silent = true },
    },
    config = require("plugins.configs.lsp_conf"),
  },

}
