local vim = vim

vim.g.mapleader = ' '

local vimp = require('vimp')

--  Helper for saving file
vimp.nmap('<C-s>', ':update<CR>')
vimp.vmap('<C-s>', '<C-c>:update<CR>')
vimp.imap('<C-s>', '<C-o>:update<CR>')

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

-- Use virtual replace mode all the time
vimp.nnoremap('r', 'gr')
vimp.nnoremap('R', 'gT')

vimp.nnoremap('<kPlus>', '<C-a>')
vimp.nnoremap('<kMinus>', '<C-x>')
vimp.nnoremap('+', '<C-a>')
vimp.nnoremap('-', '<C-x>')
vimp.vnoremap('+', 'g<C-a>gv')
vimp.vnoremap('-', 'g<C-x>gv')

-- Opens line below or above the current line
vimp.inoremap('<S-CR>', '<C-O>o')
vimp.inoremap('<C-CR>', '<C-O>O')

-- Clears hlsearch after doing a search, otherwise just does normal <CR> stuff
vimp.nnoremap({'expr', 'silent'}, '<CR>', [[{-> v:hlsearch ? ":nohl\<CR>" : "\<CR>"}()]])

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
vimp.nnoremap('<A-n>', ':NvimTreeToggle<CR>')

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
--
--

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
-- LSP
--
vimp.nnoremap('<leader>gt', ':LspTroubleToggle<CR>')

vimp.nnoremap('<C-F>',
              ':<C-U><C-R>=printf("Leaderf! rg -e %s ", expand("<cword>"))<CR>')
vimp.nnoremap('go', ':<C-U>Leaderf! rg --recall<CR>')
