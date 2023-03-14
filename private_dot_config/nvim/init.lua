if vim.g.vscode then
  return
end

require("config.global")
require("config.lazy")
require("config.autocmds")
require("config.backup")
require("config.mappings")
require("config.utils")
