--
-- Misc mappings
--
local ok, vimp = pcall(require, "vimp")
if not ok then
	error("Loading packer")
	return
end

-- moving up and down work as you would expect
-- Remap for dealing with word wrap
vim.keymap.set(
	"n",
	"k",
	"v:count == 0 ? 'gk' : 'k'",
	{ expr = true, silent = true }
)
vim.keymap.set(
	"n",
	"j",
	"v:count == 0 ? 'gj' : 'j'",
	{ expr = true, silent = true }
)

-- quitting mapping
vimp.nnoremap({ "silent" }, "q", ":BufferClose<CR>")
vimp.nnoremap({ "silent" }, "Q", ":qa<CR>")

-- expand_region
vimp.xmap({ "silent" }, "v", "<Plug>(expand_region_expand)")
vimp.xmap({ "silent" }, "V", "<Plug>(expand_region_shrink)")

vimp.nmap({ "silent" }, "<UP>", "<Nop>")
vimp.nmap({ "silent" }, "<Down>", "<Nop>")
vimp.nmap({ "silent" }, "<Left>", "<Nop>")
vimp.nmap({ "silent" }, "<Right>", "<Nop>")
vimp.imap({ "silent" }, "<UP>", "<Nop>")
vimp.imap({ "silent" }, "<Down>", "<Nop>")
vimp.imap({ "silent" }, "<Left>", "<Nop>")
vimp.imap({ "silent" }, "<Right>", "<Nop>")

-- Visual shifting (does not exit Visual mode)
vimp.vnoremap({ "silent" }, "<", "<gv")
vimp.vnoremap({ "silent" }, ">", ">gv")
vimp.nnoremap({ "silent" }, "<", "<<_")
vimp.nnoremap({ "silent" }, ">", ">>_")

-- vimp lacks of unmap() feature
vim.keymap.set({"n", "v"}, "+", "<Plug>(dial-increment)")
vim.keymap.set({"n", "v"}, "-", "<Plug>(dial-increment)")

-- Cancel a leader operation without sometimes causing unintended side effects
-- https://github.com/svermeulen/vimpeccable#chord-cancellation-maps
vimp.add_chord_cancellations("n", "<leader>")

-- formatter
vimp.nnoremap({ "silent" }, "<leader>f", ":Format<CR>")

-- Comments
-- Ctrl-/ as VSCode and Jetbrain
vimp.nmap({ "silent" }, "<c-_>", "<Plug>NERDCommenterToggle")
vimp.vmap({ "silent" }, "<c-_>", "<Plug>NERDCommenterToggle")

--
-- barbar
--
vimp.nnoremap({ "silent" }, "<leader>1", ":BufferGoto1<CR>")
vimp.nnoremap({ "silent" }, "<leader>2", ":BufferGoto2<CR>")
vimp.nnoremap({ "silent" }, "<leader>3", ":BufferGoto3<CR>")
vimp.nnoremap({ "silent" }, "<leader>4", ":BufferGoto4<CR>")
vimp.nnoremap({ "silent" }, "<leader>5", ":BufferGoto5<CR>")
vimp.nnoremap({ "silent" }, "<leader>6", ":BufferGoto6<CR>")
vimp.nnoremap({ "silent" }, "<leader>7", ":BufferGoto7<CR>")
vimp.nnoremap({ "silent" }, "<leader>8", ":BufferGoto8<CR>")
vimp.nnoremap({ "silent" }, "<leader>9", ":BufferGoto9<CR>")

-- vimp.nnoremap({ "silent" }, "<leader>o", require("portal").jump_backward)
-- vimp.nnoremap({ "silent" }, "<leader>i", require("portal").jump_forward)

--
-- Ctrl <C-> Mappings
--
--  Helper for saving file
vimp.nmap({ "silent" }, "<C-s>", ":update<CR>")
vimp.vmap({ "silent" }, "<C-s>", "<C-c>:update<CR>")
vimp.imap({ "silent" }, "<C-s>", "<C-o>:update<CR>")

-- local opts = {
--     prompt_title = "~ files ~",
--     find_command = {
--         "fd",
--         "--hidden",
--         "--type=file",
--         "--type=symlink",
--         "--exclude=.git",
--         "--ignore-case",
--         "--color=never",
--     },
-- }
--require("telescope.builtin").find_files(opts)

-- CtrlP compatibility
-- fzf.vim is quicker than fzf.preview
-- Telescope is async
vimp.nnoremap(
	{ "silent" },
	"<C-p>",
	"<cmd> Telescope find_files<CR>"
)

--
-- <F1>..<F12> Mappings
--
-- NvimTree
vimp.nnoremap({ "silent" }, "<F2>", ":NvimTreeToggle<CR>")

-- Shift + <F2>
vimp.nnoremap({ "silent" }, "<S-F2>", ":NvimTreeFindFile<CR>")

vimp.nnoremap(
	{ "silent" },
	"<F3>",
	':<C-U><C-R>=printf("Leaderf! rg -e %s ", expand("<cword>"))<CR>'
)
-- Shift + <F3>
vimp.nnoremap({ "silent" }, "<F15>", ":<C-U>Leaderf! rg --recall<CR>")

-- F5 shows a diagnostics
vimp.nnoremap({ "silent" }, "<F5>", ":TroubleToggle<CR>")

-- Search for words
vimp.nnoremap({ "silent" }, "s", "<Cmd>Svart<CR>")
vimp.xnoremap({ "silent" }, "s", "<Cmd>Svart<CR>")
vimp.onoremap({ "silent" }, "s", "<Cmd>Svart<CR>")

--
-- shellharden
--
-- nmap <silent> <F7> :%!shellharden --replace ''<CR>
