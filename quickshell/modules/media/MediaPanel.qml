import Quickshell.Services.Mpris
import Quickshell.Widgets
import QtQuick
import QtQuick.Layouts

import qs.components
import qs.managers.media
import qs.modules
import qs.utils

Item {
    id: root

    required property Outline outline

    implicitHeight: area.height
    implicitWidth: 410 * visibility

    x: 12 * outline.fullscreenProgress
    y: outline.height - height - outline.bar.height

    property real visibility: Globals.panelMedia ? 1 : 0

    Behavior on visibility {
        NumberAnimation {
            duration: 400
            easing: Easing.OutExpo
        }
    }

    MouseArea {
        id: area
        width: parent.width
        height: 620
        hoverEnabled: true
        onExited: Globals.panelMedia = false

        MarginWrapperManager {
            topMargin: 16
            rightMargin: 16
        }

        Rectangle {
            color: Theme.base
            topRightRadius: 20
            clip: true

            MarginWrapperManager {
                topMargin: 7
                bottomMargin: 14
                rightMargin: 14
            }

            ColumnLayout {
                spacing: 0
                Layout.fillWidth: true

                RowLayout {
                    Layout.fillWidth: true
                    Layout.bottomMargin: 16
                    spacing: 8

                    Repeater {
                        model: Mpris.players

                        Rectangle {
                            id: item
                            Layout.fillWidth: true
                            height: 28
                            color: "transparent"
                            clip: true

                            opacity: MediaManager.player.identity == modelData.identity ? 1 : 0.5
                            required property MprisPlayer modelData
                            RowLayout {
                                anchors.fill: parent

                                Text {
                                    Layout.alignment: Qt.AlignCenter
                                    text: item.modelData.identity
                                    font.pointSize: 10
                                    color: Theme.text
                                    elide: Text.ElideRight
                                }
                            }

                            Rectangle {
                                width: parent.width
                                height: 2
                                y: parent.height - this.height
                                color: Theme.text
                            }

                            MouseArea {
                                anchors.fill: parent
                                onClicked: MediaManager.preferredPlayer = item.modelData.identity
                            }
                        }
                    }
                }

                ClippingWrapperRectangle {
                    implicitHeight: 380
                    implicitWidth: 380
                    radius: 6
                    clip: true
                    color: "transparent"

                    Image {
                        anchors.fill: parent
                        source: Qt.resolvedUrl(MediaManager.cover)
                        fillMode: Image.PreserveAspectCrop
                    }
                }

                Item {
                    height: 16
                }

                Text {
                    Layout.fillWidth: true
                    text: MediaManager.title
                    color: Theme.text
                    font.pointSize: 18
                    elide: Text.ElideRight
                }

                Text {
                    Layout.fillWidth: true
                    text: MediaManager.artist
                    color: Theme.subtext
                    elide: Text.ElideRight
                }

                Rectangle {
                    Layout.topMargin: 16
                    Layout.fillWidth: true
                    Layout.preferredHeight: 8
                    radius: 4
                    color: Theme.hover
                    visible: MediaManager.player?.lengthSupported

                    Rectangle {
                        width: parent.width * ((MediaManager.playbackPosition || 0) / (MediaManager.player?.length || 100))
                        height: 8
                        color: Theme.text
                        radius: 4

                        Behavior on width {
                            NumberAnimation {
                                duration: 50
                            }
                        }
                    }
                }

                RowLayout {
                    Layout.topMargin: 24
                    Layout.preferredHeight: 24

                    MediaControl {
                        icon: "skip-back"
                        onClicked: MediaManager.player?.previous()
                        Layout.fillWidth: true
                    }

                    MediaControl {
                        icon: MediaManager.playing ? "pause" : "play"
                        onClicked: MediaManager.player?.togglePlaying()
                        Layout.fillWidth: true
                    }

                    MediaControl {
                        icon: "skip-forward"
                        onClicked: MediaManager.player?.next()
                        Layout.fillWidth: true
                    }
                }

                Item {
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                }
            }
        }
    }

    CornerRadius {
        implicitHeight: 32
        implicitWidth: 32
        bottomLeft: 16 * root.visibility
        color: Theme.base

        x: parent.width - 16
        y: parent.height - 32
    }

    CornerRadius {
        implicitHeight: 32
        implicitWidth: 32
        bottomLeft: 16 * root.visibility
        color: Theme.base

        y: -16
    }
}
