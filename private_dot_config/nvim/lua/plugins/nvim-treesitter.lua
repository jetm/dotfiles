local ok, nvim_treesitter = pcall(require, "nvim-treesitter.configs")
if not ok then
	error("Loading nvim-treesitter.configs")
	return
end

nvim_treesitter.setup({
	ensure_installed = "maintained",
	ignore_install = { "php", "norg", "tlaplus"},
	autotag = { enable = false },
	highlight = {
		enable = true,
		additional_vim_regex_highlighting = true,
		disable = { "gitcommit" },
	},
	-- https://github.com/nvim-treesitter/nvim-treesitter#indentation
	indent = { enable = true, disable = { "gitcommit" } },
	-- https://github.com/p00f/nvim-ts-rainbow
	rainbow = {
		enable = true,
		extended_mode = true, -- Highlight also non-parentheses delimiters
		max_file_lines = 1000,
	},
})
