local vim = vim

vim.g.coq_settings = {
    auto_start = true,
    ['clients.tabnine.enabled'] = true,
    ['clients.tmux.enabled'] = false,
    ['clients.tags.enabled'] = false
}

vim.cmd [[autocmd VimEnter * COQnow -s]]
