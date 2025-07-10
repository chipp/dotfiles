local wezterm = require 'wezterm'
local workspaces = require 'workspaces'
local mux = wezterm.mux

local Startup = {}

function Startup.setup(_)
    wezterm.on('gui-startup', function(_)
        workspaces.load()

        local workspace = mux.get_active_workspace()
        for _, window in ipairs(mux.all_windows()) do
            if window:get_workspace() == workspace then
                window:gui_window():toggle_fullscreen()
            end
        end
    end)
end

return Startup
