import QtQuick
import QtQuick.Controls

import qs.utils

ToolTip {
    id: control
    delay: 300

    contentItem: Text {
        text: control.text
        font.pointSize: 10
        color: Theme.text
    }

    background: Rectangle {
        color: Theme.base
        radius: 4
    }
}
