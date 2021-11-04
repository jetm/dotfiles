local null_ls = require("null-ls")
local lsp = require("lspconfig")
local lsp_status = require("lsp-status")
lsp_status.register_progress()

-- custom attach config for most LSP configs
local on_attach = function(client, bufnr)
    require"lsp_signature".on_attach({
        bind = true, -- This is mandatory, otherwise border config won't get registered.
        floating_window = true, -- show hint in a floating window, set to false for virtual text only mode
        hint_enable = true, -- virtual hint enable
        handler_opts = {
            border = "shadow" -- double, single, shadow, none
        }
    })

    lsp_status.on_attach(client, bufnr)
end

local b = null_ls.builtins
null_ls.config({
    sources = {
        -- b.code_actions.gitsigns,
        b.diagnostics.shellcheck
    }
})

lsp["null-ls"].setup({
    on_attach = on_attach,
    capabilities = lsp_status.capabilities
})

-- diagnostics
vim.lsp.handlers["textDocument/publishDiagnostics"] =
    vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
        virtual_text = false,
        signs = true,
    })

-- Design
local vim = vim
local cmd = vim.cmd
cmd("sign define LspDiagnosticsSignError text=")
cmd("sign define LspDiagnosticsSignWarning text=ﰣ")
cmd("sign define LspDiagnosticsSignInformation text=")
cmd("sign define LspDiagnosticsSignHint text=")

-- show line diagnostic
vim.api.nvim_command(
    "autocmd CursorHold * lua vim.lsp.diagnostic.show_line_diagnostics({ focusable = false })")

lsp.bashls.setup({
    filetypes = {"sh", "zsh", "bash"},
    on_attach = on_attach,
    capabilities = lsp_status.capabilities
})

lsp.clangd.setup {
    on_attach = on_attach,
    capabilities = lsp_status.capabilities
}
