pragma Singleton

import Quickshell
import Quickshell.Hyprland
import QtQuick

Singleton {
    id: hypr

    Timer {
        interval: 50
        onTriggered: {
            Hyprland.refreshToplevels();
            Hyprland.refreshWorkspaces();
            Hyprland.refreshMonitors();
        }
        running: true
        repeat: true
    }

    function isFullscreen(screen: ShellScreen): bool {
        let windows = Hyprland.toplevels.values;

        for (let i = 0; i < windows.length; i++) {
            const window = windows[i];

            if (window.monitor?.name == screen.name && window.wayland?.fullscreen)
                return true;
        }

        return false;
    }
}
