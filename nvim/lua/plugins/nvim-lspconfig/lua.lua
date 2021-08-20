local sumneko_root_path = os.getenv("HOME") ..
                              "/.zinit/plugins/lua-language-server"
local sumneko_binary = sumneko_root_path .. "/bin/Linux/lua-language-server"
local lsp = require("plugins.nvim-lspconfig")
local capabilities = lsp.capabilities
local lspconfig = require("lspconfig")

-- Lua Settings for nvim config and plugin development
local luadev = require("lua-dev").setup({
    lspconfig = {
        cmd = {sumneko_binary, "-E", sumneko_root_path .. "/main.lua"},
        capabilities = capabilities,
        root_dir = require("lspconfig/util").root_pattern("."),
        on_attach = function(client, bufnr) lsp:on_attach(client, bufnr) end
    }
})

lspconfig.sumneko_lua.setup(luadev)
