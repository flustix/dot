import Quickshell
import Quickshell.Networking
import Quickshell.Wayland
import Quickshell.Widgets
import QtQuick

import qs.components
import qs.managers.net
import qs.modules
import qs.utils

// qmllint disable uncreatable-type
Item {
    id: root

    required property Outline outline

    implicitHeight: (Networking.devices.values.length * 56 + 16) * visibility
    implicitWidth: 400

    x: outline.width - width - 12
    y: outline.height - height - outline.bar.height

    property real visibility: Globals.panelNetwork ? 1 : 0

    Behavior on visibility {
        NumberAnimation {
            duration: 400
            easing: Easing.OutExpo
        }
    }

    Timer {
        running: Networking.canCheckConnectivity
        interval: 1000
        repeat: true
        onTriggered: Networking.checkConnectivity()
    }

    MouseArea {
        anchors.fill: parent

        hoverEnabled: true
        onExited: Globals.panelNetwork = false

        MarginWrapperManager {
            topMargin: 16
            leftMargin: 16
        }

        Rectangle {
            color: Theme.base
            topLeftRadius: 16
            clip: true

            Column {
                spacing: 0

                Repeater {
                    model: Networking.devices
                    NetworkItem {}
                }
            }
        }
    }

    CornerRadius {
        implicitHeight: 32
        implicitWidth: 32
        bottomRight: 16 * root.visibility
        color: Theme.base

        x: -16
        y: parent.height - 32
    }

    CornerRadius {
        implicitHeight: 32
        implicitWidth: 32
        bottomRight: 16 * root.visibility
        color: Theme.base

        x: parent.width - 32
        y: -16
    }
}
