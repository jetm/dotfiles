local vim = vim
local get_opt = vim.api.nvim_get_option

vim.g.Lf_PopupHeight = 0.7
vim.g.Lf_PopupHeight = math.floor(get_opt('lines') * 0.7)
vim.g.Lf_PopupWidth = get_opt('columns') * 8 / 10
vim.g.Lf_PreviewInPopup = 1
-- Issue with Help menu
-- vim.g.Lf_PreviewResult = { Rg = 1 }
vim.g.Lf_WindowPosition = 'popup'
