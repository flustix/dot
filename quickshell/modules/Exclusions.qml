import Quickshell
import Quickshell.Wayland
import QtQuick

Scope {
    id: root

    required property ShellScreen screen
    required property Item bar

    readonly property int width: 12

    Zone {
        anchors.left: true
        screen: root.screen
        implicitWidth: root.width
    }

    Zone {
        anchors.right: true
        screen: root.screen
        implicitWidth: root.width
    }

    Zone {
        anchors.bottom: true
        screen: root.screen
        implicitHeight: root.bar.height
    }

    Zone {
        anchors.top: true
        screen: root.screen
        implicitHeight: root.width
    }

    // qmllint disable uncreatable-type
    component Zone: PanelWindow {
        color: "transparent"
        WlrLayershell.namespace: "qs-exclusions"
    }
}
