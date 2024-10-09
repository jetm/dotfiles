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
              workspace = {
                library = {
                  vim.fn.expand("$VIMRUNTIME/lua"),
                  vim.fn.expand("$VIMRUNTIME/lua/vim/lsp"),
                  vim.fn.stdpath("data") .. "/lazy/ui/nvchad_types",
                  vim.fn.stdpath("data") .. "/lazy/lazy.nvim/lua/lazy",
                  "${3rd}/luv/library",
                },
                maxPreload = 100000,
                preloadFileSize = 10000,
              },
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

end
