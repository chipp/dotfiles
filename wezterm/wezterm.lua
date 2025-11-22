local wezterm = require 'wezterm'
local keys = require 'keys'
local mouse = require 'mouse'
local startup = require 'startup'

local config = wezterm.config_builder()

keys.setup(config)
mouse.setup(config)
startup.setup(config)

config.color_scheme = 'Peppermint'
config.font = wezterm.font 'PragmataPro Liga'
config.font_size = 18.0
config.line_height = 1.1
config.freetype_load_target = "Light"
config.bold_brightens_ansi_colors = false
config.harfbuzz_features = { "ss13" }

config.scrollback_lines = 30000
config.tab_bar_at_bottom = true
config.native_macos_fullscreen_mode = true
config.window_close_confirmation = 'NeverPrompt'

config.window_padding = {
    left = '1px',
    right = '1px',
    top = '0',
    bottom = '0',
}

return config
