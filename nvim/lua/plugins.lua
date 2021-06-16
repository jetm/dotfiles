local vim = vim
local fn = vim.fn -- to call Vim functions e.g. fn.bufnr()
local api = vim.api

local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'

if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({
        'git', 'clone', 'https://github.com/wbthomason/packer.nvim',
        install_path
    })
    api.nvim_command 'packadd packer.nvim'
end

require('packer').startup(function(use)
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'

    use 'ii14/onedark.nvim'
    -- use 'joshdick/onedark.vim'

    -- Apply fast colors
    use {'norcalli/nvim-colorizer.lua'}

    -- Neovim tabline plugin
    use {'romgrk/barbar.nvim'}

    use 'kyazdani42/nvim-web-devicons'
    -- Icon set using nonicons for neovim plugins and settings
    use {'yamatsum/nvim-nonicons'}

    -- We recommend updating the parsers on update
    use {'nvim-treesitter/nvim-treesitter', run = ':TSUpdate'}
    use 'nvim-treesitter/nvim-treesitter-textobjects'
    use {"romgrk/nvim-treesitter-context"}

    -- Replace fzf
    use 'nvim-lua/popup.nvim'
    use 'nvim-lua/plenary.nvim'
    use {'nvim-telescope/telescope.nvim'}

    -- spaceline is slower
    -- Galaxyline lacks of nice configurations, like feline has
    -- lualine has better structure and theme, it's more like spaceline
    use {'hoob3rt/lualine.nvim'}

    -- Smooth scroll
    use 'karb94/neoscroll.nvim'

    -- Indent guides on blank lines for Neovim
    use {'lukas-reineke/indent-blankline.nvim', branch = 'lua'}

    -- Rainbow Parentheses Improved, shorter code, no level limit, smooth and fast,
    -- powerful configuration
    -- use 'luochen1990/rainbow'

    -- Try it later after another neovim version
    use {'p00f/nvim-ts-rainbow'}

    -- An Nvim lua plugin that dims your inactive windows
    use 'sunjon/shade.nvim'

    --
    -- Motions
    --
    -- Vim motions on speed
    use {"phaazon/hop.nvim"}

    -- Lightning fast left-right movement in Vim
    use {"unblevable/quick-scope"}

    -- usein for vim to enabling opening a file in a given line
    use 'wsdjeg/vim-fetch'

    use {
        'ethanholz/nvim-lastplace',
        config = function()
            require'nvim-lastplace'.setup {
                lastplace_ignore_buftype = {"quickfix", "nofile", "help"},
                lastplace_ignore_filetype = {
                    "gitcommit", "gitrebase", "svn", "hgcommit"
                },
                lastplace_open_folds = true
            }
        end
    }

    --
    -- Search/Replace
    --
    -- Hlsearch Lens for Neovim. Replace incsearch.vim
    use 'kevinhwang91/nvim-hlslens'

    -- substitute preview
    use 'osyo-manga/vim-over'

    --
    -- Copy/Paste
    --
    -- Dynamically show content of vim registers
    use 'gennaro-tedesco/nvim-peekup'

    -- Handles bracketed-paste-mode in vim (aka. automatic `:set paste`)
    use 'ConradIrwin/vim-bracketed-paste'

    -- Pasting in Vim with indentation adjusted to destination context
    use 'sickill/vim-pasta'

    --
    -- Diff/Git
    --
    -- Weapon to fight against conflicts in Vim
    -- [x and ]x mappings are defined as default
    use 'rhysd/conflict-marker.vim'

    -- Git features and provider for feline
    use {"lewis6991/gitsigns.nvim"}

    -- Better Diff options for Vim
    use 'chrisbra/vim-diff-enhanced'

    --
    -- Text manipulation
    --
    -- Expand selection
    use 'terryma/vim-expand-region'

    -- Vim plugin, insert or delete brackets, parens, quotes in pair
    use {"windwp/nvim-autopairs"}

    -- Quoting/parenthesizing made simple
    use 'machakann/vim-sandwich'

    -- Enable repeating supported plugin maps with .
    use 'tpope/vim-repeat'

    -- Vim plugin for intensely nerdy commenting powers
    use 'preservim/nerdcommenter'

    -- Switch between single-line and multiline forms of code
    -- gS to split a one-liner into multiple lines
    -- gJ (with the cursor on the first line of a block) to join a block into a single-line statement
    -- use 'AndrewRadev/splitjoin.vim'

    --
    -- Completion
    --
    -- Neovim completion
    use {'hrsh7th/nvim-compe'}

    -- tabnine using nvim-compe
    use {'tzachar/compe-tabnine', run = './install.sh'}

    --
    --
    -- Linter/LSP
    --
    -- Quickstart configurations for the Nvim LSP client
    use {'neovim/nvim-lspconfig'}
    use {'kabouzeid/nvim-lspinstall'}

    -- Replacing ale, as it's big for just removing whitespaces and do formatting
    use 'ntpeters/vim-better-whitespace'
    use {'mhartington/formatter.nvim'}

    -- Linter to replace ale
    use 'mfussenegger/nvim-lint'

    --
    -- Languages support
    --
    use 'sheerun/vim-polyglot'

    -- Wisely add if/fi, for/end in several languages
    use 'tpope/vim-endwise'

    -- bitbake support
    use 'kergoth/vim-bitbake'

    -- Markdown support
    -- Generate table of contents for Markdown files
    use {'mzlogin/vim-markdown-toc', opt = true}

    --
    -- Snippets
    --
    use {'rafamadriz/friendly-snippets'}
    use {"hrsh7th/vim-vsnip"}
    use {"hrsh7th/vim-vsnip-integ"}

    --
    -- File modifications
    --
    -- An alternative sudo.vim
    use 'lambdalisue/suda.vim'

    -- New files created with a shebang line are automatically made executable
    use 'tpope/vim-eunuch'

    -- File manager
    use {"kyazdani42/nvim-tree.lua"}

    -- A neovim lua plugin to help easily manage multiple terminal windows
    use {'akinsho/nvim-toggleterm.lua'}

    -- seamless integration for vim and tmux's clipboard
    -- Allows to copy between multiple neovim instances
    use {'roxma/vim-tmux-clipboard'}
end)
