pragma ComponentBehavior: Bound

import Quickshell
import Quickshell.Networking
import Quickshell.Services.SystemTray
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

import qs.components
import qs.modules.stickers
import qs.utils

RowLayout {
    id: root
    required property PanelWindow window

    spacing: 12

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

    /* MouseArea {
        implicitWidth: 24
        implicitHeight: 24

        onClicked: m => {
            let open = Globals.panelAudio;
            Globals.closePanels();
            Globals.panelAudio = !open;
        }

        TintedIcon {
            readonly property PwNode node: Pipewire.defaultAudioSink

            size: 24
            path: Icons.resolve(Icons.volume(node.audio.volume))
        }
    } */

    MouseArea {
        implicitWidth: 20
        implicitHeight: 20
        hoverEnabled: true

        Tooltip {
            visible: parent.containsMouse
            text: 'Network Devices'
        }

        property var active: Networking.devices.values.find(x => x.connected)

        onClicked: m => {
            let open = Globals.panelNetwork;
            Globals.closePanels();
            Globals.panelNetwork = !open;
        }

        TintedIcon {
            anchors.fill: parent
            path: Quickshell.iconPath(Icons.network(parent.active))
        }
    }

    MouseArea {
        implicitWidth: 20
        implicitHeight: 20
        hoverEnabled: true

        Tooltip {
            visible: parent.containsMouse
            text: 'Stickers'
        }

        onClicked: CLI.run("zsh", ["-c", "find ~/Pictures/Stickers -type f | sort | vicinae dmenu"], res => {
            if (!res.success)
                return;

            StickerManager.addSticker(res.output);
        })

        TintedIcon {
            anchors.fill: parent
            path: Quickshell.iconPath("insert-image-symbolic")
        }
    }
}
