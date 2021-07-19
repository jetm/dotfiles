require('global')
require('autocmds')
require('backup')
require('mappings')
require('colors-ui')

require("plugin-loader")

require('plugins')

--
-- VM settings
--
vim.g.python3_host_prog = "/usr/bin/python3.7"
