pragma ComponentBehavior: Bound

import Quickshell
import Quickshell.Wayland
import QtQuick
import QtQuick.Effects

import qs.modules
import qs.utils

// qmllint disable uncreatable-type
PanelWindow {
    id: root
    required property var modelData
    required property Item bar
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
            anchors.bottomMargin: root.bottomBorder
            radius: root.radius
        }
    }
}
