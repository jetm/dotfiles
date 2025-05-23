return function(_, _)
  require("conform").setup({
    -- Everything in opts will be passed to setup()
    -- Define your formatters
    formatters_by_ft = {
      bats = { "shfmt", "shellharden" },
      c = { "clang_format" },
      css = { "prettier" },
      gitcommit = { "commitmsgfmt"},
      lua = { "stylua" },
      python = { "ruff_format" },
      sh = { "shfmt", "shellharden" },
      yaml = { "yamlfmt" },
      zsh = { "shfmt", "shellharden" },
    },

    -- Customize formatters
    formatters = {
      stylua = {
        prepend_args = {
          "--indent-type=Spaces",
          "--quote-style=ForceDouble",
          "--indent-width=2",
        },
      },
      shfmt = {
        prepend_args = function(_)
          local extra_args = {
            "-sr",
            "-ci",
            "-s",
          }

          if not vim.bo.expandtab then
            -- Default indent with Tabs
            table.insert(extra_args, "--indent")
            table.insert(extra_args, 0)
          else
            -- Indent with Spaces
            table.insert(extra_args, "--indent")
            table.insert(extra_args, vim.bo.tabstop)
          end

          return extra_args
        end,
      },
      yamlfmt = {
        prepend_args = {
          "--formatter",
          "retain_line_breaks_single=true,entless_arrays=true,include_document_start=true"
        }
      }
    },
  })
end
