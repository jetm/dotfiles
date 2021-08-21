local vim = vim

local icons = require("nvim-nonicons")

vim.g.nvim_tree_icons = {
    default = icons.get("file"),
    symlink = icons.get("file-symlink"),
    git = {
        unstaged = "✗",
        staged = "✓",
        unmerged = "",
        renamed = "➜",
        untracked = "★",
        deleted = "",
        ignored = "◌"
    },
    folder = {
        arrow_open = "",
        arrow_closed = "",
        default = icons.get("file-directory"),
        open = icons.get("file-directory"),
        empty = icons.get("file-directory-outline"),
        empty_open = icons.get("file-directory-outline"),
        symlink = icons.get("file-submodule"),
        symlink_open = icons.get("file-submodule")
    }
}

-- 0 by default, will not resize the tree when opening a file
vim.g.nvim_tree_width_allow_resize = 1

-- compact folders that only contain a single folder into one node in the file
-- tree
vim.g.nvim_tree_group_empty = 1

-- shows indent markers when folders are open
vim.g.nvim_tree_indent_markers = 1

-- allows the cursor to be updated when entering a buffer
vim.g.nvim_tree_follow = 1

-- closes the tree when it's the last window
vim.g.nvim_tree_auto_close = true
