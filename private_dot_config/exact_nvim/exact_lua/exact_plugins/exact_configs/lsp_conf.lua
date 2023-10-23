return function(_, _)
  -- Install formatters
  require("mason").setup({
    opts = {
      ensure_installed = {
        "shellcheck",
        "luacheck",
        "shellharden",
        "shfmt",
        "stylua",
        "yamlfmt",
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

  -- Install LSP servers
  require("mason-lspconfig").setup({
    ensure_installed = {
      "bashls",
      "dockerls",
      "jsonls",
      "lua_ls",
      "ruff_lsp",
      "yamlls",
    },
  })

  local lspconfig = require("lspconfig")
  local lsp_defaults = lspconfig.util.default_config

  lsp_defaults.capabilities =
    vim.tbl_deep_extend("force", lsp_defaults.capabilities, require("cmp_nvim_lsp").default_capabilities())

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

  local lsp = require("lsp-zero").preset({})

  lsp.on_attach(function(_, bufnr)
    lsp.default_keymaps({ buffer = bufnr })
  end)

  -- Configure lua language server for neovim
  lsp.setup()

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
    window = {
      documentation = cmp.config.window.bordered(),
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
      { name = "nvim_lsp", priority = 1250 },
      { name = "luasnip", priority = 1000 },
      {
        name = "buffer",
        priority = 750,
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
      {
        name = "rg",
        priority = 500,
        keyword_length = 3,
        max_item_count = 5,
        option = {
          additional_arguments = "--smart-case",
        },
      },
      { name = "async_path", priority = 250 },
      { name = "bitbake_path", priority = 250 },
      {
        name = "spell",
        priority = 100,
        option = {
          keep_all_entries = false,
          enable_in_context = function()
            return true
          end,
        },
      },
    }),
    formatting = {
      format = require("lspkind").cmp_format({ with_text = false }),
    },
  })

end
