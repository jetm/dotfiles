-- Filetype-specific autocmds: indentation, wrap, spell settings
local loader = require("config.autocmds.loader")
local augroup = loader.augroup
local autocmd = loader.autocmd

-- Set indentation to 2 spaces for yaml and lua
autocmd("Filetype", {
  group = augroup("setIndent"),
  pattern = { "yaml", "lua" },
  command = "setlocal shiftwidth=2 tabstop=2 sts=2 expandtab",
})

-- Show by default 4 spaces for a tab (Go)
autocmd("Filetype", {
  group = augroup("setIndent_go"),
  pattern = { "go" },
  command = "setlocal shiftwidth=4 tabstop=4 sts=4 noexpandtab",
})

-- Enable wrap for markdown and gitcommit
autocmd("Filetype", {
  group = augroup("wrap"),
  pattern = { "markdown", "gitcommit" },
  command = "setlocal wrap",
})

-- Enable spell for gitcommit and markdown
autocmd("Filetype", {
  group = augroup("spell"),
  pattern = { "gitcommit", "markdown" },
  callback = function()
    vim.opt_local.spell = true
  end,
})

-- Wrap and check for spell in text filetypes
autocmd({ "FileType" }, {
  group = augroup("wrap_spell"),
  pattern = { "text", "plaintex", "typst", "gitcommit", "markdown" },
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.spell = true
  end,
})
