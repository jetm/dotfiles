local ok, gitsigns = pcall(require, "gitsigns")
if not ok then
	error("Loading gitsigns")
	return
end

local signs = {
	add = {
		hl = "GitSignsAdd",
		text = "▌",
		numhl = "GitSignsAdd",
		linehl = "GitSignsAddLn",
	},
	change = {
		hl = "GitSignsChange",
		text = "▌",
		numhl = "GitSignsChange",
		linehl = "GitSignsChangeLn",
	},
	delete = {
		hl = "GitSignsDelete",
		text = "▌",
		numhl = "GitSignsDelete",
		linehl = "GitSignsDeleteLn",
	},
	topdelete = {
		hl = "GitSignsDelete",
		text = "‾",
		numhl = "GitSignsDeleteNr",
		linehl = "GitSignsDeleteLn",
	},
	changedelete = {
		hl = "GitSignsChange",
		text = "~",
		numhl = "GitSignsChangeNr",
		linehl = "GitSignsChangeLn",
	},
}

-- https://github.com/lewis6991/gitsigns.nvim#usage
gitsigns.setup({
	signs = signs,
	numhl = true,
	linehl = false,
	watch_gitdir = { interval = 100 },
	sign_priority = 5,
	status_formatter = nil, -- Use default
	diff_opts = { internal = true }, -- If luajit is present
})
