import QtQuick

import qs.modules
import qs.modules.audio
import qs.modules.media
import qs.modules.network
import qs.modules.power

Item {
    id: root

    anchors.fill: parent

    required property Outline outline

    readonly property AudioPanel audio: ap
    readonly property MediaPanel media: mp
    readonly property PowerList power: pl
    readonly property NetworkList network: nl

    AudioPanel {
        id: ap
        outline: root.outline
    }

    MediaPanel {
        id: mp
        outline: root.outline
    }

    PowerList {
        id: pl
        outline: root.outline
    }

    NetworkList {
        id: nl
        outline: root.outline
    }
}
