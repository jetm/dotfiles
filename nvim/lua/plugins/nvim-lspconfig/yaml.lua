local lsp = require("plugins.nvim-lspconfig")
local capabilities = lsp.capabilities
local lspconfig = require("lspconfig")

lspconfig.yamlls.setup {
    capabilities = capabilities,
    flags = {debounce_text_changes = 500},
    on_attach = function(client, bufnr)

        lsp:on_attach(client, bufnr)
    end
}
