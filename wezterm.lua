-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This will hold the configuration.
local config = wezterm.config_builder()
local act = wezterm.action

-- =====================================================================
-- Theme
-- Copy and slightly modify theme
local custom = wezterm.color.get_builtin_schemes()["Light White (terminal.sexy)"]
-- Set background to absolute black, for oled monitors
custom.background = "#000000"
-- White text is too bright. Replace it with slightly darker color.
custom.foreground = "#b8b8b8"
config.color_schemes = {["MyTheme"] = custom}
config.color_scheme = "MyTheme"

-- =====================================================================
-- General settings
config.enable_scroll_bar = true
config.initial_cols = 180
config.initial_rows = 40

-- =====================================================================
-- OS-specific settings
if wezterm.target_triple == 'x86_64-pc-windows-msvc' then
    config.font = wezterm.font("Cascadia Mono", {weight="DemiBold", stretch="Normal", style="Normal"})
    config.font_size = 9.0
    config.default_prog = { 'wsl.exe', '--cd', '~' }
    -- Match font renderring like Windows Terminal
    config.freetype_load_target = 'Light'
    config.freetype_render_target = 'HorizontalLcd'
else
    config.font = wezterm.font("CaskaydiaCove Nerd Font Mono", {weight="Regular", stretch="Normal", style="Normal"})
    config.font_size = 11
end


-- =====================================================================
-- Right click shortcut: When with selection, copy. When without selection, paste.
config.mouse_bindings = {
    {
        event = { Down = { streak = 1, button = "Right" } },
        mods = "NONE",
        action = wezterm.action_callback(function(window, pane)
            local has_selection = window:get_selection_text_for_pane(pane) ~= ""
            if has_selection then
                window:perform_action(act.CopyTo("ClipboardAndPrimarySelection"), pane)
                window:perform_action(act.ClearSelection, pane)
            else
                window:perform_action(act({ PasteFrom = "Clipboard" }), pane)
            end
        end),
    },
}

return config
