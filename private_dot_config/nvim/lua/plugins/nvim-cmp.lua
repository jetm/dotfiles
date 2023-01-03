local M = {
	"hrsh7th/nvim-cmp",
	dependencies = {
		"dcampos/nvim-snippy",
		"honza/vim-snippets",
		"onsails/lspkind-nvim", -- no after
		"hrsh7th/cmp-nvim-lsp", -- no after
		"hrsh7th/cmp-nvim-lua",
		"hrsh7th/cmp-buffer",
		"hrsh7th/cmp-path",
	},
}

function M.config()
	local ok_cmp, cmp = pcall(require, "cmp")
	if not ok_cmp then
		error("Loading cmp")
		return
	end

	local ok_snippy, snippy = pcall(require, "snippy")
	if not ok_snippy then
		error("Loading snippy")
		return
	end

	local has_words_before = function()
		if vim.api.nvim_buf_get_option(0, "buftype") == "prompt" then
			return false
		end
		local line, col = unpack(vim.api.nvim_win_get_cursor(0))
		return col ~= 0
			and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]
					:sub(col, col)
					:match("%s")
				== nil
	end

	local tab_complete = function(fallback)
		if cmp.visible() then
			cmp.select_next_item()
		elseif snippy.can_expand_or_advance() then
			snippy.expand_or_advance()
		elseif has_words_before() then
			cmp.complete()
		else
			fallback()
		end
	end

	local s_tab_complete = function(fallback)
		if cmp.visible() then
			cmp.select_prev_item()
		elseif snippy.can_jump(-1) then
			snippy.previous()
		else
			fallback()
		end
	end

	local ok_lspkind, lspkind = pcall(require, "lspkind")
	if not ok_lspkind then
		error("Loading lspkind")
		return
	end

	cmp.setup({
		completion = {
			keyword_length = 2,
			completeopt = "menu,menuone,preview,noselect", -- want to select the first
		},

		snippet = {
			expand = function(args)
				snippy.expand_snippet(args.body)
			end,
		},

		mapping = cmp.mapping.preset.insert({
			["<CR>"] = cmp.mapping.confirm({
				behavior = cmp.ConfirmBehavior.Replace,
				select = true,
			}),
			["<Tab>"] = cmp.mapping(tab_complete, { "i", "s" }),
			["<S-Tab>"] = cmp.mapping(s_tab_complete, { "i", "s" }),
		}),

		formatting = {
			format = lspkind.cmp_format({ with_text = false, maxwidth = 50 }),
		},

		sources = {
			{ name = "buffer", max_item_count = 5, priority = 1 },
			{ name = "nvim_lsp", max_item_count = 5, priority = 2 },
			{ name = "nvim_lua", max_item_count = 5, priority = 3 },
			{ name = "snippy", priority = 4 },
			{ name = "path", max_item_count = 5, priority = 5 },
			-- {
			--     name = "rg",
			--     max_item_count = 5,
			--     priority = 10,
			--     option = {
			--         additional_arguments = "--ignore-file halon-src --ignore-file halon-test --ignore-file tools --glob '!*.patch'"
			--     },
			-- },
		},
	})

	-- Use buffer source for `/`
	-- if you enabled `native_menu`, this won't work anymore
	-- cmp.setup.cmdline("/", {
	--     mapping = cmp.mapping.preset.cmdline(),
	--     completion = {
	--         keyword_length = 2,
	--     },
	--     sources = {
	--         { name = "buffer" },
	--     },
	-- })

	-- Use cmdline & path source for ':'
	-- if you enabled `native_menu`, this won't work anymore
	-- cmp.setup.cmdline(":", {
	--     mapping = cmp.mapping.preset.cmdline(),
	--     completion = {
	--         keyword_length = 2,
	--     },
	--     sources = cmp.config.sources({
	--         { name = "path" },
	--     }, {
	--         { name = "cmdline" },
	--     }),
	-- })

	-- If you want insert `(` after select function or method item
	local ok_cmp_autopairs, cmp_autopairs = pcall(
		require,
		"nvim-autopairs.completion.cmp"
	)
	if not ok_cmp_autopairs then
		error("Loading nvim-autopairs.completion.cmp")
		return
	end
	cmp.event:on(
		"confirm_done",
		cmp_autopairs.on_confirm_done({ map_char = { tex = "" } })
	)
end

return M
