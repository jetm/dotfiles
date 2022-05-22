local ok, nvim_tree = pcall(require, "nvim-tree")
if not ok then
	error("Loading nvim-tree")
	return
end

local ok2, icons = pcall(require, "nvim-nonicons")
if not ok2 then
	error("Loading nvim-nonicons")
	return
end

local vim = vim

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

nvim_tree.setup({})
