require("parts.binds")
require("parts.colors")
require("parts.env")
require("parts.env-priv")
require("parts.exec")
require("parts.monitors")
require("parts.rules")
require("parts.workspaces")

-----------------------
----- PERMISSIONS -----
-----------------------

-- See https://wiki.hypr.land/Configuring/Advanced-and-Cool/Permissions/
-- Please note permission changes here require a Hyprland restart and are not applied on-the-fly
-- for security reasons

-- hl.config({
--   ecosystem = {
--     enforce_permissions = true,
--   },
-- })

-- hl.permission("/usr/(bin|local/bin)/grim", "screencopy", "allow")
-- hl.permission("/usr/(lib|libexec|lib64)/xdg-desktop-portal-hyprland", "screencopy", "allow")
-- hl.permission("/usr/(bin|local/bin)/hyprpm", "plugin", "allow")

hl.config({
    general = {
        gaps_in = 2,
        gaps_out = 8,
        border_size = 4,
        col = {
            active_border = { colors = { primary, secondary }, angle = 90 },
            inactive_border = surface_bright,
        },
        resize_on_border = false,
        allow_tearing = false,
        layout = "dwindle"
    },
    binds = {
        scroll_event_delay = 0
    },
    decoration = {
        rounding = 8,
        rounding_power = 2,
        blur = {
            enabled = true,
            size = 3,
            passes = 2,
            popups = true,
            ignore_opacity = true,
            xray = false
        }
    },
    group = {
        col = {
            border_active = { colors = { primary, secondary }, angle = 90 },
            border_inactive = surface_bright,
        },
        groupbar = {
            font_size = 12,
            text_color = primary,
            text_color_inactive = surface_bright,
            col = {
                active = primary,
                inactive = surface_bright,
            },
            indicator_gap = 4,
            gradient_rounding = 4,
            gaps_in = 8,
            gaps_out = 8,
            keep_upper_gap = true
        }
    },
    input = {
        kb_layout          = "de",
        kb_variant         = "",
        kb_model           = "",
        kb_options         = "",
        kb_rules           = "",
        numlock_by_default = true,
        follow_mouse       = 1,
        accel_profile      = "adaptive",
        sensitivity        = -0.5
    },
    animations = {
        enabled = true,
    },
    dwindle = {
        preserve_split = true,
    },
    master = {
        new_status = "master",
    },
    scrolling = {
        fullscreen_on_one_column = true,
    },
    misc = {
        force_default_wallpaper = -1,
        disable_hyprland_logo = false,
        middle_click_paste = false,
        font_family = "Campton Semibold"
    },
})

hl.curve("easeOutQuint", { type = "bezier", points = { { 0.23, 1 }, { 0.32, 1 } } })
hl.curve("easeInOutCubic", { type = "bezier", points = { { 0.65, 0.05 }, { 0.36, 1 } } })
hl.curve("linear", { type = "bezier", points = { { 0, 0 }, { 1, 1 } } })
hl.curve("almostLinear", { type = "bezier", points = { { 0.5, 0.5 }, { 0.75, 1 } } })
hl.curve("quick", { type = "bezier", points = { { 0.15, 0 }, { 0.1, 1 } } })
hl.curve("easy", { type = "spring", mass = 1, stiffness = 71.2633, dampening = 15.8273644 })
hl.curve("bouncy", { type = "spring", mass = 2, stiffness = 71.2633, dampening = 15.8273644 })

hl.animation({ leaf = "global", enabled = true, speed = 10, bezier = "default" })

hl.animation({ leaf = "windows", enabled = true, speed = 4, spring = "easy" })
hl.animation({ leaf = "windowsIn", enabled = true, speed = 4, bezier = "easeOutQuint", style = "popin 90%" })
hl.animation({ leaf = "windowsOut", enabled = true, speed = 2, bezier = "easeOutQuint", style = "popin 90%" })

hl.animation({ leaf = "layers", enabled = true, speed = 4, bezier = "easeOutQuint" })
hl.animation({ leaf = "layersIn", enabled = true, speed = 4, bezier = "easeOutQuint", style = "popin 90%" })
hl.animation({ leaf = "layersOut", enabled = true, speed = 4, bezier = "easeOutQuint", style = "popin 110%" })

hl.animation({ leaf = "fade", enabled = true, speed = 2, bezier = "quick" })
hl.animation({ leaf = "fadeIn", enabled = true, speed = 2, bezier = "almostLinear" })
hl.animation({ leaf = "fadeOut", enabled = true, speed = 2, bezier = "almostLinear" })
hl.animation({ leaf = "fadeLayersIn", enabled = true, speed = 2, bezier = "almostLinear" })
hl.animation({ leaf = "fadeLayersOut", enabled = true, speed = 2, bezier = "almostLinear" })

hl.animation({ leaf = "border", enabled = true, speed = 4, bezier = "easeOutQuint" })

hl.animation({ leaf = "workspaces", enabled = true, speed = 2, bezier = "almostLinear", style = "fade" })
hl.animation({ leaf = "zoomFactor", enabled = true, speed = 4, bezier = "easeOutQuint" })
