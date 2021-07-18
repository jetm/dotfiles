local vim = vim
local cmd = vim.cmd -- to execute Vim commands e.g. cmd('pwd')
local fn = vim.fn -- to call Vim functions e.g. fn.bufnr()

local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({
        'git', 'clone', 'https://github.com/wbthomason/packer.nvim',
        install_path
    })
end

cmd [[
  packadd packer.nvim
]]

-- run :PackerCompile whenever plugins.lua is updated
cmd [[
  autocmd BufWritePost plugins.lua PackerCompile
]]
