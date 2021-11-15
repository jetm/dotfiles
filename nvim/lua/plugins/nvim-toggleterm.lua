require("toggleterm").setup({
	open_mapping = [[<F11>]],
	hide_numbers = true,
	shade_terminals = false,
	start_in_insert = false,
	insert_mappings = true, -- whether or not the open mapping applies in insert mode
	persist_size = true,
	direction = "float",
	close_on_exit = true, -- close the terminal window when the process exits
	-- This field is only relevant if direction is set to 'float'
	float_opts = { border = "curved" },
})
