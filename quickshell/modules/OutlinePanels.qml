import QtQuick

import qs.modules
import qs.modules.media
import qs.modules.workspaces

Item {
    id: root

    anchors.fill: parent

    required property Outline outline
    readonly property MediaPanel media: mp

    WorkspaceDisplay {
        outline: root.outline
    }

    MediaPanel {
        id: mp
        outline: root.outline
    }
}
