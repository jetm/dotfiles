local M = {
	"VonHeikemen/lsp-zero.nvim",
	dependencies = {
		{ "neovim/nvim-lspconfig" },
		{ "williamboman/mason.nvim" },
		{ "williamboman/mason-lspconfig.nvim" },

		{ "hrsh7th/nvim-cmp" },
		{ "hrsh7th/cmp-nvim-lsp" },
		{ "hrsh7th/cmp-buffer" },
		{ "hrsh7th/cmp-path" },
		{ "saadparwaiz1/cmp_luasnip" },
		{ "hrsh7th/cmp-nvim-lua" },
		{ "onsails/lspkind.nvim" },

		-- snippets
		{ "L3MON4D3/LuaSnip" },
		{ "rafamadriz/friendly-snippets" },

		-- null-ls
		"jose-elias-alvarez/null-ls.nvim",
	},
}

function M.config()
	local ok_lsp, lsp = pcall(require, "lsp-zero")
	if not ok_lsp then
		error("Loading lsp-zero")
		return
	end

	local ok_lspkind, lspkind = pcall(require, "lspkind")
	if not ok_lspkind then
		error("Loading lspkind")
		return
	end

	lsp.preset("recommended")

	lsp.set_preferences({})

	lsp.setup_nvim_cmp({
		mapping = lsp.defaults.cmp_mappings,
		sources = {
			{ name = "path" },
			{ name = "nvim_lsp", keyword_length = 1, max_item_count = 5 },
			{ name = "buffer",   keyword_length = 3, max_item_count = 5 },
			{ name = "luasnip",  keyword_length = 2 },
		},
		formatting = {
			format = lspkind.cmp_format({ with_text = false }),
		},
	})

	lsp.ensure_installed({
		"bashls",
		"dockerls",
		"lua_ls",
		"vimls",
		"yamlls",
	})

	-- lua_ls Fix Undefined global 'vim'
	lsp.configure(
		"lua_ls",
		{ settings = { Lua = { diagnostics = { globals = { "vim" } } } } }
	)

	-- Configure lua language server for neovim
	lsp.nvim_workspace()
	lsp.setup()

	vim.opt.signcolumn = "yes"

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
			null_ls.builtins.diagnostics.zsh,
			null_ls.builtins.formatting.shfmt.with({
				extra_args = function(params)
					return {
						"-i",
						vim.api.nvim_buf_get_option(params.bufnr, "shiftwidth"),
						"-sr",
						"-ci",
						"-s",
					}
				end,
				extra_filetypes = { "zsh" },
			}),
			null_ls.builtins.formatting.stylua.with({
				extra_args = { "--column-width 80" },
			}),
		},
	})
end

return M
