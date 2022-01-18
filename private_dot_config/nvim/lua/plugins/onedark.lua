local ok, onedark = pcall(require, "onedark")
if not ok then
	error("Loading onedark")
	return
end

onedark.setup {
    style = 'dark'
}

onedark.load()
