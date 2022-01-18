local ok, tabnine = pcall(require, "cmp_tabnine.config")
if not ok then
	error("Loading cmp_tabnine.config")
	return
end

tabnine:setup({
	max_lines = 1000,
	max_num_results = 20,
	sort = true,
	run_on_every_keystroke = true,
})
