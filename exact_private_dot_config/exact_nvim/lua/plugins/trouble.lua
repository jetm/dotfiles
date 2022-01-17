local ok, trouble = pcall(require, "trouble")
if not ok then
	error("Loading trouble")
	return
end

trouble.setup({
	signs = {
		-- icons / text used for a diagnostic
		error = "",
		warning = "",
		hint =  "",
		information = "",
		other = "﫠",
	},
	use_diagnostic_signs = true,
})
