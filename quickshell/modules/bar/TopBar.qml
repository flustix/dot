import Quickshell.Widgets
import QtQuick
import QtQuick.Layouts

import qs.modules
import qs.modules.bar.top
import qs.utils

Item {
    id: root
    width: parent.width
    height: 32
    y: -height * (1 - outline.fullscreenProgress)

    required property Outline outline

    MarginWrapperManager {
        leftMargin: 20
        rightMargin: 20
    }

    Item {
        TopWindowTitle {}

        RowLayout {
            height: parent.height
            x: parent.width - width

            TopBatteryLabel {}
        }
    }
}
