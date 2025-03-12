return function(_, _)
  dofile(vim.g.base46_cache .. "lsp")
  require("nvchad.lsp").diagnostic_config()

  local lspconfig = require("lspconfig")

  local default_setup = function(server)
    lspconfig[server].setup({
      capabilities = require("blink.cmp").get_lsp_capabilities(),
    })
  end

  local handlers = {
    default_setup,

    ["bashls"] = function()
      lspconfig.bashls.setup({
        settings = {
          bashls = {
            format = { enable = true },
            validate = { enable = true },
            filetypes = { "bash", "sh", "zsh" },
            bashIde = {
              globPattern = "*@(.sh|.inc|.bash|.command|.zsh)",
            },
          },
        },
      })
    end,

    ["lua_ls"] = function()
      lspconfig.lua_ls.setup({
        Lua = {
          runtime = { version = "LuaJIT" },
          workspace = {
            checkThirdParty = false,
            library = {
              library = vim.api.nvim_get_runtime_file("", true),
            },
          },
          hint = {
            enable = true,
          },
          diagnostics = {
            globals = { "vim", "require" },
            disable = { "missing-fields" },
          },
        },
      })
    end,

    -- Disable it from now. Too slow
    -- ["harper_ls"] = function()
    --   lspconfig.harper_ls.setup({
    --     filetypes = { "gitcommit", "markdown", "text" },
    --     settings = {
    --       ["harper-ls"] = {
    --         codeActions = {
    --           forceStable = true,
    --         },
    --         -- typos handles spell checking
    --         linters = {
    --           sentence_capitalization = false,
    --           spell_check = false,
    --         },
    --       },
    --     },
    --     single_file_support = true,
    --   })
    -- end,

    ["clangd"] = function()
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

    ["yamlls"] = function()
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

    ["jsonls"] = function()
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

    ["pyright"] = function()
      -- Use Ruff exclusively for linting, formatting and organizing imports, and disable those capabilities in Pyright
      -- https://github.com/astral-sh/ruff-lsp?tab=readme-ov-file#example-neovim
      lspconfig.pyright.setup({
        settings = {
          pyright = {
            -- Using Ruff's import organizer
            disableOrganizeImports = true,
          },
          python = {
            analysis = {
              -- Ignore all files for analysis to exclusively use Ruff for linting
              ignore = { "*" },
            },
          },
        },
      })
    end,
  }

  -- Install LSP servers
  require("mason-lspconfig").setup({
    ensure_installed = {
      -- Language servers
      "bashls",
      "clangd",
      "dockerls",
      "jsonls",
      "harper_ls",
      "lua_ls",
      "pyright",
      "yamlls",
    },
    automatic_installation = true,
    handlers = handlers,
  })
end
