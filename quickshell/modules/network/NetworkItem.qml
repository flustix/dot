import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Widgets

import qs.components
import qs.managers.net
import qs.utils

MouseArea {
    id: root
    width: 400
    height: 56
    hoverEnabled: true

    required property NetworkConnection modelData

    onEntered: hover.color = Theme.hover
    onExited: hover.color = "transparent"

    onClicked: m => {
        if (modelData.connected)
            NetworkManager.down(modelData.id);
        else
            NetworkManager.up(modelData.id);
    }

    Rectangle {
        id: hover
        anchors.fill: parent
        color: "transparent"

        // really really really REALLY fucking stupid way to do this because the
        // parent rectangle does not cut it off at all
        topLeftRadius: NetworkManager.connections.indexOf(root.modelData) == 0 ? 16 : 0

        RowLayout {
            height: parent.height
            spacing: 12

            TintedIcon {
                Layout.leftMargin: 12
                size: 24
                path: Qt.resolvedUrl(`${Quickshell.shellDir}/icons/${root.modelData.connected ? 'network' : 'network-x'}`)
                opacity: root.modelData.connected ? 1 : 0.5
            }

            ColumnLayout {
                spacing: -2
                Layout.alignment: Qt.AlignLeft
                Layout.fillWidth: true

                RowLayout {
                    Text {
                        text: root.modelData.name || root.modelData.id
                        color: Theme.text
                        font.pointSize: 12
                    }

                    Text {
                        text: root.modelData.id
                        color: Theme.subtext
                        font.pointSize: 10
                        visible: root.modelData.name
                    }
                }

                Text {
                    text: root.modelData.state
                    color: Theme.subtext
                    font.pointSize: 10
                }
            }
        }
    }
}
