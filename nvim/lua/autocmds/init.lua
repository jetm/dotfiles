local cmd = vim.cmd

-- run :PackerCompile whenever plugins.lua is updated
cmd ([[
  augroup PackerCompiler
  autocmd BufWritePost plugins.lua source <afile> | PackerCompile
  augroup END
]])

-- Highlight when it yanks
cmd ([[
  augroup YankHighlight
  au TextYankPost * lua vim.highlight.on_yank {higroup="IncSearch", timeout=150, on_visual=true}
  augroup END
]])

--
-- Specific Language settings
--
-- YAML files
-- two space tabs for YAML
cmd ([[
  augroup YAMLFiles
  au FileType yaml setlocal ts=2 sts=2 sw=2 expandtab
  augroup END
]])

-- Go files
-- Show by default 4 spaces for a tab
cmd ([[
  augroup GoFiles
  au BufNewFile,BufRead *.go setlocal noexpandtab tabstop=4 shiftwidth=4
  augroup END
]])
