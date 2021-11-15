local vim = vim

vim.g.peekup_open = '"'

require("nvim-peekup.config").on_keystroke["paste_reg"] = '"'
require("nvim-peekup.config").on_keystroke["delay"] = ""
