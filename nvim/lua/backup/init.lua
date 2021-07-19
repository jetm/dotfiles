local cmd = vim.cmd

cmd [[
  set backup
  set undofile
  set undodir=$HOME/.vim_data/undofile
  set backupdir=$HOME/.vim_data/backup
  set nowritebackup
  let g:data_dir = $HOME . '/.vim_data/'
  let g:backup_dir = g:data_dir . 'backup'
  let g:swap_dir = g:data_dir . 'swap'
  let g:undo_dir = g:data_dir . 'undofile'
  let g:conf_dir = g:data_dir . 'conf'
  if finddir(g:data_dir) ==# ''
  silent call mkdir(g:data_dir, 'p', 0700)
  endif
  if finddir(g:backup_dir) ==# ''
  silent call mkdir(g:backup_dir, 'p', 0700)
  endif
  if finddir(g:swap_dir) ==# ''
  silent call mkdir(g:swap_dir, 'p', 0700)
  endif
  if finddir(g:undo_dir) ==# ''
  silent call mkdir(g:undo_dir, 'p', 0700)
  endif
  if finddir(g:conf_dir) ==# ''
  silent call mkdir(g:conf_dir, 'p', 0700)
  endif
  unlet g:data_dir
  unlet g:backup_dir
  unlet g:swap_dir
  unlet g:undo_dir
  unlet g:conf_dir
]]
