-- LSP Server Configurations
-- Using vim.lsp.config() - Neovim 0.11+ native API
-- AstroLSP handles on_attach, capabilities, and autocmds

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
    local dir = vim.fs.dirname(fname)

    -- Build files (higher priority)
    local build_root = vim.fs.find({
      "Makefile", "configure.ac", "configure.in", "config.h.in",
      "meson.build", "meson_options.txt", "build.ninja",
    }, { path = dir, upward = true })[1]

    if build_root then
      on_dir(vim.fs.dirname(build_root))
      return
    end

    -- Compile commands
    local compile_root = vim.fs.find({
      "compile_commands.json", "compile_flags.txt",
    }, { path = dir, upward = true })[1]

    if compile_root then
      on_dir(vim.fs.dirname(compile_root))
      return
    end

    -- Git root fallback
    local git_root = vim.fs.find(".git", { path = dir, upward = true })[1]
    if git_root then
      on_dir(vim.fs.dirname(git_root))
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

vim.lsp.config("ruff", {
  init_options = {
    settings = {
      logLevel = "error", -- Suppress INFO and WARN messages in LSP log
    },
  },
})

vim.lsp.config("harper_ls", {
  cmd = { "harper-ls", "--stdio" },
  filetypes = { "gitcommit" },
  settings = {
    ["harper-ls"] = {
      linters = {
        spell_check = true,
        spelled_numbers = false,
        an_a = true,
        sentence_capitalization = true,
        unclosed_quotes = true,
        wrong_quotes = false,
        long_sentences = true,
        repeated_words = true,
        spaces = true,
        matcher = true,
        correct_number_suffix = true,
        number_suffix_capitalization = true,
        multiple_sequential_pronouns = true,
        linking_verbs = false,
        avoid_curses = true,
      },
    },
  },
})

-- Servers to enable automatically
local servers = {
  "bashls",
  "clangd",
  "harper_ls",
  "jinja_lsp",
  "jsonls",
  "lua_ls",
  "ruff",
}

vim.lsp.enable(servers)
