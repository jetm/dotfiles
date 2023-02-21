local vim = vim

local M = {
	"neovim/nvim-lspconfig",
	dependencies = {
		-- Signature hint when typing
		"ray-x/lsp_signature.nvim",

		-- Generate statusline components from the built-in LSP client
		"nvim-lua/lsp-status.nvim",

		-- Pictograms for LSP completion system
		"onsails/lspkind-nvim",

		-- Use Neovim as a language server to inject LSP diagnostics, code
		-- actions, and more via Lua
		"jose-elias-alvarez/null-ls.nvim",
	},
}

function M.config()
	--
	-- Signs settings
	--
	local signs = { Error = " ", Warn = " ", Hint = "", Info = "" }

	for type, icon in pairs(signs) do
		local hl = "DiagnosticSign" .. type
		vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
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
					t.message = string
						.format("%s [%s]", t.message, t.code)
						:gsub("1. ", "")
				end
				return t.message
			end,
		},
	}

	vim.diagnostic.config(config)

	local ok, null_ls = pcall(require, "null-ls")
	if not ok then
		error("Loading null-ls")
		return
	end

	null_ls.setup({
		sources = {
			null_ls.builtins.diagnostics.shellcheck.with({
				filetypes = { "sh", "zsh", "bash" },
			}),
			null_ls.builtins.code_actions.shellcheck.with({
				filetypes = { "sh", "zsh", "bash" },
			}),
			null_ls.builtins.diagnostics.luacheck,
		},
	})

	--
	-- LSP servers configuration
	--

	-- The nvim-cmp almost supports LSP's capabilities so You should advertise it
	-- to LSP servers
	local capabilities = vim.lsp.protocol.make_client_capabilities()

	local ok1, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
	if not ok1 then
		error("Loading cmp_nvim_lsp")
		return
	end

	capabilities = cmp_nvim_lsp.default_capabilities(capabilities)

	local ok2, lsp_status = pcall(require, "lsp-status")
	if not ok2 then
		error("Loading lsp-status")
		return
	end

	lsp_status.register_progress()

	local ok3, lsp_signature = pcall(require, "lsp_signature")
	if not ok3 then
		error("Loading lsp_signature")
		return
	end

	-- custom attach config for most LSP configs
	local on_attach = function(client)
		-- enable signature help when possible
		if client.server_capabilities.signature_help then
			lsp_signature.on_attach({
				bind = true, -- This is mandatory, otherwise border config won't get registered.
				floating_window = true, -- show hint in a floating window, set to false for virtual text only mode
				hint_enable = false, -- virtual hint false
				handler_opts = {
					border = "shadow", -- double, single, shadow, none
				},
			})
		end

		lsp_status.on_attach(client)
	end

	local ok4, lspconfig = pcall(require, "lspconfig")
	if not ok4 then
		return
	end

	lspconfig.bashls.setup({
		filetypes = { "sh", "zsh", "bash" },
		on_attach = on_attach,
		capabilities = capabilities,
	})

	-- local clangd_flags = {
	--     "--all-scopes-completion",
	--     "--background-index",
	--     "--pch-storage=memory",
	--     "--log=info",
	--     "--enable-config",
	--     "--clang-tidy",
	--     "--completion-style=detailed",
	--     "--offset-encoding=utf-16", --temporary fix for null-ls
	-- }
	--
	-- lsp.clangd.setup({
	--     cmd = { "clangd", unpack(clangd_flags) },
	--     on_attach = on_attach,
	--     capabilities = capabilities,
	-- })

	lspconfig.lua_ls.setup({
		on_attach = on_attach,
		capabilities = capabilities,
		settings = {
			Lua = {
				runtime = {
					-- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
					version = "LuaJIT",
				},
				diagnostics = {
					-- Get the language server to recognize the `vim` global
					globals = { "vim" },
				},
				workspace = {
					-- Make the server aware of Neovim runtime files
					library = vim.api.nvim_get_runtime_file("", true),
					checkThirdParty = false,
				},
				-- Do not send telemetry data containing a randomized but unique identifier
				telemetry = {
					enable = false,
				},
			},
		},
	})
end

return M
