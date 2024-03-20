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
    lsp_zero.default_keymaps({buffer = bufnr})
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
      "ruff_lsp",
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

  local function check_back_space()
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
    },
    mapping = {
      -- `Enter` key to confirm completion
      ["<CR>"] = cmp.mapping.confirm({ select = false }),

      -- Accept currently selected item
      ["<S-CR>"] = cmp.mapping.confirm({
        behavior = cmp.ConfirmBehavior.Replace,
        select = true,
      }),

      -- Abort cmp and enter a new line
      ["<C-CR>"] = function(fallback)
        cmp.abort()
        fallback()
      end,

      ["<Tab>"] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_next_item()
        elseif luasnip.expand_or_jumpable() then
          luasnip.expand_or_jump()
        elseif check_back_space() then
          fallback()
        else
          cmp.complete()
        end
      end, { "i", "s" }),

      ["<S-Tab>"] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_prev_item()
        elseif luasnip.jumpable(-1) then
          luasnip.jump(-1)
        else
          fallback()
        end
      end, { "i", "s" }),
    },
    sources = cmp.config.sources({
      { name = "nvim_lsp", priority = 70, max_item_count = 5 },
      { name = "luasnip", priority = 60, max_item_count = 5 },
      {
        name = "buffer",
        priority = 50,
        max_item_count = 5,
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
      { name = "codeium", priority = 40 },
      {
        name = "rg",
        priority = 30,
        keyword_length = 3,
        max_item_count = 5,
        option = {
          additional_arguments = "--smart-case",
        },
      },
      { name = "async_path", priority = 20 },
      {
        name = "spell",
        priority = 1,
        option = {
          keep_all_entries = false,
          enable_in_context = function()
            return true
          end,
        },
      },
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
