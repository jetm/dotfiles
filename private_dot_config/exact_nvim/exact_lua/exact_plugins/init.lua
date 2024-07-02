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
  -- {
  --   "dstein64/vim-startuptime",
  --   cmd = "StartupTime",
  --   config = function()
  --     vim.g.startuptime_tries = 10
  --   end,
  -- },

  -- Markdown support
  -- Generate table of contents for Markdown files
  -- { "mzlogin/vim-markdown-toc" },

  -- {
  --   "navarasu/onedark.nvim",
  --   lazy = false,
  --
  --   config = function()
  --     vim.cmd.colorscheme("onedark")
  --   end,
  -- },
  -- More updated
  {
    "olimorris/onedarkpro.nvim",
    lazy = false,
    -- make sure we load this during startup if it is your main colorscheme
    priority = 1000,
    config = function()
      require("onedarkpro").setup({
        caching = true,
        colors = {
          onedark = { bg = "#23272E", black = "#23272E" },
          -- onedark = { bg = "#1c2025", black = "#1c2025" }, -- darker
          -- onedark = { bg = "#15181C", black = "#15181C" }, -- darker plus
        },
      })
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
    submodules = false,
    event = { "BufReadPre", "BufNewFile" },
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
    version = "*", -- try installing the latest stable version for plugins that support semver
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
    dependencies = "nvim-tree/nvim-web-devicons",
    cmd = { "TroubleToggle", "Trouble" },
    opts = {
      auto_close = true,
    },
    config = true,
    keys = {
      {
        "<F5>",
        "<cmd>Trouble diagnostics toggle<CR>",
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

  -- search/replace in multiple files
  {
    "nvim-pack/nvim-spectre",
    build = false,
    cmd = "Spectre",
    opts = { open_cmd = "noswapfile vnew" },
    -- stylua: ignore
    keys = {
      { "<leader>sr", function() require("spectre").open() end, desc = "Replace in files (Spectre)" },
    },
  },

  -- Automatic indentation style detection for Neovim
  -- {
  -- "nmac427/guess-indent.nvim",
  -- event = { "BufReadPre", "BufNewFile" },
  -- config = true,
  -- },

  -- Faster than guess-indent.nvim
  -- Dumb automatic fast indentation detection for Neovim written in Lua
  {
    "Darazaki/indent-o-matic",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      max_lines = 2048,
      standard_widths = { 2, 4, 8 },
      filetype_make = {
        max_lines = 0,
      },
      -- Don't detect 8 spaces indentations inside files without a filetype
      filetype_ = {
        standard_widths = { 2, 4 },
      },
    },
    config = true,
  },

  -- add neovim in browser
  -- {
  --   "glacambre/firenvim",
  --   -- Lazy load firenvim
  --   -- Explanation: https://github.com/folke/lazy.nvim/discussions/463#discussioncomment-4819297
  --   cond = not not vim.g.started_by_firenvim,
  --   build = function()
  --     require("lazy").load({ plugins = "firenvim", wait = true })
  --     vim.fn["firenvim#install"](0)
  --   end,
  --   config = function()
  --     vim.g.firenvim_config = {
  --       globalSettigs = {
  --         alt = "all",
  --       },
  --       localSettings = {
  --         [".*"] = {
  --           cmdline = "neovim",
  --           content = "text",
  --           priority = 0,
  --           selector = "div",
  --           takeover = "never",
  --         },
  --       },
  --     }
  --   end,
  -- },

  -- Peek lines just when you intend
  {
    "nacro90/numb.nvim",
    cond = not vim.g.vscode,
    event = { "BufRead", "BufNewFile" },
    config = true,
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
    event = "BufRead",
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

  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
    },
    cmd = "Neotree",
    keys = {
      {
        "<leader>e",
        function()
          require("neo-tree.command").execute({
            toggle = true,
            dir = vim.loop.cwd(),
          })
        end,
        desc = "Explorer NeoTree (cwd)",
      },
    },
    deactivate = function()
      vim.cmd([[Neotree close]])
    end,
    init = function()
      if vim.fn.argc(-1) == 1 then
        local stat = vim.loop.fs_stat(vim.fn.argv(0))
        if stat and stat.type == "directory" then
          require("neo-tree")
        end
      end
    end,
    opts = {
      sources = { "filesystem", "buffers", "git_status", "document_symbols" },
      open_files_do_not_replace_types = {
        "terminal",
        "Trouble",
        "qf",
        "Outline",
      },
      filesystem = {
        bind_to_cwd = false,
        follow_current_file = { enabled = true },
        use_libuv_file_watcher = true,
      },
      window = {
        mappings = {
          ["<space>"] = "none",
        },
      },
      default_component_configs = {
        indent = {
          with_expanders = true, -- if nil and file nesting is enabled, will enable expanders
          expander_collapsed = "",
          expander_expanded = "",
          expander_highlight = "NeoTreeExpander",
        },
      },
    },
    config = true,
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
        show_buffer_icons = true,
        show_buffer_close_icons = false,
        always_show_bufferline = false,
        -- For 8 -
        numbers = function(opts)
          return string.format("%s", opts.ordinal)
        end,
        offsets = {
          {
            filetype = "neo-tree",
            text = "Neo-tree",
            highlight = "Directory",
            text_align = "left",
          },
        },
      },
    },
  },

  -- status line
  -- lualine has better structure and theme, it's more like spaceline
  -- heirline needs more work. Test it later
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    dependencies = { "nvim-tree/nvim-web-devicons", "meuter/lualine-so-fancy.nvim", "dokwork/lualine-ex" },
    init = function()
      vim.g.lualine_laststatus = vim.o.laststatus
      if vim.fn.argc(-1) > 0 then
        -- set an empty statusline till lualine loads
        vim.o.statusline = " "
      else
        -- hide the statusline on the starter page
        vim.o.laststatus = 0
      end
    end,
    opts = require("plugins.configs.lualine_conf"),
  },

  -- Indent guides on blank lines for Neovim
  {
    "lukas-reineke/indent-blankline.nvim",
    event = { "BufReadPost", "BufNewFile" },
    main = "ibl",
    opts = {
      indent = {
        char = "│",
        tab_char = "├",
      },
      exclude = {
        buftypes = {
          "nofile",
          "terminal",
        },
        filetypes = {
          "help",
          "startify",
          "aerial",
          "alpha",
          "dashboard",
          "lazy",
          "neogitstatus",
          "NvimTree",
          "neo-tree",
          "Trouble",
        },
      },
    },
    config = true,
  },

  -- Active indent guide and indent text objects. When you're browsing
  -- code, this highlights the current level of indentation
  {
    "echasnovski/mini.indentscope",
    event = { "BufReadPost", "BufNewFile" },
    version = false, -- wait till new 0.7.0 release to put it back on semver
    opts = {
      symbol = "│",
      options = { try_as_border = true },
      -- remove animation. It's distracting
      draw = {
        delay = 0,
        animation = function()
          return 0
        end,
      },
    },
    init = function()
      vim.api.nvim_create_autocmd("FileType", {
        pattern = {
          "help",
          "alpha",
          "dashboard",
          "neo-tree",
          "Trouble",
          "lazy",
          "mason",
          "notify",
          "toggleterm",
          "lazyterm",
        },
        callback = function()
          vim.b.miniindentscope_disable = true
        end,
      })
    end,
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
    event = "VeryLazy",
    opts = {
      -- continue the last search
      continue = true,
      jump = {
        -- automatically jump when there is only one match
        autojump = true,
      },
      modes = {
        search = { enabled = false },
        char = {
          enabled = true,
          jump_labels = true,
          -- TODO: Change to `false` to use the current line only. Pending fix
          multi_line = true,
        },
      },
    },
    keys = {
      {
        "s",
        mode = { "n", "x", "o" },
        function()
          require("flash").jump()
        end,
        desc = "Flash",
      },
    },
  },

  -- {
  --   "ThePrimeagen/harpoon",
  --   branch = "harpoon2",
  --   -- config = require("plugins.configs.harpoon_conf"),
  --   event = { "BufReadPre", "BufNewFile" },
  --   opts = {
  --     menu = {
  --       width = vim.api.nvim_win_get_width(0) - 4,
  --     },
  --     settings = {
  --       save_on_toggle = true,
  --     },
  --   },
  --   keys = function()
  --     local keys = {
  --       {
  --         "<leader>H",
  --         function()
  --           require("harpoon"):list():add()
  --         end,
  --         desc = "Harpoon File",
  --       },
  --       {
  --         "<leader>h",
  --         function()
  --           local harpoon = require("harpoon")
  --           harpoon.ui:toggle_quick_menu(harpoon:list())
  --         end,
  --         desc = "Harpoon Quick Menu",
  --       },
  --     }
  --
  --     for i = 1, 5 do
  --       table.insert(keys, {
  --         "<leader>" .. i,
  --         function()
  --           require("harpoon"):list():select(i)
  --         end,
  --         desc = "Harpoon to File " .. i,
  --       })
  --     end
  --     return keys
  --   end,
  -- },

  -- Use the w, e, b motions. Move by subwords and skip insignificant punctuation
  -- Prefer the vim way
  -- {
  --   "chrisgrieser/nvim-spider",
  --   keys = {
  --     {
  --       "e",
  --       "<cmd>lua require('spider').motion('e')<CR>",
  --       mode = { "n", "o", "x" },
  --     },
  --     {
  --       "w",
  --       "<cmd>lua require('spider').motion('w')<CR>",
  --       mode = { "n", "o", "x" },
  --     },
  --     {
  --       "b",
  --       "<cmd>lua require('spider').motion('b')<CR>",
  --       mode = { "n", "o", "x" },
  --     },
  --   },
  -- },

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
        "<c-/>",
        function()
          return vim.v.count == 0 and "<Plug>(comment_toggle_linewise_current)"
            or "<Plug>(comment_toggle_linewise_count)"
        end,
        mode = { "n" },
        expr = true,
      },
      {
        "<c-/>",
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
    config = true,
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
      -- { "rcarriga/nvim-notify" },
    },
    config = require("plugins.configs.telescope_conf"),
  },

  -- A telescope.nvim extension that offers intelligent prioritization when selecting files from your editing history
  {
    "nvim-telescope/telescope-frecency.nvim",
    config = function()
      require("telescope").load_extension("frecency")
    end,
  },

  {
    "linrongbin16/fzfx.nvim",
    event = { "BufReadPost", "BufNewFile" },
    cmd = "FzfxLiveGrepW",
    dependencies = { "junegunn/fzf", "nvim-tree/nvim-web-devicons" },
    config = true,
  },

  -- {
  --   "nvim-treesitter/nvim-treesitter-context",
  --   event = { "BufReadPost", "BufNewFile" },
  --   opts = { max_lines = 3 },
  -- },

  {
    "nvim-treesitter/nvim-treesitter",
    event = { "BufReadPost", "BufNewFile" },
    version = false,
    dependencies = {
      {
        "nvim-treesitter/nvim-treesitter-textobjects",
      },
    },
    build = ":TSUpdate",
    config = require("plugins.configs.nvim-treesitter_conf"),
  },

  -- yaml schema support
  {
    "b0o/SchemaStore.nvim",
    lazy = true,
    version = false, -- last release is way too old
  },

  -- Linter
  {
    "mfussenegger/nvim-lint",
    event = "VeryLazy",
    config = function()
      require("lint").linters_by_ft = {
        sh = { "shellcheck" },
        zsh = { "shellcheck" },
        bats = { "shellcheck" },
        lua = { "luacheck" },
        yaml = { "yamllint" },
      }
    end,
  },

  -- Lightweight yet powerful formatter
  {
    "stevearc/conform.nvim",
    event = { "BufWritePre" },
    cmd = { "ConformInfo" },
    keys = {
      {
        "<leader>f",
        function()
          require("conform").format({ async = true, lsp_fallback = true })
        end,
        mode = { "n", "v" },
        desc = "Format buffer",
      },
    },
    config = require("plugins.configs.conform_conf"),
  },

  --
  -- LSP setup
  --
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
    -- :MasonUpdate updates registry contents
    build = ":MasonUpdate",
  },

  -- Vim Snippets engine [snippet engine] + [snippet templates]
  {
    "L3MON4D3/LuaSnip",
    event = { "BufReadPre", "BufNewFile" },
    version = "2.*",
    dependencies = {
      "rafamadriz/friendly-snippets",
    },
    config = function()
      require("luasnip.loaders.from_vscode").lazy_load()
    end,
  },

  -- {
  --   "Exafunction/codeium.vim",
  --   event = "BufEnter",
  --   build = ":Codeium Auth",
  --   config = function()
  --     vim.g.codeium_idle_delay = 250
  --     vim.g.codeium_disable_bindings = 1
  --     vim.g.codeium_no_map_tab = true
  --     vim.g.codeium_filetypes = {
  --       ["neo-tree-popup"] = false,
  --     }
  --     vim.keymap.set("i", "<C-CR>", function()
  --       return vim.fn["codeium#Accept"]()
  --     end, { expr = true })
  --     vim.keymap.set("i", "<C-.>", function()
  --       return vim.fn["codeium#CycleCompletions"](1)
  --     end, { expr = true })
  --     vim.keymap.set("i", "<C-,>", function()
  --       return vim.fn["codeium#CycleCompletions"](-1)
  --     end, { expr = true })
  --     vim.keymap.set("i", "<C-x>", function()
  --       return vim.fn["codeium#Clear"]()
  --     end, { expr = true })
  --   end,
  -- },

  {
    "garyhurtz/cmp_kitty",
    dependencies = {
      { "hrsh7th/nvim-cmp" },
    },
    init = function()
      require("cmp_kitty"):setup()
    end,
  },

  {
    "VonHeikemen/lsp-zero.nvim",
    event = { "BufReadPre", "BufNewFile" },
    branch = "v3.x",
    dependencies = {
      {
        "neovim/nvim-lspconfig",
      },
      { "williamboman/mason.nvim" },
      { "williamboman/mason-lspconfig.nvim" },

      -- A more complete solution for make an IDE
      -- {
      --   "ray-x/navigator.lua",
      --   dependencies = {
      --     { "ray-x/guihua.lua", build = "cd lua/fzy && make" },
      --     { "neovim/nvim-lspconfig" },
      --     { "nvim-treesitter/nvim-treesitter" },
      --   },
      -- },

      -- Completation engine
      { "hrsh7th/nvim-cmp" },

      -- Completation sources
      { "hrsh7th/cmp-nvim-lsp" },
      { "hrsh7th/cmp-buffer" },
      { "lukas-reineke/cmp-rg" },
      { "FelipeLema/cmp-async-path" },
      { "https://git.sr.ht/~p00f/clangd_extensions.nvim" },
      {
        "petertriho/cmp-git",
        ft = { "gitcommit" },
      },
      {
        "f3fora/cmp-spell",
        ft = { "gitcommit", "markdown" },
      },

      -- Snippets
      { "L3MON4D3/LuaSnip" },
    },
    config = require("plugins.configs.lsp_conf"),
  },

  -- Extensible UI for Neovim notifications and LSP progress messages
  {
    "j-hui/fidget.nvim",
    event = { "LspAttach" },
    opts = {
      -- options
    },
  },

  -- better diffing
  -- ]x - move to previous conflict
  -- [x - move to next conflict
  -- co - choose ours
  -- ct - choose theirs
  -- cb - choose both
  -- c0 - choose none
  -- Visualise and resolve merge conflicts in neovim
  {
    "akinsho/git-conflict.nvim",
    event = "BufReadPre",
    config = function()
      require("git-conflict").setup({
        default_mappings = true,
        disable_diagnostics = true,
      })
    end,
  },

  -- git signs highlights text that has changed since the list
  -- git commit, and also lets you interactively stage & unstage
  -- hunks in a commit
  {
    "lewis6991/gitsigns.nvim",
    event = "BufEnter",
    opts = {
      signs = {
        add = { text = "▎" },
        change = { text = "▎" },
        delete = { text = "" },
        topdelete = { text = "" },
        changedelete = { text = "▎" },
        untracked = { text = "▎" },
      },
      on_attach = function(buffer)
        local function map(mode, l, r, desc)
          vim.keymap.set(mode, l, r, { buffer = buffer, desc = desc })
        end

        -- stylua: ignore start
        map({ "n", "v" }, "<leader>ghr", ":Gitsigns reset_hunk<CR>", "Reset Hunk")
      end,
    },
  },

  -- Automatically highlights other instances of the word under your cursor.
  -- This works with LSP, Treesitter, and regexp matching to find the other
  -- instances.
  {
    "RRethy/vim-illuminate",
    event = "BufReadPre",
  },

  -- 😽 Open your Kitty scrollback buffer with Neovim
  {
    "mikesmithgh/kitty-scrollback.nvim",
    enabled = true,
    lazy = true,
    cmd = { "KittyScrollbackGenerateKittens", "KittyScrollbackCheckHealth" },
    event = { "User KittyScrollbackLaunch" },
    config = function()
      require("kitty-scrollback").setup()
    end,
  },

  -- Smart, seamless, directional navigation and resizing of Neovim + terminal multiplexer splits.
  -- Supports tmux, Wezterm, and Kitty. Think about splits in terms of "up/down/left/right".
  --
  -- to use Kitty multiplexer support, run the post install hook
  {
    "mrjones2014/smart-splits.nvim",
    build = "./kitty/install-kittens.bash",
    lazy = false,
    -- warp, default, doesn't work on kitty
    opts = { at_edge = "stop" },
  },

  {
    "epwalsh/obsidian.nvim",
    lazy = true,
    event = {
      "BufReadPre " .. vim.fn.expand("~") .. "/MEGAsync/Obsidian/**.md",
      "BufNewFile " .. vim.fn.expand("~") .. "/MEGAsync/Obsidian/jetm/**.md",
    },
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {
      workspaces = {
        {
          name = "jetm",
          path = "~/MEGAsync/Obsidian/jetm",
        },
      },
    },
  },

  -- Introduce a new operators motions to quickly replace and exchange text
  {
    "gbprod/substitute.nvim",
    opts = {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
    },
  },

  -- {
  --   "sindrets/diffview.nvim",
  --   dependencies = { "nvim-lua/plenary.nvim", "nvim-tree/nvim-web-devicons" },
  --   cmd = { "DiffviewOpen", "DiffviewClose" },
  --   config = require("plugins.configs.diffview_conf"),
  -- },

  -- Smart selection of the closest text object
  -- {
  --   "sustech-data/wildfire.nvim",
  --   event = "VeryLazy",
  --   config = true,
  -- },
}
