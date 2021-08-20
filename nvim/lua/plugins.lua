M = {}
local execute = vim.api.nvim_command
local fn = vim.fn

local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"

if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({
        "git", "clone", "https://github.com/wbthomason/packer.nvim",
        install_path
    })
    execute("packadd packer.nvim")
end

function M.reload_config()
    vim.cmd("source ~/.config/nvim/init.lua")
    vim.cmd("source ~/.config/nvim/lua/plugins.lua")
    vim.cmd(":PackerCompile")
    vim.cmd(":PackerClean")
    vim.cmd(":PackerInstall")
end

-- Need to replace this once lua api has vim modes
vim.api.nvim_exec([[
  augroup Packer
    autocmd!
    autocmd BufWritePost plugins.lua lua require'plugins'.reload_config()
  augroup end
]], false)

local inspected_buffers = {}
-- this function is called b4 a buffer is opened, so we need to manually open
-- the file and count the lines
function limit_by_line_count(max_lines)
    local fname = vim.fn.expand("%:p")
    local cache = inspected_buffers[fname]
    if cache ~= nil then return cache end

    max_lines = max_lines or 1000
    local lines = 0
    for _ in io.lines(fname) do
        lines = lines + 1
        if lines > max_lines then break end
    end
    inspected_buffers[fname] = (lines <= max_lines)
    return inspected_buffers[fname]
end

local packer = require("packer")
local use = packer.use

packer.reset()
packer.init({max_jobs = 8})

packer.startup({
    function()

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
            config = function()
                require('neoscroll').setup({mappings = {}})
            end
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
            config = function() require('plugins.nvim-peekup') end
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

        -- magit for neovim
        use {
            'TimUntersberger/neogit',
            requires = {'nvim-lua/plenary.nvim', 'sindrets/diffview.nvim'},
            config = function() require("plugins.neogit") end
        }

        -- single tabpage interface for easily cycling through diffs for all
        -- modified files for any git rev
        use {
            'sindrets/diffview.nvim',
            config = function() require("plugins.diffview") end
        }

        --
        -- Text manipulation
        --
        -- Expand selection
        use {'terryma/vim-expand-region'}

        -- Vim plugin, insert or delete brackets, parens, quotes in pair
        use {
            "windwp/nvim-autopairs",
            config = function() require('plugins.nvim-autopairs') end
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
        -- Completion
        --
        use {
            'ms-jpq/coq_nvim',
            before = 'nvim-lspconfig',
            branch = 'coq',
            run = ':COQdeps',
            config = function() require("plugins.coq") end
        }

        -- coq_nvim snippets
        use {'ms-jpq/coq.artifacts', branch = 'artifacts'}

        use {"tzachar/compe-tabnine", run = "./install.sh"}

        --
        -- LSP
        --
        -- default configs for lsp and setup lsp
        use {
            "neovim/nvim-lspconfig",
            config = function() require("plugins.nvim-lspconfig") end
        }

        use {"ray-x/lsp_signature.nvim"}

        -- window for showing LSP detected issues in code
        use {
            "folke/lsp-trouble.nvim",
            config = function() require("plugins.lsp-trouble") end
        }

        -- lsp status
        use {
            "nvim-lua/lsp-status.nvim",
            config = function() require("plugins.lsp-status") end
        }

        -- fancy popups lsp
        use {
            "glepnir/lspsaga.nvim",
            config = function() require("plugins.lspsaga") end
        }

        -- lsp extensions stuff
        use {
            "onsails/lspkind-nvim",
            config = function()
                require("lspkind").init({File = " "})
            end
        }

        -- Quickstart configurations for the Nvim LSP client
        -- use {'kabouzeid/nvim-lspinstall'}

        -- Replacing ale, as it's big for just removing whitespaces and do formatting
        use {
            'ntpeters/vim-better-whitespace',
            config = function()
                require('plugins.vim-better-whitespace')
            end
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

        use("famiu/nvim-reload")
    end,
    config = {display = {open_fn = require("packer.util").float}}
})

vim.cmd([[
function! g:Scriptnames_capture() abort
  try
    redir => out
    exe 'silent! scriptnames'
  finally
    redir END
  endtry
  call writefile(split(out, "\n", 1), glob('scriptnames.log'), 'b')
  return out
endfunction
]])

return M
