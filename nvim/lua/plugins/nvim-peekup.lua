local ok, _ = pcall(require, "nvim-peekup")
if not ok then
	error("Loading nvim-peekup")
	return
end

vim.g.peekup_open = '"'

local ok2, nvim_peekup_config = pcall(require, "nvim-peekup.config")
if not ok2 then
	error("Loading nvim-peekup.config")
	return
end

nvim_peekup_config.on_keystroke["paste_reg"] = '"'
nvim_peekup_config.on_keystroke["delay"] = ""
