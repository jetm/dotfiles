local vim = vim

vim.g.indent_blankline_char = '│'
vim.g.indent_blankline_use_treesitter = true
vim.g.indent_blankline_show_current_context = true
vim.g.indent_blankline_filetype_exclude = {'help', 'make'}
vim.g.indent_blankline_context_patterns = {
    'class', 'function', 'method', 'while', 'closure', 'for'
}
vim.g.indent_blankline_viewport_buffer = 50
