import QtQuick

import qs.managers.media
import qs.utils

Item {
    id: root

    required property LyricLine lrc

    implicitHeight: childrenRect.height
    implicitWidth: childrenRect.width
    opacity: lrc.showing ? 1 : 0

    Text {
        text: root.lrc.text
        color: Theme.text
        font.pointSize: 12
        opacity: 0.5
    }

    Item {
        implicitHeight: childrenRect.height
        implicitWidth: childrenRect.width
        clip: true

        Text {
            text: root.lrc.syncedText
            color: Theme.text
            font.pointSize: 12
        }
    }

    Behavior on opacity {
        NumberAnimation {
            duration: 100
        }
    }
}
