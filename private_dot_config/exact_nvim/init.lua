-- Must be set before Lazy
vim.g.mapleader = " "
vim.g.maplocalleader = " "

if vim.g.vscode then
  local status_ok, fault = pcall(require, "config.vscode_options")
  if not status_ok then
    vim.notify("Failed to load config.vscode_options" .. fault)
  end

  status_ok, fault = pcall(require, "config.vscode_keymaps")
  if not status_ok then
    vim.notify("Failed to load config.vscode_keymaps" .. fault)
  end

  return
end

-- Manually add new filetypes
vim.filetype.add({
  extension = {
    jinja = "jinja",
    jinja2 = "jinja",
    j2 = "jinja",
  },
  filename = {},
  pattern = {
    [".*%.bb%..*"] = "bitbake",
    [".*%.inc"] = "bitbake",
    [".*%.bats"] = "bash",
    [".*%.zsh"] = "sh",
    [".*%.rules"] = "udevrules",
    [".*%.service"] = "systemd",
  },
})

-- Configure LSP servers (must be before lazy.nvim loads plugins)
-- Using vim.lsp.config() - the native Neovim 0.11+ LSP configuration API

vim.lsp.config("bashls", {
  filetypes = { "bash", "sh", "zsh" },
  settings = {
    bashIde = {
      globPattern = "*@(.sh|.inc|.bash|.command|.zsh)",
    },
  },
})

vim.lsp.config("clangd", {
  cmd = {
    "clangd",
    "--background-index",
    "-j=16",
    "--clang-tidy",
    "--all-scopes-completion",
    "--header-insertion=iwyu",
    "--completion-style=detailed",
    "--function-arg-placeholders=0",
    "--fallback-style=LLVM",
  },
  capabilities = {
    offsetEncoding = "utf-8",
  },
  init_options = {
    usePlaceholders = true,
    completeUnimported = true,
    clangdFileStatus = true,
  },
  root_dir = function(bufnr, on_dir)
    local fname = vim.api.nvim_buf_get_name(bufnr)
    local root = require("lspconfig.util").root_pattern(
      "Makefile",
      "configure.ac",
      "configure.in",
      "config.h.in",
      "meson.build",
      "meson_options.txt",
      "build.ninja"
    )(fname) or require("lspconfig.util").root_pattern(
      "compile_commands.json",
      "compile_flags.txt"
    )(fname) or vim.fs.dirname(vim.fs.find(".git", { path = fname, upward = true })[1])
    if root then
      on_dir(root)
    end
  end,
  on_attach = function()
    require("clangd_extensions")
  end,
})

vim.lsp.config("jsonls", {
  settings = {
    json = {
      format = { enable = false },
    },
  },
})

vim.lsp.config("lua_ls", {
  on_init = function(client)
    -- Skip if project has its own .luarc.json
    if client.workspace_folders then
      local path = client.workspace_folders[1].name
      if vim.uv.fs_stat(path .. "/.luarc.json") or vim.uv.fs_stat(path .. "/.luarc.jsonc") then
        return
      end
    end
    -- Merge Neovim-specific settings
    client.config.settings.Lua = vim.tbl_deep_extend("force", client.config.settings.Lua or {}, {
      runtime = { version = "LuaJIT" },
      workspace = {
        checkThirdParty = false,
        library = { vim.env.VIMRUNTIME },
      },
    })
  end,
})

-- Configure ruff LSP (used alongside conform.nvim for formatting)
vim.lsp.config("ruff", {
  init_options = {
    settings = {
      logLevel = "error", -- Suppress INFO and WARN messages in LSP log
    },
  },
})

vim.lsp.enable("ruff")

-- Disable ruff hover in favor of pyright (per official ruff docs)
vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("lsp_attach_disable_ruff_hover", { clear = true }),
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if client and client.name == "ruff" then
      client.server_capabilities.hoverProvider = false
    end
  end,
  desc = "LSP: Disable hover capability from ruff",
})

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
local luv = vim.uv
if not luv.fs_stat(lazypath) then
  local output = vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "--branch=stable",
    "https://github.com/folke/lazy.nvim.git",
    lazypath,
  })
  if vim.api.nvim_get_vvar("shell_error") ~= 0 then
    vim.notify("Error cloning lazy.nvim repository...\n\n" .. output)
  end
  vim.notify("Please wait while plugins are installed...")
  vim.api.nvim_create_autocmd("User", {
    desc = "Load Mason and Treesitter after Lazy installs plugins",
    once = true,
    pattern = "LazyInstall",
    callback = function()
      vim.cmd.bw()
      vim.tbl_map(function(module)
        pcall(require, module)
      end, { "nvim-treesitter", "mason" })
      vim.notify("Mason is installing packages if configured, check status with `:Mason`")
    end,
  })
end
vim.opt.rtp:prepend(lazypath)

vim.g.base46_cache = vim.fn.stdpath("data") .. "/base46/"

local lazy_config = require("config.lazy")
require("lazy").setup({
  { import = "plugins" },
}, lazy_config)

-- load theme
dofile(vim.g.base46_cache .. "syntax")
dofile(vim.g.base46_cache .. "defaults")
dofile(vim.g.base46_cache .. "statusline")

-- Load local changes
local configs = vim.fn.stdpath("config") .. "/lua/config/"
dofile(configs .. "options.lua")
dofile(configs .. "autocmds.lua")
dofile(configs .. "mappings.lua")
