local M = {}

local ok, packer = pcall(require, "packer")
if not ok then
	error('Loading packer')
	return
end

function M.reload_config()
    vim.cmd("luafile ~/.config/nvim/init.lua")
    vim.cmd("luafile ~/.config/nvim/lua/plugins.lua")

    packer.compile()
    packer.clean()
	packer.install()
end

M.augroups = {
	_general_settings = {
		{
			"TextYankPost",
			"*",
			"lua require('vim.highlight').on_yank({higroup = 'Search', timeout = 200})",
		}
	},
	_filetypechanges = {
		{ "BufWritePost", "plugins.lua", [[lua require('autocmds').reload_config()]] },
		{ "BufWinEnter", "*.zsh", "setlocal filetype=sh" },
		{ "BufRead", "*.zsh", "setlocal filetype=sh" },
		{ "BufNewFile", "*.zsh", "setlocal filetype=sh" },
	},
	_git = {
		{ "FileType", "gitcommit", "setlocal wrap" },
	},
	_markdown = {
		{ "FileType", "markdown", "setlocal wrap" },
	},
	_yaml = {
		{ "FileType", "yaml", "setlocal ts=2 sts=2 sw=2 expandtab" },
	},
	-- Show by default 4 spaces for a tab
	_golang = {
		{ "FileType", "*.go", "setlocal noexpandtab tabstop=4 shiftwidth=4" },
	},
	_buffer_bindings = {
		{ "FileType", "floaterm", "nnoremap <silent> <buffer> q :q<CR>" },
	},
	_general_lsp = {
		{
			"FileType",
			"lspinfo,lsp-installer,null-ls-info",
			"nnoremap <silent> <buffer> <esc> :close<CR>",
		},
	    { "CursorHold", "*", [[lua vim.diagnostic.open_float(nil, {scope = 'line'})]] },
	    { "CursorHoldI", "*", [[lua vim.diagnostic.open_float(nil, {scope = 'line'})]] }

	},
	_cmp = {
		{
			"FileType",
			"TelescopePrompt",
			[[lua require('cmp').setup.buffer { enabled = false }]],
		},
	},
}

function M.define_augroups(definitions)
	-- Create autocommand groups based on the passed definitions
	--
	-- The key will be the name of the group, and each definition
	-- within the group should have:
	--    1. Trigger
	--    2. Pattern
	--    3. Text
	-- just like how they would normally be defined from Vim itself
	for group_name, definition in pairs(definitions) do
		vim.cmd("augroup " .. group_name)
		vim.cmd("autocmd!")

		for _, def in pairs(definition) do
			local command = table.concat(
				vim.tbl_flatten({ "autocmd", def }),
				" "
			)
			vim.cmd(command)
		end

		vim.cmd("augroup END")
	end
end

function M.setup()
	M.define_augroups(M.augroups)
end

return M
