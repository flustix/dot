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

    implicitHeight: 224
    implicitWidth: 840

    x: 12 * outline.fullscreenProgress
    y: outline.height - (height * visibility) - (outline.bar.height * outline.fullscreenProgress)

    property real visibility: Config.mediaOpen ? 1 : 0

    Behavior on visibility {
        NumberAnimation {
            duration: 400
            easing: Easing.OutQuint
        }
    }

    MouseArea {
        anchors.fill: parent
        hoverEnabled: true
        onExited: Config.mediaOpen = false

        MarginWrapperManager {
            topMargin: 16
            rightMargin: 16
        }

        Rectangle {
            color: Theme.base
            topRightRadius: 16
            clip: true

            MarginWrapperManager {
                topMargin: 14
                bottomMargin: 14
                rightMargin: 14
            }

            RowLayout {
                spacing: 16
                opacity: root.visibility

                ClippingWrapperRectangle {
                    implicitHeight: 192
                    implicitWidth: 192
                    radius: 16
                    clip: true
                    color: "transparent"

                    Image {
                        anchors.fill: parent
                        source: Qt.resolvedUrl(MediaManager.cover)
                        fillMode: Image.PreserveAspectCrop
                    }
                }

                ColumnLayout {
                    spacing: 0
                    Layout.fillWidth: true
                    Layout.fillHeight: true

                    RowLayout {
                        Layout.fillWidth: true
                        Layout.bottomMargin: 16
                        spacing: 16

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
                            icon: MediaManager.repeat === MprisLoopState.Track ? "repeat-once" : "repeat"
                            onClicked: {
                                if (!MediaManager.player)
                                    return;

                                let r = MediaManager.player.loopState;
                                if (r == MprisLoopState.None)
                                    MediaManager.player.loopState = MprisLoopState.Playlist;
                                if (r == MprisLoopState.Playlist)
                                    MediaManager.player.loopState = MprisLoopState.Track;
                                if (r == MprisLoopState.Track)
                                    MediaManager.player.loopState = MprisLoopState.None;
                            }
                            opacity: MediaManager.repeat !== MprisLoopState.None ? .5 : 1
                            Layout.fillWidth: true
                        }

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

                        MediaControl {
                            icon: "shuffle-simple"
                            onClicked: {
                                if (!MediaManager.player)
                                    return;

                                MediaManager.player.shuffle = !MediaManager.player.shuffle;
                            }
                            opacity: MediaManager.shuffle ? 1 : .5
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
    }

    CornerRadius {
        implicitHeight: 32
        implicitWidth: 32
        bottomLeft: 16 * root.visibility
        color: Theme.base

        x: parent.width - 16
        y: -16 + ((parent.height * root.visibility) - 16)
    }

    CornerRadius {
        implicitHeight: 32
        implicitWidth: 32
        bottomLeft: 16 * root.visibility
        color: Theme.base

        y: -16
    }
}
