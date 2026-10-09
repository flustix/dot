import QtQuick

import qs.utils

Rectangle {
    required property MouseArea area

    Behavior on opacity {
        NumberAnimation {
            duration: area.containsMouse ? 200 : 50
        } 
    }

    color: Theme.text
    opacity: area.containsMouse ? .25 : 0
}