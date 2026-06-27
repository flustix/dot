import QtQuick

import qs.modules
import qs.modules.media

Item {
    id: root

    anchors.fill: parent

    required property Outline outline
    readonly property MediaPanel media: mp

    MediaPanel {
        id: mp
        outline: root.outline
    }
}
