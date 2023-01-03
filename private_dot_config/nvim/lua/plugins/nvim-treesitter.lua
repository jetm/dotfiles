local M = {
	"nvim-treesitter/nvim-treesitter",
	dependencies = {
		"kyazdani42/nvim-web-devicons",
		"nvim-treesitter/nvim-treesitter-refactor",
		"nvim-treesitter/nvim-treesitter-textobjects",
		"romgrk/nvim-treesitter-context",
		"p00f/nvim-ts-rainbow",
	},
	build = ":TSUpdate",
}

local ok, nvim_treesitter = pcall(require, "nvim-treesitter.configs")
if not ok then
	error("Loading nvim-treesitter.configs")
	return
end

function M.config()
	nvim_treesitter.setup({
		ensure_installed = {
			"bash",
			"c",
			"cmake",
			"comment",
			"dockerfile",
			"dot",
			"go",
			"json",
			"lua",
			"make",
			"ninja",
			"python",
			"regex",
			"rust",
			"toml",
			"vim",
			"yaml",
		},
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
end

return M
