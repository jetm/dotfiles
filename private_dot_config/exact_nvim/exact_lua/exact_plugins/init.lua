if vim.g.vscode then
  return
end

return {
  -- plenary: full; complete; entire; absolute; unqualified.
  -- All the lua functions I don't want to write twice
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

  {
    "ibhagwan/fzf-lua",
    lazy = false,
    -- optional for icon support
    dependencies = { "echasnovski/mini.icons" },
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
        enabled = false,
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
      -- {
      --   "<C-p>",
      --   function()
      --     ---@diagnostic disable-next-line: undefined-global
      --     Snacks.picker.files()
      --   end,
      --   desc = "Find Files",
      -- },
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

  -- {
  --   "HiPhish/rainbow-delimiters.nvim",
  --   submodules = false,
  --   event = { "BufReadPre", "BufNewFile" },
  -- },

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
  -- {
  --   "MagicDuck/grug-far.nvim",
  --   opts = {
  --     headerMaxWidth = 80,
  --     maxWorkers = 16,
  --     keymaps = {
  --       close = { n = "q" },
  --     },
  --   },
  --   cmd = "GrugFar",
  --   keys = {
  --     {
  --       "<leader>g",
  --       function()
  --         local grug = require("grug-far")
  --         grug.open({
  --           prefills = {
  --             search = vim.fn.expand("<cword>"),
  --           },
  --         })
  --       end,
  --       mode = { "n" },
  --       desc = "Search and Replace current word",
  --     },
  --     {
  --       "<leader>gv",
  --       function()
  --         local grug = require("grug-far")
  --         local ext = vim.bo.buftype == "" and vim.fn.expand("%:e")
  --         grug.open({
  --           prefills = {
  --             filesFilter = ext and ext ~= "" and "*." .. ext or nil,
  --           },
  --         })
  --       end,
  --       mode = { "n", "v" },
  --       desc = "Search and Replace viusal selection",
  --     },
  --   },
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
  --   "nvim-neo-tree/neo-tree.nvim",
  --   branch = "v3.x",
  --   dependencies = {
  --     "nvim-lua/plenary.nvim",
  --     "MunifTanjim/nui.nvim",
  --   },
  --   cmd = "Neotree",
  --   keys = {
  --     {
  --       "<leader>e",
  --       function()
  --         require("neo-tree.command").execute({
  --           toggle = true,
  --           ---@diagnostic disable-next-line: undefined-field
  --           dir = vim.uv.cwd(),
  --         })
  --       end,
  --       desc = "Explorer NeoTree (cwd)",
  --     },
  --   },
  --   deactivate = function()
  --     vim.cmd([[Neotree close]])
  --   end,
  --   init = function()
  --     vim.api.nvim_create_autocmd("BufEnter", {
  --       group = vim.api.nvim_create_augroup("Neotree_start_directory", { clear = true }),
  --       desc = "Start Neo-tree with directory",
  --       once = true,
  --       callback = function()
  --         if package.loaded["neo-tree"] then
  --           return
  --         else
  --           ---@diagnostic disable-next-line: undefined-field, param-type-mismatch
  --           local stats = vim.uv.fs_stat(vim.fn.argv(0))
  --           if stats and stats.type == "directory" then
  --             require("neo-tree")
  --           end
  --         end
  --       end,
  --     })
  --   end,
  --   opts = {
  --     sources = { "filesystem", "buffers", "git_status", "document_symbols" },
  --     open_files_do_not_replace_types = {
  --       "terminal",
  --       "Trouble",
  --       "qf",
  --       "Outline",
  --     },
  --     filesystem = {
  --       bind_to_cwd = false,
  --       follow_current_file = { enabled = true },
  --       use_libuv_file_watcher = true,
  --     },
  --     window = {
  --       mappings = {
  --         ["<space>"] = "none",
  --       },
  --     },
  --     default_component_configs = {
  --       indent = {
  --         with_expanders = true, -- if nil and file nesting is enabled, will enable expanders
  --         expander_collapsed = "",
  --         expander_expanded = "",
  --         expander_highlight = "NeoTreeExpander",
  --       },
  --       icon = {
  --         provider = function(icon, node)
  --           local text, hl
  --           local mini_icons = require("mini.icons")
  --           if node.type == "file" then
  --             text, hl = mini_icons.get("file", node.name)
  --           elseif node.type == "directory" then
  --             text, hl = mini_icons.get("directory", node.name)
  --             if node:is_expanded() then
  --               text = nil
  --             end
  --           end
  --
  --           if text then
  --             icon.text = text
  --           end
  --           if hl then
  --             icon.highlight = hl
  --           end
  --         end,
  --       },
  --       kind_icon = {
  --         provider = function(icon, node)
  --           icon.text, icon.highlight = require("mini.icons").get("lsp", node.extra.kind.name)
  --         end,
  --       },
  --     },
  --   },
  --   config = true,
  -- },

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
  -- {
  --   "lukas-reineke/indent-blankline.nvim",
  --   event = { "BufReadPost", "BufNewFile" },
  --   main = "ibl",
  --   opts = {
  --     indent = { char = "│", tab_char = "├", highlight = "IblChar" },
  --     scope = { char = "│", highlight = "IblScopeChar" },
  --     exclude = {
  --       buftypes = {
  --         "nofile",
  --         "terminal",
  --       },
  --       filetypes = {
  --         "help",
  --         "startify",
  --         "aerial",
  --         "alpha",
  --         "dashboard",
  --         "lazy",
  --         "neogitstatus",
  --         "NvimTree",
  --         "neo-tree",
  --         "Trouble",
  --       },
  --     },
  --   },
  --   config = function(_, opts)
  --     dofile(vim.g.base46_cache .. "blankline")
  --
  --     local hooks = require("ibl.hooks")
  --     hooks.register(hooks.type.WHITESPACE, hooks.builtin.hide_first_space_indent_level)
  --     require("ibl").setup(opts)
  --
  --     dofile(vim.g.base46_cache .. "blankline")
  --   end,
  -- },

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
  -- {
  --   "echasnovski/mini.align",
  --   event = "InsertEnter",
  --   version = false,
  --   config = true,
  -- },

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
      -- remote_op = {
      --   restore = true,
      --   motion = true,
      -- },
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
      {
        "r",
        mode = "o",
        function()
          require("flash").remote()
        end,
        desc = "Remote Flash",
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

  -- {
  --   "m4xshen/hardtime.nvim",
  --   event = { "BufReadPre", "BufNewFile" },
  --   dependencies = "neovim/nvim-lspconfig",
  --   opts = {
  --     disable_mouse = false,
  --     restricted_keys = {
  --       ["h"] = { "n", "v" },
  --       ["j"] = { "n", "v" },
  --       ["k"] = { "n", "v" },
  --       ["l"] = { "n", "v" },
  --       ["gj"] = { "n", "v" },
  --       ["gk"] = { "n", "v" },
  --       ["<CR>"] = { "n", "v" },
  --     },
  --   },
  -- },

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

      -- Pick_chezmoi = function()
      --   local results = require("chezmoi.commands").list({
      --     args = {
      --       "--path-style=absolute",
      --       "--include=files",
      --       "--exclude=externals",
      --     },
      --   })
      --   local items = {}
      --
      --   for _, czFile in ipairs(results) do
      --     table.insert(items, {
      --       text = czFile,
      --       file = czFile,
      --     })
      --   end
      --
      --   local opts = {
      --     items = items,
      --     confirm = function(picker, item)
      --       picker:close()
      --       require("chezmoi.commands").edit({
      --         targets = { item.text },
      --         args = { "--watch" },
      --       })
      --     end,
      --   }
      --
      --   ---@diagnostic disable-next-line: undefined-global
      --   Snacks.picker.pick(opts)
      -- end

      -- fzf-lua
      Pick_chezmoi = function()
        local fzf_lua = require("fzf-lua")
        local chezmoi = require("chezmoi.commands")
        local files = chezmoi.list({
          args = {
            "--path-style=absolute",
            "--include=files",
            "--exclude=externals",
          },
        })
        local opts = {
          fzf_opts = {},
          file_icons = true,
          actions = {
            ["default"] = function(selected)
              -- Remove the icon and leading whitespace from selected[1]
              local sanitized_path = selected[1]:gsub("^[^%w~/.]+", "") -- Matches the icon and trims it
              -- Use the sanitized path with chezmoi
              chezmoi.edit({
                targets = { sanitized_path },
                args = { "--watch" },
              })
            end,
          },
        }

        files = vim.tbl_map(function(x)
          return fzf_lua.make_entry.file(x, { file_icons = true, color_icons = true })
        end, files)
        fzf_lua.fzf_exec(files, opts)
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
    branch = "main",
    version = false, -- last release too old
    cmd = { "TSUpdate", "TSInstall", "TSLog", "TSUninstall" },
    build = ":TSUpdate",
    lazy = vim.fn.argc(-1) == 0, -- load treesitter early when opening a file from the cmdline
  },

  -- wrapper around new rewrite of nvim-treesitter in main branch
  {
    "MeanderingProgrammer/treesitter-modules.nvim",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    opts = {
      ensure_installed = {
        "bash",
        "c",
        "cmake",
        "comment",
        "devicetree",
        "diff",
        "dockerfile",
        "git_rebase",
        "gitcommit",
        "go",
        "json",
        "kconfig",
        "lua",
        "luadoc",
        "luap",
        "make",
        "markdown",
        "markdown_inline",
        "ninja",
        "printf",
        "python",
        "query",
        "regex",
        "rust",
        "ssh_config",
        "toml",
        "typescript",
        "vim",
        "vimdoc",
        "xml",
        "yaml",
      },
      fold = { enable = false },
      highlight = { enable = true },
      indent = { enable = true },
      incremental_selection = { enable = true },
    },
  },

  -- Linter
  {
    "mfussenegger/nvim-lint",
    event = "VeryLazy",
    config = function()
      local lint = require("lint")

      lint.linters_by_ft = {
        sh = { "shellcheck" },
        zsh = { "shellcheck" },
        bats = { "shellcheck" },
        -- lua = { "luacheck" }, -- No required. Called by LSP
        yaml = { "yamllint" },
        json = { "jsonlint" },
        -- python = { "ruff" }, -- Enabled by pyls
      }

      -- Configure yamllint options
      lint.linters.yamllint.args = {
        "--format=parsable", -- Required by nvim to parse output
        "-d",
        "rules: {indentation: {indent-sequences: consistent}}",
        "-",
      }

      local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

      vim.api.nvim_create_autocmd({ "BufWritePost", "BufReadPost", "InsertLeave" }, {
        group = lint_augroup,
        callback = function()
          lint.try_lint()
        end,
      })

      lint.try_lint()
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
    "mason-org/mason.nvim",
    cmd = {
      "Mason",
      "MasonInstall",
      "MasonUninstall",
      "MasonUninstallAll",
      "MasonLog",
    },
    opts = {
      ui = {
        icons = {
          package_pending = " ",
          package_installed = " ",
          package_uninstalled = " ",
        },
      },
    },
  },

  {
    "b0o/schemastore.nvim",
    lazy = true,
    config = function()
      require("schemastore").setup({
        settings = {
          json = {
            schemas = require("schemastore").json.schemas(),
            validate = { enable = true },
          },
          yaml = {
            format = { enable = true, singleQuote = true },
            validate = true,
            hover = true,
            completion = true,
            schemaStore = {
              enable = true,
              url = "https://www.schemastore.org/api/json/catalog.json",
            },
            schemas = require("schemastore").yaml.schemas({
              ["https://gitlab.com/gitlab-org/gitlab/-/raw/master/app/assets/javascripts/editor/schema/ci.json"] = ".gitlab-ci.{yml,yaml}",
            }),
          },
        },
      })
    end,
  },

  {
    "p00f/clangd_extensions.nvim",
    lazy = true,
  },

  {
    "AstroNvim/astrolsp",
    lazy = true,
    opts = {
      -- Use native vim.lsp.enable() instead of lspconfig.setup()
      native_lsp_config = true,
      -- configuration table of features provided by AstroLSP
      features = {
        codelens = true, -- enable/disable codelens refresh on start
        inlay_hints = true, -- enable/disable inlay hints on start
        semantic_tokens = true, -- enable/disable semantic token highlighting
      },
      -- lsp client capabilities
      capabilities = vim.lsp.protocol.make_client_capabilities(),
      -- use conform.nvim for formatting
      formatting = { disabled = true },
      -- enable servers that you already have installed without mason
      servers = {},
      -- LSP server configurations are in init.lua via vim.lsp.config()
      config = {},
      -- configuration of LSP file operation functionality
      file_operations = {
        -- the timeout when executing LSP client operations
        timeout = 10000,
        -- fully disable/enable file operation methods
        -- don't need any of these since already does these things
        operations = {
          willRename = false,
          didRename = false,
          willCreate = false,
          didCreate = false,
          willDelete = false,
          didDelete = false,
        },
      },
      -- custom `on_attach` function to be run after the default `on_attach` function, takes two parameters `client` and `bufnr`
      on_attach = nil,
      -- configure buffer local auto commands to add when attaching a language server
      autocmds = {
        -- first key is the `augroup` to add the auto commands to (:h augroup)
        lsp_document_highlight = {
          cond = "textDocument/documentHighlight",
          -- list of auto commands to set
          {
            -- events to trigger
            event = { "CursorHold", "CursorHoldI" },
            -- the rest of the autocmd options (:h nvim_create_autocmd)
            desc = "Document Highlighting",
            callback = function()
              vim.lsp.buf.document_highlight()
            end,
          },
          {
            event = { "CursorMoved", "CursorMovedI", "BufLeave" },
            desc = "Document Highlighting Clear",
            callback = function()
              vim.lsp.buf.clear_references()
            end,
          },
        },
        lsp_codelens_refresh = {
          cond = "textDocument/codeLens",
          {
            event = { "TextChanged", "InsertLeave", "BufEnter" },
            desc = "Refresh codelens (buffer)",
            callback = function(args)
              if require("astrolsp").config.features.codelens then
                vim.lsp.codelens.refresh({ bufnr = args.buf })
              end
            end,
          },
        },
        disable_inlay_hints_on_insert = {
          -- only create for language servers that support inlay hints
          -- (and only if vim.lsp.inlay_hint is available)
          cond = vim.lsp.inlay_hint and "textDocument/inlayHint" or false,
          {
            -- when going into insert mode
            event = "InsertEnter",
            desc = "Disable inlay hints on insert",
            callback = function(args)
              local filter = { bufnr = args.buf }
              -- if the inlay hints are currently enabled
              if vim.lsp.inlay_hint.is_enabled(filter) then
                -- disable the inlay hints
                vim.lsp.inlay_hint.enable(false, filter)
                -- create a single use autocommand to turn the inlay hints back on
                -- when leaving insert mode
                vim.api.nvim_create_autocmd("InsertLeave", {
                  buffer = args.buf,
                  once = true,
                  callback = function()
                    vim.lsp.inlay_hint.enable(true, filter)
                  end,
                })
              end
            end,
          },
        },
        disable_virtual_lines_on_cursor_move = {
          {
            event = "CursorMoved",
            desc = "Disable virtual lines on cursor move",
            callback = function()
              vim.diagnostic.config({ virtual_lines = false, virtual_text = true })
            end,
          },
        },
      },
    },
  },

  {
    "neovim/nvim-lspconfig",
    dependencies = {
      { "AstroNvim/astrolsp" },
      {
        "mason-org/mason-lspconfig.nvim", -- MUST be set up before `nvim-lspconfig`
        dependencies = { "mason-org/mason.nvim" },
        opts_extend = { "ensure_installed" },
        opts = {
          ensure_installed = {},
          -- use AstroLSP setup for mason-lspconfig
          handlers = {
            function(server)
              require("astrolsp").lsp_setup(server)
            end,
          },
        },
        config = function(_, opts)
          opts.ensure_installed = nil
          -- Optionally tell AstroLSP to register new language servers before calling the `setup` function
          -- this enables the `mason-lspconfig.servers` option in the AstroLSP configuration
          require("astrolsp.mason-lspconfig").register_servers()
          require("mason-lspconfig").setup(opts)
        end,
      },
      {
        "WhoIsSethDaniel/mason-tool-installer.nvim",
        cmd = {
          "MasonToolsInstall",
          "MasonToolsInstallSync",
          "MasonToolsUpdate",
          "MasonToolsUpdateSync",
          "MasonToolsClean",
        },
        opts = {
          ensure_installed = {
            -- LSP servers
            "bashls",
            "clangd",
            "harper-ls",
            "jinja_lsp",
            "jsonls",
            "lua_ls",
            "ruff",

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
            "jsonlint",
          },
        },
        config = function(_, opts)
          local mason_tool_installer = require("mason-tool-installer")
          mason_tool_installer.setup(opts)
          if opts.run_on_start ~= false then
            mason_tool_installer.run_on_start()
          end
        end,
      },
    },
    config = function()
      dofile(vim.g.base46_cache .. "lsp")
      require("nvchad.lsp").diagnostic_config()
      require("plugins.configs.lspconfig") -- Load LSP server configurations
      vim.tbl_map(require("astrolsp").lsp_setup, require("astrolsp").config.servers)
    end,
  },

  -- Performant, batteries-included completion plugin for Neovim
  {
    "saghen/blink.cmp",
    lazy = false, -- lazy loading handled internally
    event = "InsertCharPre",
    dependencies = {
      "rafamadriz/friendly-snippets",
      "mikavilpas/blink-ripgrep.nvim",
    },
    build = "cargo build --release",
    opts = {
      sources = {
        default = {
          "lazydev",
          "lsp",
          "snippets",
          "buffer",
          "ripgrep",
          "path",
        },
        providers = {
           lazydev = {
            name = "LazyDev",
            module = "lazydev.integrations.blink",
            -- make lazydev completions top priority (see `:h blink.cmp`)
            score_offset = 100,
          },
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

  -- {
  --   "Bekaboo/dropbar.nvim",
  --   dependencies = {
  --     "nvim-telescope/telescope-fzf-native.nvim",
  --     build = "make -j${nproc}",
  --   },
  --   config = function()
  --     local dropbar_api = require("dropbar.api")
  --     vim.keymap.set("n", "<Leader>;", dropbar_api.pick, { desc = "Pick symbols in winbar" })
  --     vim.keymap.set("n", "[;", dropbar_api.goto_context_start, { desc = "Go to start of current context" })
  --     vim.keymap.set("n", "];", dropbar_api.select_next_context, { desc = "Select next context" })
  --   end,
  -- },

  -- better diffing
  -- ]x - move to previous conflict
  -- [x - move to next conflict
  -- co - choose ours
  -- ct - choose theirs
  -- cb - choose both
  -- c0 - choose none
  -- Visualise and resolve merge conflicts in neovim
  -- {
  --   "akinsho/git-conflict.nvim",
  --   event = "BufReadPre",
  --   config = function()
  --     require("git-conflict").setup({
  --       default_commands = true,
  --       disable_diagnostics = true,
  --     })
  --   end,
  -- },

  {
    "esmuellert/codediff.nvim",
    dependencies = { "MunifTanjim/nui.nvim" },
    cmd = "CodeDiff",
    config = function()
      require("codediff").setup({
        -- Highlight configuration
        highlights = {
          -- Line-level: accepts highlight group names or hex colors (e.g., "#2ea043")
          line_insert = "DiffAdd", -- Line-level insertions
          line_delete = "DiffDelete", -- Line-level deletions

          -- Character-level: accepts highlight group names or hex colors
          -- If specified, these override char_brightness calculation
          char_insert = nil, -- Character-level insertions (nil = auto-derive)
          char_delete = nil, -- Character-level deletions (nil = auto-derive)

          -- Brightness multiplier (only used when char_insert/char_delete are nil)
          -- nil = auto-detect based on background (1.4 for dark, 0.92 for light)
          char_brightness = nil, -- Auto-adjust based on your colorscheme

          -- Conflict sign highlights (for merge conflict views)
          -- Accepts highlight group names or hex colors (e.g., "#f0883e")
          -- nil = use default fallback chain
          conflict_sign = nil, -- Unresolved: DiagnosticSignWarn -> #f0883e
          conflict_sign_resolved = nil, -- Resolved: Comment -> #6e7681
          conflict_sign_accepted = nil, -- Accepted: GitSignsAdd -> DiagnosticSignOk -> #3fb950
          conflict_sign_rejected = nil, -- Rejected: GitSignsDelete -> DiagnosticSignError -> #f85149
        },

        -- Diff view behavior
        diff = {
          disable_inlay_hints = true, -- Disable inlay hints in diff windows for cleaner view
          max_computation_time_ms = 5000, -- Maximum time for diff computation (VSCode default)
          hide_merge_artifacts = false, -- Hide merge tool temp files (*.orig, *.BACKUP.*, *.BASE.*, *.LOCAL.*, *.REMOTE.*)
          original_position = "left", -- Position of original (old) content: "left" or "right"
          conflict_ours_position = "right", -- Position of ours (:2) in conflict view: "left" or "right"
        },

        -- Explorer panel configuration
        explorer = {
          position = "left", -- "left" or "bottom"
          width = 40, -- Width when position is "left" (columns)
          height = 15, -- Height when position is "bottom" (lines)
          indent_markers = true, -- Show indent markers in tree view (│, ├, └)
          icons = {
            folder_closed = "", -- Nerd Font folder icon (customize as needed)
            folder_open = "", -- Nerd Font folder-open icon
          },
          view_mode = "list", -- "list" or "tree"
          file_filter = {
            ignore = {}, -- Glob patterns to hide (e.g., {"*.lock", "dist/*"})
          },
        },

        -- Keymaps in diff view
        keymaps = {
          view = {
            quit = "q", -- Close diff tab
            toggle_explorer = "<leader>b", -- Toggle explorer visibility (explorer mode only)
            next_hunk = "]c", -- Jump to next change
            prev_hunk = "[c", -- Jump to previous change
            next_file = "]f", -- Next file in explorer mode
            prev_file = "[f", -- Previous file in explorer mode
            diff_get = "do", -- Get change from other buffer (like vimdiff)
            diff_put = "dp", -- Put change to other buffer (like vimdiff)
          },
          explorer = {
            select = "<CR>", -- Open diff for selected file
            hover = "K", -- Show file diff preview
            refresh = "R", -- Refresh git status
            toggle_view_mode = "i", -- Toggle between 'list' and 'tree' views
            toggle_stage = "-", -- Stage/unstage selected file
            stage_all = "S", -- Stage all files
            unstage_all = "U", -- Unstage all files
            restore = "X", -- Discard changes (restore file)
          },
          conflict = {
            accept_incoming = "ct", -- Accept incoming (theirs/left) change
            accept_current = "co", -- Accept current (ours/right) change
            accept_both = "cb", -- Accept both changes (incoming first)
            discard = "cx", -- Discard both, keep base
            next_conflict = "]x", -- Jump to next conflict
            prev_conflict = "[x", -- Jump to previous conflict
            diffget_incoming = "2do", -- Get hunk from incoming (left/theirs) buffer
            diffget_current = "3do", -- Get hunk from current (right/ours) buffer
          },
        },
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

  -- Sync textarea against Neovim in terminal
  {
    "subnut/nvim-ghost.nvim",
    cmd = "GhostTextStart",
    init = function()
      -- Start manually
      vim.g.nvim_ghost_autostart = 0
    end,
  },

  -- Change multiple words at once
  -- {
  --   "jake-stewart/multicursor.nvim",
  --   event = "VeryLazy",
  --   config = function()
  --     local mc = require("multicursor-nvim")
  --     mc.setup()
  --     local map = vim.keymap.set
  --
  --     map({ "n", "v" }, "<M-Down>", function()
  --       mc.matchAddCursor(1)
  --     end)
  --     map({ "n", "v" }, "<M-Left>", function()
  --       mc.matchSkipCursor(1)
  --     end)
  --     map("n", "<Esc>", function()
  --       if mc.cursorsEnabled() then
  --         mc.clearCursors()
  --       end
  --     end)
  --   end,
  -- },
  --
  -- -- Notify when a plugin has been abandoned
  -- {
  --   "ZWindL/orphans.nvim",
  --   config = true,
  -- },

  -- A simply utility for loading encrypted secrets from an age encrypted file
  {
    "histrio/age-secret.nvim",
    opts = {
      identity = vim.fn.expand("$HOME/.config/age/identity.key"),
      recipient = "age15pv6yqycjhzs7x2jpafwce0qkvnjpkyrv77lrdsd5l4azt7zudzsmqedjs",
    },
    config = true,
  },

  -- {
  --   "fei6409/log-highlight.nvim",
  -- },

  -- enhance gf/gF with look ahead and provide target-based file hopping
  -- Need to test it more
  -- { "HawkinsT/pathfinder.nvim" },

  -- Debugging in NeoVim the print() way!
  -- {
  --   "andrewferrier/debugprint.nvim",
  --
  --   config = true,
  -- },
}
