pragma ComponentBehavior: Bound

import Quickshell
import Quickshell.Services.SystemTray
import Quickshell.Services.UPower
import QtQuick
import QtQuick.Layouts

import qs.components
import qs.managers.net
import qs.utils

RowLayout {
    id: root
    required property PanelWindow window

    spacing: 8

    Repeater {
        model: SystemTray.items
        TrayItem {
            window: root.window
        }
    }

    // spacer
    Item {
        implicitWidth: 4
    }

    MouseArea {
        implicitWidth: 24
        implicitHeight: 24
        visible: UPower.devices.values.length

        onClicked: m => {
            let open = Config.batteryOpen;
            Config.closeAll();
            Config.batteryOpen = !open;
        }

        TintedIcon {
            size: 24
            path: Icons.resolve(Icons.getBattery(UPower.devices.values[0]))
            color: Icons.getBatteryColor(UPower.devices.values[0])
        }
    }

    MouseArea {
        implicitWidth: 24
        implicitHeight: 24

        onClicked: m => {
            let open = Config.networkOpen;
            Config.closeAll();
            Config.networkOpen = !open;
        }

        TintedIcon {
            size: 24
            path: Icons.resolve(NetworkManager.active ? 'network' : 'network-x')
            opacity: NetworkManager.active ? 1 : 0.5
        }
    }

    MouseArea {
        implicitWidth: 24
        implicitHeight: 24

        onClicked: Theme.openWallpaperSwitcher()

        TintedIcon {
            size: 24
            path: Icons.resolve("image")
        }
    }
}
