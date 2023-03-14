local M = {
    "akinsho/bufferline.nvim",
    dependencies = { 'nvim-tree/nvim-web-devicons' },
}

function M.config()
    local ok, bufferline = pcall(require, "bufferline")
    if not ok then
        error("Loading bufferline")
        return
    end

    bufferline.setup({
        options = {
            tab_size = 20,
            diagnostics = false,
            color_icons = true,
            show_buffer_icons = true,
            show_buffer_close_icons = true,
            show_close_icon = true,
            show_tab_indicators = true,
            separator_style = 'thin',
            enforce_regular_tabs = false,
            always_show_bufferline = true,
        },
    })
end

return M
