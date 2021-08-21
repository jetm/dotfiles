local cmd = vim.cmd

cmd([[
  " run :PackerCompile whenever plugins.lua is updated
  augroup PackerCompiler
  autocmd BufWritePost plugins.lua source <afile> | PackerCompile
  augroup END

  " Highlight when it yanks
  augroup YankHighlight
  au TextYankPost * lua vim.highlight.on_yank {higroup="IncSearch", timeout=150, on_visual=true}
  augroup END

  " YAML files
  " two space tabs for YAML
  augroup YAMLFiles
  au FileType yaml setlocal ts=2 sts=2 sw=2 expandtab
  augroup END

  " Go files
  " Show by default 4 spaces for a tab
  augroup GoFiles
  au BufNewFile,BufRead *.go setlocal noexpandtab tabstop=4 shiftwidth=4
  augroup END

  " resize panes when host window is resized
  augroup WindowAutoRisize
  autocmd VimResized * wincmd =
  augroup END
]])
