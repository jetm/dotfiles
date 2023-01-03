-- Neovim tabline plugin
local M = {
    "romgrk/barbar.nvim",
}

function M.config()
    -- Set barbar's options
    vim.g.bufferline = {
        -- Enable/disable icons
        -- if set to 'numbers', will show buffer index in the tabline
        -- if set to 'both', will show buffer index and icons in the tabline
        icons = "both",
    }
end

return M
