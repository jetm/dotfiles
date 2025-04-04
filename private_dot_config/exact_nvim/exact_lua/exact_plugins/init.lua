return {
  -- plenary: full; complete; entire; absolute; unqualified. All the lua functions I don't want to write twice
  { "nvim-lua/plenary.nvim" },

  {
    "nvchad/base46",
    build = function()
      require("base46").load_all_highlights()
    end,
  },

  {
    "nvchad/ui",
    lazy = false,
    config = function()
      require("nvchad")
    end,
  },

  { "nvchad/volt" },
  { "nvchad/minty" },
  { "nvchad/menu" },

  -- Simple session management for Neovim with git branching and autoloading support
  {
    "olimorris/persisted.nvim",
    lazy = false, -- make sure the plugin is always loaded at startup
    opts = {
      autoload = true,
    },
    config = true,
  },

  {
    "folke/lazydev.nvim",
    ft = "lua",
    cmd = "LazyDev",
    opts = {
      library = {
        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
        { path = "snacks.nvim", words = { "Snacks" } },
        { path = "lazy.nvim", words = { "LazyVim" } },
      },
    },
  },

  -- A collection of small QoL plugins for Neovim
  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    opts = {
      bigfile = { enabled = true },
      notifier = { enabled = true },
      quickfile = { enabled = true },
      picker = {
        enabled = true,
        cycle = true,
        layout = function()
          return vim.o.columns >= 120 and "vscode" or "vertical"
        end,
      },
    },
    keys = {
      {
        "q",
        function()
          ---@diagnostic disable-next-line: undefined-global
          Snacks.bufdelete()
        end,
        mode = { "n", "x" },
        desc = "Delete Buffer",
      },
      {
        "Q",
        "<CMD>qa<CR>",
        mode = { "n", "x" },
        desc = "Quit",
      },
      {
        "<leader>Q",
        function()
          ---@diagnostic disable-next-line: undefined-global
          Snacks.bufdelete.all()
        end,
        mode = { "n", "x" },
        desc = "Delete All Buffers",
      },
      {
        "<leader>n",
        function()
          ---@diagnostic disable-next-line: undefined-global
          Snacks.notifier.show_history()
        end,
        mode = { "n", "x" },
        desc = "Show Notifier History",
      },
      {
        "<C-p>",
        function()
          ---@diagnostic disable-next-line: undefined-global
          Snacks.picker.files()
        end,
        desc = "Find Files",
      },
    },
  },

  -- onedarkpro is more updated
  {
    "olimorris/onedarkpro.nvim",
    lazy = false,
    -- make sure we load this during startup if it is your main colorscheme
    priority = 1000,
    config = function()
      require("onedarkpro").setup({
        caching = true,
        colors = {
          -- onedark = { bg = "#23272E", black = "#23272E" },
          -- onedark = { bg = "#1c2025", black = "#1c2025" }, -- darker
          -- onedark = { bg = "#15181C", black = "#15181C" }, -- darker plus
        },
      })
      vim.cmd.colorscheme("onedark")
    end,
  },

  -- Enable repeating supported plugin maps with "."
  { "tpope/vim-repeat", event = "VeryLazy", keys = "." },

  -- Goto filenames with line info
  { "lewis6991/fileline.nvim", lazy = false },

  -- Gives basic functionality for error messages with format filename:line:column
  {
    "Dr-42/error-jump.nvim",
    name = "error-jump",
    lazy = false,
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

  -- YAML syntax support
  {
    "cuducos/yaml.nvim",
    ft = { "yaml" },
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
    },
  },

  -- Jump to last edition
  {
    "bloznelis/before.nvim",
    event = { "InsertEnter", "TextChanged" },
    keys = {
      {
        "<C-n>",
        function()
          require("before").jump_to_last_edit()
        end,
        desc = "Jump last edit",
      },
      {
        "<C-m>",
        function()
          require("before").jump_to_next_edit()
        end,
        desc = "Jump next edit",
      },
    },
    opts = {
      -- How many edit locations to store in memory (default: 10)
      history_size = 42,
      -- Wrap around the ends of the edit history (default: false)
      history_wrap_enabled = true,
    },
    config = true,
  },

  {
    "HiPhish/rainbow-delimiters.nvim",
    submodules = false,
    event = { "BufReadPre", "BufNewFile" },
  },

  -- Provide Icons
  {
    "echasnovski/mini.icons",
    lazy = true,
    init = function()
      ---@diagnostic disable-next-line: duplicate-set-field
      package.preload["nvim-web-devicons"] = function()
        require("mini.icons").mock_nvim_web_devicons()
        return package.loaded["nvim-web-devicons"]
      end
    end,
    opts = function(_, opts)
      if vim.g.icons_enabled == false then
        opts.style = "ascii"
      end
      dofile(vim.g.base46_cache .. "devicons")
      return { override = require("nvchad.icons.devicons") }
    end,
  },

  -- Wildmenu replacement for Neovim inspired by Helix
  {
    "vzze/cmdline.nvim",
    config = true,
  },

  -- Add/change/delete surrounding delimiter pairs with ease
  --
  -- surr*ound_words             ysiw)           (surround_words)
  -- *make strings               ys$"            "make strings"
  -- [delete ar*ound me!]        ds]             delete around me!
  -- remove <b>HTML t*ags</b>    dst             remove HTML tags
  -- 'change quot*es'            cs'"            "change quotes"
  -- <b>or tag* types</b>        csth1<CR>       <h1>or tag types</h1>
  -- delete(functi*on calls)     dsf             function calls
  {
    "kylechui/nvim-surround",
    event = { "BufReadPre", "BufNewFile" },
    config = true,
  },

  -- Introduce a new operators motions to quickly replace and exchange text
  {
    "gbprod/substitute.nvim",
    config = function()
      -- Required to play well with yank
      require("substitute").setup({})
    end,
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

  -- A pretty diagnostics, references, quickfix and location
  -- list to help you solve all the trouble your code is causing.
  {
    "folke/trouble.nvim",
    cmd = { "TroubleToggle", "Trouble" },
    opts = {
      auto_close = true,
    },
    config = true,
    keys = {
      {
        "<leader>d",
        "<cmd>Trouble diagnostics toggle<CR>",
        mode = { "n" },
        desc = "Open diagnostics",
      },
    },
  },

  -- file managing , picker etc
  {
    "nvim-tree/nvim-tree.lua",
    cmd = { "NvimTreeToggle", "NvimTreeFocus" },
    opts = function()
      return require("plugins.configs.nvim-tree")
    end,
  },

  -- Find And Replace plugin for neovim
  {
    "MagicDuck/grug-far.nvim",
    opts = {
      headerMaxWidth = 80,
      maxWorkers = 16,
      keymaps = {
        close = { n = "q" },
      },
    },
    cmd = "GrugFar",
    keys = {
      {
        "<leader>g",
        function()
          local grug = require("grug-far")
          grug.open({
            prefills = {
              search = vim.fn.expand("<cword>"),
            },
          })
        end,
        mode = { "n" },
        desc = "Search and Replace current word",
      },
      {
        "<leader>gv",
        function()
          local grug = require("grug-far")
          local ext = vim.bo.buftype == "" and vim.fn.expand("%:e")
          grug.open({
            prefills = {
              filesFilter = ext and ext ~= "" and "*." .. ext or nil,
            },
          })
        end,
        mode = { "n", "v" },
        desc = "Search and Replace viusal selection",
      },
    },
  },

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

  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
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
      vim.api.nvim_create_autocmd("BufEnter", {
        group = vim.api.nvim_create_augroup("Neotree_start_directory", { clear = true }),
        desc = "Start Neo-tree with directory",
        once = true,
        callback = function()
          if package.loaded["neo-tree"] then
            return
          else
            ---@diagnostic disable-next-line: param-type-mismatch
            local stats = vim.uv.fs_stat(vim.fn.argv(0))
            if stats and stats.type == "directory" then
              require("neo-tree")
            end
          end
        end,
      })
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
        icon = {
          provider = function(icon, node)
            local text, hl
            local mini_icons = require("mini.icons")
            if node.type == "file" then
              text, hl = mini_icons.get("file", node.name)
            elseif node.type == "directory" then
              text, hl = mini_icons.get("directory", node.name)
              if node:is_expanded() then
                text = nil
              end
            end

            if text then
              icon.text = text
            end
            if hl then
              icon.highlight = hl
            end
          end,
        },
        kind_icon = {
          provider = function(icon, node)
            icon.text, icon.highlight = require("mini.icons").get("lsp", node.extra.kind.name)
          end,
        },
      },
    },
    config = true,
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

  -- Jump between buffers faster than ever before
  -- {
  --   "voxelprismatic/rabbit.nvim",
  --   config = true,
  -- },

  -- Indent guides on blank lines for Neovim
  {
    "lukas-reineke/indent-blankline.nvim",
    event = { "BufReadPost", "BufNewFile" },
    main = "ibl",
    opts = {
      indent = { char = "│", tab_char = "├", highlight = "IblChar" },
      scope = { char = "│", highlight = "IblScopeChar" },
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
    config = function(_, opts)
      dofile(vim.g.base46_cache .. "blankline")

      local hooks = require("ibl.hooks")
      hooks.register(hooks.type.WHITESPACE, hooks.builtin.hide_first_space_indent_level)
      require("ibl").setup(opts)

      dofile(vim.g.base46_cache .. "blankline")
    end,
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
        char = {
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
      {
        "S",
        mode = { "n", "x", "o" },
        function()
          require("flash").treesitter()
        end,
        desc = "Flash Treesitter",
      },
    },
  },

  -- Precognition uses virtual text and gutter signs to show available motions
  -- Missing more hints
  -- {
  --   "tris203/precognition.nvim",
  --   keys = {
  --     {
  --       "<leader>f",
  --       mode = { "n", "x", "o" },
  --       function()
  --         require("precognition").peek()
  --       end,
  --       desc = "Precognition",
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

  -- autopairs for neovim written in lua
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = true,
  },

  {
    "xvzc/chezmoi.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    init = function()
      vim.g["chezmoi#use_tmp_buffer"] = 1
      vim.g["chezmoi#source_dir_path"] = os.getenv("HOME") .. "/.local/share/chezmoi"

      -- run chezmoi edit on file enter
      vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
        pattern = { os.getenv("HOME") .. "/.local/share/chezmoi/*" },
        callback = function()
          vim.schedule(require("chezmoi.commands.__edit").watch)
        end,
      })

      Pick_chezmoi = function()
        local results = require("chezmoi.commands").list({
          args = {
            "--path-style",
            "absolute",
            "--include",
            "files",
            "--exclude",
            "externals",
          },
        })
        local items = {}

        for _, czFile in ipairs(results) do
          table.insert(items, {
            text = czFile,
            file = czFile,
          })
        end

        local opts = {
          items = items,
          confirm = function(picker, item)
            picker:close()
            require("chezmoi.commands").edit({
              targets = { item.text },
              args = { "--watch" },
            })
          end,
        }

        ---@diagnostic disable-next-line: undefined-global
        Snacks.picker.pick(opts)
      end
    end,
    opts = {
      edit = {
        watch = false,
        force = false,
      },
      notification = {
        on_open = true,
        on_apply = true,
        on_watch = false,
      },
    },
    keys = {
      {
        "<C-c>",
        function()
          Pick_chezmoi()
        end,
        desc = "Chezmoi",
      },
    },
  },

  {
    "nvim-treesitter/nvim-treesitter-context",
    event = { "BufReadPost", "BufNewFile" },
    opts = { mode = "cursor", max_lines = 3 },
  },

  {
    "nvim-treesitter/nvim-treesitter",
    event = { "BufReadPost", "BufNewFile" },
    cmd = "TSUpdateSync",
    build = ":TSUpdate",
    version = false,
    dependencies = {
      {
        "nvim-treesitter/nvim-treesitter-textobjects",
      },
    },
    config = require("plugins.configs.nvim-treesitter"),
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
    opts = {
      -- Event to trigger linters
      events = { "BufWritePost", "BufReadPost", "InsertLeave" },
      linters_by_ft = {
        sh = { "shellcheck", "shellharden" },
        zsh = { "shellcheck", "shellharden" },
        bats = { "shellcheck", "shellharden" },
        -- lua = { "luacheck" }, -- No required. Called by LSP
        yaml = { "yamllint" },
      },
      linters = {
        sh = { "shellcheck", "shellharden" },
        zsh = { "shellcheck", "shellharden" },
        bats = { "shellcheck", "shellharden" },
        -- lua = { "luacheck" }, -- No required. Called by LSP
        yaml = { "yamllint" },
      },
    },
    config = require("plugins.configs.nvim-lint"),
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
          ---@diagnostic disable-next-line: undefined-field
          require("conform").format({ async = true, lsp_fallback = true })
        end,
        mode = { "n", "v" },
        desc = "Format buffer",
      },
    },
    config = require("plugins.configs.conform"),
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
      "MasonLog",
      "MasonUpdate",
      "MasonUpdateAll",
    },
    opts = {
      ui = {
        icons = {
          package_pending = " ",
          package_installed = " ",
          package_uninstalled = " ",
        },
      },
      ensure_installed = {
        -- Formatters
        "clang-format",
        "prettier",
        "ruff",
        "shfmt",
        "stylua",
        "yamlfmt",

        -- Linters
        "yamllint",
        "luacheck",
        "shellcheck",
        "shellharden",
      },
      max_concurrent_installers = 10,
    },

    -- :MasonUpdate updates registry contents
    build = ":MasonUpdate",
    -- Add ":MasonUpdateAll"
    dependencies = { "Zeioth/mason-extra-cmds", opts = {} },
    config = function(_, opts)
      require("mason").setup(opts)
      local mr = require("mason-registry")
      local function ensure_installed()
        for _, tool in ipairs(opts.ensure_installed) do
          local p = mr.get_package(tool)
          if not p:is_installed() then
            p:install()
          end
        end
      end
      if mr.refresh then
        mr.refresh(ensure_installed)
      else
        ensure_installed()
      end
    end,
  },

  {
    "neovim/nvim-lspconfig",
    event = "BufReadPre",
    dependencies = {
      { "williamboman/mason-lspconfig.nvim" },
    },
    config = require("plugins.configs.lspconfig"),
  },

  -- Performant, batteries-included completion plugin for Neovim
  {
    "saghen/blink.cmp",
    lazy = false, -- lazy loading handled internally
    event = "InsertCharPre",
    dependencies = {
      "rafamadriz/friendly-snippets",
      "mikavilpas/blink-ripgrep.nvim",
      "Kaiser-Yang/blink-cmp-avante",
    },
    build = "cargo build --release",
    opts = {
      sources = {
        default = {
          "lsp",
          "avante",
          "snippets",
          "buffer",
          "ripgrep",
          "path",
        },
        providers = {
          ripgrep = {
            module = "blink-ripgrep",
            name = "Ripgrep",
            opts = {
              get_command = function(_, prefix)
                return {
                  "rg",
                  "--no-config",
                  "--json",
                  "--word-regexp",
                  "--ignore-case",
                  "--",
                  prefix .. "[\\w_-]+",
                  vim.fs.root(0, ".git") or vim.fn.getcwd(),
                }
              end,
              get_prefix = function()
                local col = vim.api.nvim_win_get_cursor(0)[2]
                local line = vim.api.nvim_get_current_line()
                local prefix = line:sub(1, col):match("[%w_-]+$") or ""
                return prefix
              end,
            },
          },
          avante = {
            module = "blink-cmp-avante",
            name = "Avante",
            opts = {},
          },
        },
      },
      keymap = {
        ["<Tab>"] = { "select_next", "snippet_forward", "fallback" },
        ["<S-Tab>"] = { "select_prev", "snippet_backward", "fallback" },
        ["<Up>"] = { "select_prev", "fallback" },
        ["<Down>"] = { "select_next", "fallback" },
        ["<CR>"] = { "accept", "fallback" },
        ["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
      },
      fuzzy = { implementation = "prefer_rust" },
      cmdline = { completion = { ghost_text = { enabled = false } } },
      completion = {
        accept = { auto_brackets = { enabled = true } },
        list = {
          max_items = 10,
          selection = {
            preselect = function(ctx)
              return ctx.mode ~= "cmdline"
            end,
            auto_insert = function(ctx)
              return ctx.mode ~= "cmdline"
            end,
          },
        },
        menu = {
          draw = {
            treesitter = { "lsp" },
          },
        },
      },
    },
  },
  {
    "yetone/avante.nvim",
    event = "VeryLazy",
    version = false, -- Never set this value to "*"! Never!
    opts = {
      -- provider = "openai",
      provider = "claude",
      behaviour = {
        enable_token_counting = false,
        enable_claude_text_editor_tool_mode = true,
      },
      hints = { enabled = false },
      openai = {
        timeout = 30000,
      },
      cursor_applying_provider = "claude",
      windows = {
        width = 45,
      },
    },
    -- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
    build = "make",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "stevearc/dressing.nvim",
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
    },
  },

  {
    "GeorgesAlkhouri/nvim-aider",
    cmd = {
      "AiderTerminalToggle",
      "AiderHealth",
    },
    keys = {
      { "<leader>a/", "<cmd>AiderTerminalToggle<cr>", desc = "Open Aider" },
      -- { "<leader>as", "<cmd>AiderTerminalSend<cr>", desc = "Send to Aider", mode = { "n", "v" } },
      -- { "<leader>ac", "<cmd>AiderQuickSendCommand<cr>", desc = "Send Command To Aider" },
      -- { "<leader>ab", "<cmd>AiderQuickSendBuffer<cr>", desc = "Send Buffer To Aider" },
      -- { "<leader>a+", "<cmd>AiderQuickAddFile<cr>", desc = "Add File to Aider" },
      -- { "<leader>a-", "<cmd>AiderQuickDropFile<cr>", desc = "Drop File from Aider" },
      -- { "<leader>ar", "<cmd>AiderQuickReadOnlyFile<cr>", desc = "Add File as Read-Only" },
      -- -- Example nvim-tree.lua integration if needed
      -- { "<leader>a+", "<cmd>AiderTreeAddFile<cr>", desc = "Add File from Tree to Aider", ft = "NvimTree" },
      -- { "<leader>a-", "<cmd>AiderTreeDropFile<cr>", desc = "Drop File from Tree from Aider", ft = "NvimTree" },
    },
    dependencies = {
      "folke/snacks.nvim",
    },
    config = true,
  },

  -- A Neovim plugin that display prettier diagnostic messages
  -- Display diagnostic messages where the cursor is, with icons and colors
  {
    "rachartier/tiny-inline-diagnostic.nvim",
    event = "VeryLazy", -- Or `LspAttach`
    priority = 1000, -- needs to be loaded in first
    config = function()
      require("tiny-inline-diagnostic").setup()
      -- Only if needed in your configuration, if you already have native LSP diagnostics
      vim.diagnostic.config({ virtual_text = false })
    end,
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
        default_commands = true,
        disable_diagnostics = true,
      })
    end,
  },

  -- git signs highlights text that has changed since the list
  -- git commit, and also lets you interactively stage & unstage
  -- hunks in a commit
  {
    "lewis6991/gitsigns.nvim",
    event = "User FilePost",
    opts = function()
      return require("plugins.configs.gitsigns")
    end,
  },

  -- Automatically highlights other instances of the word under your cursor.
  -- This works with LSP, Treesitter, and regexp matching to find the other
  -- instances
  {
    "RRethy/vim-illuminate",
    event = "BufReadPre",
    config = function()
      require("illuminate").configure({
        delay = 200,
        min_count_to_highlight = 2,
        large_file_cutoff = 2000,
        large_file_overrides = { providers = { "lsp" } },
      })
    end,
  },

  -- 😽 Open your Kitty scrollback buffer with Neovim
  {
    "mikesmithgh/kitty-scrollback.nvim",
    lazy = true,
    cmd = { "KittyScrollbackGenerateKittens", "KittyScrollbackCheckHealth" },
    event = { "User KittyScrollbackLaunch" },
    config = true,
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

  -- A spelling auto correct plugin for Neovim including over 20k entries
  -- {
  --   "https://github.com/ck-zhang/mistake.nvim",
  -- },

  -- Sync textarea against Neovim in terminal
  { "subnut/nvim-ghost.nvim" },


  -- Notify when a plugin has been abandoned
  {
    "ZWindL/orphans.nvim",
    config = true,
  },

  -- Just work with a little set of languages
  -- {
  --   "https://github.com/ThePrimeagen/refactoring.nvim",
  --   event = { "BufReadPre", "BufNewFile" },
  --   dependencies = {
  --     "https://github.com/nvim-lua/plenary.nvim",
  --     "https://github.com/nvim-treesitter/nvim-treesitter",
  --   },
  --   keys = {
  --     {
  --       "<leader>cr",
  --       function()
  --         require("refactoring").select_refactor()
  --       end,
  --       mode = { "n", "v" },
  --       desc = "List refactoring",
  --     },
  --     {
  --       "<leader>cv",
  --       ":Refactor extract_var<CR>",
  --       mode = { "n", "v" },
  --       desc = "Refactor Variables",
  --     },
  --   },
  -- },

  -- Notify when a plugin has been abandoned
  {
    "ZWindL/orphans.nvim",
    config = true,
  },

  -- A simply utility for loading encrypted secrets from an age encrypted file
  {
    "histrio/age-secret.nvim",
    opts = {
      identity = vim.fn.expand("$HOME/.config/age/identity.key"),
      recipient = "age15pv6yqycjhzs7x2jpafwce0qkvnjpkyrv77lrdsd5l4azt7zudzsmqedjs",
    },
    config = true,
  },

  -- run lines/blocs of code (independently of the rest of the file), supporting multiples languages
  -- {
  --   "michaelb/sniprun",
  --   branch = "master",
  --   opts = {
  --     interpreter_options = {
  --       C_original = {
  --         compiler = "clang",
  --       },
  --     },
  --   },
  --   build = "sh install.sh",
  --   config = true,
  -- },

  -- Debugging in NeoVim the print() way!
  -- {
  --   "andrewferrier/debugprint.nvim",
  --
  --   dependencies = {
  --     "echasnovski/mini.nvim", -- Needed for :ToggleCommentDebugPrints (not needed for NeoVim 0.10+)
  --   },
  --   config = true,
  -- },

  -- {
  --   "sindrets/diffview.nvim",
  --   dependencies = { "nvim-lua/plenary.nvim" },
  --   cmd = { "DiffviewOpen", "DiffviewClose" },
  --   keys = {
  --     {
  --       "<leader>gd",
  --       function()
  --         if next(require("diffview.lib").views) == nil then
  --           vim.cmd("DiffviewOpen")
  --         else
  --           vim.cmd("DiffviewClose")
  --         end
  --       end,
  --       desc = "Diff Index",
  --     },
  --   },
  --   config = require("plugins.configs.diffview"),
  -- },

  -- Smart selection of the closest text object
  -- {
  --   "sustech-data/wildfire.nvim",
  --   event = "VeryLazy",
  --   config = true,
  -- },
}
