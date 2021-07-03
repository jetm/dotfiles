-- vim.lsp.set_log_level("debug")
require("vim.lsp.protocol").CompletionItemKind = {
    -- https://github.com/hrsh7th/nvim-compe/issues/135#issuecomment-773522031
    "", -- Text          = 1;
    "", -- Method        = 2;
    "ƒ", -- Function      = 3;
    "", -- Constructor   = 4;
    "識", -- Field         = 5;
    "勇", -- Variable      = 6;
    "", -- Class         = 7;
    "ﰮ", -- Interface     = 8;
    "", -- Module        = 9;
    "", -- Property      = 10;
    "", -- Unit          = 11;
    "", -- Value         = 12;
    "了", -- Enum          = 13;
    "", -- Keyword       = 14;
    "﬌", -- Snippet       = 15;
    "", -- Color         = 16;
    "", -- File          = 17;
    "渚", -- Reference     = 18;
    "", -- Folder        = 19;
    "", -- EnumMember    = 20;
    "", -- Constant      = 21;
    "", -- Struct        = 22;
    "鬒", -- Event         = 23;
    "Ψ", -- Operator      = 24;
    "" -- TypeParameter = 25;
}

vim.lsp.handlers["textDocument/publishDiagnostics"] =
    vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics,
                 {virtual_text = {prefix = "●"}})

vim.lsp.handlers["textDocument/hover"] =
    vim.lsp.with(vim.lsp.handlers.hover, {border = "single"})

local icons = require("nvim-nonicons")
vim.fn.sign_define("LspDiagnosticsSignError", {
    text = icons.get("x-circle"),
    texthl = "LspDiagnosticsSignError"
})

vim.fn.sign_define("LspDiagnosticsSignWarning", {
    text = icons.get("alert"),
    texthl = "LspDiagnosticsSignWarning"
})

vim.fn.sign_define("LspDiagnosticsSignInformation", {
    text = icons.get("info"),
    texthl = "LspDiagnosticsSignInformation"
})

vim.fn.sign_define("LspDiagnosticsSignHint", {
    text = icons.get("comment"),
    texthl = "LspDiagnosticsSignHint"
})

require("lsp-codelens").setup()

-- keymaps
local on_attach = function(client, bufnr)
    local function buf_set_keymap(...)
        vim.api.nvim_buf_set_keymap(bufnr, ...)
    end
    local function buf_set_option(...)
        vim.api.nvim_buf_set_option(bufnr, ...)
    end

    buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")

    -- Mappings
    local opts = {noremap = true, silent = true}

    -- FIXME: redefine the mappings
    -- buf_set_keymap("n", "gD", "<Cmd>lua vim.lsp.buf.declaration()<CR>", opts)
    -- buf_set_keymap("n", "gd", "<Cmd>lua vim.lsp.buf.definition()<CR>", opts)
    -- buf_set_keymap("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
    -- buf_set_keymap("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
    -- buf_set_keymap("n", "[d", "<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>",
    --                opts)
    -- buf_set_keymap("n", "]d", "<cmd>lua vim.lsp.diagnostic.goto_next()<CR>",
    --                opts)
    -- buf_set_keymap("n", "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>",
    --                opts)

    -- buf_set_keymap("n", "<Leader>a", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
    -- buf_set_keymap("n", "<Leader>D", "<cmd>lua vim.lsp.buf.type_definition()<CR>", opts)
    -- buf_set_keymap("n", "<Leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
    -- buf_set_keymap("n", "<Leader>e", "<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>", opts)

    -- formatting keymaps
    -- buf_set_keymap("n", "<Leader>P", "<cmd>lua vim.lsp.buf.formatting()<CR>",
    --                opts)
    -- buf_set_keymap("v", "<Leader>p",
    --                "<cmd>lua vim.lsp.buf.range_formatting()<CR>", opts)
    -- buf_set_keymap("n", "<Leader>l",
    --                "<cmd>lua require'lsp-codelens'.buf_codelens_action()<CR>",
    --                opts)

    -- buf_set_keymap("n", "<Leader>q", "<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>", opts)
    -- Workspace keymaps
    -- buf_set_keymap("n", "<Leader>wa", "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>", opts)
    -- buf_set_keymap("n", "<Leader>wr", "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>", opts)
    -- buf_set_keymap("n", "<Leader>wl",
    -- "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>", opts)

    -- vim already has builtin docs
    if vim.bo.ft ~= "vim" then
        buf_set_keymap("n", "K", "<Cmd>lua vim.lsp.buf.hover()<CR>", opts)
    end

    -- Set autocommands conditional on server_capabilities
    if client.resolved_capabilities.document_highlight then
        vim.api.nvim_exec([[
        augroup lsp_document_highlight
        autocmd! * <buffer>
        autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
        autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
        augroup END
        ]], false)
    end

    if client.resolved_capabilities.code_lens then
        vim.cmd [[
        augroup lsp_codelens
        autocmd! * <buffer>
        autocmd CursorHold,CursorHoldI,InsertLeave <buffer> lua require"lsp-codelens".buf_codelens_refresh()
        augroup END
        ]]
    end

    if client.server_capabilities.colorProvider then
        require"lsp-documentcolors".buf_attach(bufnr, {single_column = true})
    end
end

-- Configure lua language server for neovim development
local lua_settings = {
    Lua = {
        runtime = {
            -- LuaJIT in the case of Neovim
            version = "LuaJIT",
            path = vim.split(package.path, ";")
        },
        diagnostics = {
            -- Get the language server to recognize the `vim` global
            globals = {"vim"}
        },
        workspace = {
            -- Make the server aware of Neovim runtime files
            library = {
                [vim.fn.expand("$VIMRUNTIME/lua")] = true,
                [vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true
            }
        }
    }
}

-- config that activates keymaps and enables snippet support
local function make_config()
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities.textDocument.completion.completionItem.snippetSupport = true
    capabilities.textDocument.colorProvider = {dynamicRegistration = false}
    return {
        -- enable snippet support
        capabilities = capabilities,
        -- map buffer local keybindings when the language server attaches
        on_attach = on_attach
    }
end

-- lsp-install
local function setup_servers()
    require"lspinstall".setup()

    -- get all installed servers
    local servers = require"lspinstall".installed_servers()
    -- ... and add manually installed servers

    for _, server in pairs(servers) do
        local config = make_config()

        -- language specific config
        if server == "lua" then
            config.settings = lua_settings
            config.root_dir = function(fname)
                local util = require "lspconfig/util"
                return util.find_git_ancestor(fname) or util.path.dirname(fname)
            end
        end

        if server == "diagnosticls" then
            config = vim.tbl_extend("force", config, require "diagnosticls")
        end

        if server == "vim" then config.init_options = {isNeovim = true} end

        if server == "bash" then
            config.filetypes = {"sh", "bash", "zsh"};
        end

        require"lspconfig"[server].setup(config)
    end
end

setup_servers()

-- Automatically reload after `:LspInstall <server>` so we don't have to restart neovim
require"lspinstall".post_install_hook = function()
    setup_servers() -- reload installed servers
    vim.cmd("bufdo e") -- this triggers the FileType autocmd that starts the server
end

-- UI just like `:LspInfo` to show which capabilities each attached server has
vim.api.nvim_command("command! LspCapabilities lua require'lsp-capabilities'()")
