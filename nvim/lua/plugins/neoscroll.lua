local ok, neoscroll = pcall(require, "neoscroll")
if not ok then
	error("Loading neoscroll")
	return
end

neoscroll.setup({ mappings = {} })
