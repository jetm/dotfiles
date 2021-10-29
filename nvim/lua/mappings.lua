--
-- Misc mappings
--
local vimp = require('vimp')

-- moving up and down work as you would expect
vimp.nnoremap({'silent'}, 'j', 'gj')
vimp.nnoremap({'silent'}, 'k', 'gk')

-- quitting mapping
vimp.nnoremap({'silent'}, 'q', ':BufferClose<CR>')
vimp.nnoremap({'silent'}, 'Q', ':qa<CR>')

-- copy until the end
vimp.nnoremap({'silent'}, 'Y', 'y$')

-- Keep the cursor in place while joining lines
vimp.nnoremap({'silent'}, 'J', 'mzJ`z')

-- expand_region
vimp.xmap({'silent'}, "v", "<Plug>(expand_region_expand)")
vimp.xmap({'silent'}, "V", "<Plug>(expand_region_shrink)")

vimp.nmap({'silent'}, '<UP>', '<Nop>')
vimp.nmap({'silent'}, '<Down>', '<Nop>')
vimp.nmap({'silent'}, '<Left>', '<Nop>')
vimp.nmap({'silent'}, '<Right>', '<Nop>')
vimp.imap({'silent'}, '<UP>', '<Nop>')
vimp.imap({'silent'}, '<Down>', '<Nop>')
vimp.imap({'silent'}, '<Left>', '<Nop>')
vimp.imap({'silent'}, '<Right>', '<Nop>')

vimp.vmap({'silent'}, 'J', '<Plug>(MvVisDown)')
vimp.vmap({'silent'}, 'K', '<Plug>(MvVisUp)')
vimp.vmap({'silent'}, 'L', '<Plug>(MvVisRight)')
vimp.vmap({'silent'}, 'H', '<Plug>(MvVisLeft)')

-- Visual shifting (does not exit Visual mode)
vimp.vnoremap({'silent'}, '<', '<gv')
vimp.vnoremap({'silent'}, '>', '>gv')
vimp.nnoremap({'silent'}, '<', '<<_')
vimp.nnoremap({'silent'}, '>', '>>_')

-- Search selected text (consistent with `*` behaviour)
vimp.nnoremap({'silent'}, '*', [[*N]])
vimp.vnoremap({'silent'}, '*', [[y/\V<c-r>=escape(@",'/\')<cr><cr>N]])

vimp.nmap({'silent'}, '+', '<Plug>(dial-increment)')
vimp.nmap({'silent'}, '-', '<Plug>(dial-decrement)')
vimp.vmap({'silent'}, '+', '<Plug>(dial-increment)')
vimp.vmap({'silent'}, '-', '<plug>(dial-decrement)')

--
-- <leader> mappings
--
local vim = vim

vim.g.mapleader = ' '

-- Cancel a leader operation without sometimes causing unintended side effects
-- https://github.com/svermeulen/vimpeccable#chord-cancellation-maps
vimp.add_chord_cancellations('n', '<leader>')

-- formatter
vimp.nnoremap({'silent'}, '<leader>f', ':Format<CR>')

-- Comments
vimp.nmap({'silent'}, '<leader>c', '<Plug>NERDCommenterToggle')
vimp.vmap({'silent'}, '<leader>c', '<Plug>NERDCommenterToggle')

-- Use <Alt-l> to clear the highlighting
local function refresh_buffer()
    vim.api.nvim_exec([[
        nohlsearch
        diffupdate
        syntax sync fromstart
        IndentBlanklineRefresh!
        IndentBlanklineRefreshScroll!
        normal! zzze<CR>
    ]], false)

    local get_opt = vim.api.nvim_get_option

    vim.g.Lf_PopupHeight = math.floor(get_opt('lines') * 0.7)
    vim.g.Lf_PopupWidth = get_opt('columns') * 0.8
end

vimp.nnoremap({'silent'}, '<C-l>', refresh_buffer)

--
-- barbar
--
vimp.nnoremap({'silent'}, '<leader>1', ':BufferGoto1<CR>')
vimp.nnoremap({'silent'}, '<leader>2', ':BufferGoto2<CR>')
vimp.nnoremap({'silent'}, '<leader>3', ':BufferGoto3<CR>')
vimp.nnoremap({'silent'}, '<leader>4', ':BufferGoto4<CR>')
vimp.nnoremap({'silent'}, '<leader>5', ':BufferGoto5<CR>')
vimp.nnoremap({'silent'}, '<leader>6', ':BufferGoto6<CR>')
vimp.nnoremap({'silent'}, '<leader>7', ':BufferGoto7<CR>')
vimp.nnoremap({'silent'}, '<leader>8', ':BufferGoto8<CR>')
vimp.nnoremap({'silent'}, '<leader>9', ':BufferGoto9<CR>')

-- quickfix
-- vimp.nnoremap({'silent'}, "<Leader>qc", ":cclose<CR>")
-- vimp.nnoremap({'silent'}, "<Leader>qo", ":copen<CR>")
-- vimp.nnoremap("<Leader>qn", ":cnext<CR>")
-- vimp.nnoremap("<Leader>qp", ":cprev<CR>")
-- vimp.nnoremap("<Leader>qa", ":cc<CR>")

-- locationlist
-- vimp.nnoremap("<Leader>lc", ":lclose<CR>")
-- vimp.nnoremap("<Leader>lo", ":lopen<CR>")
-- vimp.nnoremap("<Leader>ln", ":lnext<CR>")
-- vimp.nnoremap("<Leader>lp", ":lprev<CR>")
-- vimp.nnoremap("<Leader>la", ":ll<CR>")

-- LSP
vimp.nnoremap({'silent'}, '<leader>gt', ':LspTroubleToggle<CR>')

--
-- Ctrl <C-> Mappings
--
--  Helper for saving file
vimp.nmap({'silent'}, '<C-s>', ':update<CR>')
vimp.vmap({'silent'}, '<C-s>', '<C-c>:update<CR>')
vimp.imap({'silent'}, '<C-s>', '<C-o>:update<CR>')

-- CtrlP compatibility
-- fzf.vim is quicker than fzf.preview
-- Telescope is async
-- Testing snap
-- Select files, symlinks, hidden files, and exclude Git directory
vimp.nnoremap({'silent'}, '<C-p>',
              ':Telescope find_files find_command=fd,-t,f,-t,l,--hidden,--exclude,.git<CR>')

--
-- Alt <M-> Mappings
--
-- Move between vim panes
vimp.nnoremap({'silent'}, '<M-j>', '<C-W>j')
vimp.nnoremap({'silent'}, '<M-k>', '<C-W>k')
vimp.nnoremap({'silent'}, '<M-l>', '<C-W>l')
vimp.nnoremap({'silent'}, '<M-h>', '<C-W>h')

-- Sizing window horizontally
vimp.nnoremap({'silent'}, '<M-,>', '<C-W><')
vimp.nnoremap({'silent'}, '<M-.>', '<C-W>>')

--
-- <F1>..<F12> Mappings
--
-- NvimTree
vimp.nnoremap({'silent'}, '<F2>', ':NvimTreeToggle<CR>')
-- Shift + <F2>
vimp.nnoremap({'silent'}, '<F14>', ':NvimTreeFindFile<CR>')

vimp.nnoremap({'silent'}, '<F3>',
              ':<C-U><C-R>=printf("Leaderf! rg -e %s ", expand("<cword>"))<CR>')
-- Shift + <F3>
vimp.nnoremap({'silent'}, '<F15>', ':<C-U>Leaderf! rg --recall<CR>')

--
-- shellharden
--
-- nmap <silent> <F7> :%!shellharden --replace ''<CR>
