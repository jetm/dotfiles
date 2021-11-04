-- Setup global configuration. More on configuration below.
local lspkind = require('lspkind')
local cmp = require('cmp')

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

local tab_complete = function(fallback)
    if vim.fn["vsnip#available"]() == 1 then
        feedkey("<Plug>(vsnip-expand-or-jump)", "")
    elseif cmp.visible() then
        cmp.select_next_item()
    elseif has_words_before() then
        cmp.complete()
    else
        fallback()
    end
end

local s_tab_complete = function(fallback)
    if vim.fn["vsnip#jumpable"](-1) == 1 then
        feedkey("<Plug>(vsnip-jump-prev)", "")
    elseif cmp.visible() then
        cmp.select_prev_item()
    else
        fallback()
    end
end

cmp.setup {
    completion = { completeopt = "menu,menuone,noselect" },
    -- You must set mapping if you want
    mapping = {
        ['<CR>'] = cmp.mapping.confirm({
            behavior = cmp.ConfirmBehavior.Replace,
            select = true
        }),
        ["<Tab>"] = cmp.mapping(tab_complete, {"i", "s"}),
        ["<C-j>"] = cmp.mapping(tab_complete, {"i", "s"}),
        ["<S-Tab>"] = cmp.mapping(s_tab_complete, {"i", "s"})
    },

    snippet = {
        expand = function(args)
            -- You must install `vim-vsnip` if you use the following as-is.
            vim.fn['vsnip#anonymous'](args.body)
        end
    },

    formatting = {
        format = lspkind.cmp_format({with_text = false, maxwidth = 50})
    },

    sources = {
        {name = 'buffer', max_item_count = 5, priority = 1},
        {name = 'treesitter', max_item_count = 5, priority = 2},
        -- unable to select new element
        -- {name = 'rg', opts = { additional_arguments = "--ignore-file halon-src --ignore-file halon-test --ignore-file tools" }, max_item_count = 10, priority = 3},
        -- too slow in big repo
        -- {name = 'cmp_tabnine', max_item_count = 5, priority = 3},
        {name = 'path', max_item_count = 10, priority = 4},
        {name = 'nvim_lsp', max_item_count = 5, priority = 5},
        {name = 'nvim_lua', max_item_count = 3, priority = 6},
        {name = 'vsnip', max_item_count = 2, priority = 7}
    }
}

require("cmp_nvim_lsp").setup()
for index, value in ipairs(vim.lsp.protocol.CompletionItemKind) do
    cmp.lsp.CompletionItemKind[index] = value
end
