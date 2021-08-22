M = {}
local execute = vim.api.nvim_command
local fn = vim.fn

local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"

if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({
        "git", "clone", "https://github.com/wbthomason/packer.nvim",
        install_path
    })
    execute("packadd packer.nvim")
end

local packer = require("packer")
local use = packer.use

packer.startup({
    function()

        -- Packer can manage itself
        use {'wbthomason/packer.nvim'}

        -- Enable repeating supported plugin maps with '.'
        use {'tpope/vim-repeat'}


    end,
    config = {display = {open_fn = require("packer.util").float}}
})

return M
