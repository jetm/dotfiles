-- local lsp = require("lspconfig")
-- local coq = require("coq")
-- local servers = {"bash", "lua"}
-- for _, server in ipairs(servers) do
--     lsp[server].setup(coq.lsp_ensure_capabilities())
-- end

local vim = vim

vim.g.coq_settings = {
    auto_start = true,
    ['clients.tabnine.enabled'] = true,
    ['clients.tabnine.enabled'] = true,
    ['clients.tmux.enabled'] = false,
    ['clients.tags.enabled'] = false
}

-- vim.g.coq_settings = {
--     ['clients.tree_sitter.enabled'] = false,
-- }
