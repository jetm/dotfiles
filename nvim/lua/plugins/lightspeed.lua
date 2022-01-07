local status_ok, lightspeed = pcall(require, "lightspeed")
if not status_ok then
	return
end

lightspeed.setup({
	limit_ft_matches = 1,
	-- Keys to jump group
	cycle_group_fwd_key = "<tab>",
	cycle_group_bwd_key = "<s-tab>",
})
