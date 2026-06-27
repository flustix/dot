import Quickshell.Hyprland
import Quickshell.Widgets
import QtQuick
import QtQuick.Layouts

import qs.modules
import qs.utils

Item {
    id: root
    height: 32
    y: -height * (1 - outline.fullscreenProgress)

    required property Outline outline

    readonly property HyprlandToplevel activeToplevel: {
        const t = Hyprland.activeToplevel;
        return t?.workspace?.name.startsWith("special:") || Hyprland.focusedWorkspace?.toplevels.values.length > 0 ? t : null;
    }

    MarginWrapperManager {
        leftMargin: 20
        rightMargin: 20
    }

    RowLayout {
        Text {
            text: root.activeToplevel?.title || ""
            font.pointSize: 10
            color: Theme.text
        }
    }
}
