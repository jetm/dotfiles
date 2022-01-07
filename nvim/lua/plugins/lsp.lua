local status_ok, lsp = pcall(require, "lspconfig")
if not status_ok then
	return
end

local lsp_status = require("lsp-status")
lsp_status.register_progress()

local vim = vim

-- custom attach config for most LSP configs
local on_attach = function(client, bufnr)
	-- enable signature help when possible
	if client.resolved_capabilities.signature_help then
		require("lsp_signature").on_attach({
			bind = true, -- This is mandatory, otherwise border config won't get registered.
			floating_window = true, -- show hint in a floating window, set to false for virtual text only mode
			hint_enable = false, -- virtual hint false
			handler_opts = {
				border = "shadow", -- double, single, shadow, none
			},
		})
	end

	lsp_status.on_attach(client, bufnr)
end

--
-- Signs settings
--
local signs = {
	{ name = "DiagnosticSignError", text = "" },
	{ name = "DiagnosticSignWarn", text = "" },
	{ name = "DiagnosticSignHint", text = "" },
	{ name = "DiagnosticSignInfo", text = "" },
}

for _, sign in ipairs(signs) do
	vim.fn.sign_define(
		sign.name,
		{ texthl = sign.name, text = sign.text, numhl = "" }
	)
end

--
-- diagnostic configuration
--
local config = {
	virtual_text = false, -- annoying
	signs = signs,
	underline = true,
	update_in_insert = true,
	severity_sort = true,
	float = {
		focusable = false,
		style = "minimal",
		border = "rounded",
		source = "always",
		header = "",
		prefix = "",
		format = function(d)
			local t = vim.deepcopy(d)
			if d.code then
				t.message = string.format("%s [%s]", t.message, t.code):gsub(
					"1. ",
					""
				)
			end
			return t.message
		end,
	},
}

vim.diagnostic.config(config)

-- automatically show diagnostic. Consider using a keymap
vim.api.nvim_command(
	"autocmd CursorHold * lua vim.diagnostic.open_float({0, {scope='line'}})"
)

local null_ls = require("null-ls")
null_ls.setup({
	sources = {
		null_ls.builtins.diagnostics.shellcheck,
		null_ls.builtins.code_actions.shellcheck,
	},
})

--
-- LSP servers configuration
--

-- The nvim-cmp almost supports LSP's capabilities so You should advertise it to LSP servers..
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").update_capabilities(capabilities)

lsp.bashls.setup({
	filetypes = { "sh", "zsh", "bash" },
	on_attach = on_attach,
	capabilities = capabilities,
})

local clangd_flags = {
	"--all-scopes-completion",
	"--background-index",
	"--pch-storage=memory",
	"--log=info",
	"--enable-config",
	"--clang-tidy",
	"--completion-style=detailed",
	"--offset-encoding=utf-16", --temporary fix for null-ls
}

lsp.clangd.setup({
	cmd = { "clangd", unpack(clangd_flags) },
	on_attach = on_attach,
	capabilities = capabilities,
})

local sumneko_root_path = os.getenv("HOME")
	.. "/.zinit/plugins/lua-language-server"
local sumneko_binary = sumneko_root_path .. "/bin/Linux/lua-language-server"

lsp.sumneko_lua.setup({
	cmd = { sumneko_binary, "-E", sumneko_root_path .. "/main.lua" },
	on_attach = on_attach,
	capabilities = capabilities,
	settings = {
		Lua = {
			telemetry = { enable = false },
			diagnostics = { enable = false },
			workspace = {
				-- Make the server aware of Neovim runtime files
				library = {
					[vim.fn.expand("$VIMRUNTIME/lua")] = true,
					[vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true,
				},
			},
		},
	},
})
