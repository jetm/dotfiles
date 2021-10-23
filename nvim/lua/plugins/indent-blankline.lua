require("indent_blankline").setup {
    char = "|",
    show_current_context = true,
    use_treesitter = true,
    filetype_exclude = {'help', 'make', 'terminal'},
    context_patterns = {
        'class', 'function', 'method', 'while', 'closure', 'for'
    },
    viewport_buffer = 50
}
