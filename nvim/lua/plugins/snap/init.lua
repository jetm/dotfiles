-- local snap = require("snap")
--
-- local git_file = snap.get"producer.git.file".args {
--     "--cached", "--others", "--exclude-standard"
-- }
--
-- local smart_file =
--     snap.get "consumer.try"(git_file, snap.get "producer.fd.file")
--
-- -- Defaults
-- local function create(config)
--     return snap.create(config, {
--         reverse = true,
--         mappings = {
--             ["next-page"] = {"<C-f>", "<PageDown>"},
--             ["prev-page"] = {"<C-b>", "<PageUp>"}
--         }
--     })
-- end

-- Files
-- snap.register.map("n", "<Space><Space>", create(function()
--     return {
--         producer = snap.get "consumer.fzf"(smart_file),
--         select = snap.get"select.file".select,
--         multiselect = snap.get"select.file".multiselect
--     }
-- end))

-- Grep
-- snap.register.map("n", "<Space>g", create(function()
--     return {
--         producer = snap.get "consumer.limit"(10000,
--                                              snap.get "producer.ripgrep.vimgrep"),
--         select = snap.get"select.vimgrep".select,
--         multiselect = snap.get"select.vimgrep".multiselect,
--         views = {snap.get "preview.vimgrep"}
--     }
-- end))

-- Old files
-- snap.register.map("n", "<Space>of", create(function()
--     return {
--         producer = snap.get "consumer.fzf"(snap.get "producer.vim.oldfile"),
--         select = snap.get"select.file".select,
--         multiselect = snap.get"select.file".multiselect,
--         views = {snap.get "preview.file"}
--     }
-- end))

-- Grep with post-filtering
-- Have missing files issues
-- snap.register.map("n", "<Space>g", create(function()
--     return {
--         producer = snap.get "consumer.limit"(10000,
--                                              snap.get "producer.ripgrep.vimgrep"),
--         steps = {
--             {consumer = snap.get "consumer.fzf", config = {prompt = "FZF>"}}
--         },
--         select = snap.get"select.file".select,
--         multiselect = snap.get"select.file".multiselect,
--         views = {snap.get "preview.file"}
--     }
-- end))

-- Vim help
-- snap.register.map("n", "<Space>h", create(function ()
--   return {
--     prompt = "Help>",
--     producer = snap.get"consumer.fzf"(snap.get"producer.vim.help"),
--     select = snap.get"select.help".select,
--     views = {snap.get"preview.help"},
--   }
-- end))