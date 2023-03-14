local wezterm = require("wezterm")

-- Show the domain and workspace in the status area, for quicker and easier sanity checking
wezterm.on("update-right-status", function(window, pane)
  window:set_right_status(
    pane:get_domain_name() .. " / " .. window:active_workspace()
  )
end)

function attach_to_workspace(name, window, pane)
  window:perform_action(
    wezterm.action({ SwitchToWorkspace = { name = name } }),
    pane
  )

  -- brief delay while SwitchToWorkspace finishes setting up the window
  wezterm.sleep_ms(250)

  window:perform_action(wezterm.action({ AttachDomain = name }), pane)
end

return {
  -- font = wezterm.font 'Fira Code',
  font_size = 11.1,
  color_scheme = "OneHalfDark",
  enable_csi_u_key_encoding = true,
  use_fancy_tab_bar = true,
  disable_default_key_bindings = true,
  -- timeout_milliseconds defaults to 1000 and can be omitted
  leader = { key = "a", mods = "CTRL", timeout_milliseconds = 1000 },
  keys = {
    { key = "e", mods = "LEADER", action = wezterm.action.ShowLauncher },
    {
      key = "|",
      mods = "LEADER|SHIFT",
      action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }),
    },
    {
      key = "-",
      mods = "LEADER",
      action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }),
    },
    {
      key = "h",
      mods = "LEADER",
      action = wezterm.action.ActivatePaneDirection("Left"),
    },
    {
      key = "l",
      mods = "LEADER",
      action = wezterm.action.ActivatePaneDirection("Right"),
    },
    {
      key = "z",
      mods = "LEADER",
      action = wezterm.action.TogglePaneZoomState,
    },
    {
      key = "c",
      mods = "LEADER",
      action = wezterm.action.CopyTo("Clipboard"),
    },
    {
      key = "v",
      mods = "SUPER",
      action = wezterm.action.PasteFrom("Clipboard"),
    },
    {
      key = "t",
      mods = "LEADER",
      action = wezterm.action.SpawnTab("CurrentPaneDomain"),
    },
    -- {key="t", mods="CTRL|SHIFT", action=wezterm.action.SpawnTab("CurrentPaneDomain")},
    {
      key = "x",
      mods = "LEADER",
      action = wezterm.action.CloseCurrentTab({ confirm = true }),
    },
    { key = "1", mods = "LEADER", action = wezterm.action.ActivateTab(0) },
    { key = "2", mods = "LEADER", action = wezterm.action.ActivateTab(1) },
    { key = "3", mods = "LEADER", action = wezterm.action.ActivateTab(2) },
    { key = "4", mods = "LEADER", action = wezterm.action.ActivateTab(3) },
    { key = "5", mods = "LEADER", action = wezterm.action.ActivateTab(4) },
    { key = "6", mods = "LEADER", action = wezterm.action.ActivateTab(5) },
    { key = "7", mods = "LEADER", action = wezterm.action.ActivateTab(6) },
    { key = "8", mods = "LEADER", action = wezterm.action.ActivateTab(7) },
    { key = "9", mods = "LEADER", action = wezterm.action.ActivateTab(8) },
    { key = "a", mods = "LEADER", action = wezterm.action.ActivateLastTab },
    {
      key = "f",
      mods = "LEADER",
      action = wezterm.action.Search({ CaseSensitiveString = "" }),
    },
  },
  scrollback_lines = 999999,
  unix_domains = {
    {
      name = "dropdown",
    },
  },
  -- default_gui_startup_args = { 'connect', 'dropdown' },
}
