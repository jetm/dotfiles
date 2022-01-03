require("nvim-treesitter.configs").setup({
	ensure_installed = {
		"bash",
		"c",
		"cmake",
		"comment",
		"dockerfile",
		"go",
		"gomod",
		"lua",
		"python",
		"regex",
		"rust",
		"vim",
		"yaml",
	},
	autotag = { enable = false },
	highlight = { enable = true },
	-- https://github.com/nvim-treesitter/nvim-treesitter#indentation
	indent = { enable = true },
	-- https://github.com/nvim-treesitter/nvim-treesitter-textobjects
	textobjects = {
		-- https://github.com/nvim-treesitter/nvim-treesitter-textobjects#text-objects-select
		select = {
			enable = true,
			keymaps = {
				["af"] = "@function.outer",
				["if"] = "@function.inner",
				["aC"] = "@class.outer",
				["iC"] = "@class.inner",
				["ac"] = "@conditional.outer",
				["ic"] = "@conditional.inner",
				["ae"] = "@block.outer",
				["ie"] = "@block.inner",
				["al"] = "@loop.outer",
				["il"] = "@loop.inner",
				["is"] = "@statement.inner",
				["as"] = "@statement.outer",
				["ad"] = "@comment.outer",
				["am"] = "@call.outer",
				["im"] = "@call.inner",
			},
		},
	},
	-- https://github.com/p00f/nvim-ts-rainbow
	rainbow = {
		enable = true,
		iextended_mode = true, -- Highlight also non-parentheses delimiters
		max_file_lines = 1000,
	},
})
