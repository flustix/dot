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
    y: outline.height - height - outline.bar.height

    property real visibility: Config.batteryOpen ? 1 : 0

    Behavior on visibility {
        NumberAnimation {
            duration: 400
            easing: Easing.OutExpo
        }
    }

    MouseArea {
        anchors.fill: parent

        hoverEnabled: true
        onExited: Config.batteryOpen = false

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
                                path: Qt.resolvedUrl(`${Quickshell.shellDir}/icons/${Icons.getBattery(item.modelData)}`)
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
                                        text: `${item.modelData.percentage * 100}%`
                                        color: Theme.subtext
                                        font.pointSize: 10
                                    }

                                    Text {
                                        visible: item.modelData.timeToEmpty
                                        text: `${Formatting.duration(item.modelData.timeToEmpty)} remaining`
                                        color: Theme.subtext
                                        font.pointSize: 10
                                        opacity: 0.65
                                    }

                                    Text {
                                        visible: item.modelData.timeToFull
                                        text: `${Formatting.duration(item.modelData.timeToFull)} until full`
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
