import Quickshell
import Quickshell.Wayland
import Quickshell.Widgets
import QtQuick

import qs.components
import qs.managers.net
import qs.utils

// qmllint disable uncreatable-type
PanelWindow {
    id: root
    WlrLayershell.namespace: "qs-network"
    WlrLayershell.layer: WlrLayer.Top
    screen: Quickshell.screens.find(x => x.name == "DP-2")
    visible: Config.networkOpen
    color: "transparent"

    implicitHeight: NetworkManager.connections.length * 56 + 16
    implicitWidth: 400

    anchors {
        bottom: true
        right: true
    }

    MouseArea {
        anchors.fill: parent

        hoverEnabled: true
        onExited: Config.networkOpen = false

        MarginWrapperManager {
            topMargin: 16
            leftMargin: 16
        }

        Rectangle {
            color: Theme.base
            topLeftRadius: 16

            Column {
                spacing: 0

                Repeater {
                    model: NetworkManager.connections
                    NetworkItem {}
                }
            }
        }
    }

    CornerRadius {
        implicitHeight: 32
        implicitWidth: 32
        bottomRight: 16
        color: Theme.base

        x: -16
        y: parent.height - 32
    }

    CornerRadius {
        implicitHeight: 32
        implicitWidth: 32
        bottomRight: 16
        color: Theme.base

        x: parent.width - 32
        y: -16
    }
}
