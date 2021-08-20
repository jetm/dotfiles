require('coq')()

local vim = vim

vim.g.coq_settings = {
    auto_start = true,
    ['clients.tmux.enabled'] = false,
    ['clients.tabnine.enabled'] = true,
    ['clients.tags.enabled'] = false,
    ["display.preview.positions"] = {east = 1, south = 2, west = 3, north = 4}
}

vim.cmd [[COQnow -s]]

-- vim.g.coq_settings = {
--     ['clients.tree_sitter.enabled'] = false,
-- }
