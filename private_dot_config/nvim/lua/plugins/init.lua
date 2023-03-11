return {
	-- Icon set using nonicons for neovim plugins and settings
	{
		"yamatsum/nvim-nonicons",
		dependencies = { "kyazdani42/nvim-web-devicons" },
	},

	-- Neovim plugin that allows you to easily write your .vimrc in lua or any
	-- lua based language
	{ "svermeulen/vimpeccable" },

	-- Replace fzf
	{ "nvim-telescope/telescope-fzf-native.nvim",     build = "make" },

	-- Neovim plugin to jump to any location with few keystrokes
	{ url = "https://gitlab.com/madyanov/svart.nvim", name = "svart.nvim" },

	-- Enable opening a file in a given line
	{ "wsdjeg/vim-fetch" },

	-- Substitute preview
	{ "osyo-manga/vim-over" },

	-- Handles bracketed-paste-mode in vim (aka. automatic `:set paste`)
	{ "ConradIrwin/vim-bracketed-paste" },

	-- Visualise and resolve merge conflicts in neovim
	-- ]x - move to previous conflict
	-- [x - move to next conflict
	-- co - choose ours
	-- ct - choose theirs
	-- cb - choose both
	-- c0 - choose none
	{ "rhysd/conflict-marker.vim" },

	-- Expand selection
	{
		"terryma/vim-expand-region",
		dependencies = {
			"kana/vim-textobj-user",
			"kana/vim-textobj-line",
			"machakann/vim-textobj-functioncall",
			"sgur/vim-textobj-parameter",
		},
	},

	-- Quoting/parenthesizing made simple
	{ "machakann/vim-sandwich" },

	-- Enable repeating supported plugin maps with '.'
	{ "tpope/vim-repeat" },

	-- enhanced increment/decrement plugin for Neovim
	{ "monaqa/dial.nvim" },

	-- Removes trailing whitespace from *modified* lines on save
	-- Replace ntpeters/vim-better-whitespace
	{ "axelf4/vim-strip-trailing-whitespace" },

	{ "sheerun/vim-polyglot" },

	-- Wisely add if/fi, for/end in several languages
	{ "tpope/vim-endwise" },

	-- bitbake support
	{ "kergoth/vim-bitbake" },

	-- Markdown support
	-- Generate table of contents for Markdown files
	{ "mzlogin/vim-markdown-toc" },

	-- New files created with a shebang line are automatically made executable
	{ "tpope/vim-eunuch" },

	-- A neovim lua plugin to help easily manage multiple terminal windows
	{ "antoinemadec/FixCursorHold.nvim" },

	{
		"cuducos/yaml.nvim",
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
		},
	},

	{ "glench/vim-jinja2-syntax" },

	{
		"folke/trouble.nvim",
		dependencies = "kyazdani42/nvim-web-devicons",
		config = true,
	},

	{ "asiryk/auto-hlsearch.nvim", config = true },

	{ 'echasnovski/mini.nvim',     version = false },
	{
		'echasnovski/mini.bracketed',
		version = false,
		config = function() require('mini.bracketed').setup() end
	},
}
