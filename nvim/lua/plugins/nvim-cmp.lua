-- Setup global configuration. More on configuration below.
local cmp = require("cmp")
local snippy = require("snippy")

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

local lspkind = require("lspkind")

cmp.setup({
	completion = { completeopt = "menu,menuone,noselect" },

	snippet = {
		expand = function(args)
			require("snippy").expand_snippet(args.body)
		end,
	},

	mapping = {
		["<CR>"] = cmp.mapping.confirm({
			behavior = cmp.ConfirmBehavior.Replace,
			select = true,
		}),
		["<Tab>"] = cmp.mapping(tab_complete, { "i", "s" }),
		["<S-Tab>"] = cmp.mapping(s_tab_complete, { "i", "s" }),
	},

	formatting = {
		format = lspkind.cmp_format({ with_text = false, maxwidth = 50 }),
	},

	sources = {
		{ name = "buffer", max_item_count = 5, priority = 1 },
		{ name = "snippy", priority = 2 },
		{ name = "path", max_item_count = 5, priority = 3 },
		{ name = "nvim_lsp", max_item_count = 5, priority = 4 },
		{ name = "nvim_lua", max_item_count = 5, priority = 5 },
		{
			name = "rg",
			max_item_count = 5,
			priority = 10,
			opts = {
				additional_arguments = "--ignore-file halon-src --ignore-file halon-test --ignore-file tools --glob '!*.patch'",
			},
		},
	},
})

require("cmp_nvim_lsp").setup()
for index, value in ipairs(vim.lsp.protocol.CompletionItemKind) do
	cmp.lsp.CompletionItemKind[index] = value
end
