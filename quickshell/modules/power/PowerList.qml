import Quickshell
import Quickshell.Wayland
import Quickshell.Widgets
import Quickshell.Services.UPower
import QtQuick
import QtQuick.Layouts

import qs.components
import qs.modules
import qs.utils

// qmllint disable uncreatable-type
Item {
    id: root

    required property Outline outline

    property var items: UPower.devices.values.filter(x => x.model)

    implicitHeight: (items.length * 56 + 16) * visibility
    implicitWidth: 400

    x: outline.width - width - 12
    y: outline.topbar.height

    property real visibility: Globals.panelPower ? 1 : 0

    Behavior on visibility {
        NumberAnimation {
            duration: 400
            easing: Easing.OutExpo
        }
    }

    MouseArea {
        anchors.fill: parent

        hoverEnabled: true
        onExited: Globals.panelPower = false

        MarginWrapperManager {
            bottomMargin: 16
            leftMargin: 16
        }

        Rectangle {
            color: Theme.base
            bottomLeftRadius: 16
            clip: true

            Column {
                spacing: 0

                Repeater {
                    model: root.items

                    Item {
                        id: item
                        required property UPowerDevice modelData
                        width: 400
                        height: 56

                        RowLayout {
                            height: parent.height
                            Layout.alignment: Qt.AlignLeft
                            spacing: 12

                            TintedIcon {
                                Layout.leftMargin: 12
                                size: 24
                                path: Quickshell.iconPath(Icons.getBattery(item.modelData))
                                color: Icons.getBatteryColor(item.modelData)
                            }

                            ColumnLayout {
                                spacing: -2
                                Layout.alignment: Qt.AlignLeft
                                Layout.fillWidth: true

                                Text {
                                    text: `${item.modelData.model}`
                                    color: Theme.text
                                    font.pointSize: 12
                                }

                                RowLayout {
                                    Text {
                                        text: `${Math.floor(item.modelData.percentage * 100)}%`
                                        color: Theme.subtext
                                        font.pointSize: 10
                                    }

                                    Text {
                                        visible: item.modelData.timeToEmpty
                                        text: `${Formatting.duration(item.modelData.timeToEmpty, true, false)} remaining`
                                        color: Theme.subtext
                                        font.pointSize: 10
                                        opacity: 0.65
                                    }

                                    Text {
                                        visible: item.modelData.timeToFull
                                        text: `${Formatting.duration(item.modelData.timeToFull, true, false)} until full`
                                        color: Theme.subtext
                                        font.pointSize: 10
                                        opacity: 0.65
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }

    CornerRadius {
        implicitHeight: 32
        implicitWidth: 32
        topRight: 16 * root.visibility
        color: Theme.base

        x: -16
    }

    CornerRadius {
        implicitHeight: 32
        implicitWidth: 32
        topRight: 16 * root.visibility
        color: Theme.base

        x: parent.width - 32
        y: parent.height - 16
    }
}
