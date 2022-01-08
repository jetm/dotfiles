local ok, nvim_autopairs = pcall(require, "nvim-autopairs")
if not ok then
	error("Loading nvim-autopairs")
	return
end

nvim_autopairs.setup()

local ok2, nvim_treesitter_configs = pcall(require, "nvim-treesitter.configs")
if not ok2 then
	error("Loading nvim-treesitter.configs")
	return
end

nvim_treesitter_configs.setup({ autopairs = { enable = true } })
