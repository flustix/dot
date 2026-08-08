-- layers
hl.layer_rule({
    match = { namespace = "(qs-.*)" },
    no_anim = true
})
hl.layer_rule({ -- screenshot & colorpicker
    match = { class = "selection" },
    animation = "fade"
})
hl.layer_rule({
    match = { namespace = "vicinae" },
    blur = true,
    animation = "popin 96%"
})
hl.layer_rule({
    match = { namespace = "kitty-panel" },
    blur = false
})

-- windows
hl.window_rule({
    name = "suppress-maximize-events",
    match = { class = ".*" },
    suppress_event = "maximize",
})

hl.window_rule({
    name = "fix-xwayland-drags",
    match = {
        class = "^$",
        title = "^$",
        xwayland = true,
        float = true,
        fullscreen = false,
        pin = false,
    },
    no_focus = true,
})

hl.window_rule({
    match = {
        class = "jetbrains-rider",
        float = true
    },
    no_blur = true
})

hl.window_rule({
    match = {
        initial_class = "fluXis"
    },
    float = true,
    maximize = false,
    center = true,
    size = "1600 900"
})

hl.window_rule({
    match = {
        initial_class = "hyprland-share-picker"
    },
    float = true,
    center = true,
    size = "640 360"
})

hl.window_rule({
    match = {
        initial_class = "org.quickshell"
    },
    float = true,
    center = true,
    size = "256 256",
    border_size = 0,
    no_blur = true,
    no_shadow = true
})

hl.window_rule({
    match = {
        initial_class = "steam",
        initial_title = "Friends List",
    },
    float = true,
    size = "480 720",
    opacity = 0.95
})

hl.window_rule({
    match = {
        initial_class = "^(code|discord|vesktop|jetbrains-rider|dev.zed.Zed)",
        fullscreen = 0
    },
    opacity = 0.95
})

hl.window_rule({
    name = "hide-from-screenshare",
    match = {
        initial_class = "^(Proton Pass)"
    },
    no_screen_share = true
})
