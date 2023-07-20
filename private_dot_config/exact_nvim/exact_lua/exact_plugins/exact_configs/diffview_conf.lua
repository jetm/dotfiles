return function(_, _)
  local diffview = require("diffview")
  local actions = require("diffview.actions")

  diffview.setup({
    enhanced_diff_hl = true,
    keymaps = {
      disable_defaults = true,
      view = {
        -- stylua: ignore start
        -- The `view` bindings are active in the diff buffers, only when the current
        -- tabpage is a Diffview.
        { "n", "[x",    actions.prev_conflict,             { desc = "jump to the previous conflict" } },
        { "n", "]x",    actions.next_conflict,             { desc = "jump to the next conflict" } },
        { "n", "co",    actions.conflict_choose("ours"),   { desc = "Choose the OURS version of a conflict" } },
        { "n", "ct",    actions.conflict_choose("theirs"), { desc = "Choose the THEIRS version of a conflict" } },
        { "n", "ca",    actions.conflict_choose("all"),    { desc = "Choose all the versions of a conflict" } },
        { "n", "dx",    actions.conflict_choose("none"),   { desc = "Delete the conflict region" } },
        { "n", "q",     diffview.close,                    { desc = "Close diffview" } },
        { "n", "<esc>", diffview.close,                    { desc = "Close diffview" } },
        -- stylua: ignore end
      },
    },
  })
end
