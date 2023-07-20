return function(_, _)
  require("mason").setup()

  -- Install LSP servers
  require("mason-lspconfig").setup({
    ensure_installed = {
      "bashls",
      "dockerls",
      "ruff_lsp",
      "lua_ls",
      "yamlls",
    },
  })

  local lspconfig = require("lspconfig")
  local lsp_defaults = lspconfig.util.default_config

  lsp_defaults.capabilities = vim.tbl_deep_extend(
    "force",
    lsp_defaults.capabilities,
    require("cmp_nvim_lsp").default_capabilities()
  )

  -- Required to fix vim global warning
  lspconfig.lua_ls.setup({
    settings = {
      Lua = {
        diagnostics = {
          -- Get the language server to recognize the `vim` global
          globals = {
            "vim",
            "require",
          },
        },
      },
    },
  })

  local lsp = require("lsp-zero").preset({})

  lsp.on_attach(function(_, bufnr)
    lsp.default_keymaps({ buffer = bufnr })
  end)

  -- Configure lua language server for neovim
  -- For now, not required
  -- lspconfig.lua_ls.setup(lsp.nvim_lua_ls())

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
      { name = "nvim_lsp", priority = 1000 },
      { name = "luasnip",  priority = 750 },
      { name = "buffer",   priority = 500 },
      { name = "path",     priority = 250 },
    }),
    duplicates = {
      nvim_lsp = 1,
      luasnip = 1,
      buffer = 1,
      path = 1,
    },
    formatting = {
      format = require("lspkind").cmp_format({ with_text = false }),
    },
  })

  vim.diagnostic.config({
    virtual_text = false,
    severity_sort = true,
    float = {
      border = "rounded",
      source = "always",
    },
  })

  -- Install linters and formatters
  require('mason-null-ls').setup({
    ensure_installed = {
      "shellcheck",
      "shellharden",
      "shfmt",
      "stylua",
    }
  })

  local null_ls = require("null-ls")

  null_ls.setup({
    -- required to restore 'gp' operator
    on_attach = function(_, bufnr)
      vim.api.nvim_buf_set_option(bufnr, "formatexpr", "")
    end,
    sources = {
      null_ls.builtins.diagnostics.shellcheck.with({
        filetypes = { "sh", "zsh", "bash", "bats" },
      }),
      null_ls.builtins.code_actions.shellcheck.with({
        filetypes = { "sh", "zsh", "bash", "bats" },
      }),
      null_ls.builtins.diagnostics.zsh,
      -- null_ls.builtins.diagnostics.checkmake,
      null_ls.builtins.formatting.shfmt.with({
        extra_args = function(params)
          local extra_args = {
            "-sr",
            "-ci",
            "-s",
          }

          if params.options and not params.options.insertSpaces then
            -- Default indent with Tabs
            table.insert(extra_args, "--indent")
            table.insert(extra_args, 0)
          else
            -- Indent with Spaces
            table.insert(extra_args, "--indent")
            table.insert(extra_args, params.options.tabSize)
          end

          return extra_args
        end,
        extra_filetypes = { "zsh", "bats" },
      }),
      null_ls.builtins.formatting.stylua.with({
        extra_args = {
          "--indent-width=2",
          "--indent-type=Spaces",
        },
      }),
    },
  })
end
