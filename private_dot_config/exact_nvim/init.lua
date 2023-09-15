if vim.g.vscode then
  return
end

if vim.loader and vim.fn.has("nvim-0.9.1") == 1 then
  vim.loader.enable()
end

-- Manually add new filetypes
vim.filetype.add({
  filename = {},
  pattern = {
    [".*%.bb%..*"] = "bitbake",
    [".*%.inc"] = "bitbake",
    [".*%.bats"] = "bash",
    [".*%.zsh"] = "sh",
    [".*%.rules"] = "udevrules",
    [".*%.service"] = "systemd",
  },
})

for _, source in ipairs({
  "config.options",
  "config.lazy",
  "config.autocmds",
  "config.mappings",
  "config.utils",
}) do
  local status_ok, fault = pcall(require, source)
  if not status_ok then
    vim.api.nvim_err_writeln("Failed to load " .. source .. "\n\n" .. fault)
  end
end
