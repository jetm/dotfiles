-- Notification Enhancer
local M = {
  "rcarriga/nvim-notify",
}

function M.config()
  local status_ok, notify = pcall(require, "notify")
  if not status_ok then
    return
  end
  notify.setup({ stages = "fade" })
  vim.notify = notify
end

return M
