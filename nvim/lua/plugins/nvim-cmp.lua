-- Setup global configuration. More on configuration below.
local cmp = require('cmp')
local lspkind = require('lspkind')

local has_words_before = function()
    if vim.api.nvim_buf_get_option(0, "buftype") == "prompt" then
        return false
    end
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and
               vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col,
                                                                          col)
                   :match("%s") == nil
end

local feedkey = function(key, mode)
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(key, true, true, true),
                          mode, true)
end

cmp.setup {
    snippet = {
        expand = function(args)
            -- You must install `vim-vsnip` if you use the following as-is.
            vim.fn['vsnip#anonymous'](args.body)
        end
    },

    -- You must set mapping if you want.
    mapping = {
        ['<CR>'] = cmp.mapping.confirm({
            behavior = cmp.ConfirmBehavior.Insert,
            select = true
        }),
        ["<Tab>"] = cmp.mapping(function(fallback)
            if vim.fn.pumvisible() == 1 then
                feedkey("<C-n>", "n")
            elseif vim.fn["vsnip#available"]() == 1 then
                feedkey("<Plug>(vsnip-expand-or-jump)", "")
            elseif has_words_before() then
                cmp.complete()
            else
                fallback() -- The fallback function sends a already mapped key. In this case, it's probably `<Tab>`.
            end
        end, {"i", "s"}),

        ["<S-Tab>"] = cmp.mapping(function()
            if vim.fn.pumvisible() == 1 then
                feedkey("<C-p>", "n")
            elseif vim.fn["vsnip#jumpable"](-1) == 1 then
                feedkey("<Plug>(vsnip-jump-prev)", "")
            end
        end, {"i", "s"})

    },

    formatting = {
        format = function(entry, vim_item)
            vim_item.kind = lspkind.presets.default[vim_item.kind]
            return vim_item
        end
    },
    --    source = {
    --   tags = false,
    --   buffer = {kind = "   (Buffer)"},
    --   nvim_lsp = {kind = "   (LSP)"},
    --   nvim_lua = {kind = "  "},
    --   path = {kind = "   (Path)"},
    --   treesitter = {kind = "  "},
    --   vsnip = {kind = "   (Snippet)"},
    -- },
    -- You should specify your *installed* sources.
    sources = {
        {name = 'buffer'}, {name = 'nvim_lsp'}, {name = 'nvim_lua'},
        {name = 'path'}, {name = 'cmp-tabnine'}, {name = 'vsnip'},
        {name = 'treesitter'}
    }
}

require("cmp_nvim_lsp").setup()
for index, value in ipairs(vim.lsp.protocol.CompletionItemKind) do
    cmp.lsp.CompletionItemKind[index] = value
end
