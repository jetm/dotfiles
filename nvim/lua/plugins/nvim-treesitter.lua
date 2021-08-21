require("nvim-treesitter.configs").setup({
    ensure_installed = "maintained",
    autotag = { enable = true },
    highlight = { enable = true },
    incremental_selection = { enable = true },
    textobjects = { enable = true },
    indent = { enable = true },
    rainbow = {
        enable = true,
        -- Highlight also non-parentheses delimiters, boolean or table: lang -> boolean
        extended_mode = true
    }
})
