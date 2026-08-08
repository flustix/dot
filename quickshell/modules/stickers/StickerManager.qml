pragma Singleton
pragma ComponentBehavior: Bound

import Quickshell
import QtQuick

Singleton {
    id: stickers

    function addSticker(path: string) {
        model.append({
            path: path
        });
    }

    ListModel {
        id: model
    }

    Repeater {
        model: model
        delegate: FloatingWindow {
            id: window

            required property int index
            required property string path

            visible: true
            color: "transparent"

            AnimatedImage {
                anchors.fill: parent
                source: Qt.resolvedUrl(window.path)
            }

            Text {
                id: label
                anchors.centerIn: parent
                text: `${window.width}x${window.height}`
                visible: false
            }

            Timer {
                id: timer
                interval: 800
                repeat: false
                running: false
                onTriggered: label.visible = false
            }

            onWidthChanged: {
                label.visible = true;
                timer.restart();
            }

            onClosed: {
                model.remove(index);
            }

            onVisibleChanged: {
                if (!visible) {
                    model.remove(index);
                }
            }
        }
    }
}
