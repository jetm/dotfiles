local vim = vim
local icons = require("nvim-nonicons")

local M = {}

function M.resize()
	local w = require("nvim-tree.view").View.width
	if original_width == nil then
		original_width = w
	end
	if w ~= original_width then
		w = original_width
	else
		w = w + 10
	end
	require("nvim-tree.view").View.width = w
	vim.cmd("NvimTreeClose")
	vim.cmd("NvimTreeToggle")
end

vim.g.nvim_tree_icons = {
	default = icons.get("file"),
	symlink = icons.get("file-symlink"),
	git = {
		unstaged = "✗",
		staged = "✓",
		unmerged = "",
		renamed = "➜",
		untracked = "★",
		deleted = "",
		ignored = "◌",
	},
	folder = {
		arrow_open = "",
		arrow_closed = "",
		default = icons.get("file-directory"),
		open = icons.get("file-directory"),
		empty = icons.get("file-directory-outline"),
		empty_open = icons.get("file-directory-outline"),
		symlink = icons.get("file-submodule"),
		symlink_open = icons.get("file-submodule"),
	},
}

require("nvim-tree").setup({
	-- closes neovim automatically when the tree is the last **WINDOW** in the view
	auto_close = true,
	-- if true the tree will resize itself after opening a file
	auto_resize = true,
	mappings = {
		-- list of mappings to set on the tree manually
		list = {
			{
				key = "z",
				cb = [[:lua require('plugins.nvim-tree').resize()<CR>]],
			},
		},
	},
})

return M
