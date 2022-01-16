local ok, lsp_lines = pcall(require, "lsp_lines")
if not ok then
	error("Loading lsp_lines")
	return
end

-- Disable virtual_text since it's redundant due to lsp_lines.
vim.diagnostic.config({
	virtual_lines = false
})

lsp_lines.register_lsp_virtual_lines()
