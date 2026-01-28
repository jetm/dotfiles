-- General autocmds: core editor behavior
local loader = require("config.autocmds.loader")
local augroup = loader.augroup
local autocmd = loader.autocmd

-- User event that loads after UIEnter + only if file buf is there
autocmd({ "UIEnter", "BufReadPost", "BufNewFile" }, {
  group = vim.api.nvim_create_augroup("NvFilePost", { clear = true }),
  callback = function(args)
    local file = vim.api.nvim_buf_get_name(args.buf)
    local buftype = vim.api.nvim_get_option_value("buftype", { buf = args.buf })

    if not vim.g.ui_entered and args.event == "UIEnter" then
      vim.g.ui_entered = true

      -- Firenvim
      local client = vim.api.nvim_get_chan_info(vim.v.event.chan).client
      if client ~= nil and client.name == "Firenvim" then
        vim.o.laststatus = 0
        vim.o.cmdheight = 0
      end
    end

    if file ~= "" and buftype ~= "nofile" and vim.g.ui_entered then
      vim.api.nvim_exec_autocmds("User", { pattern = "FilePost", modeline = false })
      vim.api.nvim_del_augroup_by_name("NvFilePost")

      vim.schedule(function()
        vim.api.nvim_exec_autocmds("FileType", {})

        if vim.g.editorconfig then
          require("editorconfig").config(args.buf)
        end
      end)
    end
  end,
})

-- Highlight on yank
autocmd("TextYankPost", {
  group = augroup("highlight_yank"),
  callback = function()
    (vim.hl or vim.highlight).on_yank({ higroup = "IncSearch", timeout = "300" })
  end,
})

-- Don't auto commenting new lines
autocmd("BufEnter", {
  pattern = "",
  command = "set fo-=c fo-=r fo-=o",
})

-- Go to last location when opening a buffer
autocmd("BufReadPost", {
  group = augroup("last_loc"),
  callback = function()
    local exclude = { "gitcommit", "gitrebase" }
    local buf = vim.api.nvim_get_current_buf()
    if vim.tbl_contains(exclude, vim.bo[buf].filetype) then
      return
    end
    local mark = vim.api.nvim_buf_get_mark(buf, "\"")
    local lcount = vim.api.nvim_buf_line_count(buf)
    if mark[1] > 0 and mark[1] <= lcount then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})

-- Apply changes in chezmoi managed files
autocmd("BufWritePost", {
  pattern = os.getenv("HOME") .. "/.local/share/chezmoi/*",
  command = "silent !chezmoi apply --source-path %",
})

-- Disable diagnostics in insert mode
autocmd("ModeChanged", {
  pattern = { "n:i", "v:s" },
  desc = "Disable diagnostics while typing",
  callback = function(e)
    vim.diagnostic.enable(false, { bufnr = e.buf })
  end,
})

autocmd("ModeChanged", {
  pattern = "i:n",
  desc = "Enable diagnostics when leaving insert mode",
  callback = function(e)
    vim.diagnostic.enable(true, { bufnr = e.buf })
  end,
})

-- Close some filetypes with <q>
autocmd("FileType", {
  group = augroup("close_with_q"),
  pattern = {
    "PlenaryTestPopup",
    "checkhealth",
    "dbout",
    "floaterm",
    "gitsigns-blame",
    "grug-far",
    "help",
    "lspinfo",
    "man",
    "neotest-output",
    "neotest-output-panel",
    "neotest-summary",
    "nofile",
    "notify",
    "qf",
    "query",
    "spectre_panel",
    "startuptime",
    "tsplayground",
  },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.schedule(function()
      vim.keymap.set("n", "q", function()
        vim.cmd("close")
        pcall(vim.api.nvim_buf_delete, event.buf, { force = true })
      end, {
        buffer = event.buf,
        silent = true,
        desc = "Quit buffer",
      })
    end)
  end,
})

-- Auto create dir when saving a file, in case some intermediate directory does not exist
autocmd({ "BufWritePre" }, {
  group = augroup("auto_create_dir"),
  callback = function(event)
    if event.match:match("^%w%w+:[\\/][\\/]") then
      return
    end
    local file = vim.uv.fs_realpath(event.match) or event.match
    vim.fn.mkdir(vim.fn.fnamemodify(file, ":p:h"), "p")
  end,
})

-- Bigfile detection
vim.filetype.add({
  pattern = {
    [".*"] = {
      function(path, buf)
        return vim.bo[buf]
            and vim.bo[buf].filetype ~= "bigfile"
            and path
            and vim.fn.getfsize(path) > vim.g.bigfile_size
            and "bigfile"
          or nil
      end,
    },
  },
})

autocmd({ "FileType" }, {
  group = augroup("bigfile"),
  pattern = "bigfile",
  callback = function(ev)
    vim.b.minianimate_disable = true
    vim.schedule(function()
      vim.bo[ev.buf].syntax = vim.filetype.match({ buf = ev.buf }) or ""
    end)
  end,
})

-- Make it easier to close man-files when opened inline
autocmd({ "FileType" }, {
  group = augroup("man_unlisted"),
  pattern = { "man" },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
  end,
})
