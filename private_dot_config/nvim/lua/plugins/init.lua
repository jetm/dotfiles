return {
  -- Icon set using nonicons for neovim plugins and settings
  {
    "yamatsum/nvim-nonicons",
    lazy = true,
    dependencies = { "nvim-tree/nvim-web-devicons", lazy = true },
  },

  -- Replace fzf
  { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },

  -- Neovim plugin to jump to any location with few keystrokes
  { url = "https://gitlab.com/madyanov/svart.nvim", name = "svart.nvim" },

  -- Enable opening a file in a given line
  { "wsdjeg/vim-fetch" },

  -- Substitute preview
  { "osyo-manga/vim-over", lazy = true },

  -- Handles bracketed-paste-mode in vim (aka. automatic `:set paste`)
  { "ConradIrwin/vim-bracketed-paste", lazy = true },

  -- Visualise and resolve merge conflicts in neovim
  -- ]x - move to previous conflict
  -- [x - move to next conflict
  -- co - choose ours
  -- ct - choose theirs
  -- cb - choose both
  -- c0 - choose none
  {
    "akinsho/git-conflict.nvim",
    lazy = true,
    config = true,
  },

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

  -- Use the w, e, b motions like a spider. Move by subwords and skip
  -- insignificant punctuation
  -- { "chrisgrieser/nvim-spider", lazy = true },

  -- Add/change/delete surrounding delimiter pairs with ease
  {
    "kylechui/nvim-surround",
    event = "VeryLazy",
    config = true,
  },

  -- Enable repeating supported plugin maps with '.'
  { "tpope/vim-repeat", lazy = true },

  -- enhanced increment/decrement plugin for Neovim
  { "monaqa/dial.nvim", lazy = true },

  -- Removes trailing whitespace from *modified* lines on save
  -- Replace ntpeters/vim-better-whitespace
  { "axelf4/vim-strip-trailing-whitespace" },

  -- Disabled. Overwritten autocmds. Need more work
  -- { "sheerun/vim-polyglot" },

  -- Wisely add if/fi, for/end in several languages
  { "tpope/vim-endwise" },

  -- bitbake support
  { "kergoth/vim-bitbake", lazy = true },

  -- Markdown support
  -- Generate table of contents for Markdown files
  -- { "mzlogin/vim-markdown-toc" },

  -- New files created with a shebang line are automatically made executable
  { "tpope/vim-eunuch" },

  -- A neovim lua plugin to help easily manage multiple terminal windows
  -- { "antoinemadec/FixCursorHold.nvim" },

  {
    "cuducos/yaml.nvim",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
    },
  },

  {
    "glench/vim-jinja2-syntax",
    event = { "BufReadPre", "BufNewFile" },
  },

  {
    "folke/trouble.nvim",
    cmd = { "TroubleToggle", "Trouble" },
    dependencies = "nvim-tree/nvim-web-devicons",
    config = true,
  },

  { "asiryk/auto-hlsearch.nvim", config = true },

  { "echasnovski/mini.nvim", version = false },

  {
    "echasnovski/mini.bracketed",
    version = false,
    config = true,
  },

  -- Automatic indentation style detection for Neovim
  { "nmac427/guess-indent.nvim", config = true },

}
