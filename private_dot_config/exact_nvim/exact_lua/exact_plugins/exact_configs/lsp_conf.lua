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
        "clang-format",

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

  lsp_zero.on_attach(function(_, bufnr)
    -- see :help lsp-zero-keybindings
    -- to learn the available actions
    lsp_zero.default_keymaps({ buffer = bufnr })
  end)

  local lspconfig = require("lspconfig")

  local capabilities = {
    textDocument = {
      completion = {
        completionItem = {
          documentationFormat = { "markdown", "plaintext" },
          snippetSupport = true,
          preselectSupport = true,
          insertReplaceSupport = true,
          labelDetailsSupport = true,
          deprecatedSupport = true,
          commitCharactersSupport = true,
          tagSupport = { valueSet = { 1 } },
          resolveSupport = { properties = { "documentation", "detail", "additionalTextEdits" } },
        },
      },
    },
  }

  require("cmp_nvim_lsp").default_capabilities(capabilities)

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

  -- Must setup `cmp` after lsp-zero
  local cmp = require("cmp")

  local has_words_before = function()
    local line, col = (unpack or table.unpack)(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
  end
  local function is_visible(cmp)
    return cmp.core.view:visible() or vim.fn.pumvisible() == 1
  end

  local get_icon_provider = function()
    local _, mini_icons = pcall(require, "mini.icons")
    if _G.MiniIcons then
      return function(kind)
        return mini_icons.get("lsp", kind)
      end
    end
  end
  local icon_provider = get_icon_provider()

  local format = function(entry, item)
    local highlight_colors_avail, highlight_colors = pcall(require, "nvim-highlight-colors")
    local color_item = highlight_colors_avail and highlight_colors.format(entry, { kind = item.kind })
    if icon_provider then
      local icon = icon_provider(item.kind)
      if icon then
        item.kind = icon
      end
    end
    if color_item and color_item.abbr_hl_group then
      item.kind, item.kind_hl_group = color_item.abbr, color_item.abbr_hl_group
    end
    return item
  end

  cmp.setup({
    completion = {
      -- this is important
      -- @see https://github.com/hrsh7th/nvim-cmp/discussions/1411
      completeopt = "menuone,noinsert,noselect",
    },
    mapping = {
      ["<Up>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),
      ["<Down>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),
      -- `Enter` key to confirm completion
      ["<CR>"] = cmp.mapping(cmp.mapping.confirm({ select = false }), { "i", "c" }),

      ["<Tab>"] = cmp.mapping(function(fallback)
        if is_visible(cmp) then
          cmp.select_next_item()
        elseif vim.api.nvim_get_mode().mode ~= "c" and vim.snippet and vim.snippet.active({ direction = 1 }) then
          vim.schedule(function()
            vim.snippet.jump(1)
          end)
        elseif has_words_before() then
          cmp.complete()
        else
          fallback()
        end
      end, { "i", "s" }),
    },
    sources = cmp.config.sources({
      { name = "nvim_lsp", priority = 70, max_item_count = 3 },
      { name = "luasnip", priority = 60, max_item_count = 3 },
      { name = "buffer", priority = 50, max_item_count = 2 },
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
    formatting = { fields = { "kind", "abbr", "menu" }, format = format },
    confirm_opts = {
      behavior = cmp.ConfirmBehavior.Replace,
      select = false,
    },
  })

  cmp.setup.filetype("gitcommit", {
    sources = cmp.config.sources({
      { name = "spell", max_item_count = 5 },
      { name = "git", max_item_count = 3 },
      {
        name = "buffer",
        max_item_count = 3,
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
    }),
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
