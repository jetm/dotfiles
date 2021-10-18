local lspconfig = require("lspconfig")

-- efm setups
-- local prettier = require("plugins.efm.prettier")
-- local luafmt = require("plugins.efm.luafmt")
local shellcheck = require("plugins.efm.shellcheck")
local shfmt = require("plugins.efm.shfmt")

-- formatting and linting with efm
lspconfig.efm.setup {
    on_attach = function(client)
        client.resolved_capabilities.document_formatting = true
    end,
    root_dir = function() return vim.fn.getcwd() end,
    init_options = {
        documentFormatting = true,
        documentSymbol = false,
        completion = false,
        codeAction = false,
        hover = false
    },
    settings = {
        rootMarkers = {"go.mod", ".git/", ".zshrc"},
        languages = {bash = {shellcheck, shfmt}, sh = {shellcheck, shfmt}}
    },
    filetypes = {"lua", "bash", "sh"}
}