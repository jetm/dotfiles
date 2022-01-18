--
-- Misc mappings
--
local ok, vimp = pcall(require, "vimp")
if not ok then
	error("Loading packer")
	return
end

-- moving up and down work as you would expect
vimp.nnoremap({ "silent" }, "j", "gj")
vimp.nnoremap({ "silent" }, "k", "gk")

-- Keep the cursor in place while joining lines
vimp.nnoremap({ "silent" }, "J", "mzJ`z")

-- Move selected line / block of text in visual mode
vimp.vnoremap({ "silent" }, "K", ":move '<-2<CR>gv-gv")
vimp.vnoremap({ "silent" }, "J", ":move '>+1<CR>gv-gv")

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

-- Search selected text (consistent with `*` behaviour)
vimp.nnoremap({ "silent" }, "*", [[*N]])
vimp.vnoremap({ "silent" }, "*", [[y/\V<c-r>=escape(@",'/\')<cr><cr>N]])

vimp.nmap({ "silent" }, "+", "<Plug>(dial-increment)")
vimp.nmap({ "silent" }, "-", "<Plug>(dial-decrement)")
vimp.vmap({ "silent" }, "+", "<Plug>(dial-increment)")
vimp.vmap({ "silent" }, "-", "<plug>(dial-decrement)")

--
-- <leader> mappings
--
vim.g.mapleader = " "

-- Cancel a leader operation without sometimes causing unintended side effects
-- https://github.com/svermeulen/vimpeccable#chord-cancellation-maps
vimp.add_chord_cancellations("n", "<leader>")

-- formatter
vimp.nnoremap({ "silent" }, "<leader>f", ":Format<CR>")

-- Comments
vimp.nmap({ "silent" }, "<leader>c", "<Plug>NERDCommenterToggle")
vimp.vmap({ "silent" }, "<leader>c", "<Plug>NERDCommenterToggle")

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

--
-- Ctrl <C-> Mappings
--
--  Helper for saving file
vimp.nmap({ "silent" }, "<C-s>", ":update<CR>")
vimp.vmap({ "silent" }, "<C-s>", "<C-c>:update<CR>")
vimp.imap({ "silent" }, "<C-s>", "<C-o>:update<CR>")

-- CtrlP compatibility
-- fzf.vim is quicker than fzf.preview
-- Telescope is async
-- Testing snap
-- Select files, symlinks, hidden files, and exclude Git directory
-- ":Telescope find_files find_command=git,ls-files<CR>"
vimp.nnoremap(
	{ "silent" },
	"<C-p>",
	":Telescope find_files find_command=fd,-t,f,-t,l,--hidden,--exclude,.git,--color,never<CR>"
)

vimp.nnoremap(
	{ "silent" },
	"<F5>",
	":lua vim.lsp.diagnostic.show_line_diagnostics()<CR>"
)

--
-- Alt <M-> Mappings
--
-- navigation
vimp.inoremap({ "silent" }, "<A-Up>", "<C-\\><C-N><C-w>k")
vimp.inoremap({ "silent" }, "<A-Down>", "<C-\\><C-N><C-w>j")
vimp.inoremap({ "silent" }, "<A-Left>", "<C-\\><C-N><C-w>h")
vimp.inoremap({ "silent" }, "<A-Right>", "<C-\\><C-N><C-w>l")

-- Move current line / block with Alt-j/k ala vscode
vimp.inoremap({ "silent" }, "<A-j>", "<Esc>:m .+1<CR>==gi")
vimp.inoremap({ "silent" }, "<A-k>", "<Esc>:m .-2<CR>==gi")

-- Move current line / block with Alt-j/k a la vscode
vimp.nnoremap({ "silent" }, "<A-j>", ":m .+1<CR>==")
vimp.nnoremap({ "silent" }, "<A-k>", ":m .-2<CR>==")

-- Sizing window horizontally
vimp.nnoremap({ "silent" }, "<M-,>", "<C-W><")
vimp.nnoremap({ "silent" }, "<M-.>", "<C-W>>")

-- Move current line / block with Alt-j/k ala vscode)
vimp.vnoremap({ "silent" }, "<A-j>", ":m '>+1<CR>gv-gv")
vimp.vnoremap({ "silent" }, "<A-k>", ":m '<-2<CR>gv-gv")

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

--
-- shellharden
--
-- nmap <silent> <F7> :%!shellharden --replace ''<CR>
