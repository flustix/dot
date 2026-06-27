pragma ComponentBehavior: Bound

import Quickshell
import Quickshell.Wayland
import QtQuick
import QtQuick.Effects

import qs.modules
import qs.modules.workspaces
import qs.utils

// qmllint disable uncreatable-type
PanelWindow {
    id: root
    required property var modelData
    required property Item bar
    property Item topbar
    property OutlinePanels panels

    color: "transparent"
    screen: modelData
    WlrLayershell.namespace: "qs-outline"
    WlrLayershell.layer: WlrLayer.Overlay
    exclusionMode: ExclusionMode.Ignore
    focusable: false
    mask: fullscreen ? emptyRegion : regions

    OutlineRegion {
        id: regions
        window: root
        bar: root.bar
        topbar: root.topbar
        panels: root.panels
    }

    Region {
        id: emptyRegion
    }

    anchors {
        top: true
        bottom: true
        left: true
        right: true
    }

    implicitHeight: screen.height
    implicitWidth: screen.width

    readonly property bool fullscreen: Hypr.isFullscreen(screen)
    property real fullscreenProgress: fullscreen ? 0 : 1

    property int border: fullscreenProgress * 12
    property int topBorder: fullscreenProgress * (topbar?.height || 12)
    property int bottomBorder: fullscreenProgress * bar.height
    property int radius: fullscreenProgress * 20

    Behavior on fullscreenProgress {
        NumberAnimation {
            duration: 400
            easing.type: Easing.OutQuint
        }
    }

    Exclusions {
        screen: root.modelData
        bar: root.bar
        topbar: root.topbar
    }

    Rectangle {
        anchors.fill: parent
        color: Theme.base

        layer.enabled: true
        layer.effect: MultiEffect {
            maskSource: mask
            maskEnabled: true
            maskInverted: true
            maskThresholdMin: 0.5
            maskSpreadAtMin: 1
        }
    }

    Item {
        id: mask

        anchors.fill: parent
        layer.enabled: true
        visible: false

        Rectangle {
            anchors.fill: parent
            anchors.margins: root.border
            anchors.topMargin: root.topBorder
            anchors.bottomMargin: root.bottomBorder
            radius: root.radius
        }
    }

    WorkspaceDisplay {
        outline: root
    }

    Rectangle {
        width: parent.width
        height: parent.height
        z: 500
        opacity: Globals.dimmed ? 1 : 0
        color: '#000'

        Behavior on opacity {
            NumberAnimation {
                duration: 600
            }
        }
    }
}
