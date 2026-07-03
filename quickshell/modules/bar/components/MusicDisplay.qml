import Quickshell.Widgets
import QtQuick.Layouts
import QtQuick

import qs.managers.media
import qs.utils

Item {
    id: music
    visible: MediaManager.player
    height: childrenRect.height
    width: childrenRect.width

    // layout
    RowLayout {
        spacing: 8

        ClippingWrapperRectangle {
            implicitWidth: 40
            implicitHeight: 40
            radius: 4
            clip: true
            color: "transparent"

            Image {
                anchors.fill: parent
                source: Qt.resolvedUrl(MediaManager.cover)
                fillMode: Image.PreserveAspectCrop
            }
        }

        Item {
            Layout.alignment: Qt.AlignLeft
            implicitHeight: childrenRect.height
            implicitWidth: childrenRect.width

            ColumnLayout {
                spacing: -2
                opacity: !MediaManager.showingLyrics ? 1 : 0

                Behavior on opacity {
                    NumberAnimation {
                        duration: 100
                    }
                }

                Text {
                    text: MediaManager.title
                    color: Theme.text
                    font.pointSize: 12
                }

                Text {
                    text: MediaManager.artist
                    color: Theme.subtext
                    font.pointSize: 10
                }
            }

            RowLayout {
                anchors.fill: parent
                opacity: MediaManager.showingLyrics ? 1 : 0

                Behavior on opacity {
                    NumberAnimation {
                        duration: 100
                    }
                }

                Item {
                    Layout.alignment: Qt.AlignLeft
                    implicitHeight: childrenRect.height
                    implicitWidth: childrenRect.width

                    MusicLyric {
                        // qmllint disable incompatible-type
                        lrc: MediaManager.lr1
                    }

                    MusicLyric {
                        lrc: MediaManager.lr2
                    }
                }
            }
        }
    }

    // mouse interactions
    MouseArea {
        z: 1
        anchors.fill: parent
        hoverEnabled: true
        acceptedButtons: Qt.LeftButton | Qt.RightButton | Qt.MiddleButton
        onClicked: m => {
            if (!MediaManager.player)
                return;

            if (m.button == Qt.LeftButton)
                MediaManager.player.togglePlaying();
            if (m.button == Qt.RightButton)
                MediaManager.player.next();
            if (m.button == Qt.MiddleButton) {
                let open = Config.mediaOpen;
                Config.closeAll();
                Config.mediaOpen = !open;
            }
        }
        onWheel: wheel => {
            if (!MediaManager.player)
                return;

            let delta = wheel.angleDelta.y > 0 ? 0.05 : -0.05;
            let newVolume = Math.min(Math.max(MediaManager.player.volume + delta, 0), 1);
            MediaManager.player.volume = newVolume;
        }
    }

    // fade on playstate
    opacity: MediaManager.playing ? 1 : 0.5
    Behavior on opacity {
        NumberAnimation {
            duration: 200
        }
    }
}
