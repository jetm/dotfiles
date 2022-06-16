-- Disable perl/ruby provider
vim.g.loaded_perl_provider = 0
vim.g.loaded_ruby_provider = 0

-- Disable some unused built-in Neovim plugins
local disabled_built_ins = {
	"2html_plugin",
	"getscript",
	"getscriptPlugin",
	"gzip",
	"logipat",
	"man",
	"matchit",
	"netrw",
	"netrwFileHandlers",
	"netrwPlugin",
	"netrwSettings",
	"remotes_plugins",
	"rrhelper",
	"spellfile_plugin",
	"tar",
	"tarPlugin",
	"vimball",
	"vimballPlugin",
	"zip",
	"zipPlugin",
}

for _, plugin in pairs(disabled_built_ins) do
	vim.g["loaded_" .. plugin] = false
end
