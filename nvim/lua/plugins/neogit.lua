local status_ok, neogit = pcall(require, "neogit")
if not status_ok then
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
