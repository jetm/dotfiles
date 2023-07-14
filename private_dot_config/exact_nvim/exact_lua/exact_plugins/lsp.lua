local M = {
  "VonHeikemen/lsp-zero.nvim",
  branch = "v2.x",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    { "neovim/nvim-lspconfig" },
    {
      "williamboman/mason.nvim",
      cmd = {
        "Mason",
        "MasonInstall",
        "MasonUninstall",
        "MasonUninstallAll",
        "MasonUpdate", -- AstroNvim extension here as well
        "MasonUpdateAll", -- AstroNvim specific
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
    },
    { "williamboman/mason-lspconfig.nvim" },
    {
      "WhoIsSethDaniel/mason-tool-installer.nvim",
      auto_update = true,
      debounce_hours = 5,
    },

    -- completation
    { "hrsh7th/nvim-cmp" },
    { "hrsh7th/cmp-buffer" },
    { "hrsh7th/cmp-path" },
    { "hrsh7th/cmp-nvim-lsp" },
    { "onsails/lspkind.nvim" },
    {
      "f3fora/cmp-spell",
      ft = { "gitcommit", "markdown" },
    },

    --  Vim Snippets engine  [snippet engine] + [snippet templates]
    {
      "L3MON4D3/LuaSnip",
      dependencies = {
        "rafamadriz/friendly-snippets",
      },
      config = function(_, _)
        require("luasnip.loaders.from_vscode").lazy_load()
      end,
    },

    -- null-ls
    "jose-elias-alvarez/null-ls.nvim",
  },
}

function M.config()
  require("mason").setup()
  require("mason-lspconfig").setup()

  local lspconfig = require("lspconfig")
  local lsp_defaults = lspconfig.util.default_config

  lsp_defaults.capabilities = vim.tbl_deep_extend(
    "force",
    lsp_defaults.capabilities,
    require("cmp_nvim_lsp").default_capabilities()
  )

  lspconfig.lua_ls.setup({})

  local ok3, mason_installer = pcall(require, "mason-tool-installer")
  if not ok3 then
    error("Loading mason-tool-installer")
    return
  end

  local function check_back_space()
    local col = vim.fn.col(".") - 1
    if col == 0 or vim.fn.getline("."):sub(col, col):match("%s") then
      return true
    else
      return false
    end
  end

  mason_installer.setup({
    -- a list of all tools you want to ensure are installed upon
    -- start; they should be the names Mason uses for each tool
    ensure_installed = {
      "bash-language-server",
      "dockerfile-language-server",
      "flake8",
      "marksman",
      "shellcheck",
      "shellharden",
      "shfmt",
      "stylua",
      "vim-language-server",
      "lua-language-server",
      "yaml-language-server",
    },
    auto_update = true,
  })

  local lsp = require("lsp-zero").preset({})

  lsp.on_attach(function(client, bufnr)
    lsp.default_keymaps({ buffer = bufnr })
  end)

  -- Configure lua language server for neovim
  -- For now, not required
  -- lspconfig.lua_ls.setup(lsp.nvim_lua_ls())

  -- Configure lua language server for neovim
  lsp.setup()

  -- Must setup `cmp` after lsp-zero
  local cmp = require("cmp")

  local ok2, lspkind = pcall(require, "lspkind")
  if not ok2 then
    error("Loading lspkind")
    return
  end

  local luasnip = require("luasnip")

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
      { name = "luasnip", priority = 750 },
      { name = "buffer", priority = 500 },
      { name = "path", priority = 250 },
    }),
    duplicates = {
      nvim_lsp = 1,
      luasnip = 1,
      buffer = 1,
      path = 1,
    },
    formatting = {
      format = lspkind.cmp_format({ with_text = false }),
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

  local ok4, null_ls = pcall(require, "null-ls")
  if not ok4 then
    error("Loading null-ls")
    return
  end

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
          "--column-width=80",
          "--indent-width=2",
          "--indent-type=Spaces",
        },
      }),
    },
  })
end

return M
