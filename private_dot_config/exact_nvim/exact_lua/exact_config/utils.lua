_G.yet = {}

-- For debugging purpose
-- :lua debug(...)
---@diagnostic disable-next-line: duplicate-set-field
function yet.debug(...)
  local objects = {}
  for i = 1, select("#", ...) do
    local v = select(i, ...)
    table.insert(objects, vim.inspect(v))
  end

  print(table.concat(objects, "\n"))
  return ...
end

---@diagnostic disable-next-line: duplicate-set-field
function yet.key(mode, lhs, rhs, opts)
  local keys = require("lazy.core.handler").handlers.keys
  ---@cast keys LazyKeysHandler
  -- do not create the keymap if a lazy keys handler exists
  if not keys.active[keys.parse({ lhs, mode = mode }).id] then
    opts = opts or {}
    opts.silent = opts.silent ~= false
    vim.keymap.set(mode, lhs, rhs, opts)
  end
end

---@diagnostic disable-next-line: duplicate-set-field
function yet.ClipboardPaste()
  vim.cmd("let @@ = system('xsel -o -b')")
end
