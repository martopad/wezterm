-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This will hold the configuration.
local config = wezterm.config_builder()

-- Copy and slightly modify "Catppuccin Mocha" theme
-- Taken from https://github.com/catppuccin/WezTerm#-faq
local custom = wezterm.color.get_builtin_schemes()["Catppuccin Mocha"]
custom.background = "#000000"
config.color_schemes = {["OLEDppuccin"] = custom}
config.color_scheme = "OLEDppuccin"

-- White text is too bright. Replace it with slightly darker color.
custom.foreground = "#b8b8b8"

return config
