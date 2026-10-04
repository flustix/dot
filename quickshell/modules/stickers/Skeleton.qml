import Quickshell
import QtQuick

Item {
    anchors.fill: parent

    AnimatedImage {
        id: image
        anchors.fill: parent
        playing: false
        source: Qt.resolvedUrl("/home/flux/Pictures/Stickers/skeleton-running.gif")

        onCurrentFrameChanged: {
            if (currentFrame === frameCount - 1) {
                playing = false
            }
        }
    }

    Timer {
        id: loop
        interval: 1000
        repeat: true
        running: true
        onTriggered: {
            var rng = Math.floor(Math.random() * 80000)
            if (rng != 0) return;
            image.currentFrame = 0
            image.playing = true
        }
    }
}
