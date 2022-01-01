local lsp = require("lspconfig")
local lsp_status = require("lsp-status")
lsp_status.register_progress()

-- custom attach config for most LSP configs
local on_attach = function(client, bufnr)
	require("lsp_signature").on_attach({
		bind = true, -- This is mandatory, otherwise border config won't get registered.
		floating_window = true, -- show hint in a floating window, set to false for virtual text only mode
		hint_enable = true, -- virtual hint enable
		handler_opts = {
			border = "shadow", -- double, single, shadow, none
		},
	})

	lsp_status.on_attach(client, bufnr)
end

local null_ls = require("null-ls")
null_ls.setup({
	sources = {
		null_ls.builtins.diagnostics.shellcheck,
	},
})

-- diagnostics
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
	vim.lsp.diagnostic.on_publish_diagnostics,
	{ virtual_text = false, signs = true }
)

-- Design
local vim = vim
local cmd = vim.cmd
cmd("sign define LspDiagnosticsSignError text=")
cmd("sign define LspDiagnosticsSignWarning text=ﰣ")
cmd("sign define LspDiagnosticsSignInformation text=")
cmd("sign define LspDiagnosticsSignHint text=")

-- show line diagnostic
vim.api.nvim_command(
	"autocmd CursorHold * lua vim.diagnostic.open_float({ focusable = false })"
)

lsp.bashls.setup({
	filetypes = { "sh", "zsh", "bash" },
	on_attach = on_attach,
	capabilities = lsp_status.capabilities,
})

lsp.clangd.setup({
	on_attach = on_attach,
	capabilities = lsp_status.capabilities,
})

local sumneko_root_path = os.getenv("HOME")
	.. "/.zinit/plugins/lua-language-server"
local sumneko_binary = sumneko_root_path .. "/bin/Linux/lua-language-server"

lsp.sumneko_lua.setup({
	cmd = { sumneko_binary, "-E", sumneko_root_path .. "/main.lua" },
	on_attach = on_attach,
	capabilities = lsp_status.capabilities,
	settings = {
		Lua = {
			runtime = {
				-- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
				version = "LuaJIT",
				-- Setup your lua path
				path = vim.split(package.path, ";"),
			},
			diagnostics = {
				-- Get the language server to recognize the `vim` global
				globals = { "vim" },
			},
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
