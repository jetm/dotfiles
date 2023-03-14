local M = {
	"nvim-tree/nvim-tree.lua",
	dependencies = "nvim-tree/nvim-web-devicons",
}

function M.config()
	local ok, nvim_tree = pcall(require, "nvim-tree")
	if not ok then
		error("Loading nvim-tree")
		return
	end

	nvim_tree.setup({ })
end

return M
