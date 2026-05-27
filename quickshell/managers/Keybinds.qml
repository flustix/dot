import Quickshell
import Quickshell.Hyprland
import QtQuick

import qs.utils

Scope {
    // qmllint disable unresolved-type
    GlobalShortcut {
        appid: "hyprflux"
        name: "wallpaper-switch"
        description: "Opens vicinae to change the current wallpaper and theme."
        onPressed: Theme.openWallpaperSwitcher()
    }
}
