import Quickshell
import Quickshell.Hyprland
import Quickshell.Widgets
import QtQuick
import QtQuick.Layouts

import qs.components
import qs.utils

RowLayout {
    id: root
    height: parent.height
    spacing: 8

    readonly property HyprlandToplevel activeToplevel: {
        const t = Hyprland.activeToplevel;
        return t?.workspace?.name.startsWith("special:") || Hyprland.focusedWorkspace?.toplevels.values.length > 0 ? t : null;
    }

    readonly property DesktopEntry currentEntry: activeToplevel?.wayland ? DesktopEntries.heuristicLookup(activeToplevel.wayland.appId) : null

    TintedIcon {
        size: 20
        effect: true
        visible: root.currentEntry && root.currentEntry?.icon && Quickshell.hasThemeIcon(root.currentEntry.icon)
        path: Quickshell.iconPath(root.currentEntry?.icon ?? "")
    }

    Text {
        text: {
            if (!root.activeToplevel?.wayland)
                return "";

            if (root.currentEntry && root.currentEntry.name)
                return root.currentEntry.name;

            var id = root.activeToplevel.wayland.appId;
            var split = id.split(".");
            var last = split[split.length - 1];
            last = `${last[0].toUpperCase()}${last.substring(1)}`;
            return last;
        }
        font.pointSize: 10
        color: Theme.text
    }
}
