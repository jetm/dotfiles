-- A value of 1 disables both filetype.vim and filetype.lua
-- A value of 0 disables filetype.vim
-- vim.g.did_load_filetypes = 1

-- NOTE: The do_filetype_lua global variable activates the Lua filetype detection mechanism, which
-- runs before the legacy Vim script filetype detection.
vim.g.do_filetype_lua = 1

vim.cmd("au BufRead,BufNewFile *.scc set filetype=conf")

-- Has bugs. Wait until 0.8 release
-- vim.filetype.add({
--     filename = {
--         [".gitignore"] = "conf",
--         [".scc"] = "config",
--     },
--     pattern = {
--         ["*.env.*"] = "env",
--         ["*.conf"] = "conf",
--         ["*.scc"] = "config",
--     },
--     extension = {
--         scc = "config",
--     },
-- })
