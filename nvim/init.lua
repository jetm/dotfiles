--
-- VM settings
--
local vim = vim

vim.g.python3_host_prog = '/usr/bin/python3.9'

-- Do not source the default filetype.vim
-- vim.g.did_load_filetypes = 1

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
-- :lua put(...)
function _G.put(...)
  local objects = {}
  for i = 1, select('#', ...) do
    local v = select(i, ...)
    table.insert(objects, vim.inspect(v))
  end

  print(table.concat(objects, '\n'))
  return ...
end

vim.notify = function(msg, log_level, _)
    if msg:match("exit code") then return end
    if log_level == vim.log.levels.ERROR then
        vim.api.nvim_err_writeln(msg)
    else
        vim.api.nvim_echo({{msg}}, true, {})
    end
end
