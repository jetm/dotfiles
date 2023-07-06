_G.yet = {}

-- For debugging purpose
-- :lua put(...)
function yet.put(...)
  local objects = {}
  for i = 1, select("#", ...) do
    local v = select(i, ...)
    table.insert(objects, vim.inspect(v))
  end

  print(table.concat(objects, "\n"))
  return ...
end

function yet.map(mode, lhs, rhs, opts)
  local keys = require("lazy.core.handler").handlers.keys
  ---@cast keys LazyKeysHandler
  -- do not create the keymap if a lazy keys handler exists
  if not keys.active[keys.parse({ lhs, mode = mode }).id] then
    opts = opts or {}
    opts.silent = opts.silent ~= false
    vim.keymap.set(mode, lhs, rhs, opts)
  end
end

-- vim.notify = function(msg, log_level, _)
--   if msg:match("exit code") then
--     return
--   end
--   if log_level == vim.log.levels.ERROR then
--     vim.api.nvim_err_writeln(msg)
--   else
--     vim.api.nvim_echo({ { msg } }, true, {})
--   end
-- end
