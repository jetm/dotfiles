local ok, lightspeed = pcall(require, "lightspeed")
if not ok then
	error("Loading lightspeed")
	return
end

lightspeed.setup({
	limit_ft_matches = 1,
	-- Keys to jump group
	special_keys = {
		next_match_group = "<tab>",
		prev_match_group = "<s-tab>",
	},
})
