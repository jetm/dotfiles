local status_ok, dressing = pcall(require, "dressing")
if not status_ok then
	return
end

dressing.setup({
	input = {
		default_prompt = "➤ ",
		winhighlight = "Normal:Normal,NormalNC:Normal",
	},
	select = {
		backend = { "telescope", "builtin" },
		builtin = { winhighlight = "Normal:Normal,NormalNC:Normal" },
	},
})
