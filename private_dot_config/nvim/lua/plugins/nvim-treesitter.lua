local M = {
	"nvim-treesitter/nvim-treesitter",
	dependencies = {
		"kyazdani42/nvim-web-devicons",
		"nvim-treesitter/nvim-treesitter-refactor",
		"nvim-treesitter/nvim-treesitter-textobjects",
		"romgrk/nvim-treesitter-context",
		"HiPhish/nvim-ts-rainbow2",
	},
	build = ":TSUpdate",
}

local ok, nvim_treesitter = pcall(require, "nvim-treesitter.configs")
if not ok then
	error("Loading nvim-treesitter.configs")
	return
end

function M.config()
	require("nvim-treesitter.install").prefer_git = true
	nvim_treesitter.setup({
		version = false,
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
		highlight = {
			enable = true,
			additional_vim_regex_highlighting = true,
			disable = { "gitcommit" },
		},
		-- https://github.com/nvim-treesitter/nvim-treesitter#indentation
		indent = { enable = true, disable = { "gitcommit", "python" } },
		rainbow = {
			enable = true,
			extended_mode = true, -- Highlight also non-parentheses delimiters
			max_file_lines = 1000,
			-- Which query to use for finding delimiters
			query = 'rainbow-parens',
			-- Highlight the entire buffer all at once
			strategy = require 'ts-rainbow.strategy.global',
		},
		context_commentstring = { enable = true, enable_autocmd = false },
	})
end

return M
