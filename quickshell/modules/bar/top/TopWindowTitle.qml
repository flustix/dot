import Quickshell
import Quickshell.Hyprland
import QtQuick
import QtQuick.Layouts

import qs.utils

RowLayout {
    id: root
    height: parent.height

    readonly property HyprlandToplevel activeToplevel: {
        const t = Hyprland.activeToplevel;
        return t?.workspace?.name.startsWith("special:") || Hyprland.focusedWorkspace?.toplevels.values.length > 0 ? t : null;
    }

    Text {
        text: {
            if (!root.activeToplevel?.wayland)
                return "";

            var id = root.activeToplevel.wayland.appId;
            var entry = DesktopEntries.heuristicLookup(id);

            if (entry && entry.name) {
                return entry.name;
            }

            var split = id.split(".");
            var last = split[split.length - 1];
            last = `${last[0].toUpperCase()}${last.substring(1)}`;
            return last;
        }
        font.pointSize: 10
        color: Theme.text
    }
}
