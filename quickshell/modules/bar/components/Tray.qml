pragma ComponentBehavior: Bound

import Quickshell
import Quickshell.Networking
import Quickshell.Services.SystemTray
import Quickshell.Services.UPower
import QtQuick
import QtQuick.Layouts

import qs.components
import qs.managers.net
import qs.modules.stickers
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
            path: Icons.resolve(Icons.getBattery(UPower.displayDevice))
            color: Icons.getBatteryColor(UPower.displayDevice)
        }
    }

    MouseArea {
        implicitWidth: 24
        implicitHeight: 24

        onClicked: m => {
            let open = Globals.panelAudio;
            Config.closeAll();
            Globals.panelAudio = !open;
        }

        TintedIcon {
            size: 24
            path: Icons.resolve('network')
        }
    }

    MouseArea {
        implicitWidth: 24
        implicitHeight: 24

        property var active: Networking.devices.values.find(x => x.connected)

        onClicked: m => {
            let open = Config.networkOpen;
            Config.closeAll();
            Config.networkOpen = !open;
        }

        TintedIcon {
            size: 24
            path: Icons.resolve(parent.active ? (parent.active.type == 1 ? 'wifi-high' : 'network') : 'network-x')
            opacity: parent.active ? 1 : 0.5
        }
    }

    MouseArea {
        implicitWidth: 24
        implicitHeight: 24

        onClicked: CLI.run("zsh", ["-c", "find ~/Pictures/Stickers -type f | sort | vicinae dmenu"], res => {
            if (!res.success)
                return;

            StickerManager.addSticker(res.output);
        })

        TintedIcon {
            size: 24
            path: Icons.resolve("sticker")
        }
    }
}
