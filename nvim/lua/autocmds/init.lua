local cmd = vim.cmd

-- Highlight when it yanks
cmd [[
  au TextYankPost * lua vim.highlight.on_yank {higroup="IncSearch", timeout=150, on_visual=true}
]]

--
-- Specific Language settings
--
-- YAML files
-- two space tabs for YAML
cmd [[
  autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab
]]

-- Go files
-- Show by default 4 spaces for a tab
cmd [[
  autocmd BufNewFile,BufRead *.go setlocal noexpandtab tabstop=4 shiftwidth=4'
]]
