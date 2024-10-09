return {
  defaults = {
    cond = not vim.g.vscode,
    version = false, -- always use the latest git commit
  },
  checker = {
    enabled = true,
    concurrency = 16,
    notify = false,
    frequency = 3600 * 24 * 2, -- update every two days
  },
  performance = {
    rtp = {
      -- Internal Plugins at share/nvim/runtime/plugin
      disabled_plugins = {
        "2html_plugin",
        "tohtml",
        "getscript",
        "getscriptPlugin",
        "gzip",
        "logipat",
        "netrw",
        "netrwPlugin",
        "netrwSettings",
        "netrwFileHandlers",
        "matchit",
        "tar",
        "tarPlugin",
        "rrhelper",
        "spellfile_plugin",
        "vimball",
        "vimballPlugin",
        "zip",
        "zipPlugin",
        "tutor",
        "rplugin",
        "syntax",
        "synmenu",
        "optwin",
        "compiler",
        "bugreport",
        "ftplugin",
      },
    },
  },
}
