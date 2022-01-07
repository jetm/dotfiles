local status_ok, _ = pcall(require, "nvim-peekup")
if not status_ok then
	return
end

local vim = vim

vim.g.peekup_open = '"'

require("nvim-peekup.config").on_keystroke["paste_reg"] = '"'
require("nvim-peekup.config").on_keystroke["delay"] = ""
