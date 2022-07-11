local ok, nvim_tree = pcall(require, "nvim-tree")
if not ok then
	error("Loading nvim-tree")
	return
end

nvim_tree.setup({
})
