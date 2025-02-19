local M = {}
local map = vim.keymap.set

-- export on_attach & capabilities
M.on_attach = function(_, bufnr)
  local function opts(desc)
    return { buffer = bufnr, desc = "LSP " .. desc }
  end

  map("n", "gD", vim.lsp.buf.declaration, opts("Go to declaration"))
  map("n", "gd", vim.lsp.buf.definition, opts("Go to definition"))
  map("n", "gi", vim.lsp.buf.implementation, opts("Go to implementation"))
  map("n", "<leader>sh", vim.lsp.buf.signature_help, opts("Show signature help"))
  map("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, opts("Add workspace folder"))
  map("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, opts("Remove workspace folder"))

  map("n", "<leader>wl", function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, opts("List workspace folders"))

  map("n", "<leader>D", vim.lsp.buf.type_definition, opts("Go to type definition"))
  map("n", "<leader>ra", require("nvchad.lsp.renamer"), opts("NvRenamer"))

  map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts("Code action"))
  map("n", "gr", vim.lsp.buf.references, opts("Show references"))
end

-- disable semanticTokens
M.on_init = function(client, _)
  if client.supports_method("textDocument/semanticTokens") then
    client.server_capabilities.semanticTokensProvider = nil
  end
end

M.default_capabilities = vim.lsp.protocol.make_client_capabilities()
M.capabilities = require("blink.cmp").get_lsp_capabilities(M.default_capabilities)

M.capabilities.textDocument.completion.completionItem = {
  documentationFormat = { "markdown", "plaintext" },
  snippetSupport = true,
  preselectSupport = true,
  insertReplaceSupport = true,
  labelDetailsSupport = true,
  deprecatedSupport = true,
  commitCharactersSupport = true,
  tagSupport = { valueSet = { 1 } },
  resolveSupport = {
    properties = {
      "documentation",
      "detail",
      "additionalTextEdits",
    },
  },
}

M.defaults = function()
  dofile(vim.g.base46_cache .. "lsp")
  require("nvchad.lsp").diagnostic_config()

  require("lspconfig").lua_ls.setup({
    on_attach = M.on_attach,
    capabilities = M.capabilities,
    on_init = M.on_init,

    settings = {
      Lua = {
        diagnostics = {
          globals = { "vim" },
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
end

-- Install formatters and linters
require("mason").setup({
  opts = {
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
    "pyright",
    "yamlls",
  },
  handlers = {
    lua_ls = function()
      lspconfig.lua_ls.setup({
        capabilities = M.capabilities,
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
        capabilities = M.capabilities,
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
        capabilities = M.capabilities,
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

    -- Use Ruff exclusively for linting, formatting and organizing imports, and disable those capabilities in Pyright
    -- https://github.com/astral-sh/ruff-lsp?tab=readme-ov-file#example-neovim
    pyright = function()
      lspconfig.pyright.setup({
        capabilities = M.capabilities,
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

    bashls = function()
      lspconfig.bashls.setup({
        capabilities = M.capabilities,
        settings = {
          bashls = {
            format = { enable = false },
            validate = { enable = true },
          },
        },
      })
    end,

    jsonls = function()
      lspconfig.jsonls.setup({
        capabilities = M.capabilities,
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

return M
