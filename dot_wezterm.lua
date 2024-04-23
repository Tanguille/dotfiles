-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This table will hold the configuration.
local config = {}

-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
if wezterm.config_builder then
  config = wezterm.config_builder()
end

-- This is where you actually apply your config choices

config.keys = {
 {
      key = 'c',
      mods = 'CTRL',
      action = wezterm.action_callback(function(window, pane)
          selection_text = window:get_selection_text_for_pane(pane)
          is_selection_active = string.len(selection_text) ~= 0
          if is_selection_active then
              window:perform_action(wezterm.action.CopyTo('ClipboardAndPrimarySelection'), pane)
          else
              window:perform_action(wezterm.action.SendKey{ key='c', mods='CTRL' }, pane)
          end
      end),
  }
}

-- and finally, return the configuration to wezterm
return config
