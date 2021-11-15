local vim = vim
local cmd = vim.cmd -- to execute Vim commands e.g. cmd('pwd')
local fn = vim.fn -- to call Vim functions e.g. fn.bufnr()
local o = vim.o -- to set options-- Putting here before onedar plugin is downloaded. I should be using setup and

-- config, but it seems packer has issues
if fn.exists("+termguicolors") == 1 then
	cmd([[
        let &t_8f = "\\<Esc>[38;2;%lu;%lu;%lum"
        let &t_8b = "\\<Esc>[48;2;%lu;%lu;%lum"
    ]])
	o.termguicolors = true
end
cmd([[colorscheme onedark]])
