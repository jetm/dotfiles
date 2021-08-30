-- Setup global configuration. More on configuration below.
local cmp = require('cmp')
local lspkind = require('lspkind')

local check_back_space = function()
    local col = vim.fn.col('.') - 1
    return col == 0 or vim.fn.getline('.'):sub(col, col):match('%s')
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
        ['<S-Tab>'] = cmp.mapping(cmp.mapping.select_prev_item(), {'i', 's'}),
        ['<Tab>'] = function(fallback)
            if vim.fn.pumvisible() == 1 then
                vim.fn.feedkeys(vim.api.nvim_replace_termcodes('<C-n>', true,
                                                               true, true), 'n')
            elseif check_back_space() then
                vim.fn.feedkeys(vim.api.nvim_replace_termcodes('<Tab>', true,
                                                               true, true), 'n')
            elseif vim.fn['vsnip#available']() == 1 then
                vim.fn.feedkeys(vim.api.nvim_replace_termcodes(
                                    '<Plug>(vsnip-expand-or-jump)', true, true,
                                    true), '')
            else
                fallback()
            end
        end
    },

    formatting = {
        format = function(entry, vim_item)
            vim_item.kind = lspkind.presets.default[vim_item.kind]
            return vim_item
        end
    },
    -- You should specify your *installed* sources.
    sources = {
        {name = 'nvim_lsp'}, {name = 'buffer'}, {name = 'path'},
        {name = 'cmp-tabnine'}, {name = 'nvim_lua'}, {name = 'vsnip'}
    }
}
