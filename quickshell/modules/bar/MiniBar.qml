import Quickshell
import QtQuick
import QtQuick.Layouts

import qs.modules
import qs.utils

Item {
    id: bar
    required property Outline outline
    required property SystemClock clock

    height: 36
    width: parent.width
    y: parent.height - (height * outline.fullscreenProgress)

    RowLayout {
        anchors.centerIn: parent
        spacing: 12

        Text {
            text: Qt.formatDateTime(bar.clock.date, "dd MMM yyyy")
            color: Theme.subtext
            font.pointSize: 10
        }

        RowLayout {
            spacing: 0

            Text {
                text: Qt.formatDateTime(bar.clock.date, "hh:mm")
                color: Theme.text
                font.pointSize: 10
            }

            Text {
                text: Qt.formatDateTime(bar.clock.date, ":ss")
                color: Theme.subtext
                font.pointSize: 10
            }
        }
    }
}
