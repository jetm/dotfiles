local vim = vim

vim.g.mapleader = ' '

local vimp = require('vimp')

--  Helper for saving file
vimp.nmap({'silent'}, '<C-s>', ':update<CR>')
vimp.vmap({'silent'}, '<C-s>', '<C-c>:update<CR>')
vimp.imap({'silent'}, '<C-s>', '<C-o>:update<CR>')

-- moving up and down work as you would expect
vimp.nnoremap({'silent'}, 'j', 'gj')
vimp.nnoremap({'silent'}, 'k', 'gk')

-- move one line up and one line down
vimp.nnoremap({'silent'}, '<M-j>', ':move +1<CR>')
vimp.nnoremap({'silent'}, '<M-k>', ':move -2<CR>')

vimp.nnoremap({'silent'}, 'Q', ':q<CR>')

-- Stop being so lazy - remove arrow key config
vimp.nmap({'silent'}, '<UP>', '<Nop>')
vimp.nmap({'silent'}, '<Down>', '<Nop>')
vimp.nmap({'silent'}, '<Left>', '<Nop>')
vimp.nmap({'silent'}, '<Right>', '<Nop>')
vimp.imap({'silent'}, '<UP>', '<Nop>')
vimp.imap({'silent'}, '<Down>', '<Nop>')
vimp.imap({'silent'}, '<Left>', '<Nop>')
vimp.imap({'silent'}, '<Right>', '<Nop>')

vimp.nnoremap({'silent'}, 'q', '<Nop>')

-- Sizing window horizontally
vimp.nnoremap({'silent'}, '<C-,>', '<C-W><')
vimp.nnoremap({'silent'}, '<C-.>', '<C-W>>')

-- copy until the end
vimp.nnoremap({'silent'}, 'Y', 'y$')

-- Keep the cursor in place while joining lines
-- vimp.nnoremap({'silent'}, 'J', 'mzJ`z')

-- Visual shifting (does not exit Visual mode)
vimp.vmap({'silent'}, '<', '<gv')
vimp.vmap({'silent'}, '>', '>gv')

-- Move between vim panes with Ctrl-J
vimp.nnoremap({'silent'}, '<C-J>', '<C-W>j')
vimp.nnoremap({'silent'}, '<C-K>', '<C-W>k')
vimp.nnoremap({'silent'}, '<C-L>', '<C-W>l')
vimp.nnoremap({'silent'}, '<C-H>', '<C-W>h')

-- Use virtual replace mode all the time
vimp.nnoremap({'silent'}, 'r', 'gr')
vimp.nnoremap({'silent'}, 'R', 'gT')

vimp.nmap({'silent'}, '+', '<Plug>(dial-increment)')
vimp.nmap({'silent'}, '-', '<Plug>(dial-decrement)')
vimp.vmap({'silent'}, '+', '<Plug>(dial-increment)')
vimp.vmap({'silent'}, '-', '<Plug>(dial-decrement)')

-- Opens line below or above the current line
vimp.inoremap({'silent'}, '<S-CR>', '<C-O>o')
vimp.inoremap({'silent'}, '<C-CR>', '<C-O>O')

-- Clears hlsearch after doing a search, otherwise just does normal <CR> stuff
vimp.nnoremap({'expr', 'silent'}, '<CR>',
              [[{-> v:hlsearch ? ":nohl\<CR>" : "\<CR>"}()]])

-- CtrlP compatibility
-- fzf.vim is quicker than fzf.preview
-- Telescope is async
-- Testing snap
-- Select files, symlinks, hidden files, and exclude Git directory
vimp.nnoremap({'silent'}, '<C-p>',
              ':Telescope find_files find_command=fd,-t,f,-t,l,--hidden,--exclude,.git<CR>')

-- Use <Alt-l> to clear the highlighting of :set hlsearch
vimp.nnoremap({'silent'}, '<M-l>',
              ':nohlsearch<CR>:diffupdate<CR>:syntax sync fromstart<CR><C-l>')

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

--
-- NvimTree
--
vimp.nnoremap({'silent'}, '<leader>n', ':NvimTreeFindFile<CR>')
vimp.nnoremap({'silent'}, '<A-n>', ':NvimTreeToggle<CR>')

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
--
--

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

vimp.nnoremap({'silent'}, '<C-F>',
              ':<C-U><C-R>=printf("Leaderf! rg -e %s ", expand("<cword>"))<CR>')
vimp.nnoremap({'silent'}, 'go', ':<C-U>Leaderf! rg --recall<CR>')
