local menu = "vicinae"
local term = "kitty"
local hyprflux = "/media/development/flustix/bar/hyprflux.Scripts/bin/Debug/net9.0/hyprflux.Scripts"

local immerse = false;
local zoom = 1;

-- Special
hl.bind("CONTROL + SHIFT + Escape", hl.dsp.exec_cmd(term .. " btop"))
hl.bind("CONTROL + ALT + DELETE", hl.dsp.global("hyprflux:poweroff"))
hl.bind("ALT + Tab", hl.dsp.exec_cmd("snappy-switcher next --mod alt"))

-- Mod
hl.bind("SUPER + Q", hl.dsp.exec_cmd(term))
hl.bind("SUPER + W", hl.dsp.global("hyprflux:wallpaper-switch"))
hl.bind("SUPER + E", hl.dsp.exec_cmd("nautilus"))
hl.bind("SUPER + R", hl.dsp.exec_cmd(menu .. " toggle"))
hl.bind("SUPER + I", function() ToggleImmerse() end)
hl.bind("SUPER + O", function() Minimize("com.obsproject.Studio", "/usr/bin/obs") end)
hl.bind("SUPER + P", hl.dsp.window.pseudo())

-- Super
hl.bind(
    "SUPER + D",
    function()
        Minimize(
            "vesktop",
            "vesktop --enable-blink-features=MiddleClickAutoscroll --disable-features=WebRtcAllowInputVolumeAdjustment"
        )
    end
)
hl.bind("SUPER + F", hl.dsp.window.float())
hl.bind("SUPER + G", hl.dsp.group.toggle())
hl.bind("SUPER + J", hl.dsp.layout("rotatesplit 90"))
hl.bind("SUPER + L", hl.dsp.exec_cmd("hyprlock"))

hl.bind("SUPER + C", hl.dsp.window.close())
hl.bind("SUPER + V", hl.dsp.exec_cmd(menu .. " vicinae://launch/clipboard/history"))
hl.bind("SUPER + M", function() Minimize("finamp", "/opt/finamp/finamp") end)

hl.bind("SUPER + Left", hl.dsp.focus({ direction = "l" }))
hl.bind("SUPER + Up", hl.dsp.focus({ direction = "u" }))
hl.bind("SUPER + Right", hl.dsp.focus({ direction = "r" }))
hl.bind("SUPER + Down", hl.dsp.focus({ direction = "d" }))

hl.bind("SUPER + mouse_up", hl.dsp.layout("move -400"))
hl.bind("SUPER + mouse_down", hl.dsp.layout("move 400"))

-- Mod-Shift
hl.bind(
    "SUPER + SHIFT + S",
    hl.dsp.exec_cmd("grimblast --freeze -n copysave area ~/Pictures/Screenshots/$(date +%Y-%m-%d_%H-%m-%s).png")
)
hl.bind("SUPER + SHIFT + C", hl.dsp.exec_cmd("hyprpicker | wl-copy"))

hl.bind("SUPER + SHIFT + Up", function() CycleWorkspaces(-1) end)
hl.bind("SUPER + SHIFT + Down", function() CycleWorkspaces(1) end)

for i = 1, 10 do
    local key = i % 10 -- 10 maps to key 0
    hl.bind("SUPER + SHIFT + " .. key, hl.dsp.window.move({ workspace = i, follow = false }))
end

-- Mod-Control
hl.bind("SUPER + CONTROL + S", hl.dsp.workspace.toggle_special())

hl.bind("SUPER + CONTROL + C", hl.dsp.window.kill())

hl.bind("SUPER + CONTROL + Left", hl.dsp.window.move({ direction = "l" }))
hl.bind("SUPER + CONTROL + Up", hl.dsp.window.move({ direction = "u" }))
hl.bind("SUPER + CONTROL + Right", hl.dsp.window.move({ direction = "r" }))
hl.bind("SUPER + CONTROL + Down", hl.dsp.window.move({ direction = "d" }))

-- Mod-Mouse
hl.bind("SUPER + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind("SUPER + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Scrolling using Volume Knob
hl.bind(
    "XF86AudioRaiseVolume",
    hl.dsp.exec_cmd('sh ~/scripts/volume-scroll.sh 1'),
    { locked = true, repeating = true }
)
hl.bind(
    "XF86AudioLowerVolume",
    hl.dsp.exec_cmd('sh ~/scripts/volume-scroll.sh -1'),
    { locked = true, repeating = true }
)

-- Volume/Media/Brightness
-- hl.bind(
--     "XF86AudioRaiseVolume",
--     hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"),
--     { locked = true, repeating = true }
-- )
-- hl.bind("XF86AudioLowerVolume",
--     hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),
--     { locked = true, repeating = true }
-- )
hl.bind(
    "XF86AudioMute",
    hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),
    { locked = true, repeating = true }
)
hl.bind(
    "XF86AudioMicMute",
    hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"),
    { locked = true, repeating = true }
)
hl.bind(
    "XF86MonBrightnessUp",
    hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%+"),
    { locked = true, repeating = true }
)
hl.bind(
    "XF86MonBrightnessDown",
    hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%-"),
    { locked = true, repeating = true }
)

-- Zooming
hl.bind("SUPER + SHIFT + mouse_up", function() SetZoom(zoom - 1) end)
hl.bind("SUPER + SHIFT + mouse_down", function() SetZoom(zoom + 1) end)
hl.bind("SUPER + SHIFT + Escape", function() SetZoom(1) end)

-- Mod-Ctrl-Scroll to switch between windows in groups
hl.bind("SUPER + CONTROL + mouse_up", hl.dsp.group.next())
hl.bind("SUPER + CONTROL + mouse_down", hl.dsp.group.prev())

-- Passtrough
hl.bind(
    "SHIFT + pause",
    hl.dsp.send_shortcut({ window = "class:vesktop", mods = "CONTROL SHIFT", key = "D" }),
    { transparent = true }
)
hl.bind(
    "pause",
    hl.dsp.send_shortcut({ window = "class:vesktop", mods = "CONTROL SHIFT", key = "M" })
)

-- Functions
function SetZoom(val)
    zoom = math.max(val, 1)
    hl.config({ cursor = { zoom_factor = val } })
end

function ToggleImmerse()
    immerse = not immerse;

    local mult = immerse and 0 or 1;
    hl.config({
        general = {
            gaps_in = 2 * mult,
            gaps_out = 8 * mult,
            border_size = 4 * mult,
        },
        decoration = {
            rounding = 8 * mult,
        }
    })
end

-- "Minimizes" a window by putting it in the special workspace
function Minimize(class, exec)
    local window = hl.get_window("class:" .. class)

    if not window then
        hl.dispatch(hl.dsp.exec_cmd(exec))
        return
    end

    if window.workspace.name == "special:special" then
        hl.dispatch(hl.dsp.window.move({ window = window, workspace = hl.get_active_workspace() }))
    else
        hl.dispatch(hl.dsp.window.move({ window = window, workspace = "special", follow = false }))
    end
end

function CycleWorkspaces(shift)
    local mouse = hl.get_cursor_pos();

    local monitors = hl.get_monitors()
    local count = #monitors;
    table.sort(monitors, function(a, b)
        return a.x < b.x
    end)

    local first = -1;
    local start = 1;

    for idx, m in ipairs(monitors) do
        if (first == -1) then
            first = m.active_workspace.id

            local times = math.floor(first / count);
            start = times * count;
        end

        if start == 0 and shift < 0 then
            return
        elseif start == 12 and shift > 0 then
            return
        end

        local target = start + idx + (count * shift);

        hl.dispatch(hl.dsp.workspace.move({ monitor = m, workspace = target }))
        hl.dispatch(hl.dsp.focus({ workspace = target }))
    end

    if mouse ~= nil then
        hl.dispatch(hl.dsp.cursor.move({ x = mouse.x, y = mouse.y }))
    end
end
