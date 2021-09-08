require'lightspeed'.setup { }

local vim = vim

-- Disable default behavior for 'x' key map
vim.api.nvim_del_keymap('o', 'x')
vim.api.nvim_del_keymap('x', 'x')
vim.api.nvim_del_keymap('o', 'X')
vim.api.nvim_del_keymap('x', 'X')
