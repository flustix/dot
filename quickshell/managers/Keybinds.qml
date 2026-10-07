import Quickshell
import Quickshell.Io
import Quickshell.Hyprland
import QtQuick

import qs.utils

Scope {
    // qmllint disable unresolved-type
    GlobalShortcut {
        appid: "hyprflux"
        name: "lock"
        description: "Lock the screen."
        onPressed: Globals.locked = true
    }

    GlobalShortcut {
        appid: "hyprflux"
        name: "poweroff"
        description: "Fades the screen to black and turns off the machine."
        onPressed: () => {
            Globals.dimmed = true;
            poweroffTimer.running = true;
        }
    }

    Timer {
        id: poweroffTimer
        interval: 1000
        repeat: false
        onTriggered: poweroff.running = true
    }

    Process {
        id: poweroff
        command: ["poweroff"]
    }
}
