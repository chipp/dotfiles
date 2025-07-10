local wezterm = require 'wezterm'
local act = wezterm.action

Mouse = {}

function Mouse.setup(config)
    config.mouse_bindings = {
        {
            event = { Up = { streak = 1, button = 'Left' } },
            mods = 'NONE',
            action = act.CompleteSelection 'ClipboardAndPrimarySelection',
        },
        {
            event = { Up = { streak = 1, button = 'Left' } },
            mods = 'CMD',
            action = act.OpenLinkAtMouseCursor,
        }
    }
end

return Mouse
