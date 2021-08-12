local signs = {
    add = {
        hl = "GitSignsAdd",
        text = "▌",
        numhl = "GitSignsAdd",
        linehl = "GitSignsAddLn"
    },
    change = {
        hl = "GitSignsChange",
        text = "▌",
        numhl = "GitSignsChange",
        linehl = "GitSignsChangeLn"
    },
    delete = {
        hl = "GitSignsDelete",
        text = "▌",
        numhl = "GitSignsDelete",
        linehl = "GitSignsDeleteLn"
    },
    topdelete = {
        hl = "GitSignsDelete",
        text = "‾",
        numhl = "GitSignsDeleteNr",
        linehl = "GitSignsDeleteLn"
    },
    changedelete = {
        hl = "GitSignsChange",
        text = "~",
        numhl = "GitSignsChangeNr",
        linehl = "GitSignsChangeLn"
    }
}

require("gitsigns").setup {
    signs = signs,
    numhl = true,
    linehl = false,
    watch_index = {interval = 100},
    sign_priority = 5,
    status_formatter = nil, -- Use default
    use_decoration_api = true,
    use_internal_diff = true -- If luajit is present
}
