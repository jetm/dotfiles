local ok, neogit = pcall(require, "neogit")
if not ok then
	error("Loading neogit")
	return
end

neogit.setup({
	integrations = {
		-- Neogit only provides inline diffs. If you want a more traditional way to
		-- look at diffs, you can use `sindrets/diffview.nvim`.
		diffview = true,
	},
})

-- neogit keybindings
-- https://github.com/TimUntersberger/neogit#status-keybindings
