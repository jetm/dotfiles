return function(_, _)
  -- Install formatters and linters
  require("mason").setup({
    opts = {
      ensure_installed = {
        -- Formatters
        "shfmt",
        "stylua",
        "yamlfmt",
        "yamllint",
        "prettier",

        -- Linters
        "shellcheck",
        "luacheck",
        "shellharden",
      },
    },
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
  })

  local lsp_zero = require("lsp-zero")

  lsp_zero.on_attach(function(client, bufnr)
    -- see :help lsp-zero-keybindings
    -- to learn the available actions
    lsp_zero.default_keymaps({ buffer = bufnr })
  end)

  local lspconfig = require("lspconfig")

  -- Install LSP servers
  require("mason-lspconfig").setup({
    ensure_installed = {
      -- Language servers
      "bashls",
      "clangd",
      "dockerls",
      "jsonls",
      "lua_ls",
      "ruff",
      "yamlls",
    },
    handlers = {
      lsp_zero.default_setup,

      lua_ls = function()
        lspconfig.lua_ls.setup({
          settings = {
            Lua = {
              diagnostics = {
                -- Required to fix vim global warning
                -- Get the language server to recognize the `vim` global
                globals = {
                  "vim",
                  "require",
                },
              },
              format = { enable = false },
              completion = {
                callSnippet = "Replace",
              },
              workspace = {
                checkThirdParty = false,
              },
              telemetry = { enable = false },
            },
          },
        })
      end,

      clangd = function()
        lspconfig.clangd.setup({
          root_dir = function(fname)
            return require("lspconfig.util").root_pattern(
              "Makefile",
              "configure.ac",
              "configure.in",
              "config.h.in",
              "meson.build",
              "meson_options.txt",
              "build.ninja"
            )(fname) or require("lspconfig.util").root_pattern("compile_commands.json", "compile_flags.txt")(
              fname
            ) or require("lspconfig.util").find_git_ancestor(fname)
          end,
          cmd = {
            "clangd",
            "--background-index",
            "--clang-tidy",
            "--header-insertion=iwyu",
            "--completion-style=detailed",
            "--function-arg-placeholders",
            "--fallback-style=llvm",
          },
          init_options = {
            usePlaceholders = true,
            completeUnimported = true,
            clangdFileStatus = true,
          },
        })
      end,

      yamlls = function()
        lspconfig.yamlls.setup({
          settings = {
            redhat = { telemetry = { enabled = false } },
            yaml = {
              format = { enable = false },
              keyOrdering = false,
              completion = true,
              validate = { enable = true },
              schemaStore = {
                -- Must disable built-in schemaStore support to use
                -- schemas from SchemaStore.nvim plugin
                enable = false,
                -- Avoid TypeError: Cannot read properties of undefined (reading 'length')
                url = "",
              },
              schemas = require("schemastore").yaml.schemas(),
            },
          },
        })
      end,

      jsonls = function()
        lspconfig.jsonls.setup({
          settings = {
            jsonls = {
              format = { enable = false },
              validate = { enable = true },
              schemaStore = {
                -- Must disable built-in schemaStore support to use
                -- schemas from SchemaStore.nvim plugin
                enable = false,
              },
              schemas = require("schemastore").yaml.schemas(),
            },
          },
        })
      end,
    },
  })

  local function check_backspace()
    local col = vim.fn.col(".") - 1
    if col == 0 or vim.fn.getline("."):sub(col, col):match("%s") then
      return true
    else
      return false
    end
  end

  local luasnip = require("luasnip")

  -- Must setup `cmp` after lsp-zero
  local cmp = require("cmp")

  local select_option = {
    behavior = cmp.SelectBehavior.Insert,
  }

  local has_words_before = function()
    if vim.api.nvim_get_option_value("buftype", { buf = 0 }) == "prompt" then
      return false
    end
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and vim.api.nvim_buf_get_text(0, line - 1, 0, line - 1, col, {})[1]:match("^%s*$") == nil
  end

  cmp.setup({
    snippet = {
      expand = function(args)
        luasnip.lsp_expand(args.body)
      end,
    },
    performance = {
      trigger_debounce_time = 500,
      throttle = 550,
      fetching_timeout = 80,
      maxi_view_entries = 15,
    },
    completion = {
      -- this is important
      -- @see https://github.com/hrsh7th/nvim-cmp/discussions/1411
      completeopt = "menuone,noinsert,noselect",
    },
    mapping = {
      -- `Enter` key to confirm completion
      ["<CR>"] = cmp.mapping.confirm({ select = false }),

      ["<Tab>"] = cmp.mapping(function(fallback)
        if cmp.visible() and has_words_before() then
          cmp.select_next_item(select_option)
        elseif luasnip.expandable() then
          luasnip.expand()
        elseif luasnip.expand_or_jumpable() then
          luasnip.expand_or_jump()
        elseif check_backspace() then
          fallback()
        else
          fallback()
        end
      end, { "i", "s" }),
    },
    sources = cmp.config.sources({
      { name = "nvim_lsp", priority = 70, max_item_count = 3 },
      { name = "luasnip", priority = 60, max_item_count = 3 },
      { name = "kitty", priority = 40, max_item_count = 2 },
      {
        name = "rg",
        priority = 30,
        keyword_length = 3,
        max_item_count = 3,
        option = {
          additional_arguments = "--smart-case",
        },
      },
      { name = "async_path", priority = 20, max_item_count = 2 },
    }),
    formatting = {
      format = function(_, item)
        local icons = yet.icons.kinds
        if icons[item.kind] then
          item.kind = icons[item.kind] .. item.kind
        end
        return item
      end,
    },
    sorting = {
      comparators = {
        cmp.config.compare.offset,
        cmp.config.compare.exact,
        cmp.config.compare.recently_used,
        require("clangd_extensions.cmp_scores"),
        cmp.config.compare.kind,
        cmp.config.compare.sort_text,
        cmp.config.compare.length,
        cmp.config.compare.order,
      },
    },
  })

  cmp.setup.filetype("gitcommit", {
    sources = cmp.config.sources({
      { name = "git" },
    }, {
      {
        name = "buffer",
        option = {
          get_bufnrs = function()
            local LIMIT = 1024 * 1024 -- 1 Megabyte max
            local bufs = {}

            for _, buf in ipairs(vim.api.nvim_list_bufs()) do
              local line_count = vim.api.nvim_buf_line_count(buf)
              local byte_size = vim.api.nvim_buf_get_offset(buf, line_count)

              if byte_size < LIMIT then
                bufs[buf] = true
              end
            end

            return vim.tbl_keys(bufs)
          end,
        },
      },
    }, { { name = "spell" } }),
  })

  vim.diagnostic.config({
    virtual_text = false,
    update_in_insert = true,
    underline = true,
    severity_sort = true,
    float = {
      focusable = true,
      style = "minimal",
      border = "rounded",
      source = "always",
      header = "",
      prefix = "",
    },
  })

  --
  -- Has issues with neovim nightly
  --
  -- require("navigator").setup({
  --   treesitter_navigation = false, -- bool|table false: use lsp to navigate between symbol ']r/[r', table: a list of
  --   transparency = 100,
  --   lsp_signature_help = true, -- if you would like to hook ray-x/lsp_signature plugin in navigator
  --   mason = true, -- set to true if you would like use the lsp installed by williamboman/mason
  --   lsp = {
  --     code_action = { enable = false, sign = false, virtual_text = false },
  --     code_lens_action = { enable = false, sign = false, virtual_text = false },
  --     document_highlight = true, -- LSP reference highlight,
  --     -- it might already supported by you setup, e.g. LunarVim
  --     format_on_save = false,
  --     diagnostic = {
  --       underline = true,
  --       virtual_text = false, -- show virtual for diagnostic message
  --       update_in_insert = false, -- update diagnostic message in insert mode
  --       severity_sort = true,
  --       float = {
  --         focusable = false,
  --         style = "minimal",
  --         border = "rounded",
  --         source = "always",
  --         header = "",
  --         prefix = "",
  --       },
  --     },
  --     diagnostic_virtual_text = false,
  --     diagnostic_update_in_insert = true,
  --     display_diagnostic_qf = 'trouble',
  --   },
  -- })
end
