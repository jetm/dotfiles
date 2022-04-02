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

local ok3, nvim_tree_view = pcall(require, "nvim-tree.view")
if not ok3 then
	error("Loading nvim-tree.view")
	return
end

local M = {}

function M.resize()
	local w = nvim_tree_view.View.width
	if original_width == nil then
		original_width = w
	end
	if w ~= original_width then
		w = original_width
	else
		w = w + 10
	end
	nvim_tree_view.View.width = w
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

nvim_tree.setup({
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
