-- Autocmds loader with conflict detection
-- Provides shared utilities and loads all autocmd modules

if vim.g.vscode then
  return {}
end

local M = {}

-- Track registered augroups to detect conflicts
M.registered_groups = {}

--- Create an augroup with conflict detection
---@param name string The augroup name (will be prefixed with "yet_")
---@return integer The augroup ID
function M.augroup(name)
  local full_name = "yet_" .. name
  if M.registered_groups[full_name] then
    vim.notify("Autocmd conflict: augroup '" .. full_name .. "' already exists", vim.log.levels.WARN)
  end
  M.registered_groups[full_name] = true
  return vim.api.nvim_create_augroup(full_name, { clear = true })
end

-- Shorthand for creating autocmds
M.autocmd = vim.api.nvim_create_autocmd

-- Store in package.loaded first to prevent circular dependency
package.loaded["config.autocmds.loader"] = M

-- Load all autocmd modules
local modules = { "general", "filetype", "encryption" }
for _, mod in ipairs(modules) do
  local ok, err = pcall(require, "config.autocmds." .. mod)
  if not ok then
    vim.notify("Failed to load autocmds." .. mod .. ": " .. err, vim.log.levels.ERROR)
  end
end

return M
