local o = vim.o -- to set options

o.autowrite = true -- Automatically write a file when leaving a modified buffer
o.cursorline = true -- Highlight current line
o.hidden = true -- Allow buffer switching without saving
o.ignorecase = true
o.linebreak = true -- Do not break words
o.linespace = 0 -- No extra spaces between rows
o.matchtime = 0 -- Hide matching time
o.mouse = "a" -- Enable mouse scrolling
o.number = true
o.regexpengine = 1 -- Use the old engine, new is for debugging
o.relativenumber = true -- Enable numbers on the left, current line is 0
o.shiftround = true -- Round indent to multiple of 'shiftwidth'
o.shortmess = "atOI" -- No help Uganda information, and overwrite read messages to avoid PRESS ENTER prompts
o.showmatch = true -- Show matching brackets/parentthesis
o.showmode = true -- Show current mode in command-line
o.showtabline = 2 -- Always show tabline
o.smartcase = true -- Case insensitive search, but case sensitive when uc present
o.smartindent = true
o.statusline = 3 -- Have a single statusline at bottom of neovim instead of one for every window
o.expandtab = true
o.softtabstop = 4
o.shiftwidth = o.softtabstop
o.tabstop = o.softtabstop -- Tab width

-- Display whitespace characters
o.list = true
vim.opt.listchars = { tab = "→ ", trail = "·" }

-- config, but it seems packer has issues
if vim.fn.exists("+termguicolors") == 1 then
	vim.cmd([[
        let &t_8f = "\\<Esc>[38;2;%lu;%lu;%lum"
        let &t_8b = "\\<Esc>[48;2;%lu;%lu;%lum"
    ]])
	o.termguicolors = true
end

-- sync yanked text with the system clipboard
vim.opt.clipboard:append { 'unnamedplus' }
