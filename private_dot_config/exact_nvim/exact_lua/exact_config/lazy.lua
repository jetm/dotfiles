local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
local luv = vim.uv or vim.loop -- TODO: REMOVE WHEN DROPPING SUPPORT FOR Neovim v0.9
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
    vim.api.nvim_err_writeln(
      "Error cloning lazy.nvim repository...\n\n" .. output
    )
  end
  local oldcmdheight = vim.opt.cmdheight:get()
  vim.opt.cmdheight = 1
  vim.notify("Please wait while plugins are installed...")
  vim.api.nvim_create_autocmd("User", {
    desc = "Load Mason and Treesitter after Lazy installs plugins",
    once = true,
    pattern = "LazyInstall",
    callback = function()
      vim.cmd.bw()
      vim.opt.cmdheight = oldcmdheight
      vim.tbl_map(function(module)
        pcall(require, module)
      end, { "nvim-treesitter", "mason" })
      vim.notify("Mason is installing packages if configured, check status with `:Mason`")
    end,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  spec = {
    { import = "plugins" },
  },
  checker = {
    enabled = true,
    concurrency = 8,
    notify = false,
    frequency = 3600, -- check for updates every hour
  },
  performance = {
    rtp = {
      disabled_plugins = {
        "tohtml",
        "gzip",
        "zipPlugin",
        "netrwPlugin",
        "tarPlugin",
        "tutor",
        "matchparen",
      },
    },
  },
})
