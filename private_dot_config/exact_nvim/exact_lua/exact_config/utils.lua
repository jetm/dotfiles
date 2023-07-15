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
