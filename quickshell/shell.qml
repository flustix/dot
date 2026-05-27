pragma ComponentBehavior: Bound
//@ pragma UseQApplication

import Quickshell
import QtQuick

import qs.managers
import qs.modules
import qs.modules.bar
import qs.modules.network
import qs.modules.media
import qs.modules.notify
import qs.modules.power
import qs.modules.workspaces
import qs.utils

ShellRoot {
    id: shell

    // outlines
    Variants {
        model: Quickshell.screens.filter(x => x.name != Config.primaryScreen)
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
        modelData: Quickshell.screens.find(x => x.name == Config.primaryScreen)
        panels: pnl
        bar: bp

        OutlinePanels {
            id: pnl
            outline: op
        }

        Bar {
            id: bp
            clock: clock
            outline: op
        }
    }

    NetworkList {}
    PowerList {}
    NotificationPopup {
        screen: Quickshell.screens.find(x => x.name == Config.primaryScreen)
    }

    Keybinds {}

    SystemClock {
        id: clock
        precision: SystemClock.Seconds
    }
}
