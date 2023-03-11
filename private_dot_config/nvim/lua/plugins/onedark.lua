local M = {
    "navarasu/onedark.nvim",
    priority = 1000,
}

function M.config()
    local ok, onedark = pcall(require, "onedark")
    if not ok then
        error("Loading onedark")
        return
    end

    onedark.setup {
        style = 'dark'
    }

    onedark.load()
end

return M
