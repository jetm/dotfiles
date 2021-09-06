local vim = vim
local vimp = require('vimp')

vim.g.mapleader = ' '

--  Helper for saving file
vimp.nmap({'silent'}, '<C-s>', ':update<CR>')
vimp.vmap({'silent'}, '<C-s>', '<C-c>:update<CR>')
vimp.imap({'silent'}, '<C-s>', '<C-o>:update<CR>')

-- moving up and down work as you would expect
vimp.nnoremap({'silent'}, 'j', 'gj')
vimp.nnoremap({'silent'}, 'k', 'gk')

-- move one line up and one line down
vimp.bind({'repeatable'}, '<M-k>', ':move -2<CR>')
vimp.bind({'repeatable'}, '<M-j>', ':move +1<CR>')

vimp.nmap({'silent'}, '<UP>', '<Nop>')
vimp.nmap({'silent'}, '<Down>', '<Nop>')
vimp.nmap({'silent'}, '<Left>', '<Nop>')
vimp.nmap({'silent'}, '<Right>', '<Nop>')
vimp.imap({'silent'}, '<UP>', '<Nop>')
vimp.imap({'silent'}, '<Down>', '<Nop>')
vimp.imap({'silent'}, '<Left>', '<Nop>')
vimp.imap({'silent'}, '<Right>', '<Nop>')

-- macros mapping
vimp.noremap({'silent'}, 'Q', '@q')
vimp.nnoremap({'silent'}, 'q', '<Nop>')

-- Sizing window horizontally
vimp.nnoremap({'silent'}, '<C-,>', '<C-W><')
vimp.nnoremap({'silent'}, '<C-.>', '<C-W>>')

-- copy until the end
vimp.nnoremap({'silent'}, 'Y', 'y$')

-- Keep the cursor in place while joining lines
vimp.nnoremap({'silent'}, 'J', 'mzJ`z')

-- Visual shifting (does not exit Visual mode)
vimp.vnoremap({'silent'}, '<', '<gv')
vimp.vnoremap({'silent'}, '>', '>gv')
vimp.nnoremap({'silent'}, '<', '>>_')
vimp.nnoremap({'silent'}, '>', '>>_')

-- Move between vim panes
vimp.nnoremap({'silent'}, '<C-j>', '<C-W>j')
vimp.nnoremap({'silent'}, '<C-k>', '<C-W>k')
vimp.nnoremap({'silent'}, '<C-l>', '<C-W>l')
vimp.nnoremap({'silent'}, '<C-h>', '<C-W>h')

-- Search selected text (consistent with `*` behaviour)
vimp.nnoremap({'silent'}, '*', [[*N]])
vimp.vnoremap({'silent'}, '*', [[y/\V<c-r>=escape(@",'/\')<cr><cr>N]])

vimp.nmap({'silent'}, '+', '<Plug>(dial-increment)')
vimp.nmap({'silent'}, '-', '<Plug>(dial-decrement)')
vimp.vmap({'silent'}, '+', '<Plug>(dial-increment)')
vimp.vmap({'silent'}, '-', '<plug>(dial-decrement)')

-- CtrlP compatibility
-- fzf.vim is quicker than fzf.preview
-- Telescope is async
-- Testing snap
-- Select files, symlinks, hidden files, and exclude Git directory
vimp.nnoremap({'silent'}, '<C-p>',
              ':Telescope find_files find_command=fd,-t,f,-t,l,--hidden,--exclude,.git<CR>')

-- Use <Alt-l> to clear the highlighting of :set hlsearch
vimp.nnoremap({'silent'}, '<M-l>',
              '<Cmd>nohlsearch<Bar>diffupdate<Bar>syntax sync fromstart<CR><M-l>')

-- Comments
vimp.nmap({'silent'}, '<leader>c', '<Plug>NERDCommenterToggle')
vimp.vmap({'silent'}, '<leader>c', '<Plug>NERDCommenterToggle')

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

-- barbar buffer close still has some issues. Try later
vimp.nnoremap({'silent'}, '<leader>x', ':BufferClose<CR>')
-- nnoremap <silent> <leader>x :Bwipeout<CR>

vimp.nnoremap({'silent'}, '<F4>', ':q<CR>')

vimp.nnoremap({'silent'}, '<F3>',
              ':<C-U><C-R>=printf("Leaderf! rg -e %s ", expand("<cword>"))<CR>')
vimp.nnoremap({'silent'}, '<C-F>', ':<C-U>Leaderf! rg --recall<CR>')

--
-- NvimTree
--
vimp.nnoremap({'silent'}, '<F14>', ':NvimTreeFindFile<CR>')
vimp.nnoremap({'silent'}, '<F2>', ':NvimTreeToggle<CR>')

--
-- shellharden
--
-- nmap <silent> <F7> :%!shellharden --replace ''<CR>

--
-- expand_region
--
vimp.xmap({'silent'}, "v", "<Plug>(expand_region_expand)")
vimp.xmap({'silent'}, "V", "<Plug>(expand_region_shrink)")

--
-- formatter
--
vimp.nnoremap({'silent'}, '<leader><leader>', ':Format<CR>')

-- quickfix
vimp.nnoremap({'silent'}, "<Leader>qc", ":cclose<CR>")
vimp.nnoremap({'silent'}, "<Leader>qo", ":copen<CR>")
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
-- LSP
--
vimp.nnoremap({'silent'}, '<leader>gt', ':LspTroubleToggle<CR>')

-- Cancel a leader operation without sometimes causing unintended side effects
-- https://github.com/svermeulen/vimpeccable#chord-cancellation-maps
vimp.add_chord_cancellations('n', '<leader>')
