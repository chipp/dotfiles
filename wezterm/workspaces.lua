local wezterm = require 'wezterm'
local mux = wezterm.mux

local Workspaces = {}

local function create_workspace(workspace, workspace_config)
    for _, window_config in ipairs(workspace_config.windows) do
        local window

        for _, tab_config in ipairs(window_config.tabs) do
            local last_pane

            local size = 1 / #tab_config.panes
            for _, pane_config in ipairs(tab_config.panes) do
                local panes = {}

                if type(pane_config) == "table" then
                    local subsize = 1 / #pane_config
                    local direction = 'Bottom'
                    for _, pane_path in ipairs(pane_config) do
                        panes[#panes + 1] = {
                            path = pane_path,
                            direction = direction,
                            size = subsize
                        }
                        direction = 'Right'
                    end
                else
                    panes[#panes + 1] = {
                        path = pane_config,
                        direction = 'Bottom',
                        size = size
                    }
                end

                for _, pane in ipairs(panes) do
                    if not window then
                        wezterm.log_info("create window for " .. workspace)
                        _, last_pane, window = mux.spawn_window {
                            workspace = workspace,
                            cwd = pane.path,
                        }
                    else
                        if not last_pane then
                            _, last_pane = window:spawn_tab {
                                cwd = pane.path,
                            }
                        else
                            last_pane = last_pane:split {
                                direction = pane.direction,
                                size = pane.size,
                                cwd = pane.path,
                            }
                        end
                    end
                end
            end
        end
    end

    if workspace_config.default then
        wezterm.log_info('set ' .. workspace .. ' as default workspace')
        mux.set_active_workspace(workspace)
    end
end

function Workspaces.load()
    local path = wezterm.home_dir .. "/.config/wezterm/workspaces.json"

    local workspaces, err = io.open(path, "r")
    if not workspaces then
        wezterm.log_error("Failed to open file: " .. err)
        return
    end

    local content = workspaces:read("*a")
    workspaces:close()

    local config = wezterm.json_parse(content)
    if not config then
        wezterm.log_error("Failed to parse JSON")
        return
    end

    for workspace, workspace_config in pairs(config) do
        wezterm.log_info("Creating workspace: " .. workspace)
        create_workspace(workspace, workspace_config)
    end
end

function Workspaces.save()
    local windows = mux.all_windows()
    local config = {}
    local active_workspace = wezterm.mux.get_active_workspace()

    for _, workspace in ipairs(wezterm.mux.get_workspace_names()) do
        config[workspace] = {
            default = active_workspace == workspace,
            windows = {}
        }
    end

    for _, window in ipairs(windows) do
        local window_config = { tabs = {} }

        for tab_index, tab_info in ipairs(window:tabs_with_info()) do
            local tab_config = { panes = {} }

            for pane_index, pane_info in ipairs(tab_info.tab:panes_with_info()) do
                tab_config.panes[pane_index] = pane_info.pane:get_current_working_dir().file_path
            end

            window_config.tabs[tab_index] = tab_config
        end

        config[window:get_workspace()].windows[#config[window:get_workspace()].windows + 1] = window_config
    end

    local json = wezterm.json_encode(config)
    local path = wezterm.home_dir .. "/.config/wezterm/workspaces.json"

    local workspaces, err = io.open(path, "w")
    if not workspaces then
        wezterm.log_error("Failed to open file: " .. err)
        return
    end

    workspaces:write(json)
    workspaces:close()
end

return Workspaces
