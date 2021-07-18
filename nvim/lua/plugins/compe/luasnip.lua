local function prequire(...)
    local status, lib = pcall(require, ...)
    if (status) then
        return lib
    end
    return nil
end

local luasnip = prequire("luasnip")
-- require("luasnip/loaders/from_vscode").lazy_load({"~/.local/share/nvim/site/pack/packer/start/friendly-snippets"})


