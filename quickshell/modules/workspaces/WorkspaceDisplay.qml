pragma ComponentBehavior: Bound

import Quickshell.Hyprland
import Quickshell.Widgets
import QtQuick
import QtQuick.Layouts

import qs.modules
import qs.utils

Item {
    id: root

    required property Outline outline
    readonly property HyprlandWorkspace workspace: Hyprland.monitorFor(outline.screen).activeWorkspace

    width: content.width
    height: content.height * visibility
    y: outline.height - outline.bottomBorder - height
    clip: true
    anchors {
        horizontalCenter: parent.horizontalCenter
    }

    property real visibility: 0

    Behavior on visibility {
        NumberAnimation {
            duration: 200
            easing: Easing.OutCurve
        }
    }

    Rectangle {
        id: content
        color: Theme.base
        topLeftRadius: 16 * root.visibility
        topRightRadius: 16 * root.visibility

        MarginWrapperManager {
            topMargin: 12
            leftMargin: 16
            rightMargin: 16
            bottomMargin: 8
        }

        RowLayout {
            Text {
                text: `Workspace ${root.workspace.id}`
                color: Theme.text
            }
        }
    }

    Timer {
        id: disappearTimer
        interval: 800
        onTriggered: root.visibility = 0
    }

    function show() {
        disappearTimer.restart();
        visibility = 1;
    }

    Connections {
        target: root

        function onWorkspaceChanged() {
            root.show();
        }
    }
}
