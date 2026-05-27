import Quickshell
import Quickshell.Wayland
import Quickshell.Widgets
import Quickshell.Services.UPower
import QtQuick
import QtQuick.Layouts

import qs.components
import qs.utils

// qmllint disable uncreatable-type
PanelWindow {
    id: root
    WlrLayershell.namespace: "qs-power"
    WlrLayershell.layer: WlrLayer.Top
    screen: Quickshell.screens.find(x => x.name == "DP-2")
    visible: Config.batteryOpen
    color: "transparent"

    implicitHeight: UPower.devices.values.length * 56 + 16
    implicitWidth: 400

    anchors {
        bottom: true
        right: true
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

            Column {
                spacing: 0

                Repeater {
                    model: UPower.devices

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
                                        text: `(${item.modelData.timeToEmpty} remaining)`
                                        color: Theme.subtext
                                        font.pointSize: 10
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
        bottomRight: 16
        color: Theme.base

        x: -16
        y: parent.height - 32
    }

    CornerRadius {
        implicitHeight: 32
        implicitWidth: 32
        bottomRight: 16
        color: Theme.base

        x: parent.width - 32
        y: -16
    }
}
