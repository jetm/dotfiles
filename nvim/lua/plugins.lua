require('packer').startup(function(use)
    -- Packer can manage itself
    use {'wbthomason/packer.nvim'}

    -- Vim version
    -- use 'joshdick/onedark.vim'
    -- Coping joshdick
    -- use {'ii14/onedark.nvim'}
    -- More complete
    use {
        'navarasu/onedark.nvim',
        config = function() require('onedark').setup() end
    }

    -- Neovim plugin that allows you to easily write your .vimrc in lua or any lua based language
    use {'svermeulen/vimpeccable'}

    -- Apply fast colors
    use {
        'norcalli/nvim-colorizer.lua',
        config = function()
            -- Attaches to every FileType mode
            require("colorizer").setup({'*'}, {
                RGB = true, -- #RGB hex codes
                RRGGBB = true, -- #RRGGBB hex codes
                RRGGBBAA = true, -- #RRGGBBAA hex codes
                rgb_fn = true, -- CSS rgb() and rgba() functions
                hsl_fn = true, -- CSS hsl() and hsla() functions
                css = true, -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
                css_fn = true -- Enable all CSS *functions*: rgb_fn, hsl_fn
            })
        end
    }

    -- Neovim tabline plugin
    use {
        'romgrk/barbar.nvim',
        config = function() require('plugins.barbar') end
    }

    -- Icons collections
    use {'kyazdani42/nvim-web-devicons'}

    -- Icon set using nonicons for neovim plugins and settings
    use {'yamatsum/nvim-nonicons'}

    -- We recommend updating the parsers on update
    use {
        'nvim-treesitter/nvim-treesitter',
        run = ':TSUpdate',
        config = function()

            require("nvim-treesitter.configs").setup({
                ensure_installed = "maintained",
                highlight = {
                    enable = true,
                    use_languagetree = true
                    -- disable = {"sh", "bash"}
                },
                -- Still an experimental
                indent = {enable = false},
                rainbow = {
                    enable = true,
                    -- Highlight also non-parentheses delimiters, boolean or table: lang -> boolean
                    extended_mode = true
                }
            })
        end
    }

    use {"romgrk/nvim-treesitter-context"}

    --
    -- Navigation
    --
    -- fuzzy finder
    -- Replace fzf
    use {"nvim-lua/popup.nvim"}
    use {"nvim-lua/plenary.nvim"}
    use {"nvim-telescope/telescope-fzf-native.nvim", run = "make"}
    use {
        "nvim-telescope/telescope.nvim",
        config = function() require("plugins.telescope") end
    }

    use {
        "Yggdroot/LeaderF",
        run = function() vim.cmd([[LeaderfInstallCExtension]]) end,
        config = function() require('plugins.leaderf') end
    }

    use {'kevinhwang91/nvim-bqf'}

    -- use {'camspiers/snap',
    -- config = function() require('plugins.snap')
    -- end}

    -- Smooth scroll
    use {
        'karb94/neoscroll.nvim',
        config = function() require('neoscroll').setup({mappings = {}}) end
    }

    -- Indent guides on blank lines for Neovim
    use {
        'lukas-reineke/indent-blankline.nvim',
        config = function() require('plugins.indent-blankline') end
    }

    --
    -- UI
    --
    -- Rainbow Parentheses Improved, shorter code, no level limit, smooth and fast,
    -- powerful configuration
    use {'p00f/nvim-ts-rainbow'}

    -- spaceline is slower
    -- Galaxyline lacks of nice configurations, like feline has
    -- lualine has better structure and theme, it's more like spaceline
    use {
        'hoob3rt/lualine.nvim',
        config = function() require('plugins.lualine') end
    }

    --
    -- Motions
    --
    -- Next-generation motion plugin for incredibly fast on-screen navigation.
    -- Replace hop.nvim and quick-scope
    use {'ggandor/lightspeed.nvim'}

    -- usein for vim to enabling opening a file in a given line
    use {'wsdjeg/vim-fetch'}

    -- Go to the last edited place
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
    use {'kevinhwang91/nvim-hlslens'}

    -- Substitute preview
    use {'osyo-manga/vim-over'}

    --
    -- Copy/Paste
    --
    -- Dynamically show content of vim registers
    use {
        'gennaro-tedesco/nvim-peekup',
        config = function() require('plugins.peekup') end
    }

    -- Handles bracketed-paste-mode in vim (aka. automatic `:set paste`)
    use {'ConradIrwin/vim-bracketed-paste'}

    -- Pasting in Vim with indentation adjusted to destination context
    use {'sickill/vim-pasta'}

    -- seamless integration for vim and tmux's clipboard
    -- Allows to copy between multiple neovim instances
    -- tmux.nvim needs a lot configuration
    use {'roxma/vim-tmux-clipboard'}

    --
    -- Diff/Git
    --
    -- Weapon to fight against conflicts in Vim
    -- [x and ]x mappings are defined as default
    use {'rhysd/conflict-marker.vim'}

    -- Git features and provider for feline
    -- like gitgutter shows hunks etc on sign column
    use {
        "lewis6991/gitsigns.nvim",
        requires = {'nvim-lua/plenary.nvim'},
        config = function() require("plugins.gitsigns") end
    }

    --
    -- Text manipulation
    --
    -- Expand selection
    use {'terryma/vim-expand-region'}

    -- Vim plugin, insert or delete brackets, parens, quotes in pair
    use {
        "windwp/nvim-autopairs",
        config = function() require('plugins.autopairs') end
    }

    -- Quoting/parenthesizing made simple
    use {'machakann/vim-sandwich'}

    -- Enable repeating supported plugin maps with '.'
    use {'tpope/vim-repeat'}

    -- Vim plugin for intensely nerdy commenting powers
    use {
        'preservim/nerdcommenter',
        config = function() require('plugins.nerd-commenter') end
    }

    -- Switch between single-line and multiline forms of code
    -- gS to split a one-liner into multiple lines
    -- gJ (with the cursor on the first line of a block) to join a block into a single-line statement
    -- use 'AndrewRadev/splitjoin.vim'

    --
    -- Completion/LSP
    --
    use {"ray-x/lsp_signature.nvim"}

    -- window for showing LSP detected issues in code
    use {
        "folke/lsp-trouble.nvim",
        config = function() require("trouble").setup {} end
    }

    -- lsp status
    use {
        "nvim-lua/lsp-status.nvim",
        config = function() require("plugins.lspStatus") end
    }

    -- fancy popups lsp
    use {
        "glepnir/lspsaga.nvim",
        config = function() require("plugins.lspsaga") end
    }

    -- lsp extensions stuff
    use {
        "onsails/lspkind-nvim",
        config = function() require("lspkind").init({File = " "}) end
    }

    -- default configs for lsp and setup lsp
    use {
        "neovim/nvim-lspconfig",
        config = function() require("plugins.lspconfig").init() end
    }

    -- completion engine
    use {
        "hrsh7th/nvim-compe",
        config = function() require("plugins.compe").init() end
    }

    use {"tzachar/compe-tabnine", run = "./install.sh"}

    -- Quickstart configurations for the Nvim LSP client
    -- use {'kabouzeid/nvim-lspinstall'}

    -- Replacing ale, as it's big for just removing whitespaces and do formatting
    use {
        'ntpeters/vim-better-whitespace',
        config = function() require('plugins.vim-better-whitespace') end
    }
    use {
        'mhartington/formatter.nvim',
        config = function() require('plugins.formatter') end
    }

    --
    -- Languages support
    --
    -- lua nvim setup
    use {"folke/lua-dev.nvim"}

    use {'sheerun/vim-polyglot'}

    -- Wisely add if/fi, for/end in several languages
    use {'tpope/vim-endwise'}

    -- bitbake support
    use {'kergoth/vim-bitbake'}

    -- Markdown support
    -- Generate table of contents for Markdown files
    use {'mzlogin/vim-markdown-toc', opt = true}

    --
    -- Snippets
    --
    use {"L3MON4D3/LuaSnip"}

    use {"rafamadriz/friendly-snippets"}

    --
    -- File modifications
    --
    -- An alternative sudo.vim
    use {
        'lambdalisue/suda.vim',

        config = function() require('plugins.suda') end
    }

    -- New files created with a shebang line are automatically made executable
    use {'tpope/vim-eunuch'}

    -- File manager
    use {
        "kyazdani42/nvim-tree.lua",
        config = function() require('plugins.nvim-tree') end
    }

    -- A neovim lua plugin to help easily manage multiple terminal windows
    use {
        'akinsho/nvim-toggleterm.lua',
        config = function()
            require("toggleterm").setup {
                open_mapping = [[<F11>]],
                shade_terminals = false,
                hide_numbers = true
            }
        end
    }

    -- todo searcher
    use {
        "folke/todo-comments.nvim",
        requires = "nvim-lua/plenary.nvim",
        config = function() require('plugins.todo-comments') end
    }

    -- Create key bindings that stick. Displays a popup with possible
    -- keybindings of the command you started typing
    use {
        "folke/which-key.nvim",
        config = function()
            require("which-key").setup {
                -- your configuration comes here
                -- or leave it empty to use the default settings
            }
        end
    }
end)
