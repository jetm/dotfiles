if not vim.filetype then return end

vim.filetype.add({
  extension = {
    lock = 'yaml',
  },
  filename = {
  },
  pattern = {
    ['.*%.bb%..*'] = 'bitbake',
    ['.*%.inc'] = 'bitbake',
    ['.*%.bats'] = 'bash',
    ['.*%.zsh'] = 'sh',
  },
})
