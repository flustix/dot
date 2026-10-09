import Quickshell.Hyprland
import Quickshell.Widgets
import QtQuick
import QtQuick.Layouts

import qs.modules
import qs.modules.bar.top
import qs.utils

Item {
    id: root
    width: parent.width
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

    Item {
        RowLayout {
            height: parent.height

            Text {
                text: {
                    if (!root.activeToplevel?.wayland)
                        return ""

                    var id = root.activeToplevel.wayland.appId;

                    if (DesktopEntries.mapping[id])
                        return DesktopEntries.mapping[id];

                    var split = id.split(".");
                    var last = split[split.length - 1];
                    last = `${last[0].toUpperCase()}${last.substring(1)}`;
                    return last;
                }
                font.pointSize: 10
                color: Theme.text
            }
        }

        RowLayout {
            height: parent.height
            x: parent.width - width

            TopBatteryLabel {}
        }
    }
}
