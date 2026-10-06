import Quickshell
import Quickshell.Services.Pipewire
import Quickshell.Widgets
import QtQuick

import qs.components
import qs.modules
import qs.utils

Item {
    id: root
    required property Outline outline

    property var outputs: Pipewire.nodes.values.filter(x => x.isSink && !x.isStream)

    implicitWidth: 400
    implicitHeight: (outputs.length * 56) * visibility

    x: outline.width - width - 12
    y: outline.height - height - outline.bar.height

    property real visibility: Globals.panelAudio ? 1 : 0

    Behavior on visibility {
        NumberAnimation {
            duration: 400
            easing: Easing.OutExpo
        }
    }

    MouseArea {
        anchors.fill: parent

        hoverEnabled: true
        onExited: Globals.panelAudio = false

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
                    model: root.outputs
                    AudioEntry {}
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