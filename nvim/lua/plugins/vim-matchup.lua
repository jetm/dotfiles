local vim = vim

vim.g.matchup_matchparen_offscreen = {method = 'popup'}

require'nvim-treesitter.configs'.setup {
    matchup = {enable = true }
}
