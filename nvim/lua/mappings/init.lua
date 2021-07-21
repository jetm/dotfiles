local vim = vim
local fn = vim.fn

vim.g.mapleader = ' '

local vimp = require('vimp')

--  Helper for saving file
vimp.nmap('<C-s>', ':update<CR>')
vimp.vmap('<C-s>', '<C-c>:update<CR>')
vimp.imap('<C-s>', '<C-o>:update<CR>')

--
-- moving up and down work as you would expect
vimp.nnoremap('j', 'gj')
vimp.nnoremap('k', 'gk')

-- move one line up and one line down
vimp.nnoremap('<M-j>', ':move +1<CR>')
vimp.nnoremap('<M-k>', ':move -2<CR>')

vimp.nnoremap('Q', ':q<CR>')

-- Stop being so lazy - remove arrow key config
vimp.nmap('<UP>', '<Nop>')
vimp.nmap('<Down>', '<Nop>')
vimp.nmap('<Left>', '<Nop>')
vimp.nmap('<Right>', '<Nop>')
vimp.imap('<UP>', '<Nop>')
vimp.imap('<Down>', '<Nop>')
vimp.imap('<Left>', '<Nop>')
vimp.imap('<Right>', '<Nop>')

-- copy until the end
vimp.nnoremap('Y', 'y$')

-- Keep the cursor in place while joining lines
vimp.nnoremap('J', 'mzJ`z')

-- Visual shifting (does not exit Visual mode)
vimp.vmap('<', '<gv')
vimp.vmap('>', '>gv')

-- Move between vim panes with Ctrl-J
vimp.nnoremap('<C-J>', '<C-W>j')
vimp.nnoremap('<C-K>', '<C-W>k')
vimp.nnoremap('<C-L>', '<C-W>l')
vimp.nnoremap('<C-H>', '<C-W>h')

-- CtrlP compatibility
-- fzf.vim is quicker than fzf.preview
-- Telescope is async
-- Testing snap
-- Select files, symlinks, hidden files, and exclude Git directory
vimp.nnoremap('<C-p>',
              ':Telescope find_files find_command=fd,-t,f,-t,l,--hidden,--exclude,.git<CR>')

-- Use <Alt-l> to clear the highlighting of :set hlsearch.
vimp.nnoremap('<M-l>',
              ':nohlsearch<CR>:diffupdate<CR>:syntax sync fromstart<CR><C-l>')

-- Comments
vimp.nmap('<leader>c', '<Plug>NERDCommenterToggle')
vimp.vmap('<leader>c', '<Plug>NERDCommenterToggle')

--
-- barbar
--
vimp.nnoremap('<leader>1', ':BufferGoto1<CR>')
vimp.nnoremap('<leader>2', ':BufferGoto2<CR>')
vimp.nnoremap('<leader>3', ':BufferGoto3<CR>')
vimp.nnoremap('<leader>4', ':BufferGoto4<CR>')
vimp.nnoremap('<leader>5', ':BufferGoto5<CR>')
vimp.nnoremap('<leader>6', ':BufferGoto6<CR>')
vimp.nnoremap('<leader>7', ':BufferGoto7<CR>')
vimp.nnoremap('<leader>8', ':BufferGoto8<CR>')
vimp.nnoremap('<leader>9', ':BufferGoto9<CR>')

-- barbar buffer close still has some issues. Try later
vimp.nnoremap('<leader>x', ':BufferClose<CR>')
-- nnoremap <silent> <leader>x :Bwipeout<CR>

--
-- NvimTree
--
vimp.nnoremap('<leader>n', ':NvimTreeFindFile<CR>')
vimp.nnoremap('<C-n>', ':NvimTreeToggle<CR>')

--
-- shellharden
--
-- nmap <silent> <F7> :%!shellharden --replace ''<CR>

--
-- expand_region
--
vimp.xmap("v", "<Plug>(expand_region_expand)")
vimp.xmap("V", "<Plug>(expand_region_shrink)")

--
-- hlslens
--
vimp.nnoremap("n",
              "<cmd>execute('normal! ' . v:count1 . 'n')<CR><cmd>lua require('hlslens').start()<CR>")
vimp.nnoremap("N",
              "<cmd>execute('normal! ' . v:count1 . 'N')<CR><cmd>lua require('hlslens').start()<CR>")
vimp.nnoremap("*", "*<cmd>lua require('hlslens').start()<CR>")
vimp.nnoremap("#", "#<cmd>lua require('hlslens').start()<CR>")
vimp.nnoremap("g*", "g*<cmd>lua require('hlslens').start()<CR>")
vimp.nnoremap("g#", "g#<cmd>lua require('hlslens').start()<CR>")

--
-- formatter
--
vimp.nnoremap('<leader><leader>', ':Format<CR>')

-- quickfix
vimp.nnoremap("<Leader>qc", ":cclose<CR>")
vimp.nnoremap("<Leader>qo", ":copen<CR>")
-- vimp.nnoremap("<Leader>qn", ":cnext<CR>")
-- vimp.nnoremap("<Leader>qp", ":cprev<CR>")
-- vimp.nnoremap("<Leader>qa", ":cc<CR>")

-- locationlist
-- vimp.nnoremap("<Leader>lc", ":lclose<CR>")
-- vimp.nnoremap("<Leader>lo", ":lopen<CR>")
-- vimp.nnoremap("<Leader>ln", ":lnext<CR>")
-- vimp.nnoremap("<Leader>lp", ":lprev<CR>")
-- vimp.nnoremap("<Leader>la", ":ll<CR>")

--
-- Snippets
--
local function prequire(...)
    local status, lib = pcall(require, ...)
    if (status) then return lib end
    return nil
end

require("luasnip/loaders/from_vscode").lazy_load({
    "~/.local/share/nvim/site/pack/packer/start/friendly-snippets"
})

local luasnip = prequire("luasnip")

--
-- completion
--
-- completion menu settings
vim.o.completeopt = "menuone,noselect"
vim.o.omnifunc = "v:lua.vim.lsp.omnifunc"

local t = function(str)
    return vim.api.nvim_replace_termcodes(str, true, true, true)
end

local check_back_space = function()
    local col = fn.col(".") - 1
    if col == 0 or fn.getline("."):sub(col, col):match("%s") then
        return true
    else
        return false
    end
end

_G.tab_complete = function()
    if vim.fn.pumvisible() == 1 then
        return t "<C-n>"
    elseif luasnip and luasnip.expand_or_jumpable() then
        return t "<Plug>luasnip-expand-or-jump"
    elseif check_back_space() then
        return t "<Tab>"
    else
        return vim.fn["compe#complete"]()
    end
end

_G.s_tab_complete = function()
    if vim.fn.pumvisible() == 1 then
        return t "<C-p>"
    elseif luasnip and luasnip.jumpable(-1) then
        return t "<Plug>luasnip-jump-prev"
    else
        return t "<S-Tab>"
    end
end

function _G.completions()
    local npairs = require("nvim-autopairs")
    if fn.pumvisible() == 1 then
        if fn.complete_info()["selected"] ~= -1 then
            return fn["compe#confirm"]("<CR>")
        end
    end
    return npairs.check_break_line_char()
end

--
-- completions mappings
--
vim.api.nvim_set_keymap("i", "<Tab>", [[v:lua.tab_complete()]], {expr = true})
vim.api.nvim_set_keymap("s", "<Tab>", [[v:lua.tab_complete()]], {expr = true})
vim.api.nvim_set_keymap("i", "<S-Tab>", [[v:lua.s_tab_complete()]],
                        {noremap = true, expr = true})
vim.api.nvim_set_keymap("s", "<S-Tab>", [[v:lua.s_tab_complete()]],
                        {noremap = true, expr = true})
vim.api.nvim_set_keymap("i", "<CR>", [[v:lua.completions()]], {expr = true})

--
-- LSP
--
vimp.nnoremap('<leader>gt', ':LspTroubleToggle<CR>')

