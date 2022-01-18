vim.g.matchup_matchparen_offscreen = { method = "popup" }

local ok, nvim_treesitter_configs = pcall(require, "nvim-treesitter.configs")
if not ok then
	error('Loading nvim-treesitter.configs')
	return
end

nvim_treesitter_configs.setup({
	matchup = { enable = true },
})
