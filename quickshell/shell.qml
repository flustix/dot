pragma ComponentBehavior: Bound
//@ pragma UseQApplication

import Quickshell
import QtQuick

import qs.managers
import qs.modules
import qs.modules.bar
import qs.modules.notify
import qs.utils

ShellRoot {
    id: shell

    // outlines
    Variants {
        model: Quickshell.screens.filter(x => x.name != Globals.primaryScreenId)
        Outline {
            id: o
            bar: b

            MiniBar {
                id: b
                clock: clock
                outline: o
            }
        }
    }

    Outline {
        id: op
        modelData: Globals.primaryScreen
        panels: pnl
        bar: bp
        topbar: tbp

        OutlinePanels {
            id: pnl
            outline: op
        }

        Bar {
            id: bp
            clock: clock
            outline: op
        }

        TopBar {
            id: tbp
            outline: op
        }
    }

    NotificationPopup {
        screen: Globals.primaryScreen
    }

    Keybinds {}

    SystemClock {
        id: clock
        precision: SystemClock.Seconds
    }
}
