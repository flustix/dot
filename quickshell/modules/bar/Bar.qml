import Quickshell
import Quickshell.Hyprland
import Quickshell.Wayland
import Quickshell.Widgets
import QtQuick
import QtQuick.Layouts

import qs.modules
import qs.modules.bar.components
import qs.utils

Item {
    id: root
    required property Outline outline
    required property SystemClock clock

    readonly property real centerSize: 480
    readonly property real sideWidth: (parent.width - centerSize) / 2

    height: 56
    width: parent.width
    y: parent.height - (height * outline.fullscreenProgress)

    MarginWrapperManager {
        leftMargin: 8
        rightMargin: 12
    }

    RowLayout {
        MusicDisplay {
            Layout.minimumWidth: root.sideWidth
            Layout.maximumWidth: root.sideWidth
        }

        Item {
            Layout.fillWidth: true
            implicitHeight: childrenRect.height
        }

        RowLayout {
            Layout.minimumWidth: root.sideWidth
            Layout.maximumWidth: root.sideWidth

            RowLayout {
                Layout.alignment: Qt.AlignRight
                spacing: 16

                Tray {
                    window: root.outline
                }

                ColumnLayout {
                    spacing: -2

                    RowLayout {
                        Layout.alignment: Qt.AlignRight
                        spacing: 0

                        Text {
                            text: Qt.formatDateTime(root.clock.date, "hh:mm")
                            color: Theme.text
                            font.pointSize: 12
                        }

                        Text {
                            text: Qt.formatDateTime(root.clock.date, ":ss")
                            color: Theme.subtext
                            font.pointSize: 10
                        }
                    }

                    Text {
                        text: Qt.formatDateTime(root.clock.date, "dd MMM yyyy")
                        color: Theme.subtext
                        font.pointSize: 10
                        Layout.alignment: Qt.AlignRight
                    }
                }
            }
        }
    }
}
