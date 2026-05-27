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
    blur = true
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
    no_blur = true,
    no_initial_focus = true
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
