local wezterm = require 'wezterm'
local workspaces = require 'workspaces'
local act = wezterm.action

Keys = {}

function Keys.setup(config)
    config.keys = {
        {
            key = 'Enter',
            mods = 'CMD',
            action = act.ToggleFullScreen,
        },
        { key = 'LeftArrow',  mods = 'CMD', action = act.ActivateTabRelative(-1) },
        { key = 'RightArrow', mods = 'CMD', action = act.ActivateTabRelative(1) },
        {
            key = ',',
            mods = 'CMD',
            action = wezterm.action_callback(function(_, _)
                wezterm.open_with(wezterm.config_dir, "Sublime Text")
            end)
        },
        {
            key = 'k',
            mods = 'CMD',
            action = act.Multiple {
                act.ClearScrollback 'ScrollbackAndViewport',
                act.SendKey { key = 'l', mods = 'CTRL' },
            }
        },
        {
            key = 'LeftArrow',
            mods = 'CMD|ALT',
            action = act.ActivatePaneDirection 'Left',
        },
        {
            key = 'RightArrow',
            mods = 'CMD|ALT',
            action = act.ActivatePaneDirection 'Right',
        },
        {
            key = 'UpArrow',
            mods = 'CMD|ALT',
            action = act.ActivatePaneDirection 'Up',
        },
        {
            key = 'DownArrow',
            mods = 'CMD|ALT',
            action = act.ActivatePaneDirection 'Down',
        },
        {
            key = 'n',
            mods = 'SUPER',
            action = act.Multiple {
                act.SpawnWindow,
                wezterm.action_callback(function(_, _)
                    workspaces.save()
                end)
            }
        },
        {
            key = 't',
            mods = 'SUPER',
            action = act.Multiple {
                act.SpawnTab 'CurrentPaneDomain',
                wezterm.action_callback(function(_, _)
                    workspaces.save()
                end)
            }
        },
        {
            key = 'd',
            mods = 'CMD',
            action = act.Multiple {
                act.SplitHorizontal { domain = 'CurrentPaneDomain' },
                wezterm.action_callback(function(_, _)
                    workspaces.save()
                end)
            }
        },
        {
            key = 'D',
            mods = 'CMD|SHIFT',
            action = act.Multiple {
                act.SplitVertical { domain = 'CurrentPaneDomain' },
                wezterm.action_callback(function(_, _)
                    workspaces.save()
                end)
            }
        },
        {
            key = 'w',
            mods = 'CMD',
            action = act.Multiple {
                act.CloseCurrentTab { confirm = true },
                wezterm.action_callback(function(_, _)
                    workspaces.save()
                end),
            }
        },
        {
            key = 'w',
            mods = 'CMD|SHIFT',
            action = act.Multiple {
                act.CloseCurrentPane { confirm = true },
                wezterm.action_callback(function(_, _)
                    workspaces.save()
                end)
            }
        },
        {
            key = 'q',
            mods = 'SUPER',
            action = act.Multiple {
                wezterm.action_callback(function(_, _)
                    workspaces.save()
                end),
                act.QuitApplication
            }
        },
    }
end

return Keys
