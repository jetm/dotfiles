if vim.g.vscode then
  return
end

_G.yet = {}

-- For debugging purpose
-- :lua debug(...)
---@diagnostic disable-next-line: duplicate-set-field
function yet.debug(...)
  local objects = {}
  for i = 1, select("#", ...) do
    local v = select(i, ...)
    table.insert(objects, vim.inspect(v))
  end

  print(table.concat(objects, "\n"))
  return ...
end

--- Serve a notification
function yet._notify(msg, type, opts)
  vim.schedule(function()
    vim.notify(msg, type, opts)
  end)
end

local function mason_notify(msg, type)
  yet._notify(msg, type, { title = "Mason" })
end

--- Update all packages in Mason
function yet._mason_update_all()
  local registry_avail, registry = pcall(require, "mason-registry")
  if not registry_avail then
    vim.api.nvim_err_writeln("Unable to access mason registry")
    return
  end

  mason_notify("Checking for package updates...")
  registry.update(vim.schedule_wrap(function(success, updated_registries)
    if success then
      local installed_pkgs = registry.get_installed_packages()
      local running = #installed_pkgs
      local no_pkgs = running == 0

      if no_pkgs then
        mason_notify("No updates available")
      else
        local updated = false
        for _, pkg in ipairs(installed_pkgs) do
          pkg:check_new_version(function(update_available, version)
            if update_available then
              updated = true
              mason_notify(("Updating `%s` to %s"):format(pkg.name, version.latest_version))
              pkg:install():on("closed", function()
                running = running - 1
                if running == 0 then
                  mason_notify("Update Complete")
                end
              end)
            else
              running = running - 1
              if running == 0 then
                if updated then
                  mason_notify("Update Complete")
                else
                  mason_notify("No updates available")
                end
              end
            end
          end)
        end
      end
    else
      mason_notify(("Failed to update registries: %s"):format(updated_registries), vim.log.levels.ERROR)
    end
  end))
end

function yet._custom_fold_text()
  local line = vim.fn.getline(vim.v.foldstart)

  return "   " .. line
end

local cmd = vim.api.nvim_create_user_command
cmd("MasonUpdateAll", function()
  yet._mason_update_all()
end, { desc = "Update Mason Packages" })

yet.icons = {
  kinds = {
    Array = " ",
    Boolean = "󰨙 ",
    Class = " ",
    Codeium = "󰘦 ",
    Color = " ",
    Control = " ",
    Collapsed = " ",
    Constant = "󰏿 ",
    Constructor = " ",
    Copilot = " ",
    Enum = " ",
    EnumMember = " ",
    Event = " ",
    Field = " ",
    File = " ",
    Folder = " ",
    Function = "󰊕 ",
    Interface = " ",
    Keyword = " ",
    Method = "󰊕 ",
    Module = " ",
    Namespace = "󰦮 ",
    Null = " ",
    Number = "󰎠 ",
    Object = " ",
    Operator = " ",
    Package = " ",
    Property = " ",
    Reference = " ",
    Snippet = " ",
    String = " ",
    Struct = "󰆼 ",
    TabNine = "󰏚 ",
    Text = " ",
    TypeParameter = " ",
    Unit = " ",
    Value = " ",
    Variable = "󰀫 ",
  },
}
