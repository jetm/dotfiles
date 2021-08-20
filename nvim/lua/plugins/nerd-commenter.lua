local vim = vim

-- Add spaces after comment delimiters
vim.g.NERDSpaceDelims = 1

vim.g.NERDCreateDefaultMappings = 0

-- Use compact syntax for prettified multi-line comments
vim.g.NERDCompactSexyComs = 1

-- Align line-wise comment delimiters flush left instead of following code
-- indentation
vim.g.NERDDefaultAlign = 'left'

-- Enable trimming of trailing whitespace when uncommenting
vim.g.NERDTrimTrailingWhitespace = 1

-- Allow commenting and inverting empty lines (useful when commenting a region)
vim.g.NERDCommentEmptyLines = 1

-- Enable NERDCommenterToggle to check all selected lines is commented or not
vim.g.NERDToggleCheckAllLines = 1
