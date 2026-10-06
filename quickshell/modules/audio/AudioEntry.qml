import Quickshell.Services.Pipewire
import QtQuick
import QtQuick.Layouts

import qs.utils

Item {
    id: root
    required property PwNode modelData

    width: 400
    height: 56

    RowLayout {
        implicitWidth: parent.width
        implicitHeight: parent.height
        spacing: 12

        ColumnLayout {
            spacing: -2
            Layout.alignment: Qt.AlignLeft
            Layout.fillWidth: true

            RowLayout {
                Layout.fillWidth: true

                Text {
                    text: root.modelData.description || root.modelData.name
                    color: Theme.text
                    font.pointSize: 12
                }

                Text {
                    Layout.fillWidth: true
                    text: root.modelData.audio.volume
                    color: Theme.subtext
                    font.pointSize: 12
                }
            }

            Text {
                text: root.modelData.type
                color: Theme.subtext
                font.pointSize: 10
            }
        }
    }
}
