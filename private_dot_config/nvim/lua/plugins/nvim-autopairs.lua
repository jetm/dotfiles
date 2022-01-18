local ok, nvim_autopairs = pcall(require, "nvim-autopairs")
if not ok then
	error("Loading nvim-autopairs")
	return
end

nvim_autopairs.setup({
	active = true,
	on_config_done = nil,
	---@usage  modifies the function or method delimiter by filetypes
	map_char = {
		all = "(",
		tex = "{",
	},
	---@usage check bracket in same line
	enable_check_bracket_line = false,
	---@usage check treesitter
	check_ts = true,
	disable_filetype = { "TelescopePrompt" },
	ignored_next_char = string.gsub([[ [%w%%%'%[%"%.] ]], "%s+", ""),
	enable_moveright = true,
	---@usage disable when recording or executing a macro
	disable_in_macro = false,
	---@usage add bracket pairs after quote
	enable_afterquote = true,
	---@usage map the <BS> key
	map_bs = true,
	---@usage map <c-w> to delete a pair if possible
	map_c_w = false,
	---@usage disable when insert after visual block mode
	disable_in_visualblock = false,
	fast_wrap = {
		map = "<M-e>",
		chars = { "{", "[", "(", '"', "'" },
		pattern = string.gsub([[ [%'%"%)%>%]%)%}%,] ]], "%s+", ""),
		offset = 0, -- Offset from pattern match
		end_key = "$",
		keys = "qwertyuiopzxcvbnmasdfghjkl",
		check_comma = true,
		highlight = "Search",
		highlight_grey = "Comment",
	},
})

local ok2, nvim_treesitter_configs = pcall(require, "nvim-treesitter.configs")
if not ok2 then
	error("Loading nvim-treesitter.configs")
	return
end

nvim_treesitter_configs.setup({ autopairs = { enable = true } })
