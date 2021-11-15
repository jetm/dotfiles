local vim = vim

vim.g.coq_settings = {
	auto_start = "shut-up",
	clients = {
		lsp = { short_name = "LSP" },
		snippets = { enabled = true },
		-- too slow in big repo. coq uses a slow version
		tabnine = { enabled = false },
		paths = { preview_lines = 6 },
		tree_sitter = { enabled = true },
		buffers = {
			-- Filter matches only from the same filetype buffers.
			same_filetype = true,
			short_name = "B",
		},
		tags = { enabled = false },
		tmux = { enabled = false },
	},
}
