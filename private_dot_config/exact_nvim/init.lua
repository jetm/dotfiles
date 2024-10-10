-- Must be set before Lazy
vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.g.root_spec = { "lsp", { ".git", "lua" }, "cwd" }

-- Manually add new filetypes
vim.filetype.add({
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
    vim.api.nvim_err_writeln("Error cloning lazy.nvim repository...\n\n" .. output)
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
dofile(vim.g.base46_cache .. "defaults")
dofile(vim.g.base46_cache .. "statusline")

for _, source in ipairs({
  "config.utils",
  "config.options",
  "config.autocmds",
  "config.mappings",
}) do
  local status_ok, fault = pcall(require, source)
  if not status_ok then
    vim.api.nvim_err_writeln("Failed to load " .. source .. "\n\n" .. fault)
  end
end
