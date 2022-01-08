local ok, trouble = pcall(require, "trouble")
if not ok then
	error("Loading trouble")
	return
end

trouble.setup()
