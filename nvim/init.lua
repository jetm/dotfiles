--
-- VM settings
--
local vim = vim

vim.g.python3_host_prog = os.getenv("HOME") ..
                              "/.asdf/installs/python/3.9.6/bin/python3.9"

-- Disable some unused built-in Neovim plugins
local disabled_built_ins = {
    '2html_plugin', 'getscript', 'getscriptPlugin', 'gzip', 'logipat', 'man',
    'matchit', 'netrw', 'netrwFileHandlers', 'netrwPlugin', 'netrwSettings',
    'remotes_plugins', 'rrhelper', 'spellfile_plugin', 'tar', 'tarPlugin',
    'vimball', 'vimballPlugin', 'zip', 'zipPlugin'
}

for _, plugin in pairs(disabled_built_ins) do vim.g['loaded_' .. plugin] = false end

require('plugins')
require('global')
require('autocmds')
require('backup')
require('mappings')
require('colors-ui')

-- For debugging purpose
-- :lua dump(...)
function _G.dump(...)
    local objects = vim.tbl_map(vim.inspect, {...})
    print(unpack(objects))
end

vim.notify = function(msg, log_level, _)
    if msg:match("exit code") then return end
    if log_level == vim.log.levels.ERROR then
        vim.api.nvim_err_writeln(msg)
    else
        vim.api.nvim_echo({{msg}}, true, {})
    end
end
